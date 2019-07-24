Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF71AC41517
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890812147A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMWGhYPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfGXOhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:37:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45287 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:37:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so21054505pfq.12;
        Wed, 24 Jul 2019 07:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=pRKU9ZsfXWZZ6HXEE4+hVO3uJ28ZYXaqoFlhsjaVxi4=;
        b=fMWGhYPKcg1fuDOKsGn8CYQvFZAuaZIB7tE7rMgC6NDQMQBj/0QyzUrxlcMRlxEVmF
         tK4epoaqK+H6dO7CaiBn8iUtWOnmg4cgxB50ddYJ0cyMj3vqRSHq/UzwpFXmX84IRMY8
         EyMM1e6q/T9MUftK6cipdFzbgiToXfk7+wN48E9vtlyuuJzCN0O0AxT7mqgSrtnCsHpi
         hJ6AAzho5nsiJ1zs1GBclFkV5ZMU2vunN6zBr86IRYe+FIzZixZFVa63kqSwgg0R0kxl
         1v2Nx+qe+2AwFjY+Ix/1sMbLh9YdLfLpDSpa+QIYTYdmeLIMG1vY1x6fVMVBybk5NgU+
         t1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=pRKU9ZsfXWZZ6HXEE4+hVO3uJ28ZYXaqoFlhsjaVxi4=;
        b=MP52jop4GxSbHrZerhNssakyAyvNfjBNJfDxr20oZsjuRFh7NETq72HerfR7z/vlXX
         XW8RBI3I1KuwrXAwzr5LISFXhWGkrJosKxY5tfq5egupoEdYzqPXociVES3FLD1KO7WL
         KH7Wqh9r7jvgc7+PXVRFGQrpRecx080Ee8nd40LT6sClpJWW2ODJy1lh8bR0bPJm2jr9
         uP+xhlE5JL/tnPhY2O/fgM1LEnOYNLapPxqlUftDiEIA/qA6Uj8PoQQLq85nNk2F02p3
         4vdXYnRWq06umN+4dVJ9qLLBHlF25ZVP7cOSGnMkZjPsBSSp1pzBRO719fXJdXYuCCxv
         Q1Wg==
X-Gm-Message-State: APjAAAUv5HTuwz2o994Eki3OqSbnrDHCl/pA+r4QvUCAwWq7YJEo78cE
        nMJE/oTmRqBKUvSQ8slyBNRZHHkm
X-Google-Smtp-Source: APXvYqwieKraIPU1vuqXBs2P3vEya9b94cEWHxfDEQcWqcn/r7eQv2O5QuSQBdz7xh3zbcwKr7DllQ==
X-Received: by 2002:a62:35c6:: with SMTP id c189mr11694721pfa.96.1563979036030;
        Wed, 24 Jul 2019 07:37:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v14sm47825090pfm.164.2019.07.24.07.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 07:37:14 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] usb: typec: tcpm: Add NULL check before dereferencing config
Date:   Wed, 24 Jul 2019 07:37:12 -0700
Message-Id: <1563979032-25292-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When instantiating tcpm on an NXP OM 13588 board with NXP PTN5110,
the following crash is seen when writing into the 'preferred_role'
sysfs attribute.

