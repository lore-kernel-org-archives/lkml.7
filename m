Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C894AFC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D63420650
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573249008;
	bh=aiHMdEMJOgAa6jrM3jbVr8IRnFbQkF1HPb45tscKBaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MqPsbBB0N+pbixDenTUB8Xj39nv7W7NsBC3WmkquJifcllL6X9mUnQtk064lFllcr
	 K5m97ExANhSP9TeDQ93XmAITXU/5s/hm5s+emMhUrESd6gZ+aM0qzqRaqOdYsxOZ0A
	 i1bCyOK64t4Saf4bSlZQVBhHMCU4ruG+GVYWEHzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbfKHVgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:36:47 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:44882 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731097AbfKHVgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:36:46 -0500
Received: by mail-lj1-f174.google.com with SMTP id g3so7673981ljl.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 13:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGYbfXBmYeGO7pa06B9v9RYZuC6G4mksi25tARbE4oY=;
        b=D2lIv3jCmGx6XX86kRru64oEZZHnbWw2knlo1We7LolVbJbNK9HgSHPqCuNFkLo8ad
         GU8k1DTmDoi/kms3XxcfX7lhY59TGnHP8CiCPpdo/DYtNT8a4RPLc9sR5QaxINzKAI91
         MruliR/YTKfAHzSlhF17f4O8c+PUKsS3yl0wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGYbfXBmYeGO7pa06B9v9RYZuC6G4mksi25tARbE4oY=;
        b=WI6Y7uVCwAKkwrfLAyFTUOrvsMRaOiB98on3FHtsXvanYNcvTn+74q92c+dSGJiWH9
         ojIbMwd1rhGL5MuJWI+9/1LASGJM3FOXzSTLjlwA5KoZv5uEzp6gf7Tcm62xY1EmcX9u
         kGrBFO8HugH6EvolYCvlK6LygkedvvdcYF+qcUccJfIOUUaYNJYDWnwOR6e/i9IR2rCV
         K8mqIofjAd7iJVLgQNhSlvJuzYfyAKSS+iWsPH/eIu528/rA8+CxD5XdSJqvIk6rL4di
         n/O0hyWH/vwptq9GGpimd+ug1x22Im8lVmM9SfPRUWsk172R/ZWOcr+H8DeqXDC+srQ9
         sW5Q==
X-Gm-Message-State: APjAAAXcSCUESbk9S8jypCrhhuoOOhAaSXQWO6SmsiUbbhHJqbn1VVs7
        xtv/5GORBO0YRDK/VZGX65UkhdQTWs0=
X-Google-Smtp-Source: APXvYqygv9/W81QLQVq7URdIVh0eGNZuhtMPyuLcktDoYh4oyp6fYbweY6Pz+r7cyrxPWv/5JGeV3g==
X-Received: by 2002:a2e:b4e1:: with SMTP id s1mr8195248ljm.5.1573249002438;
        Fri, 08 Nov 2019 13:36:42 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id n1sm2817702ljg.44.2019.11.08.13.36.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 13:36:41 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id n21so7676307ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 13:36:40 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr8336920ljp.133.1573249000556;
 Fri, 08 Nov 2019 13:36:40 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
 <CANn89i+RrngUr11_iOYDuqDvAZnPfG3ieJR025M78uhiwEPuvQ@mail.gmail.com>
 <CAHk-=wi-aTQx5-gD51QC6UWJYxQv1p1CnrPpfbn4X1S4AC7G-g@mail.gmail.com> <CANn89iJh-WcvZYQEfdK=RGswQX8e1rp=CR27a6kWQkgK996P7g@mail.gmail.com>
In-Reply-To: <CANn89iJh-WcvZYQEfdK=RGswQX8e1rp=CR27a6kWQkgK996P7g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 13:36:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh_-1pj0vsAHiHf_FVardKkN7AZGX73QwGpViMyF7_mvQ@mail.gmail.com>
Message-ID: <CAHk-=wh_-1pj0vsAHiHf_FVardKkN7AZGX73QwGpViMyF7_mvQ@mail.gmail.com>
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

On Fri, Nov 8, 2019 at 12:53 PM Eric Dumazet <edumazet@google.com> wrote:
>
> per cpu SNMP counters mostly, with no IRQ safety requirements.
>
> Note that this could be implemented using local{64}_add() on arches like x86_64,
> while others might have to fallback to WRITE_ONCE(variable, variable + add)

raw_cpu_add()?

We already use those for vm_counters where we intentionally accept races.

              Linus
