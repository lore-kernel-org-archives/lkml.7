Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6092CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFF92070C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfJUXzj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 19:55:39 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:52268 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbfJUXzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:55:39 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id C2F8075B92D3F24D26F4;
        Tue, 22 Oct 2019 07:55:36 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x9LNtId7050475;
        Tue, 22 Oct 2019 07:55:18 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019102207552806-63452 ;
          Tue, 22 Oct 2019 07:55:28 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     vinicius.gomes@intel.com, jhs@mojatatu.com
Cc:     xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, up2wing@gmail.com,
        wang.liang82@zte.com.cn
Subject: [RESEND][PATCH net-next] net: sched: taprio: fix -Wmissing-prototypes warnings
Date:   Tue, 22 Oct 2019 07:57:42 +0800
Message-Id: <1571702262-25929-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-10-22 07:55:28,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-22 07:55:20
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse-fl1.zte.com.cn x9LNtId7050475
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get one warnings when build kernel W=1:
net/sched/sch_taprio.c:1155:6: warning: no previous prototype for ‘taprio_offload_config_changed’ [-Wmissing-prototypes]

Make the function static to fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 net/sched/sch_taprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 6719a65..2121187 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1152,7 +1152,7 @@ void taprio_offload_free(struct tc_taprio_qopt_offload *offload)
  * offload state (PENDING, ACTIVE, INACTIVE) so it can be visible in dump().
  * This is left as TODO.
  */
-void taprio_offload_config_changed(struct taprio_sched *q)
+static void taprio_offload_config_changed(struct taprio_sched *q)
 {
 	struct sched_gate_list *oper, *admin;
 
-- 
1.8.3.1

