Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9759C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E72217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="zS/bVLGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfGXSLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:11:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35015 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfGXSLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:11:46 -0400
Received: by mail-ed1-f67.google.com with SMTP id w20so47884159edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=O8BpPykOGPMrcNWO68vuYRL0O4QY5mFmWnwLnMdbXek=;
        b=zS/bVLGPe7Biddu3tvwjxuJoE7XfssHm9A/D8B3sP1tRSW0ABm1Zr3GTP948ZUZoYk
         rRQk1qET++mJxWEizDZAZlrHpxRur3R4IwaejxU3NgmAAP0EBUVI+lb/54oEy/WdTZ9h
         SKobC8Q0AWyJr5Kk/XAxuCZLeTUzOg78ZegpDU6YlMXhQWYFdKRsi9QpqYTrCqUIgbEI
         vNQ4oIeVdvyPQLBmKqZdyuQkJeTgbO5xafzcXSyUD1eoBeiiEoSACykaToz9efeG/xQZ
         Opm842qAOGZH9V/l9cbqIRV8TfquUXfLQlDvLLZl8EPUa/YUvwrY6sdElsmQdqZvgcDS
         tdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O8BpPykOGPMrcNWO68vuYRL0O4QY5mFmWnwLnMdbXek=;
        b=OW7HalopPhISxJ82D95vINoX2szbIIIWEqGA9GtHXicdxia32DkjLJLbd21o1RdhHv
         pySAu7ENUgCsZrZlgIM7K31dKsocnIJEi5Bbl67wHIW+7Rv77OrA5Hnp9232IKFurEMz
         YRwIdYiQO9I4nfTjo3tpmtlD5zKz+NfGmWfairjOd/fDYhQdN97rke9PUC75vYl7xzLY
         GAoCAPMNylrnxyFHolxVLrptja6SVxAywTPWIo2lD4EjuwwtPC+nTuaqjXwOqpYHYo5m
         ML6RupBY1HNIFtpZAhkN/MXliR44MThuCj39PLyecrWRQWaq8yTBm8DGB3FSli9Csfx9
         b8Jw==
X-Gm-Message-State: APjAAAWXawob1MDvsDzWyHKcgHLEmhjrdG4pFgoGg6i7hoX/N2Esj9YR
        QAqwXZY8/ZA51HuKFbE7wCw=
X-Google-Smtp-Source: APXvYqwHZDCykwuaTSueWVYio2HcO73aA9TvoYdpNFeI/tjrkP+9Vh22NPhDR7Ipv0BvDyCS4iR4qQ==
X-Received: by 2002:a17:906:2f0f:: with SMTP id v15mr61261234eji.33.1563991904593;
        Wed, 24 Jul 2019 11:11:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o11sm9407138ejd.68.2019.07.24.11.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 11:11:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 00DBA10169F; Wed, 24 Jul 2019 21:11:39 +0300 (+03)
Date:   Wed, 24 Jul 2019 21:11:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
 DMA masks
Message-ID: <20190724181139.yebja5yflzjgfxlx@box>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
 <20190724155530.hlingpcirjcf2ljg@box>
 <acee0a74-77fc-9c81-087b-ce55abf87bd4@amd.com>
 <a89e7574-096d-9105-45ff-34bbb74918a5@arm.com>
 <c4110c6b-686c-7e77-fedc-33782e5b3e50@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4110c6b-686c-7e77-fedc-33782e5b3e50@amd.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 05:34:26PM +0000, Lendacky, Thomas wrote:
> On 7/24/19 12:06 PM, Robin Murphy wrote:
> > On 24/07/2019 17:42, Lendacky, Thomas wrote:
> >> On 7/24/19 10:55 AM, Kirill A. Shutemov wrote:
> >>> On Wed, Jul 10, 2019 at 07:01:19PM +0000, Lendacky, Thomas wrote:
> >>>> @@ -351,6 +355,32 @@ bool sev_active(void)
> >>>>   }
> >>>>   EXPORT_SYMBOL(sev_active);
> >>>>   +/* Override for DMA direct allocation check -
> >>>> ARCH_HAS_FORCE_DMA_UNENCRYPTED */
> >>>> +bool force_dma_unencrypted(struct device *dev)
> >>>> +{
> >>>> +    /*
> >>>> +     * For SEV, all DMA must be to unencrypted addresses.
> >>>> +     */
> >>>> +    if (sev_active())
> >>>> +        return true;
> >>>> +
> >>>> +    /*
> >>>> +     * For SME, all DMA must be to unencrypted addresses if the
> >>>> +     * device does not support DMA to addresses that include the
> >>>> +     * encryption mask.
> >>>> +     */
> >>>> +    if (sme_active()) {
> >>>> +        u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
> >>>> +        u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
> >>>> +                        dev->bus_dma_mask);
> >>>> +
> >>>> +        if (dma_dev_mask <= dma_enc_mask)
> >>>> +            return true;
> >>>
> >>> Hm. What is wrong with the dev mask being equal to enc mask? IIUC, it
> >>> means that device mask is wide enough to cover encryption bit, doesn't it?
> >>
> >> Not really...  it's the way DMA_BIT_MASK works vs bit numbering. Let's say
> >> that sme_me_mask has bit 47 set. __ffs64 returns 47 and DMA_BIT_MASK(47)
> >> will generate a mask without bit 47 set (0x7fffffffffff). So the check
> >> will catch anything that does not support at least 48-bit DMA.
> > 
> > Couldn't that be expressed as just:
> > 
> >     if (sme_me_mask & dma_dev_mask == sme_me_mask)
> 
> Actually !=, but yes, it could have been done like that, I just didn't
> think of it.

I'm looking into generalizing the check to cover MKTME.

Leaving	off the Kconfig changes and moving the check to other file, doest
the change below look reasonable to you. It's only build tested so far.

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index fece30ca8b0c..6c86adcd02da 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -355,6 +355,8 @@ EXPORT_SYMBOL(sev_active);
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
+	u64 dma_enc_mask;
+
 	/*
 	 * For SEV, all DMA must be to unencrypted addresses.
 	 */
@@ -362,18 +364,20 @@ bool force_dma_unencrypted(struct device *dev)
 		return true;
 
 	/*
-	 * For SME, all DMA must be to unencrypted addresses if the
-	 * device does not support DMA to addresses that include the
-	 * encryption mask.
+	 * For SME and MKTME, all DMA must be to unencrypted addresses if the
+	 * device does not support DMA to addresses that include the encryption
+	 * mask.
 	 */
-	if (sme_active()) {
-		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
-		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
-						dev->bus_dma_mask);
+	if (!sme_active() && !mktme_enabled())
+		return false;
 
-		if (dma_dev_mask <= dma_enc_mask)
-			return true;
-	}
+	dma_enc_mask = sme_me_mask | mktme_keyid_mask();
+
+	if (dev->coherent_dma_mask && (dev->coherent_dma_mask & dma_enc_mask) != dma_enc_mask)
+		return true;
+
+	if (dev->bus_dma_mask && (dev->bus_dma_mask & dma_enc_mask) != dma_enc_mask)
+		return true;
 
 	return false;
 }
-- 
 Kirill A. Shutemov
