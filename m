Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B30FC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7865214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568753948;
	bh=rcuBWze4V7iBrlBBThBQvxrbrfu58rkr9F6dUTCwlII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0Gt+e/PTlACZumMj7zIgH7rm9+qOBM0kNWJXcXC4vzRg8ubZxo2h2kOi595BNCmDe
	 G1jSSDvMY5DGESKP+sAFa0UBW2e2obXxzZQoAf+TSyTnSxEPkzryIFq2dgooQTxUWM
	 Ecrreq442lZ3NSGeFpbvYfV6S/AdSJhvoQvVJMMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfIQU7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:59:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45746 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfIQU7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:59:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so4968468ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHrObK8b+yTwXUpTknBWom0+qFXiK3R3tZjZ4MRZwFw=;
        b=ZGDVy1dUaQtKpgdgdOVfn2ocAdPPX/vdWupn5Tq0b6mOU1+upk6uZJtQVBC20v7jGw
         CbIdJYnxxcQqMf9qM5m5SL0B1Rfxv9frW2ay/IyXYPuQIqy8qt8R3bYEpGAA/jNcpOUh
         Rvj5TZaXMBPqI1vJva1Ju07IwTuegIJmAAbNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHrObK8b+yTwXUpTknBWom0+qFXiK3R3tZjZ4MRZwFw=;
        b=M74vWTUOnLpg+JM4qtQHng8B1ckDrb6Us6edjrDCYUpz7CS8ZuL1kMy110Euqfe8Qs
         FIsNnpSfgIOIAhsInd6Xhvr7MvQj74YCk0ZNT7dGAKzhihNFL9een1znpezVp0UsCUfS
         C15jqsl2m9Cgo0vhy2lu4Y4njb8B0hva2pBmgEBpgahDJJz9oEwovaxSs3tPVwSKN8ec
         sNKagt8qtGUchxXE7lB3+MHI7gSjRABff/WPXe8++2moR45v+v+z/LxuVSHSTtSUgEp+
         Kna2c1q9yTZVLyca69fXS1ZY3fmzWqKZWlr+FEF4sUMoD/xAAxUTbwZS2uGOHmdrhejY
         Kkww==
X-Gm-Message-State: APjAAAV2wNGN3VrLLsIyeCPIsxmLMk4fS801fBOn44ttY8b1p1OseMX0
        ksKEebS38kT2LWERVSF1Gz6QhAW0y1I=
X-Google-Smtp-Source: APXvYqypmdra0raW/Tm/tJ7ZC0tiLrytuQD2iDmxawKXEP2cpcfi0yn6oHh8zwIeIkbbRjK85OPbMg==
X-Received: by 2002:a2e:96cc:: with SMTP id d12mr202256ljj.30.1568753945247;
        Tue, 17 Sep 2019 13:59:05 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id o13sm207874lji.31.2019.09.17.13.59.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 13:59:02 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id e17so4942009ljf.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 13:59:01 -0700 (PDT)
X-Received: by 2002:a2e:9854:: with SMTP id e20mr203592ljj.72.1568753941203;
 Tue, 17 Sep 2019 13:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org> <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba> <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login> <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login> <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
In-Reply-To: <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 13:58:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOCv2eOT2M8Vw9GD_yOpsTwF364-hkeADyEu9erHgMGw@mail.gmail.com>
Message-ID: <CAHk-=wgOCv2eOT2M8Vw9GD_yOpsTwF364-hkeADyEu9erHgMGw@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Side note, and entirely unrelated to this particular problem, but
_because_ I was looking at the entropy init and sources of randomness
we have, I notice that we still don't use the ToD clock as a source.

There's not a whole lot of bits there, but at least one of the attacks
against entirely missing boot-time randomness was to look at the
output of get_random_bytes(), and just compare it across machines. We
sanitize things by going through a cryptographic hash function, but
that helps hide the internal entropy buffers from direct viewing, but
it still leaves the "are those internal entropy buffers the _same_
across machines" for the nasty embedded hardware case with identical
hardware.

Of course, some of those machines didn't even have a a time-of-day
clock either. But the fact that some didn't doesn't mean we shouldn't
take it into account.

So adding a "add_device_randomness()" to do_settimeofday64() (which
catches them all) wouldn't be a bad idea. Not perhaps "entropy", but
helping against detecting the case of basically very limited entropy
at all at early boot.

I'm pretty sure we discussed that case when we did those things
originally, but I don't actually see us doing it anywhere right now.

So we definitely have some sources of differences for different
systems that we could/should use, even if we might not be able to
really account them as "entropy". The whole "people generated a number
of the same keys" is just horrendously bad, even if they were to use
/dev/urandom that doesn't have any strict entropy guarantees.

               Linus
