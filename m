Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2347BC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A092086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561562504;
	bh=2C45GR8QcNUlXUagChm3h55vqnTJi2n65xAwHFBqPMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mVLUZjMHwVfdD4ufzohLdv3JlHY4YmVNioqXRoKgOeetwx5uIruIk15LWnT/NJCkI
	 I8W8TfOIESgAQn7zTHZMz+Kcxk9cd6fIVewP4WCiPdKUOfoJGBimcDgZfkd9DqAWBD
	 mEUU7ccmoY0AXDtLmWDwGW42xC10LzQ4lXB3eBzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfFZPVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:21:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45603 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfFZPVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:21:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so1943624qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AqcyecsyR72Z800wF2DqV9Cha6bDH1l5BuA6pDWNwYs=;
        b=KfrqTafq5djpR60pvGLE24kaqVkohaB+1Fpu1qAbV1Z3UJnWWZHWEBXkU6CphviNT1
         omXIPfZ9zFPf4yGSgg17P5BQXYGiGGP+jB0FpgTBSR6f7jLWzuXvQnaH2UHQJ+jSUDQg
         FENMBf5dbkbQn1mv8JdGHmZlZR/hQfBJ25Vcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AqcyecsyR72Z800wF2DqV9Cha6bDH1l5BuA6pDWNwYs=;
        b=FsZX5Q9awe5SIgHwpZwe9as/z45dr8HCOoQDvefn8ztjfzqQmlF1w8nVzXiNKDylSF
         JEZJLMmDzBTTjROKCvKfQrt7IUsoFCrrTrAdXziQaY710Ri+9Z9Mj6YSZDsOHdtNGtuQ
         i147AaXIxWKxBE8ihpIqIQ9pNEBJtyvSK5feVTHi6SRjJhRa1aW7tvFDCmeZGmPP146j
         TSd83U8PZl+D8CBocfvStuk7mRgDq4LrSVypZRSQhKtuLTAvYGGSgC87ivRQvkWmEKYe
         N629QSu5X6jIo1t8bs03g5TjCCw4dvmyw4Fy/Tc4XHHFgnH2djMzM2noCUnSJLOaxNwl
         uFKA==
X-Gm-Message-State: APjAAAWnz5STRNfo7d6H0NyrIZepyfdWSJt8M7alqIyrfOOr6PJ5ufvt
        qdt+HN4ie1vUejB8JzFllUcm7LGRvE8=
X-Google-Smtp-Source: APXvYqxzZ8iLSdr4K35JOc9DwvkixONaa8VxxhxUgn2Hu9TD/fRdCOA0eE8w19uDwLbWTvyFi2KN5A==
X-Received: by 2002:a05:620a:1292:: with SMTP id w18mr4442657qki.416.1561562501107;
        Wed, 26 Jun 2019 08:21:41 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id k33sm8995923qte.69.2019.06.26.08.21.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 08:21:40 -0700 (PDT)
Date:   Wed, 26 Jun 2019 11:21:38 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: On Nitrokey Pro's ECC support
Message-ID: <20190626152138.GA28688@chatter.i7.local>
Mail-Followup-To: Jonathan Corbet <corbet@lwn.net>,
        Jarkko Sakkinen <jarkko.sakkinen@iki.fi>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c9c1e7f83a55bc5fb621e2e4e1dab90c5b3aac01.camel@iki.fi>
 <20190626082541.2cd5897c@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20190626082541.2cd5897c@lwn.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 08:25:41AM -0600, Jonathan Corbet wrote:
>On Wed, 26 Jun 2019 17:11:46 +0300
>Jarkko Sakkinen <jarkko.sakkinen@iki.fi> wrote:
>
>> I was getting myself a smartcard stick and looked for options from [1].
>> The documentation says that Nitrokey Pro does not support ECC while it
>> actually does [2]. I was already canceling my order when Jan Suhr, the
>> CEO of that company, kindly pointed out to me this.
>>
>> [1] https://www.kernel.org/doc/html/latest/process/maintainer-pgp-guide.html
>> [2] https://shop.nitrokey.com/shop/product/nitrokey-pro-2-3
>
>Maybe Konstantin (copied) might be willing to supply an update to the
>document to reflect this?

Hello:

I just sent a patch with updates that reflect ECC capabilities in newer 
devices.

Best,
-K
