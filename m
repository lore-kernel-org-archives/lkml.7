Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF2CC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C182133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="I83VedrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfFZPQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:16:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60479 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfFZPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:16:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QFG74N4157838
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 08:16:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QFG74N4157838
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561562168;
        bh=X7NXGseKumNEiycbUaFlqHKZwn9YBPBWxfY85WvqOSQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=I83VedrXPWWbQ67uEUooqYlhy+29BQBG/HjPa37OB//s9DnRqw6KWKKEAOnAEoWM+
         rd0+O463nRWZKBNX0VNm/i9rPwdipkGyjzAj+5j/3fZl866VSSt1VG9y+/bACZg+iv
         YIHpR4p9Nei30tz7wrylxCTNvYIL1tHvFOVM83Uj9rOqGFQ67LKuhEqVuDIG1LYcqj
         lDaox1Xy/2YT275sARzyT/ORnom910WJofV7lHNzVPjcMVrC7CGMCza4bDujOJqQBI
         KhCp2wQmPXMKMDjsXh8F7+gMBIECIm1q5JKDZTp/znQgj9pVRYt68yk6e+4cfZcCxf
         oRqLsruMEhCIw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QFG6Gq4157822;
        Wed, 26 Jun 2019 08:16:06 -0700
Date:   Wed, 26 Jun 2019 08:16:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Geert Uytterhoeven <tipbot@zytor.com>
Message-ID: <tip-1bf72720281770162c87990697eae1ba2f1d917a@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, ben@decadent.org.uk,
        hpa@zytor.com, jpoimboe@redhat.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, geert@linux-m68k.org, jkosina@suse.cz,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, jkosina@suse.cz, geert@linux-m68k.org,
          gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
          ben@decadent.org.uk, jpoimboe@redhat.com
In-Reply-To: <20190516070935.22546-1-geert@linux-m68k.org>
References: <20190516070935.22546-1-geert@linux-m68k.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/urgent] cpu/speculation: Warn on unsupported mitigations=
 parameter
Git-Commit-ID: 1bf72720281770162c87990697eae1ba2f1d917a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1bf72720281770162c87990697eae1ba2f1d917a
Gitweb:     https://git.kernel.org/tip/1bf72720281770162c87990697eae1ba2f1d917a
Author:     Geert Uytterhoeven <geert@linux-m68k.org>
AuthorDate: Thu, 16 May 2019 09:09:35 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 16:56:21 +0200

cpu/speculation: Warn on unsupported mitigations= parameter

Currently, if the user specifies an unsupported mitigation strategy on the
kernel command line, it will be ignored silently.  The code will fall back
to the default strategy, possibly leaving the system more vulnerable than
expected.

This may happen due to e.g. a simple typo, or, for a stable kernel release,
because not all mitigation strategies have been backported.

Inform the user by printing a message.

Fixes: 98af8452945c5565 ("cpu/speculation: Add 'mitigations=' cmdline option")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190516070935.22546-1-geert@linux-m68k.org

---
 kernel/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 077fde6fb953..551db494f153 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2339,6 +2339,9 @@ static int __init mitigations_parse_cmdline(char *arg)
 		cpu_mitigations = CPU_MITIGATIONS_AUTO;
 	else if (!strcmp(arg, "auto,nosmt"))
 		cpu_mitigations = CPU_MITIGATIONS_AUTO_NOSMT;
+	else
+		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",
+			arg);
 
 	return 0;
 }
