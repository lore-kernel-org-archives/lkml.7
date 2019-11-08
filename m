Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6B5C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A200A214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573236759;
	bh=lkvzY4O9DhxZCYUqr8lUZGJXYZj7SilXVcdxOfioOTo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2n5B/0MT+KRKnW6bwx4BlTwgYxzL2u6Z46w24dNH0RySeWb4nzHY1ID6VhQDX1W3v
	 jiN2xU1C4V43REh0YdvlSwNpfKOlChCtKPwZzkNM8sgLyVv2StYLvv2dnd5KR14HP5
	 4h1U3FRCUaxwFt7TSDbnwKWWvKuSR5DcfvMmdlRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfKHSMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:12:38 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37095 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfKHSMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:12:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so5156039lfp.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UwOe/0M2mqJUTnI7Cbij9+EXC9Tu0LMdXKdxLl7NQv8=;
        b=Tty72ZI+f/UrYcmEO8Ttap8J2ndzFJNgOvOIEsjOGXNDZDxbS3eJdFc1wvOgAkhTae
         HLu2Gs/SEuoh93AyFYWuYVGXZRyvcZzwo9IRcP7UYgKpfdaT0318sOFFV7yfTAuoQUuM
         qzCAoo7N2AMj7L2Iz8ESsZqrPCxDcoIImZAlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UwOe/0M2mqJUTnI7Cbij9+EXC9Tu0LMdXKdxLl7NQv8=;
        b=CmSzuNhmfAEtfa+boKwcWVmpCalPCZ4nEseyJrlQU10iHwemQhmoVFCOF2IPQ81JB5
         AVl03KUmhIywEBHWl6Itt1ssATAsBPmYhVQE9sf3+4hiptwyJ2ueLjVAlcSnZpdHKk2b
         VU7uqLE/gcVFRmHSzBn8ZifV9kLDVLzzQ1NxZnSPk9kbx3ocQWAUeRjWpQkZfNZ4iJsx
         MNAs7PtlFvo9wZOmhvcPm8ntRaJU5gTzgwdW5LpG+rNkMg0fjvlrmhiWZM/u0fEK1Ix/
         Lqw7ELpxaVNPUdJxuE/J68FCzeuSIhnkz6MBwQ53PkSM4OL/ZJTnPEAYnJoSSbvKORnC
         fKGA==
X-Gm-Message-State: APjAAAVdCN1Yim3g8iLLP58Da0uc0XwggVz6ZB/VqyVnydGy9UI9L2WP
        kpLZOzdUuZ0GnBGW6wB0fk5EAUlrBdc=
X-Google-Smtp-Source: APXvYqw0DlPlBtiB/khHn+iCIIO6B5wpkUfr5wdVhE4E4d16kQ5wJgGLjaJcigkR6Nx9G4ci7HRJYw==
X-Received: by 2002:a19:ec16:: with SMTP id b22mr8147481lfa.74.1573236754100;
        Fri, 08 Nov 2019 10:12:34 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id i30sm3267945lfp.39.2019.11.08.10.12.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 10:12:33 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id q2so7185894ljg.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 10:12:31 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr7846398ljp.133.1573236751292;
 Fri, 08 Nov 2019 10:12:31 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
 <CANn89i+RrngUr11_iOYDuqDvAZnPfG3ieJR025M78uhiwEPuvQ@mail.gmail.com> <CANn89iLN758CpQPKcd++NLdj62LS-ekiEUV91VREzMsamLn9bw@mail.gmail.com>
In-Reply-To: <CANn89iLN758CpQPKcd++NLdj62LS-ekiEUV91VREzMsamLn9bw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 10:12:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5+N2WS2vO6doxfza1G8zk4DP5RhodiaSeAyf+Ooy7wQ@mail.gmail.com>
Message-ID: <CAHk-=wg5+N2WS2vO6doxfza1G8zk4DP5RhodiaSeAyf+Ooy7wQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 10:02 AM Eric Dumazet <edumazet@google.com> wrote:
>
> Another interesting KCSAN report :
>
> static inline s64 percpu_counter_read_positive(struct percpu_counter *fbc)
> {
>         s64 ret = fbc->count;   // data-race ....

Yeah, I think that's fundamentally broken on 32-bit. It might need a
sequence lock instead of that raw_spinlock_t to be sanely done
properly on 32-bit.

Or we just admit that 32-bit doesn't really matter any more in the
long run, and that this is not a problem in practice because the
32-bit overflow basically never happens on small machines anyway.

               Linus
