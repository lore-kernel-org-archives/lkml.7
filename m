Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5755C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861FE2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QOdvq3F7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfJAQhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:37:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42533 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfJAQhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:37:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id z12so10006079pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nRBqIlLhM8ZUJgatnzPvhuMc606HDrYYNudVlJiQtTo=;
        b=QOdvq3F7RPeoeqsDbhWOOUVxzHnf6D2wVftkdGGj7lbk6tdr5FAZLxzC65bB/Ovnni
         UeOttAleJyJ/kz4TXsHzrARBIN7Cuapykt9NtyGO6IEU7eUPKwURc6F3iEM98ehRUZS9
         GXYsHtFIAT7VlERhrlt3NiNiGb1M0OiN+tV/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nRBqIlLhM8ZUJgatnzPvhuMc606HDrYYNudVlJiQtTo=;
        b=d9217rZGXyNKNZl+EBlWxKMGSkZgHsBpQjQGm1zOpek5fAp2B7vOIyU2YejDaQCMq6
         mfEpYRMJxMAPgZ/gnLV44tzB259I/cMoW/0M5T02K2lgg7gvfyWNr8WX4+l/K8em7p2v
         3MQeYymPYU7BsMORu39E4BHojxjzec4+2ftxMayy6RKtY5xVu4wkEmPXO55qasoYvABQ
         2O5pZm87bPastqo3z58DUKzdmbZ5+uql/d6d4e3HWRj4S/w/Ji4aFMV5O3Vef5hymv+h
         rrCgAzDOO7z+mhmOcLb/sst46e+hTK5gB/fNHTwMXJXPD8hQQSOOUL5y/S8H91bRwin+
         CK9w==
X-Gm-Message-State: APjAAAUBjSdh5qqDMIcscQavB8zwouNY63M+g9EYcHXiAmaLFpYCSDbm
        dPRwaMMbSe/MBknntKFpdVfZ0Q==
X-Google-Smtp-Source: APXvYqxABunlkZYYv47wKMZHW4Sh+AhM/8kQR1CYPnWCpBn6VhnZ7CX/4jr3QFOIhmKBT/OaLCrRGA==
X-Received: by 2002:a17:90a:bb8e:: with SMTP id v14mr6323823pjr.84.1569947861914;
        Tue, 01 Oct 2019 09:37:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q20sm19504378pfl.79.2019.10.01.09.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 09:37:41 -0700 (PDT)
Date:   Tue, 1 Oct 2019 09:37:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, a.darwish@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <201910010932.C6DF862@keescook>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <20191001161448.GA1918@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191001161448.GA1918@darwi-home-pc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 06:15:02PM +0200, Ahmed S. Darwish wrote:
> On Sat, Sep 28, 2019 at 04:53:52PM -0700, Linus Torvalds wrote:
> > Ahmed - would you be willing to test this on your problem case (with
> > the ext4 optimization re-enabled, of course)?
> >
> 
> So I pulled the patch and the revert of the ext4 revert as they're all
> now merged in master. It of course made the problem go away...
> 
> To test the quality of the new jitter code, I added a small patch on
> top to disable all other sources of randomness except the new jitter
> entropy code, [1] and made quick tests on the quality of getrandom(0).
> 
> Using the "ent" tool, [2] also used to test randomness in the Stephen
> Müller LRNG paper, on a 500000-byte file, produced the following
> results:
> 
>     $ ent rand-file
> 
>     Entropy = 7.999625 bits per byte.
> 
>     Optimum compression would reduce the size of this 500000 byte file
>     by 0 percent.
> 
>     Chi square distribution for 500000 samples is 259.43, and randomly
>     would exceed this value 41.11 percent of the times.
> 
>     Arithmetic mean value of data bytes is 127.4085 (127.5 = random).
> 
>     Monte Carlo value for Pi is 3.148476594 (error 0.22 percent).
> 
>     Serial correlation coefficient is 0.001740 (totally uncorrelated = 0.0).
> 
> As can be seen above, everything looks random, and almost all of the
> statistical randomness tests matched the same kernel without the
> "jitter + schedule()" patch added (after getting it un-stuck).

Can you post the patch for [1]? Another test we should do is the
multi-boot test. Testing the stream (with ent, or with my dieharder run)
is mainly testing the RNG algo. I'd like to see if the first 8 bytes
out of the kernel RNG change between multiple boots of the same system.
e.g. read the first 8 bytes, for each of 100000 boots, and feed THAT
byte "stream" into ent...

-- 
Kees Cook
