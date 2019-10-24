Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5850CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF692166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="fvXE2XfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438545AbfJXJaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:30:21 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25401 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732032AbfJXJaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:30:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571909372; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RGcytpkcewegJVEiw7Osb36GQgBJwXF7z4OYlbQODEOZn0zzLSaluebUjgyaN5BOXGpAzi/EeufFj4XgXB3ERZU4fi7RMd05VN6vsHG+KqwMMOB2hF72Vg/TzyZA238rny8h+zPvtoXQ/xdBkyE7srypocPD/2IkNYhiFrosInk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571909372; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=Q/4rGbVZyQuUGq0iZ44tLzODrxmkBjBJWNbgus33LnQ=; 
        b=l+iRk4R3inceE1/UKtNjQve/6Lw8XvgmWSKxprLcKEWYcgkFvzz7/S3E8XnC88gk3HINXlALwcJ2O3nXIi7kkTvvyVtJ0+JOZw5pXzAZGyhnKokh7hSwDjzVL342b5cJC1ViPVoHi38PvWu3JW55RNiSH7I5CP8l1Ht+0L9otuA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=nRMmBKVkrFjS71ZbWi8ka2B73mPbbbwkJjnU4kK0ItfZFl881GHbpltCanAoDkxR+F9bU2qKssqE
    t5LZ827c3AWXP4PcC+pXK8Ppgk1PDPYrw4XzRapnMsLcBgTS6Z0q  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571909372;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=892;
        bh=Q/4rGbVZyQuUGq0iZ44tLzODrxmkBjBJWNbgus33LnQ=;
        b=fvXE2XfFwARSwikeEvk9KFVD1OpQHYe6IXpnrPcUJJH5WAeAfhL0jd0ByNyxXdW4
        okBZIzGva9dfsFUvxYUTNXhtSfX5SdpJirruNM6tYiHdj7YA1Gt/UFmcLNEL+4lZ+xh
        55me5nYU8zWGzZJkQMdNywAbM1tb2rYhh+5GyHQs=
Received: from zhouyanjie-virtual-machine.localdomain (182.148.156.27 [182.148.156.27]) by mx.zohomail.com
        with SMTPS id 1571909368329755.0229216143092; Thu, 24 Oct 2019 02:29:28 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        jhogan@kernel.org, gregkh@linuxfoundation.org,
        paul.burton@mips.com, chenhc@lemote.com, paul@crapouillou.net,
        tglx@linutronix.de, jiaxun.yang@flygoat.com
Subject: [PATCH 1/2] MIPS: Rename JZRISC to XBurst.
Date:   Thu, 24 Oct 2019 17:29:00 +0800
Message-Id: <1571909341-10108-2-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571909341-10108-1-git-send-email-zhouyanjie@zoho.com>
References: <1571909341-10108-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now in addition to the JZ line, Ingenic has added three product
lines X, T and M. and the real name of the CPU from Ingenic is
XBurst, not JZRISC.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 arch/mips/kernel/cpu-probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c2eb392..16033a4 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1951,7 +1951,7 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 	case PRID_IMP_XBURST:
 		c->cputype = CPU_XBURST;
 		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
-		__cpu_name[cpu] = "Ingenic JZRISC";
+		__cpu_name[cpu] = "Ingenic XBurst";
 		/*
 		 * The XBurst core by default attempts to avoid branch target
 		 * buffer lookups by detecting & special casing loops. This
-- 
2.7.4


