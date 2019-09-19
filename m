Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4C8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C8A21924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbfISJSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 05:18:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55016 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387757AbfISJSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:18:31 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AC69EA8542200CA7C669;
        Thu, 19 Sep 2019 17:18:29 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 19 Sep 2019 17:18:20 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <penberg@cs.helsinki.fi>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>
CC:     <nico@fluxnic.net>, <textshell@uchuujin.de>, <sam@ravnborg.org>,
        <daniel.vetter@ffwll.ch>, <mpatocka@redhat.com>,
        <ghalat@redhat.com>, <linux-kernel@vger.kernel.org>,
        <yangyingliang@huawei.com>, <yuehaibing@huawei.com>,
        <zengweilin@huawei.com>
Subject: [PATCH] tty:vt: Add check the return value of kzalloc to avoid oops
Date:   Thu, 19 Sep 2019 17:18:15 +0800
Message-ID: <1568884695-56789-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using kzalloc() to allocate memory in function con_init(), but not
checking the return value, there is a risk of null pointer references
oops.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 drivers/tty/vt/vt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 34aa39d..db83e52 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3357,15 +3357,33 @@ static int __init con_init(void)
 
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
 		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
+		if (unlikely(!vc)) {
+			pr_warn("%s:failed to allocate memory for the %u vc\n",
+					__func__, currcons);
+			break;
+		}
 		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 		tty_port_init(&vc->port);
 		visual_init(vc, currcons, 1);
 		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
+		if (unlikely(!vc->vc_screenbuf)) {
+			pr_warn("%s:failed to allocate memory for the %u vc_screenbuf\n",
+					__func__, currcons);
+			visual_deinit(vc);
+			tty_port_destroy(&vc->port);
+			kfree(vc);
+			vc_cons[currcons].d = NULL;
+			break;
+		}
 		vc_init(vc, vc->vc_rows, vc->vc_cols,
 			currcons || !vc->vc_sw->con_save_screen);
 	}
 	currcons = fg_console = 0;
 	master_display_fg = vc = vc_cons[currcons].d;
+	if (unlikely(!vc)) {
+		console_unlock();
+		return 0;
+	}
 	set_origin(vc);
 	save_screen(vc);
 	gotoxy(vc, vc->vc_x, vc->vc_y);
-- 
1.8.5.6

