Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FAAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAA8222BD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498915;
	bh=2FW1doQBV2NX9sicCfo3h+ExRWGyhemW59yfH0imPVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q25s0YRzz24LBXhADBWuiP2q/R50z50tuucDAR8jO62xdA+SSxke0CVR7ITy1cI2q
	 6jhIo7Yqm74K8aNkZ3vUYRvBdptrChLNP6lLQAC+9FEVYBCjlGJRhuwepssq6mw2ME
	 SzzEDWuazv7Tz5ZPIGIj9Iy3J40gu/HRfE9POgAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfKKTBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:01:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36416 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbfKKSum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:50:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15so14972363lja.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzwj0Bcu0+gyIzlUlN7XJHfbOaRzWPHagplExJJIvPs=;
        b=ew5m8ZL/3PZXEH82FW7NciyTpX79pXMZzxowB+MlMPaTW/kiutG2GumvXkfpUaRgOq
         P2W1GftekPzYO7cncT0B3PbtH2mr6stdJFhMeleFIDj20NSRAHa/lpsPd2tHpgwHBNki
         C9b4sV+Ddh67bYfuCFNneVQaMCjOafWrdcZl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzwj0Bcu0+gyIzlUlN7XJHfbOaRzWPHagplExJJIvPs=;
        b=atJmU9Igr+lGVogFj/mLfrXWCDejevlTESkLd6v5D62btodHIdn53DJmYnh8y/K+RF
         hYzaxofY/WU5gWJJwnbLUG++R93nRx2maCGT+T+SSarFpWeVHSBacgu035JSweCfabHX
         zmo3Xil9P73UMlLx5GBpbvx0NgC482Tlt5qojvKkhl3b//PXn4pMMp9YmSzAmZ5DJwJu
         Xr/0Qd5lgxHq4vlV6SFwRvDEVNi1lpJVj3zaMOxjyZb2OZfKHMcPp64x9j95dauG2uQj
         d1VAqAle0fJT9jm2lytlsovWxFOObIonWxcUiZ2b5qNs74F+MtZqLqsvyvi/A8UCR2SY
         4J+g==
X-Gm-Message-State: APjAAAUWl0sZzwmzMb9L4Qqxa70SwfVkO6pCJZPpQrhE8dUSxKRmZBtB
        1wrv2p+jC2boQzAT5PDh/7zzUNzwN6E=
X-Google-Smtp-Source: APXvYqxgnjQlnUBf2y4y+UqZYWyjA3YHZzywxlbc3RmgPNtSO5Jy8A4kUpJC8N1c62zT3D1xwi5Brg==
X-Received: by 2002:a2e:8601:: with SMTP id a1mr17604295lji.159.1573498240124;
        Mon, 11 Nov 2019 10:50:40 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id z24sm8026839lfj.40.2019.11.11.10.50.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 10:50:39 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id q5so4669385lfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:50:38 -0800 (PST)
X-Received: by 2002:a19:c790:: with SMTP id x138mr16826204lff.61.1573498238697;
 Mon, 11 Nov 2019 10:50:38 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com> <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
In-Reply-To: <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 10:50:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgWf7Ma+iWuJTTr9HW1-yP26vEswC1Gids-A=eOP7LaOQ@mail.gmail.com>
Message-ID: <CAHk-=wgWf7Ma+iWuJTTr9HW1-yP26vEswC1Gids-A=eOP7LaOQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 10:31 AM Eric Dumazet <edumazet@google.com> wrote:
>
> Problem is that KASAN/KCSAN stops as soon as one issue is hit,
> regardless of it being a false positive or not.

So mayb e that - together with the known huge base of false positives
- just means that KCSAN needs some more work before it can be used as
a basis for sending out patches.

Maybe the reporting needs to create a hash of the location, and report
once per location? Or something like that.

Maybe KCSAN needs a way to filter out known false positives on a KCSAN
side, without having to change the source for a tool that gives too
much noise?

> If we do not annotate the false positive, the real issues might be
> hidden for years.

I don't think "change the kernel source for a tool that isn't good
enough" is the solution.

> There is no pattern really, only a lot of noise (small ' bugs'  that
> have no real impact)

Yeah, if it hasn't shown any real bugs so far, that just strengthens
the "it needs much fewer false positives to be useful".

KASAN and lockdep can afford to stop after the first problem, because
the problems they report - and the additional annotations you might
want to add - are quality problems and annotations.

                Linus
