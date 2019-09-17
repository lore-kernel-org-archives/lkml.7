Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30805C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03977206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568684518;
	bh=qyph07UWpAex17FgoCL1r5b+7tyl4ETGGhdXOzgUefU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dbwQSOjAd55v74/BvF3jPv2DrhZ/iLfN3dXbuWZuAAKiu/6MqRJPg3mDvQmUC5lTi
	 N2p0n5x1t8oOpR3FQiqNckLz2rir/KxjEzbYtQkctRlh/+ihxx12UC5iYYwZsfLvUx
	 HamlrVLQUD26ZKfDXRQXsEM9QFWZJ2fDt2rc9vRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391744AbfIQBl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 21:41:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45457 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfIQBl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:41:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so1714466ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 18:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFonvhfNYcxKepSfnQcuhKAjMEuQmhnrqu5ZWiTPe6o=;
        b=Bmy2g+SI64cuFudCSab745GhMwBUH8vFBHoCEPyte/aVPJTeqvf0Ub3G6d17emIl2S
         cXEEoOWnhpdJi6yi8YT0lVGj2snzwX9DRJYCmT2Fi2PkFCGtXGxs2cGseskytXSyw5ue
         jAlwgncWpCtsxiLRT6WPIAxhjk0PtHEWVcWT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFonvhfNYcxKepSfnQcuhKAjMEuQmhnrqu5ZWiTPe6o=;
        b=e3M332kNW+jopYoRpChd4a/dBU22Vwy8dAVD8mL0zUp0ugmxCspjLGZFQwyzm8lT53
         w8OJJcRa6Bo6V+bc8FMIyZY6ppGEYqhfpRa7f4BwfKfVJX1ZKERTI018BbtwQiVDwXIc
         lPe2X0vLm8YGzjDleI3Ji3/9AidtUaF67q0TH4veH56xfs5UyYZ3mslIdcQTOd0oeel7
         YMq/67LEyUj7JkFumWPtxdJhkSXUyJyQi5UulRIbPmk/jbdvdHrpJRuszTfwfoBd8agO
         ZyeqAa8iLj9BD5LI39hZbIP/E+aPZod0kygmFBPRBCjENx0kOCS1gNSVOMRTpV62+glu
         qVkA==
X-Gm-Message-State: APjAAAXedq3o9m5QPmsZI/+0aYSlSPNi5k4YrWphVDeK/CvfPEoBkLOU
        lg4MM9/DHbXe9oY4sb3QivUfzou8Onw=
X-Google-Smtp-Source: APXvYqyW5AcUk3GXTEgL0/ZryoYY1aHqwDxLILigR+H4Y1KGQqvDJ+Qx5DNGdcapPciuXmLKgyrZPw==
X-Received: by 2002:a2e:9b4f:: with SMTP id o15mr396461ljj.142.1568684514367;
        Mon, 16 Sep 2019 18:41:54 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 25sm111157lje.58.2019.09.16.18.41.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 18:41:53 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id w67so1492115lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 18:41:52 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr577900lfn.52.1568684512695;
 Mon, 16 Sep 2019 18:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190916042952.GB23719@1wt.eu> <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu> <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
 <20190916172117.GB15263@mit.edu> <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org> <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com>
 <20190916231103.bic65ab4ifv7vhio@srcf.ucam.org> <CAHk-=wjwJDznDUsiaXH=UCxFRQxNEpj2tTCa0GvZm2WB4+hJ4A@mail.gmail.com>
 <20190916232922.GA7880@darwi-home-pc> <CAHk-=wh2PuYtuUVt523j20cTceN+ps8UNJY=uRWQuRaDeDyLQw@mail.gmail.com>
 <BEF07E89-E36D-480F-AB1E-25C80C9DABE7@srcf.ucam.org>
In-Reply-To: <BEF07E89-E36D-480F-AB1E-25C80C9DABE7@srcf.ucam.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 18:41:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfPwei+yf9vBgfSuG5HDtiYmt3nOu9Js+vkTYSrMf2ow@mail.gmail.com>
Message-ID: <CAHk-=whfPwei+yf9vBgfSuG5HDtiYmt3nOu9Js+vkTYSrMf2ow@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
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

On Mon, Sep 16, 2019 at 6:24 PM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> Exactly the scenario where you want getrandom() to block, yes.

It *would* block. Just not forever.

And btw, the whole "generate key at boot when nothing else is going
on" is already broken, so presumably nobody actually does it.

See why I'm saying "hypothetical"? You're doing it again.

> >Then you have to ignore the big warning too.
>
> The big warning that's only printed in dmesg?

Well, the patch actually made getrandom() return en error too, but you
seem more interested in the hypotheticals than in arguing actualities.

          Linus