Unable to handle kernel NULL pointer dereference at virtual address 00000028
pgd = f69149ad
[00000028] *pgd=00000000
Internal error: Oops: 5 [#1] THUMB2
Modules linked in: tcpci tcpm
CPU: 0 PID: 1882 Comm: bash Not tainted 5.1.18-sama5-armv7-r2 #4
Hardware name: Atmel SAMA5
PC is at tcpm_try_role+0x3a/0x4c [tcpm]
LR is at tcpm_try_role+0x15/0x4c [tcpm]
pc : [<bf8000e2>]    lr : [<bf8000bd>]    psr: 60030033
sp : dc1a1e88  ip : c03fb47d  fp : 00000000
r10: dc216190  r9 : dc1a1f78  r8 : 00000001
r7 : df4ae044  r6 : dd032e90  r5 : dd1ce340  r4 : df4ae054
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : df4ae044
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment none
Control: 50c53c7d  Table: 3efec059  DAC: 00000051
Process bash (pid: 1882, stack limit = 0x6a6d4aa5)
Stack: (0xdc1a1e88 to 0xdc1a2000)
1e80:                   dd05d808 dd1ce340 00000001 00000007 dd1ce340 c03fb4a7
1ea0: 00000007 00000007 dc216180 00000000 00000000 c01e1e03 00000000 00000000
1ec0: c0907008 dee98b40 c01e1d5d c06106c4 00000000 00000000 00000007 c0194e8b
1ee0: 0000000a 00000400 00000000 c01a97db dc22bf00 ffffe000 df4b6a00 df745900
1f00: 00000001 00000001 000000dd c01a9c2f 7aeab3be c0907008 00000000 dc22bf00
1f20: c0907008 00000000 00000000 00000000 00000000 7aeab3be 00000007 dee98b40
1f40: 005dc318 dc1a1f78 00000000 00000000 00000007 c01969f7 0000000a c01a20cb
1f60: dee98b40 c0907008 dee98b40 005dc318 00000000 c0196b9b 00000000 00000000
1f80: dee98b40 7aeab3be 00000074 005dc318 b6f3bdb0 00000004 c0101224 dc1a0000
1fa0: 00000004 c0101001 00000074 005dc318 00000001 005dc318 00000007 00000000
1fc0: 00000074 005dc318 b6f3bdb0 00000004 00000007 00000007 00000000 00000000
1fe0: 00000004 be800880 b6ed35b3 b6e5c746 60030030 00000001 00000000 00000000
[<bf8000e2>] (tcpm_try_role [tcpm]) from [<c03fb4a7>] (preferred_role_store+0x2b/0x5c)
[<c03fb4a7>] (preferred_role_store) from [<c01e1e03>] (kernfs_fop_write+0xa7/0x150)
[<c01e1e03>] (kernfs_fop_write) from [<c0194e8b>] (__vfs_write+0x1f/0x104)
[<c0194e8b>] (__vfs_write) from [<c01969f7>] (vfs_write+0x6b/0x104)
[<c01969f7>] (vfs_write) from [<c0196b9b>] (ksys_write+0x43/0x94)
[<c0196b9b>] (ksys_write) from [<c0101001>] (ret_fast_syscall+0x1/0x62)

Since commit 96232cbc6c994 ("usb: typec: tcpm: support get typec and pd
config from device properties"), the 'config' pointer in struct tcpc_dev
is optional when registering a Type-C port. Since it is optional, we have
to check if it is NULL before dereferencing it.

Reported-by: Douglas Gilbert <dgilbert@interlog.com>
Fixes: 96232cbc6c994 ("usb: typec: tcpm: support get typec and pd config from device properties")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Doug:
    I didn't add your Tested-by: since I added more code.
    It would be great if you can re-test.

 drivers/usb/typec/tcpm/tcpm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index fba32d84e578..77f71f602f73 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -379,7 +379,8 @@ static enum tcpm_state tcpm_default_state(struct tcpm_port *port)
 			return SNK_UNATTACHED;
 		else if (port->try_role == TYPEC_SOURCE)
 			return SRC_UNATTACHED;
-		else if (port->tcpc->config->default_role == TYPEC_SINK)
+		else if (port->tcpc->config &&
+			 port->tcpc->config->default_role == TYPEC_SINK)
 			return SNK_UNATTACHED;
 		/* Fall through to return SRC_UNATTACHED */
 	} else if (port->port_type == TYPEC_PORT_SNK) {
@@ -4114,7 +4115,7 @@ static int tcpm_try_role(const struct typec_capability *cap, int role)
 	mutex_lock(&port->lock);
 	if (tcpc->try_role)
 		ret = tcpc->try_role(tcpc, role);
-	if (!ret && !tcpc->config->try_role_hw)
+	if (!ret && (!tcpc->config || !tcpc->config->try_role_hw))
 		port->try_role = role;
 	port->try_src_count = 0;
 	port->try_snk_count = 0;
@@ -4701,7 +4702,7 @@ static int tcpm_copy_caps(struct tcpm_port *port,
 	port->typec_caps.prefer_role = tcfg->default_role;
 	port->typec_caps.type = tcfg->type;
 	port->typec_caps.data = tcfg->data;
-	port->self_powered = port->tcpc->config->self_powered;
+	port->self_powered = tcfg->self_powered;
 
 	return 0;
 }
-- 
2.7.4

