Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C008C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9000218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfCVPrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:47:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47809 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfCVPrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:47:52 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MjjKf-1gjc5b16ZX-00lE5J; Fri, 22 Mar 2019 16:47:44 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 16/25] usb: gadget: Add the gserial port checking in gs_start_tx()
Date:   Fri, 22 Mar 2019 16:44:07 +0100
Message-Id: <20190322154425.3852517-17-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Gosm4FGMsO5444Yg2Rf0+LQ/wGhky3Ep9nyBnNCh3iX2HcC7Jqm
 QRhr2Wo5HVbg+g+U9ybx4brDFsuOPqV7XrvydvCQnY4KLVEkg7chK9/opsptLw/KnBaK7dT
 6Ws8K+2CsaWRWoF8ewFtCYh2/J7Tv6abQ5bCXh8/7zQdFfZ1DtMb9E6UD6ccANR3CXSelrD
 05HW0XW+xnWmFMNdqqfMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sMKRZ0XQZVQ=:m7r/UvufhblTmUzBYkZa5q
 p4hpUgO2sRWcQOukcKg1UBbA2a+XFUqXPmjT907LUZO9rvBGleAUvIiWLuWNku+4oOmiAvrx+
 Z6FPAmd6D/ctYxYRwXN9azzPSqdW4RrehZxWqlrQduuSSacQbIsSZ1N4AYoyNyJzQYwC6BmQ/
 nRJGbdnjoHkec07CiGgZE+6quYmo9y8ccATf54sJTC9r1c1nAliTkEuH0mT4yfZ4UXxjWXjgC
 TUxQaS85HwprcBwB44xlGNMV9aXMJAedeL1LcPu7giVCooKl2g+nfMKRopj2FyLz7wfmDqzKV
 Ca8IRLmbHpwhdi8tZP5B4XCYiq1tsbqO88RDbKZfWwo+YuBE35reFZjWZOZkTp5WBcKudH3dC
 49sRlU6jVz7hHoqZpBBwFA/7gQ8SYSytHfK8NsDd7XGWCIDhFBM5P5vP2eFhVjoTmzNFR3nS2
 fVSYqZUPEAHu3Bl6eB+kD/rTjbNwnHL7MsITEe+5nwiNdMHcUJlXEbfjKiE82TVajMjcue5ty
 nHwawyh8mHiuyXeXhy43p9lbphOK+oKNHrdbQCFki3meHMdldT+cPIYR6DQTwncAr/mBr/00w
 QWKQnazP6vBd9EI7zjUInvBQtZ2i6JcYznstgP0Ek7n80nidh8V08N+l/2bkpNTiRdrsmQX9r
 6W3UO6Eag30fipuj+mDBp1apgRYQshK22Bcz3U4j3wUMcAkCMR0kKaeGg0EH3DiiYdUwTX2At
 QQiRhmmFr20T5i6fb5s9N8zMq6yOksSjaC6iRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

When usb gadget is set gadget serial function, it will be crash in below
situation.

It will clean the 'port->port_usb' pointer in gserial_disconnect() function
when usb link is inactive, but it will release lock for disabling the endpoints
in this function. Druing the lock release period, it maybe complete one request
to issue gs_write_complete()--->gs_start_tx() function, but the 'port->port_usb'
pointer had been set NULL, thus it will be crash in gs_start_tx() function.

This patch adds the 'port->port_usb' pointer checking in gs_start_tx() function
to avoid this situation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(cherry picked from commit 511a36d2f357724312bb3776d2f6eed3890928b2)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/function/u_serial.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 4ea44f7122ee..d73618475664 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -361,10 +361,15 @@ __acquires(&port->port_lock)
 */
 {
 	struct list_head	*pool = &port->write_pool;
-	struct usb_ep		*in = port->port_usb->in;
+	struct usb_ep		*in;
 	int			status = 0;
 	bool			do_tty_wake = false;
 
+	if (!port->port_usb)
+		return status;
+
+	in = port->port_usb->in;
+
 	while (!port->write_busy && !list_empty(pool)) {
 		struct usb_request	*req;
 		int			len;
-- 
2.20.0

