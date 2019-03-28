Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE98C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A7A2184D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553806074;
	bh=OUdWJ1MxYstZr0ftO5djNGzo7jr42IwfteS8dZXzSsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FB3Y2ZdSmGMP/Fr6XJkxyMjZQBd3+mBTTegdghUnlL7l2jHpZfncy5CW5uoemSqA8
	 2FEgoBE4uTlv/LSmuiotGJ0hP/6JumiuNKzm/PgwbU+UFio9ybmRhrgyvC+9nUi9cL
	 QVriuhiVJWa4Pd5n5S8Qzy6g/FThR8sEaGiE13Nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfC1Urw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:47:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34194 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfC1Urw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:47:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id j89so79120ljb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjZ/SZzZnq6l1TMJe3kpk/VKFzOVkn/Odq6bLyzQxEY=;
        b=KV4lM6DhP49I616Bal7K7sYU+clkXl1pcQpA/w0Jl6niInr803GJytaWdhIk/gEvnW
         P2OIcd/xBth8ZjZH8RGMbwakjhD0RG1hPZ+roqu3VuHwIcEEWP9M1ko5jBYyg88+OqQA
         5ZUTXLy0FFeDZZKSO61t+gPGnVASfzrS7xyPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjZ/SZzZnq6l1TMJe3kpk/VKFzOVkn/Odq6bLyzQxEY=;
        b=nrNbq5BxyANt5P0qxil6mXXQqvkneEsVsMukSHl3pIXVQ3gjSurYFkqFqPojH/B4Lq
         r2ePmBn7SqSyjjeHxjNPHu0uuaJB2yX4hKQIvCDLyuqbw2R2pxpAHe0BnbgcWkMYjf6T
         rpjDTmvM1kRa5XYv+ZMhT8pV8ye0c1HoPbgGAWpXOdN9RhZLPJCII7Jgo2qI02Vxc9ZO
         vZQMAFEGp2MvV2HAks4Vlg4AZJ3XIeQICpxOgDZuwdRxJ+yut8FyLap6VEKZpeVnmiz7
         bQJtJifGYsDgL0Hl8V8zu5IHQ3vhsHgfk0+BhcwefrdqoTAD3UvpaSgSFqy8l2aETYQO
         bAVg==
X-Gm-Message-State: APjAAAXIs7ACd/Pkm70RpTLhsPtTSoHFMyXK+3n1SqsjV2cndAnTLHR0
        asE6Ogma/f/3Coj6Eq7wAdUFoh0PJDw=
X-Google-Smtp-Source: APXvYqxwcvlA8Un6texTsXZ2VX7FJS0gzOzSrOad+67k72eTiEt291zUCu2bD9d6EIhbKopIN2KqGg==
X-Received: by 2002:a2e:81da:: with SMTP id s26mr4824142ljg.86.1553806069186;
        Thu, 28 Mar 2019 13:47:49 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id z18sm66612lfi.57.2019.03.28.13.47.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 13:47:48 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id b7so10457847lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:47:47 -0700 (PDT)
X-Received: by 2002:a19:4a49:: with SMTP id x70mr6932248lfa.11.1553806067495;
 Thu, 28 Mar 2019 13:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190328181106.22887-1-longman@redhat.com> <20190328181106.22887-13-longman@redhat.com>
In-Reply-To: <20190328181106.22887-13-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Mar 2019 13:47:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7eanC+W7DpSpAsAAYeRTp3EB5qUxMnDFW3HqNQC0GFQ@mail.gmail.com>
Message-ID: <CAHk-=wh7eanC+W7DpSpAsAAYeRTp3EB5qUxMnDFW3HqNQC0GFQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] locking/rwsem: Make MSbit of count as guard bit to
 fail readlock
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 11:12 AM Waiman Long <longman@redhat.com> wrote:
>
> With the merging of owner into count for x86-64, there is only 16 bits
> left for reader count. It is theoretically possible for an application to
> cause more than 64k readers to acquire a rwsem leading to count overflow.

Ahh, and here's the thing that makes 16 bits work for readers.

I think this at a minimum needs to be made very clear in the patch
that actually lowered the reader count bits, but preferably this just
needs to be done *before* that patch, so that you don't have a point
in history where rwlocks are simply not reliable.

               Linus
