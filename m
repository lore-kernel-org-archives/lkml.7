Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE21ECE58B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27A5222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbfJDUHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:07:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729079AbfJDUHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:07:32 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 033C3B62C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2019 20:07:32 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id g126so13981853iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 13:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YQkPCdZHoSj6NvroC4Ee1AB26jF4gvzQTiWkamm8ZZQ=;
        b=JtA4v4ft2trBq9jM9bUqiTmQm6TsmdRZwLk2FMyP7GcDNpaCH5AWj2MpjCYUTralh+
         uz6ycdSmv7NjAN9OqryVPK4znR4L3iRiRmcFj5snRulgQpir7FeKptR8tYX9HLZ7+VFH
         /s/qVoNNyquPPEkxvV/tR19dBHW2kYLIGQOj7qeKlMGbpmABxVXcF6r1o21dbhQN8YQH
         qR52VVhNjemXg7SDXkRpZ/2pnBXWyuU+/HtQb1IoCGtzkAnpTLEGw3tOa85tqxSuWGQ5
         jn7GL2+bFpkJE/2k6bSG9U4pkFdV4pOFtiHvs3bCU+BS6rwB0yFjedQbaDWdhxbDHxFV
         VTow==
X-Gm-Message-State: APjAAAWk6LpOKBHcHPgC0MYlCrmkFr+MpjVfFYHTWHUU/0pXkM1E26l6
        A21T60BFD3L93zztexy/3RCyxz8xtpLkUL5BGL6WOsdiY6KGA+9SPbxsX8XOM6wYKR5/JcdU8oo
        xegnYqBecwD6ekI0cxKd5CbAr
X-Received: by 2002:a02:3786:: with SMTP id r128mr16553375jar.76.1570219651263;
        Fri, 04 Oct 2019 13:07:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxArhHxm0Nstx7C4ZP+pXUNPuCNDxE4yPahY8Po8tmCh9X9YYrdtdBzGg9wsxS84j6KFUUzNg==
X-Received: by 2002:a02:3786:: with SMTP id r128mr16553338jar.76.1570219650932;
        Fri, 04 Oct 2019 13:07:30 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id d21sm2454373iom.29.2019.10.04.13.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 13:07:30 -0700 (PDT)
Date:   Fri, 4 Oct 2019 13:07:28 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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
Message-ID: <20191004200728.xoj6jlgbhv57gepc@cantor>
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
References: <20191003175854.GB19679@linux.intel.com>
 <1570128827.5046.19.camel@linux.ibm.com>
 <20191003215125.GA30511@linux.intel.com>
 <20191003215743.GB30511@linux.intel.com>
 <1570140491.5046.33.camel@linux.ibm.com>
 <1570147177.10818.11.camel@HansenPartnership.com>
 <20191004182216.GB6945@linux.intel.com>
 <1570213491.3563.27.camel@HansenPartnership.com>
 <20191004183342.y63qdvspojyf3m55@cantor>
 <1570214574.3563.32.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1570214574.3563.32.camel@HansenPartnership.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 04 19, James Bottomley wrote:
>On Fri, 2019-10-04 at 11:33 -0700, Jerry Snitselaar wrote:
>> On Fri Oct 04 19, James Bottomley wrote:
>> > On Fri, 2019-10-04 at 21:22 +0300, Jarkko Sakkinen wrote:
>> > > On Thu, Oct 03, 2019 at 04:59:37PM -0700, James Bottomley wrote:
>> > > > I think the principle of using multiple RNG sources for strong
>> > > > keys is a sound one, so could I propose a compromise:  We have
>> > > > a tpm subsystem random number generator that, when asked for
>> > > > <n> random bytes first extracts <n> bytes from the TPM RNG and
>> > > > places it into the kernel entropy pool and then asks for <n>
>> > > > random bytes from the kernel RNG? That way, it will always have
>> > > > the entropy to satisfy the request and in the worst case, where
>> > > > the kernel has picked up no other entropy sources at all it
>> > > > will be equivalent to what we have now (single entropy source)
>> > > > but usually it will be a much better mixed entropy source.
>> > >
>> > > I think we should rely the existing architecture where TPM is
>> > > contributing to the entropy pool as hwrng.
>> >
>> > That doesn't seem to work: when I trace what happens I see us
>> > inject 32 bytes of entropy at boot time, but never again.  I think
>> > the problem is the kernel entropy pool is push not pull and we have
>> > no triggering event in the TPM to get us to push.  I suppose we
>> > could set a timer to do this or perhaps there is a pull hook and we
>> > haven't wired it up correctly?
>> >
>> > James
>> >
>>
>> Shouldn't hwrng_fillfn be pulling from it?
>
>It should, but the problem seems to be it only polls the "current" hw
>rng ... it doesn't seem to have a concept that there may be more than
>one.  What happens, according to a brief reading of the code, is when
>multiple are registered, it determines what the "best" one is and then
>only pulls from that.  What I think it should be doing is filling from
>all of them using the entropy quality to adjust how many bits we get.
>
>James
>

Most of them don't even set quality, including the tpm, so they end up
at the end of the list. For the ones that do I'm not sure how they determined
the value. For example virtio-rng sets quality to 1000.
