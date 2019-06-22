Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAFEC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C32E20665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RgSK7WpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfFVKQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:16:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFVKQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:16:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MAGGoN2098588
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:16:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MAGGoN2098588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198576;
        bh=UgCLYyRcladY/2LueQdl/LrGBuzcBspTlrRUs69Hjy0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=RgSK7WpNsOSHvo14Gr2rqZ1YQL1hUQoueeoZ9ez5njIIIbe+oaH5iCd85JZKuyN2e
         YvvO7c8oYc1DpMhQ3OTBsQCtXlIIe3qcxmgcRzJ1FmdZ1Br6eguExU7BZ6LYxpCCNm
         Ju5eu8JtuI1owqzipHNWAgLHYPuW9JzLzG/v/VyqWs7LsEiD8AFSkr/nbaIeLxD4ak
         DqMVLhuku0EUKPlpukI1RXEuvKlz4vupufZ3Zv+olFF7aQ8vKIXlKsh5v/oR56cNhN
         73d/kaBqFs/HA/q7CUGkQBzxkB7l14Nd2I4ljm47tdXTpL9ZskhfXwpt/ZobsO+j7H
         XLXbN3gtKSqpg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MAGFSg2098585;
        Sat, 22 Jun 2019 03:16:15 -0700
Date:   Sat, 22 Jun 2019 03:16:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-0a05fa67e62c73baad2a7d0fa20e8f96896c1093@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Reply-To: andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, bp@alien8.de, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190617115537.33309-1-andriy.shevchenko@linux.intel.com>
References: <20190617115537.33309-1-andriy.shevchenko@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpu: Split Tremont based Atoms from the rest
Git-Commit-ID: 0a05fa67e62c73baad2a7d0fa20e8f96896c1093
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

Commit-ID:  0a05fa67e62c73baad2a7d0fa20e8f96896c1093
Gitweb:     https://git.kernel.org/tip/0a05fa67e62c73baad2a7d0fa20e8f96896c1093
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Mon, 17 Jun 2019 14:55:37 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:45:57 +0200

x86/cpu: Split Tremont based Atoms from the rest

Split Tremont based Atoms from the rest to keep logical grouping.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20190617115537.33309-1-andriy.shevchenko@linux.intel.com

---
 arch/x86/include/asm/intel-family.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 087de5d3b93a..c92a367a4a7a 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -74,6 +74,7 @@
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
 #define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denverton */
 #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
+
 #define INTEL_FAM6_ATOM_TREMONT_X	0x86 /* Jacobsville */
 
 /* Xeon Phi */
