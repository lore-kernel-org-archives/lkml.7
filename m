Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649ADC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF74214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576274492;
	bh=MVWYfCWCZF9XClnBZtJX/FHZfnBGhRYYzCAYDdp0yJM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2h5SvDxAmbzzsIlshAGC0U1pzPmz4JKWDocJgS7SfDqmShGSFGuafaeIg//KFtsSw
	 IsEwMZsHgtZuRhrxDWAraWscH564jU1SBGD24HGKlJqgS9lENATZQmojPMhyOMmKVb
	 K70mRPTo0/8LvxC4e0oyTvebl1IrEGlZzGSRyQzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLMWBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:01:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46298 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfLMWBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:01:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id z17so249462ljk.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 14:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfICJ6KhaPZeol1tl5aqhZNB4nOYiiQp60xAzoCt3JU=;
        b=OMLOqShWneJ3fe3UbyHRP01hVO4iIEtu+rKtip4uFYuny7eKWa9RVguRhdDXyGlazr
         Vu8irtlqDqkjSxlpxcEnR/mPZqGnWrv40jn+8NdgbI7DAtOpxmVjJ6hnmrSN7O80Gy2B
         6ZEjjOYm27LL3/V26Z0KJqLy5QPWKtyS57u7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfICJ6KhaPZeol1tl5aqhZNB4nOYiiQp60xAzoCt3JU=;
        b=VJb0IP2wvO7QzJPwGjxK8bIEOL4fyeEXoUCzx0NjpXDMiDiRmO/j0XxV6pHsFTZxyl
         hhg9HiIH/pvVGAw/BW2lf7e53O3wzvlTd3ykeP4AGhNIcabxn4FsXThdhdpQ6pH7+iWD
         CM6Gqf3d98vUUEFtWAwJxg2XJiKjvLyCisdhmV6ELeeplkiL+cdIr78IwYym3ln16Qyw
         m00WUm1+nz0uPxYHtsoKOpyBCZoUZoGnRLdG29Vd/8ZkCjJPP5qN0REo3YleXejMGISZ
         QjuqUv1ExUELS+JYjDdNMOSZ130/sivcNe0U9Q0EMcUH4HsDNTOTZ3MK0cq8lI2txM4o
         lLfA==
X-Gm-Message-State: APjAAAUwBlB5CQy4OAd7XBkX81QbGKAnMmrikVHYWyokMLw7cU2/kckH
        Rb8p9/1Mg8rxKZnlequGZqS/9rJbi0Q=
X-Google-Smtp-Source: APXvYqwUE/kgOzfpgZm7tSyBoAwhXvlnJZ3xx0F7MItkL789qZaf8Uu7quP3kfFOujoIjgzbBxGI9g==
X-Received: by 2002:a05:651c:112d:: with SMTP id e13mr9740546ljo.99.1576274488006;
        Fri, 13 Dec 2019 14:01:28 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id q10sm5497456ljj.60.2019.12.13.14.01.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 14:01:27 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id b15so366100lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 14:01:26 -0800 (PST)
X-Received: by 2002:a05:6512:1dd:: with SMTP id f29mr10402310lfp.106.1576274486558;
 Fri, 13 Dec 2019 14:01:26 -0800 (PST)
MIME-Version: 1.0
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <CAK8P3a2QYpT_u3D7c_w+hoyeO-Stkj5MWyU_LgGOqnMtKLEudg@mail.gmail.com> <CAK8P3a014U76S+t3rKyPghepOT_fYHBExuMC27MoGMNffjczEw@mail.gmail.com>
In-Reply-To: <CAK8P3a014U76S+t3rKyPghepOT_fYHBExuMC27MoGMNffjczEw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Dec 2019 14:01:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsN+0i8mF_1L8zDvY0XJEkZNumT1dH0NBiSbecZZ3+HA@mail.gmail.com>
Message-ID: <CAHk-=wgsN+0i8mF_1L8zDvY0XJEkZNumT1dH0NBiSbecZZ3+HA@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 1:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> A few hundred randconfig (x86, arm32 and arm64) builds later I
> still only found one other instance:

Just send me the pull request to READ_ONCE() and WRITE_ONCE() be
arithmetic types, and your two trivial fixes, and let's get this over
with.

With that, you can remove the 'volatile' with my simple
'typeof(0+*(p))' trick, and we're all good, and we don't need to worry
about compiler versions either.

I'm willing to take that after the merge window as a "sanity fix".

             Linus
