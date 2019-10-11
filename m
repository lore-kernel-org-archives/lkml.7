Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF42C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED672089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfJKPul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:50:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:5706 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfJKPul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:50:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 08:50:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="200820645"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Oct 2019 08:50:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C4EB116A; Fri, 11 Oct 2019 18:50:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] ipmi: use %*ph to print small buffer
Date:   Fri, 11 Oct 2019 18:50:36 +0300
Message-Id: <20191011155036.36748-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andy.shevchenko@gmail.com>

Use %*ph format to print small buffer as hex string.

The change is safe since the specifier can handle up to 64 bytes and taking
into account the buffer size of 100 bytes on stack the function has never been
used to dump more than 32 bytes. Note, this also avoids potential buffer
overflow if the length of the input buffer is bigger.

This completely eliminates ipmi_debug_msg() in favour of Dynamic Debug.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- eliminate ipmi_debug_msg() in favour of Dynamic Debug (Joe)
 drivers/char/ipmi/ipmi_msghandler.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 2aab80e19ae0..1768b81aaf78 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -44,25 +44,6 @@ static void need_waiter(struct ipmi_smi *intf);
 static int handle_one_recv_msg(struct ipmi_smi *intf,
 			       struct ipmi_smi_msg *msg);
 
-#ifdef DEBUG
-static void ipmi_debug_msg(const char *title, unsigned char *data,
-			   unsigned int len)
-{
-	int i, pos;
-	char buf[100];
-
-	pos = snprintf(buf, sizeof(buf), "%s: ", title);
-	for (i = 0; i < len; i++)
-		pos += snprintf(buf + pos, sizeof(buf) - pos,
-				" %2.2x", data[i]);
-	pr_debug("%s\n", buf);
-}
-#else
-static void ipmi_debug_msg(const char *title, unsigned char *data,
-			   unsigned int len)
-{ }
-#endif
-
 static bool initialized;
 static bool drvregistered;
 
@@ -2267,7 +2248,7 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		ipmi_free_smi_msg(smi_msg);
 		ipmi_free_recv_msg(recv_msg);
 	} else {
-		ipmi_debug_msg("Send", smi_msg->data, smi_msg->data_size);
+		pr_debug("Send: %*ph\n", smi_msg->data_size, smi_msg->data);
 
 		smi_send(intf, intf->handlers, smi_msg, priority);
 	}
@@ -3730,7 +3711,7 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
 		msg->data[10] = ipmb_checksum(&msg->data[6], 4);
 		msg->data_size = 11;
 
-		ipmi_debug_msg("Invalid command:", msg->data, msg->data_size);
+		pr_debug("Invalid command: %*ph\n", msg->data_size, msg->data);
 
 		rcu_read_lock();
 		if (!intf->in_shutdown) {
@@ -4217,7 +4198,7 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
 	int requeue;
 	int chan;
 
-	ipmi_debug_msg("Recv:", msg->rsp, msg->rsp_size);
+	pr_debug("Recv: %*ph\n", msg->rsp_size, msg->rsp);
 
 	if ((msg->data_size >= 2)
 	    && (msg->data[0] == (IPMI_NETFN_APP_REQUEST << 2))
@@ -4576,7 +4557,7 @@ smi_from_recv_msg(struct ipmi_smi *intf, struct ipmi_recv_msg *recv_msg,
 	smi_msg->data_size = recv_msg->msg.data_len;
 	smi_msg->msgid = STORE_SEQ_IN_MSGID(seq, seqid);
 
-	ipmi_debug_msg("Resend: ", smi_msg->data, smi_msg->data_size);
+	pr_debug("Resend: %*ph\n", smi_msg->data_size, smi_msg->data);
 
 	return smi_msg;
 }
-- 
2.23.0

