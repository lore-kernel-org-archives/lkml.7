Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA5DC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 15:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3572173B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566143697;
	bh=ZWafWvHOSPFwrkkmemNoHUGxdVDsJJv5r+k4/hJt6Go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SV09qKivlSmeheMfnhKuRSVbkCHGGA0V33MZtTlQCy9aMRCcXcuEYhP+8QxC4m3tX
	 8P3oo7ZGJ8QACZliV07rnlczasL7D90rKeJRf65xlw7wP2BBaajjXfmQfYSOSqAqFo
	 9eYmzzWFA3uQ5uUYC9O2828D6e3NcF/zgmhpC7fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfHRPy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 11:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHRPy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 11:54:56 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D50920851;
        Sun, 18 Aug 2019 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566143694;
        bh=ZWafWvHOSPFwrkkmemNoHUGxdVDsJJv5r+k4/hJt6Go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zmy4Da5WjUvdWkpI/6oYHU4y5e3v1ssH0hPPUH1md+On3mtmnqGJ5k0HjFvkvrXkK
         rSz5w2uMbpm1qWWsaB3hUBT+NPVQWR8V1Jm771gR1r76NTisT8YaxvKFf2RCIkELIy
         bF9YfweOIgxPEwEKO1GTTJy/lW1oEILuCil5Yky0=
Date:   Sun, 18 Aug 2019 08:54:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] crypto: sha256 - Move lib/sha256.c to lib/crypto
Message-ID: <20190818155453.GC1118@sol.localdomain>
Mail-Followup-To: Hans de Goede <hdegoede@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190816211611.2568-1-hdegoede@redhat.com>
 <20190816211611.2568-4-hdegoede@redhat.com>
 <20190817051942.GB8209@sol.localdomain>
 <909d255d-a648-13b5-100f-fe67be547961@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <909d255d-a648-13b5-100f-fe67be547961@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 10:28:04AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 17-08-19 07:19, Eric Biggers wrote:
> > On Fri, Aug 16, 2019 at 11:16:08PM +0200, Hans de Goede wrote:
> > > diff --git a/include/linux/sha256.h b/include/crypto/sha256.h
> > > similarity index 100%
> > > rename from include/linux/sha256.h
> > > rename to include/crypto/sha256.h
> > 
> > <crypto/sha.h> already has the declarations for both SHA-1 and SHA-2, including
> > SHA-256.  So I'm not sure a separate sha256.h is appropriate.  How about putting
> > these declarations in <crypto/sha.h>?
> 
> The problems with that is that the sha256_init, etc. names are quite generic
> and they have not been reserved before, so a lot of the crypto hw-accel
> drivers use them, for private file-local (static) code, e.g.:
> 
> [hans@shalem linux]$ ack -l sha256_init
> include/crypto/sha256.h
> drivers/crypto/marvell/hash.c
> drivers/crypto/ccp/ccp-ops.c
> drivers/crypto/nx/nx-sha256.c
> drivers/crypto/ux500/hash/hash_core.c
> drivers/crypto/inside-secure/safexcel_hash.c
> drivers/crypto/chelsio/chcr_algo.h
> drivers/crypto/stm32/stm32-hash.c
> drivers/crypto/omap-sham.c
> drivers/crypto/padlock-sha.c
> drivers/crypto/n2_core.c
> drivers/crypto/atmel-aes.c
> drivers/crypto/axis/artpec6_crypto.c
> drivers/crypto/mediatek/mtk-sha.c
> drivers/crypto/qat/qat_common/qat_algs.c
> drivers/crypto/img-hash.c
> drivers/crypto/ccree/cc_hash.c
> lib/crypto/sha256.c
> arch/powerpc/crypto/sha256-spe-glue.c
> arch/mips/cavium-octeon/crypto/octeon-sha256.c
> arch/x86/purgatory/purgatory.c
> arch/s390/crypto/sha256_s390.c
> arch/s390/purgatory/purgatory.c
> 
> (in case you do not know ack is a smarter grep, which skips .o files, etc.)

You need to match at word boundaries to avoid matching on ${foo}_sha256_init().
So it's actually a somewhat shorter list:

$ git grep -l -E '\<sha(224|256)_(init|update|final)\>'
arch/arm/crypto/sha256_glue.c
arch/arm/crypto/sha256_neon_glue.c
arch/arm64/crypto/sha256-glue.c
arch/s390/crypto/sha256_s390.c
arch/s390/purgatory/purgatory.c
arch/x86/crypto/sha256_ssse3_glue.c
arch/x86/purgatory/purgatory.c
crypto/sha256_generic.c
drivers/crypto/ccree/cc_hash.c
drivers/crypto/chelsio/chcr_algo.h
drivers/crypto/n2_core.c
include/linux/sha256.h
lib/sha256.c

5 of these are already edited by this patchset, so that leaves only 8 files.

> 
> All these do include crypto/sha.h and putting the stuff which is in what
> was linux/sha256.h into crypto/sha.h leads to name collisions which causes
> more churn then I would like this series to cause.
> 
> I guess we could do a cleanup afterwards, with one patch per file above
> to fix the name collision issue, and then merge the 2 headers. I do not
> want to do that for this series, as I want to keep this series as KISS
> as possible since it is messing with somewhat sensitive stuff.
> 
> And TBH I even wonder if a follow-up series is worth the churn...
> 

I think it should be done; the same was done when introducing the AES library.
But I'm okay with it being done later, if you want to keep this patchset
shorter.

- Eric
