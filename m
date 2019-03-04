Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FB9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9542082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZnGBaH1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfCDKAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:00:36 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42412 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfCDKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3KISdEsEat/4nexUPYnK+FWnprlUbr4DUHRy5J9S4g8=; b=ZnGBaH1/RZuMcN96Flh2wEeoA
        gUxGHW6MGJe1jFw1tpAuBA4OmAPCfmT1QooX/TR+OH5JWn3xXyo+mZ8E7r0JPTeEgTbLcYk9BV0XH
        WplgcmEoYGCTLehVzQITmb2Ume/leYMrBabzbkPxYLq6wCZZnT+IadyUE2VdDiUMZVTujoeKqFe68
        HeTiAqicr2pz3Z4EJ6HQiVoZkqH4Fb/7TYzE9YveZ3nXqCepKpP2FLe8zMM3NdJAWcIozdrrsSHif
        m2549ozPGF0indfkJ7Qv3jRQNeF8/1tjWZC+xWhV7m80GqX1xyhKfPXc8k6xXp2XhUVLyPIAZd1JV
        gJ24VjJVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0kOW-0003aB-Ld; Mon, 04 Mar 2019 10:00:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AEDF120295AAE; Mon,  4 Mar 2019 11:00:22 +0100 (CET)
Date:   Mon, 4 Mar 2019 11:00:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 02/17] drivers/net/b44: Align pwol_mask to unsigned
 long for better performance
Message-ID: <20190304100022.GA32477@hirez.programming.kicks-ass.net>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-3-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551494711-213533-3-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 06:44:56PM -0800, Fenghua Yu wrote:
> A bit in pwol_mask is set in b44_magic_pattern automatically by set_bit.
> set_bit sets the bit in a single unsigned long location. Since pwol_mask
> may not be aligned to unsigned long, the location may cross two cache
> lines and accessing the location degradates performance. On x86, accessing
> two cache lines in locked instruction in set_bit is called split lock and
> can cause overall performance degradation.
> 
> To avoid to impact performance by accessing two cache lines in set_bit,
> align pwol_mask to unsigned long.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  drivers/net/ethernet/broadcom/b44.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
> index 97ab0dd25552..bc544b6b9c3a 100644
> --- a/drivers/net/ethernet/broadcom/b44.c
> +++ b/drivers/net/ethernet/broadcom/b44.c
> @@ -1547,7 +1547,8 @@ static void b44_setup_pseudo_magicp(struct b44 *bp)
>  	u32 val;
>  	int plen0, plen1, plen2;
>  	u8 *pwol_pattern;
> -	u8 pwol_mask[B44_PMASK_SIZE];
> +	/* Align to unsigned long for better performance in set_bit() */
> +	u8 pwol_mask[B44_PMASK_SIZE] __aligned(sizeof(unsigned long));
>  
>  	pwol_pattern = kzalloc(B44_PATTERN_SIZE, GFP_KERNEL);
>  	if (!pwol_pattern)

That is truly horrid code. But afaict pwol_mask is local and never
exposed to concurrency, so _why_ does it need atomic bitset in the first
place?

Would not the below be a _much_ better solution?


diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 97ab0dd25552..0b4226b406b1 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1520,7 +1520,7 @@ static int b44_magic_pattern(u8 *macaddr, u8 *ppattern, u8 *pmask, int offset)
 
 	memset(ppattern + offset, 0xff, magicsync);
 	for (j = 0; j < magicsync; j++)
-		set_bit(len++, (unsigned long *) pmask);
+		__set_bit(len++, (unsigned long *) pmask);
 
 	for (j = 0; j < B44_MAX_PATTERNS; j++) {
 		if ((B44_PATTERN_SIZE - len) >= ETH_ALEN)
@@ -1532,7 +1532,7 @@ static int b44_magic_pattern(u8 *macaddr, u8 *ppattern, u8 *pmask, int offset)
 		for (k = 0; k< ethaddr_bytes; k++) {
 			ppattern[offset + magicsync +
 				(j * ETH_ALEN) + k] = macaddr[k];
-			set_bit(len++, (unsigned long *) pmask);
+			__set_bit(len++, (unsigned long *) pmask);
 		}
 	}
 	return len - 1;
