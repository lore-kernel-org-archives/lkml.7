Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E6CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEB521907
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569016083;
	bh=OEB9selO6qWOkLDV6zPRfKT8jxShJFah86gtPaMgXLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MnefvDQxzwQoU1KySgctzuMTKEyFcZ9EZl/+DXC4YFAX0D20fdTFRInAvX8fgd3g0
	 PqOTn5wI6g74afADvrW7waChRlhj80sjk7iZfKMWbWblq7g0kuKZTGPDxxctazjnmu
	 H7MBtmmnZ289ewANP56Y0RZSd9FKi4cqV5G9j8/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfITVsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfITVsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:48:02 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06098206C2;
        Fri, 20 Sep 2019 21:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569016081;
        bh=OEB9selO6qWOkLDV6zPRfKT8jxShJFah86gtPaMgXLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQ5180kTJU8tOgJkw7uiK3T0p+qkq7+9nc3VkAeAHrbAiNr5WR2fGa/EZLW1aF+f/
         fXapMq6noAV7C28cDFIkySz4h9qKih8F4SN4uA9OvjVlvhPdXWGCP7vabJXhbf+JET
         S5sLzYd/Ejy5YkturfUtvDYL7BaFotTLN/7ETF1U=
Date:   Fri, 20 Sep 2019 14:47:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] dm-crypt error when CONFIG_CRYPTO_AUTHENC is disabled
Message-ID: <20190920214758.GA162854@gmail.com>
Mail-Followup-To: Mike Snitzer <snitzer@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20190920154434.GA923@gandi.net>
 <20190920173707.GA21143@redhat.com>
 <13e25b01-f344-ea1d-8f6c-9d0a60eb1e0f@gmail.com>
 <20190920212746.GA22061@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920212746.GA22061@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 05:27:46PM -0400, Mike Snitzer wrote:
> On Fri, Sep 20 2019 at  3:21pm -0400,
> Milan Broz <gmazyland@gmail.com> wrote:
> 
> > On 20/09/2019 19:37, Mike Snitzer wrote:
> > > On Fri, Sep 20 2019 at 11:44am -0400,
> > > Thibaut Sautereau <thibaut.sautereau@clip-os.org> wrote:
> > > 
> > >> Hi,
> > >>
> > >> I just got a dm-crypt "crypt: Error allocating crypto tfm" error when
> > >> trying to "cryptsetup open" a volume. I found out that it was only
> > >> happening when I disabled CONFIG_CRYPTO_AUTHENC.
> > >>
> > >> drivers/md/dm-crypt.c includes the crypto/authenc.h header and seems to
> > >> use some CRYPTO_AUTHENC-related stuff. Therefore, shouldn't
> > >> CONFIG_DM_CRYPT select CONFIG_CRYPTO_AUTHENC?
> > > 
> > > Yes, it looks like commit ef43aa38063a6 ("dm crypt: add cryptographic
> > > data integrity protection (authenticated encryption)") should've added
> > > 'select CRYPTO_AUTHENC' to dm-crypt's Kconfig.  I'll let Milan weigh-in
> > > but that seems like the right way forward.
> > 
> > No, I don't this so. It is like you use some algorithm that is just not compiled-in,
> > or it is disabled in the current state (because of FIPS mode od so) - it fails
> > to initialize it.
> > 
> > I think we should not force dm-crypt to depend on AEAD - most users
> > do not use authenticated encryption, it is perfectly ok to keep this compiled out.
> > 
> > I do not see any principal difference from disabling any other crypto
> > (if you disable XTS mode, it fails to open device that uses it).
> > 
> > IMO the current config dependence is ok.
> 
> That is a good point.  I hadn't considered the kernel compiles just fine
> without CRYPTO_AUTHENC.. which it clearly does.
> 
> SO I retract the question/thought of updating the Kconfig for dm-crypt
> in my previous mail.
> 
> Though in hindsight: wonder whether the dm-integrity based dm-crypt
> authenticated encryption support should have been exposed as a proper
> CONFIG option within the DM_CRYPT section?  Rather than lean on the
> crypto subsystem to happily stub out the dm-crypt AEAD and AUTHENC
> related code dm-crypt could've established #ifdef boundaries for that
> code.
> 
> I'm open to suggestions and/or confirmation that the way things are now
> is perfectly fine.  But I do see this report as something that should
> drive some improvement.
> 

FWIW, I think you're being saved right now by the craziness in the crypto
subsystem Kconfig options: CONFIG_DM_CRYPT selects CONFIG_CBC, which selects
CONFIG_CRYPTO_MANAGER, which selects CONFIG_CRYPTO_MANAGER2, which selects
CONFIG_CRYPTO_AEAD2 (and all the other algorithm types, for that matter).
This makes the AEAD API available.

If this wasn't the case, dm-crypt's use of crypto_alloc_aead() would be causing
a link error in some kernel configurations, since CONFIG_DM_CRYPT doesn't
actually select the AEAD API itself.

At some point I (or someone else up to the task) might try to fix the crypto
subsystem to not make every template select every algorithm type.  In that
happens, we'll need to update the users like dm-crypt to explicitly select the
algorithm types they're using, if they were being implicitly selected before.

In any case, allowing users to compile out the AEAD support in dm-crypt would
also be nice if it's not too difficult, since not everyone needs it.

- Eric
