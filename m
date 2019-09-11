Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3069BC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066B62168B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568221243;
	bh=3w6xF3foq1hxXmdkkCHS1s5w3xVpNEx7uKE/4HZvrkY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TZjk5SrnwifsBOWaZWrCNS2XSE1jBvkOYWdX6XVKK0NPkexP34kYFofnebxtzv6Q7
	 xIWkSK998NQbaW3oLhsPjHyWxn7YJtv4qOahfv43GGqkYxeWpVUIdlely//dnmID6u
	 6yq0my5R+djZw1vrk9xu1DKtDb3+uqkvePum0UTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfIKRAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:00:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40413 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfIKRAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:00:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id w18so5137689lfk.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hI3EB/9BDPeGlAj5JSZDGYA2f1JCFRdoSzkNrQAXirE=;
        b=CGKf9ffZA0sDKRiYz4VTL4pJ6O/i9q/3SuKL2cMKY0lYCwrIgBzzQc9qpL02hJUCVf
         zhRFfXilE/dIFAK6zLlsU05aZBlAW8SlX2gIrBCON7ulaV9IINxTNXZGi6/Lfghu5RUo
         Ttenh548bV73virB1och/bEQUdMXAWdJlPKp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hI3EB/9BDPeGlAj5JSZDGYA2f1JCFRdoSzkNrQAXirE=;
        b=c+3UELMlvXpsUV6eyou0WT8YCD2PCzZr+VsrSHRQ0rKszP0uQhfYLvdWoShanm4LVS
         QU0MWeggXTQYFA9s4KoCxDYHHwmytoiuOb+Ol2cTz5Vp+eSowmEWQF5ZPy6ZS+tfVm5k
         OfTRhGkNLdIjSwe/Sg463wDrVzrouxwsQB+lZUWVsDxg1o/aUIFLnGYVKDR1rsomzWWd
         svOyiWSCzNFLCs9FMkBReek8mQDYrYn7WnvVjpaPRAVBqXB0hYpphrsvRFaE2INofN/W
         dml95q8+vdrubU2mA5iDGrSShwvHmggElL15apCFicCcKJQjNlAj8T5cgsGcieE8QAbS
         H7Tw==
X-Gm-Message-State: APjAAAUO4FHCl+60THQxVXal9oZLn+VgHYtGdHlNfNlXzAUPjie2p6os
        Ua4tNnreb8z6T/lKBvP6vJO/X5maj4eDOQ==
X-Google-Smtp-Source: APXvYqwuw22AlyB+GUVhQjJXXO8ejvkYvS2KU2Xm3XgT/yzvF+xkYXywVXpHG2TG7/Ymlj+g2aJ/bw==
X-Received: by 2002:ac2:5196:: with SMTP id u22mr25025912lfi.130.1568221237378;
        Wed, 11 Sep 2019 10:00:37 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q24sm5451408lfa.94.2019.09.11.10.00.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 10:00:36 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id q64so10172185ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 10:00:36 -0700 (PDT)
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr16107533ljo.180.1568221235850;
 Wed, 11 Sep 2019 10:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc> <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc> <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu> <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
In-Reply-To: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Sep 2019 18:00:19 +0100
X-Gmail-Original-Message-ID: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
Message-ID: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 5:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I'd be inclined to either lower the limit regardless - and perhaps
> make the "user space asked for randomness much too early" be a big
> *warning* instead of being a basically fatal hung machine?

Hmm. Just testing - normally I run my laptop with TRUST_CPU enabled,
so I never see this any more, but warning (rather than waiting) is
what we still do for the kernel.

And I see

    [    0.231255] random: get_random_bytes called from
start_kernel+0x323/0x4f5 with crng_init=0

and that's this code:

        add_latent_entropy();
        add_device_randomness(command_line, strlen(command_line));
        boot_init_stack_canary();

in particular, it's the boot_init_stack_canary() thing that asks for a
random number for the canary.

I don't actually see the 'crng init done' until much much later:

    [   21.741125] random: crng init done

but part of that may be that my early boot is slow due to having an
encrypted disk and so the bootup ends up waiting for me to type the
passphrase.

But this does show that

 (a) we have the same issue in the kernel, and we don't block there

 (b) initializing the crng really can be a timing problem

The interrupt thing is only going to get worse as disks turn into
ssd's and some of them end up using polling rather than interrupts..
So we're likely to see _fewer_ interrupts in the future, not more.

            Linus
