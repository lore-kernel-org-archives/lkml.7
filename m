Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05993C4CECB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 02:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D029120828
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 02:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568513526;
	bh=jYf6bGRyPsw4fCQcLGBE2QxZIm6UjUeRveIboApq5TA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Mqn1ppaSua8ntzIpKsPHcb1Spj07IFLCebYn6qruXRJSzXebKSS64qEYAf2Wfv1nh
	 JOp3MFDrHH6lcK/m2Gwe0jk4Sr+uKdXCntACK8f6NWI/7na4zV6w0bUeSULVE7Kw7p
	 yZnRuG/Z99gpE0AELJ82/Lu9jZwwNk+HvFmfW/Ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfIOCMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 22:12:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42633 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfIOCMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 22:12:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so30493545lje.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 19:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rYFEB2K43HNknGCuNtqwY11d7jNo13i6prZjBn/RDM=;
        b=IFLavFfBEECvUaRBp/EiSvd06bt8SLP7qdIU8LhowKpuB244awAuNyT4xXKNmN8XsF
         qKdO4HiiFlSNQQjo59uVaTwlCPHmxYMbqFjOi4brsClvtwRtIGCqxPsJvahupKarYSzE
         nprKJDuzUk/SMYuio6GVb4ZLDckKb7XB7gnLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rYFEB2K43HNknGCuNtqwY11d7jNo13i6prZjBn/RDM=;
        b=GryDzkHzzFwNJROJDXvc3TedmJyYwxkN0+xpAb4oN41mFkrGj51Z3wijPQhoj6EM1S
         DtVKWm+pWXEKLpFXCuMpFaZD8WIlJi30kWWXW5C/A/wQJ4JppJEtDIuWyjFNaiuz/cja
         5S5bY3oQcfaVHYio9IXPC/7hRXUVCUtA32+FZfJJvFWy2fTN208he0x1odg0YYvLtheJ
         QZc+apBNkfVm+IVzl7jlUgBTsBErolmiy5ZOpkP8qI1RtXahf7etqSkbOeiPfFIvQCoL
         xa2VNa6v9up+lkdBYZGTGjMskQODTMMLlZ065z9zOmj6PVWNIBTl8ZkpDKCXvEqxpJJe
         Awkw==
X-Gm-Message-State: APjAAAWJLsnGU1+sO40qi+MvkyjSq5MW3s4p03At1jjnrs4pCCL/CPhr
        OUoQX7THJSNN2YR8QZ/9T/m8gXUsFhc=
X-Google-Smtp-Source: APXvYqwrrXACpTeLm/EsqC/4lg6OtbeqILWasHR15ZCn71mD1UC4vcVepZ1Z8384/EtFXgUnB9PgsA==
X-Received: by 2002:a2e:9881:: with SMTP id b1mr16268902ljj.134.1568513521938;
        Sat, 14 Sep 2019 19:12:01 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id c3sm7909589lfi.32.2019.09.14.19.11.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 19:11:59 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id a22so30529567ljd.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 19:11:58 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr34727113ljg.72.1568513518572;
 Sat, 14 Sep 2019 19:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190914211126.GA4355@darwi-home-pc> <20190914222432.GC19710@mit.edu>
 <CAHk-=wi-y26j4yX5JtwqwXc7zKX1K8FLQGVcx49aSYuW8JwM+w@mail.gmail.com>
 <20190915010037.GE19710@mit.edu> <CAHk-=wjGTV0e_P73V0B3cPVrfeoSZcV6CjQMgj-+yL-s38DKaw@mail.gmail.com>
 <20190915020521.GF19710@mit.edu>
In-Reply-To: <20190915020521.GF19710@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 19:11:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5BPZeH+wBdgWbDNYuHwiPN+GR-VBhUMjRsYuqEit6Ag@mail.gmail.com>
Message-ID: <CAHk-=wg5BPZeH+wBdgWbDNYuHwiPN+GR-VBhUMjRsYuqEit6Ag@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 7:05 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> I'd be willing to let it take at least 2 minutes, since that's slow
> enough to be annoying.

Have you ever met a real human being?

A boot that blocks will result in people pressing the big red button
in less than 30 seconds, unless it talks very much about _why_ it
blocks and gives an estimate of how long.

Please go out and actually interact with real people some day.

            Linus
