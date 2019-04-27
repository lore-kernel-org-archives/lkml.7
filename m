Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10891C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA839206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfD0PTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:19:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34192 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727670AbfD0PPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:38 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP38-0000zP-JL; Sat, 27 Apr 2019 16:15:34 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2j-0004SW-2f; Sat, 27 Apr 2019 16:15:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Corey Minyard" <cminyard@mvista.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.556583980@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 061/202] ipmi: msghandler: Fix potential Spectre v1
 vulnerabilities
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

commit a7102c7461794a5bb31af24b08e9e0f50038897a upstream.

channel and addr->channel are indirectly controlled by user-space,
hence leading to a potential exploitation of the Spectre variant 1
vulnerability.

These issues were detected with the help of Smatch:

drivers/char/ipmi/ipmi_msghandler.c:1381 ipmi_set_my_address() warn: potential spectre issue 'user->intf->addrinfo' [w] (local cap)
drivers/char/ipmi/ipmi_msghandler.c:1401 ipmi_get_my_address() warn: potential spectre issue 'user->intf->addrinfo' [r] (local cap)
drivers/char/ipmi/ipmi_msghandler.c:1421 ipmi_set_my_LUN() warn: potential spectre issue 'user->intf->addrinfo' [w] (local cap)
drivers/char/ipmi/ipmi_msghandler.c:1441 ipmi_get_my_LUN() warn: potential spectre issue 'user->intf->addrinfo' [r] (local cap)
drivers/char/ipmi/ipmi_msghandler.c:2260 check_addr() warn: potential spectre issue 'intf->addrinfo' [r] (local cap)

Fix this by sanitizing channel and addr->channel before using them to
index user->intf->addrinfo and intf->addrinfo, correspondingly.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -46,6 +46,7 @@
 #include <linux/proc_fs.h>
 #include <linux/rcupdate.h>
 #include <linux/interrupt.h>
+#include <linux/nospec.h>
 
 #define PFX "IPMI message handler: "
 
@@ -1116,6 +1117,7 @@ int ipmi_set_my_address(ipmi_user_t   us
 {
 	if (channel >= IPMI_MAX_CHANNELS)
 		return -EINVAL;
+	channel = array_index_nospec(channel, IPMI_MAX_CHANNELS);
 	user->intf->channels[channel].address = address;
 	return 0;
 }
@@ -1127,6 +1129,7 @@ int ipmi_get_my_address(ipmi_user_t   us
 {
 	if (channel >= IPMI_MAX_CHANNELS)
 		return -EINVAL;
+	channel = array_index_nospec(channel, IPMI_MAX_CHANNELS);
 	*address = user->intf->channels[channel].address;
 	return 0;
 }
@@ -1138,6 +1141,7 @@ int ipmi_set_my_LUN(ipmi_user_t   user,
 {
 	if (channel >= IPMI_MAX_CHANNELS)
 		return -EINVAL;
+	channel = array_index_nospec(channel, IPMI_MAX_CHANNELS);
 	user->intf->channels[channel].lun = LUN & 0x3;
 	return 0;
 }
@@ -1149,6 +1153,7 @@ int ipmi_get_my_LUN(ipmi_user_t   user,
 {
 	if (channel >= IPMI_MAX_CHANNELS)
 		return -EINVAL;
+	channel = array_index_nospec(channel, IPMI_MAX_CHANNELS);
 	*address = user->intf->channels[channel].lun;
 	return 0;
 }
@@ -1875,6 +1880,7 @@ static int check_addr(ipmi_smi_t       i
 {
 	if (addr->channel >= IPMI_MAX_CHANNELS)
 		return -EINVAL;
+	addr->channel = array_index_nospec(addr->channel, IPMI_MAX_CHANNELS);
 	*lun = intf->channels[addr->channel].lun;
 	*saddr = intf->channels[addr->channel].address;
 	return 0;

