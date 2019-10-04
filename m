Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A86EC4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8EC21D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfJDULi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:11:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730942AbfJDULi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:11:38 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84E6D883CA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2019 20:11:37 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id o11so13801117iop.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 13:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=oefRLRHPUFRhefeZoPfYtoKI/frpILJv/HMoF+sATsw=;
        b=t2c5Dvv+9shmgakFuaUKsDCwewNPt/YpL5eiC0v9//gi8t9VX0IYxe22/kQ+/AiT6M
         990usJ+NyBCyillBWWsCoBF0giiS/Emx8kiGP0RzB8QXWMCqDBdGGR27godhKk2MaFfZ
         SPCI579UH9u/QWxRwT0ELCni6oLgOXgBqBeufqlA5jgY7ilktTqjs7AFKw5d3p4BGuoc
         9wMTrlyOyP9pVAGJ1kuXsL3oyL6OgxsTP6d2C/AqRPc/u3ikYSCQbET801kHji54OqJo
         8iR+ziy8e9LmK4j6UOQopWlfe1qfZye2IffL/rUZO1eRfr7I5kSs+i5RAtSTH6XLtzpq
         mBuQ==
X-Gm-Message-State: APjAAAVkJMmHCIllHTm+66YJ3hMM/WQV+MoWx0oaeSovFUyxYGYuuGtt
        iCwWxORfXCCu4xBkIfkkUMjcspfXpzYedPwp1eS0Nx/hl1GNNQ6wOQDmsGOw+jUb1aT1hcUivhW
        VdI30++hhRXMTa4q67tp7aqAs
X-Received: by 2002:a92:3bca:: with SMTP id n71mr18292797ilh.104.1570219896812;
        Fri, 04 Oct 2019 13:11:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy1qh//E7zUDQGLacjK8MB0QFfBwC6v81r/DwCPI28EUzHD5yO7QqL9crRHlqdxwAyYXmoNPg==
X-Received: by 2002:a92:3bca:: with SMTP id n71mr18292760ilh.104.1570219896550;
        Fri, 04 Oct 2019 13:11:36 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id f12sm2530228iob.58.2019.10.04.13.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 13:11:35 -0700 (PDT)
Date:   Fri, 4 Oct 2019 13:11:34 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Safford <david.safford@ge.com>,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-ID: <20191004201134.nuesk6hxtxajnxh2@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Safford <david.safford@ge.com>,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1570128827.5046.19.camel@linux.ibm.com>
 <20191003215125.GA30511@linux.intel.com>
 <20191003215743.GB30511@linux.intel.com>
 <1570140491.5046.33.camel@linux.ibm.com>
 <1570147177.10818.11.camel@HansenPartnership.com>
 <20191004182216.GB6945@linux.intel.com>
 <1570213491.3563.27.camel@HansenPartnership.com>
 <20191004183342.y63qdvspojyf3m55@cantor>
 <1570214574.3563.32.camel@HansenPartnership.com>
 <20191004200728.xoj6jlgbhv57gepc@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191004200728.xoj6jlgbhv57gepc@cantor>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 04 19, Jerry Snitselaar wrote:
>On Fri Oct 04 19, James Bottomley wrote:
>>On Fri, 2019-10-04 at 11:33 -0700, Jerry Snitselaar wrote:
>>>On Fri Oct 04 19, James Bottomley wrote:
>>>> On Fri, 2019-10-04 at 21:22 +0300, Jarkko Sakkinen wrote:
>>>> > On Thu, Oct 03, 2019 at 04:59:37PM -0700, James Bottomley wrote:
>>>> > > I think the principle of using multiple RNG sources for strong
>>>> > > keys is a sound one, so could I propose a compromise:  We have
>>>> > > a tpm subsystem random number generator that, when asked for
>>>> > > <n> random bytes first extracts <n> bytes from the TPM RNG and
>>>> > > places it into the kernel entropy pool and then asks for <n>
>>>> > > random bytes from the kernel RNG? That way, it will always have
>>>> > > the entropy to satisfy the request and in the worst case, where
>>>> > > the kernel has picked up no other entropy sources at all it
>>>> > > will be equivalent to what we have now (single entropy source)
>>>> > > but usually it will be a much better mixed entropy source.
>>>> >
>>>> > I think we should rely the existing architecture where TPM is
>>>> > contributing to the entropy pool as hwrng.
>>>>
>>>> That doesn't seem to work: when I trace what happens I see us
>>>> inject 32 bytes of entropy at boot time, but never again.  I think
>>>> the problem is the kernel entropy pool is push not pull and we have
>>>> no triggering event in the TPM to get us to push.  I suppose we
>>>> could set a timer to do this or perhaps there is a pull hook and we
>>>> haven't wired it up correctly?
>>>>
>>>> James
>>>>
>>>
>>>Shouldn't hwrng_fillfn be pulling from it?
>>
>>It should, but the problem seems to be it only polls the "current" hw
>>rng ... it doesn't seem to have a concept that there may be more than
>>one.  What happens, according to a brief reading of the code, is when
>>multiple are registered, it determines what the "best" one is and then
>>only pulls from that.  What I think it should be doing is filling from
>>all of them using the entropy quality to adjust how many bits we get.
>>
>>James
>>
>
>Most of them don't even set quality, including the tpm, so they end up
>at the end of the list. For the ones that do I'm not sure how they determined
>the value. For example virtio-rng sets quality to 1000.

I should have added that I like that idea though.
