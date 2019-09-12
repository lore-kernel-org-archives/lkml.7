Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0365C4CECB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE24F20684
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568288106;
	bh=ysIBs7xyasl4sNXtJn0FnTX+Y4HNAIYUBNHh5rd0is4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=saZTrdK2Xt//XKR4b3pn1/5xOQ0dI1d7aKCLPy4Zh/d+cnVFHBjaBXz6reoFqs0pS
	 wRN6ZDwyAo3esgr1Ccfc9riKzvo5S2sDQUsFOga9SimlOtYSjsDam27myWO4Tii3qf
	 JOPIHX6P8opoEgQSaGLF+YK7SoBzWmOVpH+5NJIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfILLfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:35:05 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:44061 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbfILLfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:35:05 -0400
Received: by mail-lj1-f175.google.com with SMTP id u14so23224258ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJEjXo6Uv0jyp2+Brgg1JL8WxFYC+E50/NKS1o8RgP4=;
        b=SoqpQsGN0urBE3TZhDDbfGxMqQFL1cSw3SqSCRD7jsTJhbHzZSr7ZZSQZhcXfxdkDc
         rNbyzfu3s7rI7jD4hkuWmJhs7sZYsjUnj7IUIPx0yWxF6qwKRfkFXQOSdwttIBTxaccA
         Gqqy35oMPqJwLuP5+0ltXVj/AffUCCXYemJFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJEjXo6Uv0jyp2+Brgg1JL8WxFYC+E50/NKS1o8RgP4=;
        b=ZCrZL8l90F8HvQnZ1rxf7vl3FY42otBoTGA2PfAUDFqlffaFCnC7JY67uc0DtL/8ie
         8jELRPR/VmkBIMWBIp5S+nAQ9Ly913MhLctupitQkIOgNjVnFTH0PCDReObYrlYCHCdN
         aFLfLyB+DbuWTGNizuzwAkA0RiBUKbittavyj4fZ2zwmegEno+jWnxJXfG1L0+B8DOmR
         CtX/or+FnfwYxH/ca6l/PmLoRJjQ1LOpP5OE7ST0gwor4hx3VpPjX33zmo+Tgi5wSer9
         FaHOPU34SvzP/c6w7mXQDIrmxzbf1zGJvKPiZkPvo7I5dCJ6CKixShIshuCVFsnrzZHt
         fT0w==
X-Gm-Message-State: APjAAAXj15Eu/kNbfTvPjmzCRMfsN8Ed+rKs/qDZrAB5d5IxhyhmKwf8
        h0nu7q/bZMHYMrejmH98zCdQu7cLeJhAlA==
X-Google-Smtp-Source: APXvYqyi924KAgltOBVLcOgWrJ88XipxWRqF03SP8t4YF5VLUEK1Gto/8Qfg40MRX8JRof0aAJUdEw==
X-Received: by 2002:a2e:7801:: with SMTP id t1mr12027189ljc.140.1568288102952;
        Thu, 12 Sep 2019 04:35:02 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id c16sm6139859lfj.8.2019.09.12.04.35.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 04:35:01 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id a4so23232684ljk.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 04:35:01 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr26938394ljg.72.1568288101290;
 Thu, 12 Sep 2019 04:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc> <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc> <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu> <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
In-Reply-To: <20190912082530.GA27365@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Sep 2019 12:34:45 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
Message-ID: <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
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

On Thu, Sep 12, 2019 at 9:25 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> Hmm, one thought might be GRND_FAILSAFE, which will wait up to two
> minutes before returning "best efforts" randomness and issuing a huge
> massive warning if it is triggered?

Yeah, based on (by now) _years_ of experience with people mis-using
"get me random numbers", I think the sense of a new flag needs to be
"yeah, I'm willing to wait for it".

Because most people just don't want to wait for it, and most people
don't think about it, and we need to make the default be for that
"don't think about it" crowd, with the people who ask for randomness
sources for a secure key having to very clearly and very explicitly
say "Yes, I understand that this can take minutes and can only be done
long after boot".

Even then people will screw that up because they copy code, or some
less than gifted rodent writes a library and decides "my library is so
important that I need that waiting sooper-sekrit-secure random
number", and then people use that broken library by mistake without
realizing that it's not going to be reliable at boot time.

An alternative might be to make getrandom() just return an error
instead of waiting. Sure, fill the buffer with "as random as we can"
stuff, but then return -EINVAL because you called us too early.

                  Linus
