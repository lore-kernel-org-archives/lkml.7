Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75815C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A1A208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568118102;
	bh=MGzA/vgtbEww0YtW4+BASKPEBvGCoohCbZMroP2bsBw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aF+FHXT78RyiroKRj7EISBWFZInk/ZyFqiV3ZOsgmd91ANDsA7dMjL6ziG13rheTk
	 uY2AgW7jhQHRDROxqs3J4UdjbtDai7DRM7t0zS0ALcjBSoSSTXsCuAlcU53OlirC/s
	 Vc+YRbS55jl93CCMP6V9RMv3PXd9QblyVBeBZQCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390263AbfIJMVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:21:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33247 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732465AbfIJMVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:21:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so16240365ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 05:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3GxIwes7c12IDMkagZ1amMldsYg5ctDWa58fzZZ05I4=;
        b=brWJNeJGPrjnKz0dqpJab6tvBVljJnGRygk6NzTwBHyO68ltDx77g7v5Jq08Jw42+n
         lLdANR7DQAWsFhUR8rvAjcHV8o/1N6uJIKtpYMvYlBYws9XIyN4nAd/q3IoS2Q8ZIbOe
         rq2IbTwhbbvIt93IANqnbtX1919STSSOn0g+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GxIwes7c12IDMkagZ1amMldsYg5ctDWa58fzZZ05I4=;
        b=JFY5NGFjtDuXAkZEi5urOh405O2jSSm+XGI9wSknO2DPdXB/btHZmsIfM18rvr0v/N
         9uUoj8L3HMwo4PJWnaASGLqERWMEgZ/e0fp7YQ9Nsb8vEi/0u513eJewbsIMPsuckFV1
         3MppY4xaYurc9KXa/ejlrDM/ryKqIOvICW23i3chtx6/FVrjqemnikYMfqmEqLJz72X8
         nrAJKKRvdozL2VCdTEwIuxzFnXQjU34Trsq4K4pFWWamC5Gm38ClI2BmItGKne5qwfWK
         O37INxMw3W2+vEfLtpYRYA/Ea3q4TomCA/wzlSK/mUqSJnIMMODveU3x/XJq4ouelKMV
         fx6Q==
X-Gm-Message-State: APjAAAWJyQRWvxkZLrJER9Vc/85ueOuQ81Vwy75PPoTF4FM9UiLGhIuW
        H60lR5908D8Tc9SqPyM9xdm39X9sfMqarg==
X-Google-Smtp-Source: APXvYqwl0AzSvBAOaahxuHdaaOheycKZyFGTIjKL2f74XyACvYm+t8TVBixgOusXbQBlchpWXxOx3w==
X-Received: by 2002:a2e:8183:: with SMTP id e3mr18955332ljg.97.1568118098706;
        Tue, 10 Sep 2019 05:21:38 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id g1sm3727956ljl.31.2019.09.10.05.21.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 05:21:38 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id d5so16198002lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 05:21:37 -0700 (PDT)
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr11751783ljo.180.1568118097545;
 Tue, 10 Sep 2019 05:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc> <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
In-Reply-To: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Sep 2019 13:21:21 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgL47gCQFRkj7KYf4XVoWZW2zf3Lcmk6n-0w=3L-hmcLw@mail.gmail.com>
Message-ID: <CAHk-=wgL47gCQFRkj7KYf4XVoWZW2zf3Lcmk6n-0w=3L-hmcLw@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, zhangjs <zachary@baishancloud.com>,
        linux-ext4@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 12:33 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Are you sure it's entropy that is blocking, and not perhaps some odd
> "forgot to unplug" situation?

Looking at that code, it's all trivial, and it definitely unplugs properly.

Lack of entropy still sounds _very_ strange, and you . Are you doing
something odd at boot?

Does the boot continue if you press keys on the keyboard, or how did
you decide it was about entropy?

I guess sysrq-'t' followed by enough keyboard input to unblock the
boot process should give you something in dmesg that shows what is
blocked?

                Linus
