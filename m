Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C18C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17EC217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558468635;
	bh=Yuwfvh/AEXlq/uPFyZpH8HHGz9P+rYOcUyWEZqy46OU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HytkN4LIRRVVIWct2Hx7VQiqhIruRMGjte4ymy/bmxfKlOC8vIlTJ4f96igrPEScD
	 eF49nFgAjpceBmjc+3xs130+viGjFdTn8UUJZqapHfKlSjREvCptupWAwkr2reiJUt
	 HLo6FUlOd5AK2RdJfIGuh3Szp8ayops0jfHPwcOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfEUT5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 15:57:15 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:34078 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfEUT5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 15:57:14 -0400
Received: by mail-lj1-f174.google.com with SMTP id j24so17054476ljg.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTpPvAgNQPd+rEl9afcf+1rE3kROr+UUfM46fnx4Bk8=;
        b=XqVmfpVbg1slSewkR5f2U6b3+5XKlOvQU4VbouanVZRGjER9fB9LOAy3D+fO85wRuZ
         S5WiCRf3BsQ2QU8lgAnmzhlZsozczleIK4DMhHPaVcubH86ofESdISvaimjGPaFYOtlA
         s/15v1YFHk/6YHAlQygnydejKxnX5lsdWs4Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTpPvAgNQPd+rEl9afcf+1rE3kROr+UUfM46fnx4Bk8=;
        b=CKDi82nlyk5rUUgI9+ySFm5+lnKjrlp/foo2Tk/INry0FwzXGjxrcL0h17tu7MkdRw
         1zvR83EX7Vddhzni6z3jfsl6IcgfD6zRQVEi+IPRp24WKOCMKDeo62u7DR+fJldiBiJy
         c28hoiWLU+BlJu/P3tcLX+pIS3lQ2s2WtDVIcbYAxSQq3HInQj2ZNW1+G5sm32lhfu2h
         ZOAtOSqtNugtEYzSL3RZHsoBeX1h52N/MJUrlGfkeuAupHoEO6ZaeD9fLgJOxuuFy3Id
         ss3vQhQawcrelnsuB37DLBaJbYRO8yb3vOfYBUfLhJKt7tGhyu8vDqZA6NNpQZR5EhHR
         xHTQ==
X-Gm-Message-State: APjAAAVsrP6XOHEnfexyaMVn3K0O9HxWbJhN3Bs//CXLf0kBSxIAtloz
        Ulbgx7RLty0NpboqJppzE3oQWJ1hnUE=
X-Google-Smtp-Source: APXvYqy31C0mJS7GNd7GwzuRkCZ6C5dnQy3UxW7kkJg0TV79aKBczUyeDheHGUagLa+R92e6f/aPLw==
X-Received: by 2002:a2e:9983:: with SMTP id w3mr13272400lji.58.1558468631850;
        Tue, 21 May 2019 12:57:11 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id h11sm4964525lfh.8.2019.05.21.12.57.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 12:57:11 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id n22so13989829lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 12:57:10 -0700 (PDT)
X-Received: by 2002:a19:4cd5:: with SMTP id z204mr26787248lfa.113.1558468630474;
 Tue, 21 May 2019 12:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190521133257.GA21471@kroah.com>
In-Reply-To: <20190521133257.GA21471@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 May 2019 12:56:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPy6ak8ERbRaPrkJ+n9iqVuNhH4t8YnbLXsM00K0fRPg@mail.gmail.com>
Message-ID: <CAHk-=wiPy6ak8ERbRaPrkJ+n9iqVuNhH4t8YnbLXsM00K0fRPg@mail.gmail.com>
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 6:33 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Thomas Gleixner (24):
>       treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 1

I thought rule 1 was that we don't talk about SPDX replacement?

              Linus
