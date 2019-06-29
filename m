Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722DCC5B577
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B42216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561837542;
	bh=aNGhjTlauXBAX1R2rS5eZelZ/isDvCGZ0ObqehgBCCw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=fCIv4pTza/4xcir7fhPqXw///sto8Q5nKUAkM80iz3GU59mf5xz2VXte8vVw3kk2w
	 5HWwfoCJRlK45/Rl3kKXbFBJKDspHIPLI4Sqoydo7Gf8GUOOugCI2tkbRDdvwobIOy
	 bEidFZuHmfyMUwufuYtXawrNkPEhIG1dzD4EYn4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfF2Tpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 15:45:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37401 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfF2Tpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 15:45:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so12002679wme.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=i9bIbekwL2VrPm4IMJP3CGrBD4pqZvbgGOnwWEwLu/4=;
        b=dosGB9LBpZoENBntDpfX7OFSMgwi097OfeyX66KQPNFehcu2EKMKd8XvkBqCfz/qYP
         lGDk8AraryQmCE0CZ1CeppOHu1yeBLWyj91DH5iHvNTVqqVvuutsT8e+awIKImLWFjgH
         P5xoqkqnc3EmPpDontgCNQxf+s2K12D2mE8Ev2rgkMaLVXVpI8V7TLC/K6KH+oocCsed
         DujczcaVAUdQXP5Gbjy/q9EuRh7CwH6OTXsA4MSWQi2Vhq6aW3kTkSMxdM3ieoLjJaCB
         mlDD51XRaZIGNq7JXmHthy7Kojv84jY3uLMB+c/2fGq1D3BtluuxqZeMiBY6Z4KnurK9
         qK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=i9bIbekwL2VrPm4IMJP3CGrBD4pqZvbgGOnwWEwLu/4=;
        b=La+2QfEpRp2hjjUSdMxkPZM5RhsPgiVHiES8lzuIY12Thgn4TdwXEH8H8wkpdBcnc2
         fhMiUjW07xExTiTwo7+sZh4IFFW5ZmJ5N3oR94LB22ciGYITOQRIf7HPhh7FPpJFTgnH
         YEBFHbzju/f78QXHb8+YPka1lkJGEBWFPgJeXDRF5JAPixWBKcuoRsTUkTgb0Iklej63
         caFLd/qFprWxHCNYaaUAzzh48yobqtVKej8JpiTYZXk73Vdwa4neaNKsJnofR+KnJ4Ak
         7v44CWTunL3WvhWOoBtY+IAU1gET6Ssw51s03VG1WZ0O1QEGW7tyDrTApZC5BgYNIPq8
         IqLA==
X-Gm-Message-State: APjAAAVTZWuZAynUMwjZqK6Omx/7uq+9tbRXJXNNgY/gBzJhp79wnGUQ
        +nuaUgJEHvTelOm6riBfx+E=
X-Google-Smtp-Source: APXvYqw3vVLgralcYhVGSLxP1N3OuaS+69tawKV+XMfV10gNkIpwTVEwl68Pu/BB21qYmhHLpW8xlw==
X-Received: by 2002:a7b:c310:: with SMTP id k16mr10713598wmj.133.1561837538153;
        Sat, 29 Jun 2019 12:45:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n5sm4475408wmi.21.2019.06.29.12.45.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 12:45:37 -0700 (PDT)
Date:   Sat, 29 Jun 2019 21:45:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] smp/urgent fixes
Message-ID: <20190629194535.GA79708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest smp-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus

   # HEAD: 33d4a5a7a5b4d02915d765064b2319e90a11cbde cpu/hotplug: Fix out-of-bounds read when setting fail state

Two fixes:

 - Fix an out of bounds access when writing nonsensical values to 
   /sys/devices/system/cpu/cpuX/hotplug/fail

 - Warn about unsupported mitigations= parameters.

 Thanks,

	Ingo

------------------>
Eiichi Tsukata (1):
      cpu/hotplug: Fix out-of-bounds read when setting fail state

Geert Uytterhoeven (1):
      cpu/speculation: Warn on unsupported mitigations= parameter


 kernel/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 077fde6fb953..ef1c565edc5d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1964,6 +1964,9 @@ static ssize_t write_cpuhp_fail(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (fail < CPUHP_OFFLINE || fail > CPUHP_ONLINE)
+		return -EINVAL;
+
 	/*
 	 * Cannot fail STARTING/DYING callbacks.
 	 */
@@ -2339,6 +2342,9 @@ static int __init mitigations_parse_cmdline(char *arg)
 		cpu_mitigations = CPU_MITIGATIONS_AUTO;
 	else if (!strcmp(arg, "auto,nosmt"))
 		cpu_mitigations = CPU_MITIGATIONS_AUTO_NOSMT;
+	else
+		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",
+			arg);
 
 	return 0;
 }
