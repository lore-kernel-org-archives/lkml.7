Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF14C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 21:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBD52412E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 21:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559509348;
	bh=QRRvQ5Cdm8o+ysb3bFXNhac8aAWSvjgYaFEeZiTAgCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2vxQVlLfjknDB8FVC7xn6Yy5Hm5uJx61flZglJIeS1noOjyTm2Wq+TOOdE4/A9/Zh
	 jC9+OFeHKh5kJf4oi7fki0E2Jd90O8rvae74xaeX+T/0d7pBfdxpiWBnk2XyIlHA5i
	 yVLW7WdQq7kEKeJuIFqpW0O84TwMB91uViRNNG6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfFBVC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 17:02:27 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:40572 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFBVC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 17:02:27 -0400
Received: by mail-io1-f46.google.com with SMTP id n5so12645942ioc.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 14:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HC8vtrRsh50Ohc3EaIB0NoebMSo23njywbCwxitxUSo=;
        b=G05oV6yGANfGUrsafNDMFdY+sdiwhud8O9hlc5blEpxavx9e8NMec2fjDyxse4N94X
         2a89tU71cAzexNCkHgP9PRg5MZKqWwfvM5tdRQOUzBE+IVLhk0nxFDg1nKUAGhNgYJWK
         OTOxrwoH4oo/4pDSoZ0Fkojiw/sCTsCbJPv9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HC8vtrRsh50Ohc3EaIB0NoebMSo23njywbCwxitxUSo=;
        b=FTcHSl3nz+Mv/4Y4+d9/gYI1rRZ+WQNXh90HXKh+RXO2KnqFXo7NwwkKtt+1dkD9Nq
         xJUrptdw+ZShPAr2JpKwDmu90j/ZbEgyvbVo9Gc+3/tYYxD1axCadeXmatunPPzXtqKs
         sKAtla7cWGzxrZFHGDkGxhwAKuhtsRNf4wVBcnShf6ayuyWix1HqADowMFTQgr/9zgir
         SeqvrHUIbSlX59+JdhYSmUhwDCd5ypb9XvHHFMdiIg6wrIa78q6De8VxS5IYprUsqJ0m
         Dnjrkn8+I0cZrCCT/eik+EqHgAIv10j0pOC++1mdxcrnHVoIuJcVc4Yl2Ei2pHBVriUG
         z4RA==
X-Gm-Message-State: APjAAAWJTlj5Iz4C1Huov3XRjiX3jZmnTdAgKHX0abaQliuMRkqGUBTs
        rbUTgc6ZCwY4XNdG5UPtuj1dpwUGSK8=
X-Google-Smtp-Source: APXvYqxlnw73pTZ9X3LGfQhk4wHkxDI22S6dISiA1Mrh1rHUWpFhM8Ynp9JwrYuQPTbxTvYWg9PiIA==
X-Received: by 2002:a05:6602:2285:: with SMTP id d5mr14055239iod.196.1559509346192;
        Sun, 02 Jun 2019 14:02:26 -0700 (PDT)
Received: from mail-it1-f171.google.com (mail-it1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id y18sm4154690iob.64.2019.06.02.14.02.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 14:02:26 -0700 (PDT)
Received: by mail-it1-f171.google.com with SMTP id n189so5150651itd.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 14:02:25 -0700 (PDT)
X-Received: by 2002:a24:5652:: with SMTP id o79mr15076656itb.164.1559508868756;
 Sun, 02 Jun 2019 13:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20150910005708.GA23369@wfg-t540p.sh.intel.com>
 <20150910102513.GA1677@fixme-laptop.cn.ibm.com> <20150910171649.GE4029@linux.vnet.ibm.com>
 <20150911021933.GA1521@fixme-laptop.cn.ibm.com> <20150921193045.GA13674@lerouge>
 <20150921204327.GH4029@linux.vnet.ibm.com> <20190602055607.bk5vgmwjvvt4wejd@gondor.apana.org.au>
In-Reply-To: <20190602055607.bk5vgmwjvvt4wejd@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Jun 2019 13:54:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLGKOmM++OQi5GX08_dfh8Xfz9Wq7khPo+MVtPYh_8hw@mail.gmail.com>
Message-ID: <CAHk-=whLGKOmM++OQi5GX08_dfh8Xfz9Wq7khPo+MVtPYh_8hw@mail.gmail.com>
Subject: Re: rcu_read_lock lost its compiler barrier
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 1, 2019 at 10:56 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> You can't then go and decide to remove the compiler barrier!  To do
> that you'd need to audit every single use of rcu_read_lock in the
> kernel to ensure that they're not depending on the compiler barrier.

What's the possible case where it would matter when there is no preemption?

          Linus
