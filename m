Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F6CC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959D4218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568837632;
	bh=EfHKjzH3JKs8tuLuDdNGJKB3lQdfO47Opo/cl8XK6+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eEceOnGJR2GZ6pVSAt4VNzVGzWI3lCdHY2ae1Wd35HnthzmgCpdTeEoSahcF2SVWI
	 tFlCzYZO4f8xg7rQ0qN/qfAE2SJw7d4Xcl+xBK/01JnJ84aX8WswJqnIUJCOucWUi5
	 XUmssIID05ugDUhbyZwmsC3p0H/0vPCQJwgeac4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391208AbfIRUNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:13:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47093 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391137AbfIRUNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:13:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so565067lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmbXGFEWVtjHX9X1Gctkgau+tuI+qC0BzTbw+aLuRTU=;
        b=g8RyMjdNFqBzYdgO0kOInb/luNvfmUgoogrNuN/uHaQmSTAkISDVuPXAX+IS8y6uPa
         113T2PmQ3xMCkzcuMhaKO1jOI6snQm5pleau2vnztg3o4ImV+DP3gV+uEBDCi+BFOxCm
         kSQ4VNgu1hZOijED+yZ0+HFQwvWFxFemQxZvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmbXGFEWVtjHX9X1Gctkgau+tuI+qC0BzTbw+aLuRTU=;
        b=CkFvmzJv4jjK9qmAERl9yOCVQ9igJxLowM7vkN1scnk3skZKC/+jbakuY5mgjPNCXe
         NNvnu5bkFLh75Y62HoR8sHWqKTVwt2h5/duSBAUtJinQdkctdQnt0iO8ciF9SEEzn80p
         /OBBV7sRwwxfTv9wc0ZlZa9yekj4yXNmjfySGHitCyBxW2mbIuGefAkQCnO/XP0wGaVS
         V8cEwynorWXnz56bwRF1HSIWVp3U7MZgJV3/yzo/zY0OsrmVED5Gz5pL36tiFWeeyIxN
         05daRNJtuER97iMIS3aW6bTfcQPFrfu+RJt1W3obuUd+4wwdEP3nZIDhbnAuCkMwEVfe
         7mGQ==
X-Gm-Message-State: APjAAAVKxja6C1CcnwK3JtmASGhDVh6tCTEunKKtA0Hj6SfvkSGiKdRJ
        QKt/qFht4pePvCjOE4F80cPvk2ljObc=
X-Google-Smtp-Source: APXvYqxEuiXd5t4csQbS8pk2DcRk9p6I9wcFEZhpqZThRJVREAki/LbFLlDzq8/MRo64rre+SRZKUw==
X-Received: by 2002:a19:488f:: with SMTP id v137mr2931242lfa.26.1568837627930;
        Wed, 18 Sep 2019 13:13:47 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k23sm1210002ljc.13.2019.09.18.13.13.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 13:13:46 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u3so584541lfl.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 13:13:46 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr3074674lfp.61.1568837626504;
 Wed, 18 Sep 2019 13:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org> <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba> <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login> <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login> <87zhj15qgf.fsf@x220.int.ebiederm.org>
In-Reply-To: <87zhj15qgf.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 13:13:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMipoCnraaP3FwnGhb+D-AtHgsLbRa5ZPa9ZK715aVng@mail.gmail.com>
Message-ID: <CAHk-=wgMipoCnraaP3FwnGhb+D-AtHgsLbRa5ZPa9ZK715aVng@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
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

On Wed, Sep 18, 2019 at 12:56 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> The cheap solution appears to be copying a random seed from a previous
> boot, and I think that will take care of many many cases, and has
> already been implemented.  Which reduces this to a system first
> boot issue.

Not really.

Part of the problem is that many people don't _trust_ that "previous
boot entropy".

The lack of trust is sometimes fundamental mistrust ("Who knows where
it came from"), which also tends to cover things like not trusting
rdrand or not trusting the boot loader claimed randomness data.

But the lack of trust has been realistic - if you generated your disk
image by cloning a pre-existing one, you may well have two (or more -
up to any infinite number) of subsequent boots that use the same
"random" data for initialization.

And doing that "boot a pre-existing image" is not as unusual as you'd
think. Some people do it to make bootup faster - there have been
people who work on pre-populating bootup all the way to user mode by
basically making boot be a "resume from disk" kind of event.

So a large part of the problem is that we don't actually trust things
that _should_ be trust-worthy, because we've seen (over and over
again) people mis-using it. So then we do mix in the data into the
randomness pool (because there's no downside to _that_), but we don't
treat it as entropy (because while it _probably_ is, we don't actually
trust it sufficiently).

A _lot_ of the problems with randomness come from these trust issues.
Our entropy counting is very very conservative indeed.

            Linus
