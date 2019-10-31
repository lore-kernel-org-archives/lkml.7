Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362D5CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0079D21734
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NtDoHHgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfJaPtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:49:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48424 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbfJaPtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:49:33 -0400
Received: from nazgul.tnic (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B26F1EC0CDE;
        Thu, 31 Oct 2019 16:49:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572536968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y5xotETdYxC/qXscPBu87/2M7mA/G8jPv3JiPD0/WkA=;
        b=NtDoHHgnVBKNgT+xyKi0TH8lKc6DqoIVJUtKnkIMMRlllvJ4G/H9Vj7mlujLChw8Idj1kc
        4Y7vC3KPDagdJdhKEUH0/Sb8eKRt1ESVW1OZG8bsuMymMQTZvKvf6rriklnGg+4WFOCa5O
        iY1vkHsIGDaKrdk1l/wXgrzDGlg5554=
Date:   Thu, 31 Oct 2019 16:49:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/ioremap: Use WARN_ONCE instead of printk() +
 WARN_ON_ONCE()
Message-ID: <20191031154916.GA24152@nazgul.tnic>
References: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com>
 <20191031110304.GE21133@nazgul.tnic>
 <5DBACB61.90809@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5DBACB61.90809@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 07:54:09PM +0800, zhong jiang wrote:
> Look at this again, It should not works. Because that will change the logical.
> if phys_addr_valid is false, we should drop out in time.

That you can do too:

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index a39dcdb5ae34..13f44cc064af 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -171,12 +171,10 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	if (!size || last_addr < phys_addr)
 		return NULL;
 
-	if (!phys_addr_valid(phys_addr)) {
-		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
-		       (unsigned long long)phys_addr);
-		WARN_ON_ONCE(1);
+	if (WARN_ONCE(!phys_addr_valid(phys_addr),
+	    "ioremap: invalid physical address %llx\n",
+	    (unsigned long long)phys_addr))
 		return NULL;
-	}
 
 	__ioremap_check_mem(phys_addr, size, &io_desc);
 
---

I'm not sure whether we care about printing every invalid address, as
Joe points out. Maybe we do... *shrug*

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
