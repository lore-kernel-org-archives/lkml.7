Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DA3C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 04:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAEF21823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 04:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLFEgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 23:36:03 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:50930 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726273AbfLFEgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 23:36:03 -0500
Received: from mr5.cc.vt.edu (mr5.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xB64a2HE026999
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 23:36:02 -0500
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xB64Zv87003848
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 23:36:02 -0500
Received: by mail-qv1-f69.google.com with SMTP id bt18so3475328qvb.19
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 20:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=wa7TpTud7BRmM1OncVOI6zNrtzmUU/qh5/8FLa3ECNc=;
        b=dV5IQqs2WE/iO76krz4ciKEWil9t+JAnqZPN4z3Sh9Hoegy5i7OyoCYIo6ycJCbpNn
         8V7Hqj7Y0/s/bxdcBCTPQB2D0tg44tpPiJDlVbzpZCggEFbk76RuegWI+90fNnUTOG21
         R/6i64XloFwCOVCV5FXPWL9PGzQLQQKPSLOkGplVWVwTVoZ5AXcda8wem7r48OKxEfZp
         lGKbXkxhZKVVG/cBTWhOiTCYTrvIu0JZ/xrefGAHlxHh9ytBO8+IxndvWDKalqg/jdsc
         S/Ias2Mamfb+f4depYhovhmg6lW1TLwpuBbU7YUI9MP/sCPc94Q9JCEthAY0y3FwUBbU
         Tsrg==
X-Gm-Message-State: APjAAAXuhFccsdHOi9ParHDv1OrWa1r36H8+AYglvFZESopufdybVfWU
        9rfzQZjg2Fb1HAEaWOhQeAAdsw5I5jCuRjkRgVUR8bmZWq/yItBkxIWkyQ7ZJeT1pxs96QnoSM0
        E/KVSoaUkccMtTBdL5YKgVZ8Q12jX+KlSQt4=
X-Received: by 2002:aed:34a3:: with SMTP id x32mr10861545qtd.309.1575606957164;
        Thu, 05 Dec 2019 20:35:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcw+aA4bY8kUCawJ7vXDs8h9Z3JViFc4IwTZ8GjU1avmodlaNollM4LciqXqziLL8LmvCihw==
X-Received: by 2002:aed:34a3:: with SMTP id x32mr10861533qtd.309.1575606956904;
        Thu, 05 Dec 2019 20:35:56 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id p188sm5656184qkb.94.2019.12.05.20.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 20:35:55 -0800 (PST)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/build: provide missing include file for capflags.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 05 Dec 2019 23:35:54 -0500
Message-ID: <59982.1575606954@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with C=2, sparse warns about missing definitions:

  CHECK   arch/x86/kernel/cpu/capflags.c
arch/x86/kernel/cpu/capflags.c:5:12: warning: symbol 'x86_cap_flags' was not declared. Should it be static?
arch/x86/kernel/cpu/capflags.c:261:12: warning: symbol 'x86_bug_flags' was not declared. Should it be static?

Make the script that generates the C file create the needed #include.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/arch/x86/kernel/cpu/mkcapflags.sh b/arch/x86/kernel/cpu/mkcapflags.sh
index aed45b8895d5..f26caa6b6f2d 100644
--- a/arch/x86/kernel/cpu/mkcapflags.sh
+++ b/arch/x86/kernel/cpu/mkcapflags.sh
@@ -56,6 +56,10 @@ trap 'rm "$OUT"' EXIT
 	echo "#include <asm/cpufeatures.h>"
 	echo "#endif"
 	echo ""
+	echo "#ifndef _ASM_X86_CPUFEATURE_H"
+	echo "#include <asm/cpufeature.h>"
+	echo "#endif"
+	echo ""
 
 	dump_array "x86_cap_flags" "NCAPINTS*32" "X86_FEATURE_" ""
 	echo ""


