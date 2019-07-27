Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3570C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851EE20644
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564194579;
	bh=+XbhQePs8JPC8XpWg0i6qNGvKaFbftIw1I10QPS4q78=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=V+6AymyW2xHK3Y2I3vXaHnn1syks7vPXhFqUe8lOdBzLlNveUgTygS1BIn1Z5on1I
	 XPGjdKjDdIGxy6vXB4znwFZZnN1hqd15No+FpGU7FqUqA5MICEO5FL6iXtwzFtrFS+
	 04ZaNufpZjkH3kFLk6axEwFFGSzY4Ykio3TENEJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfG0C3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 22:29:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44681 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfG0C3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 22:29:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id r15so21368466lfm.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 19:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRuVoGQyiTr9OUVJXnZ+mSEFCM9DeRijbw8KeVVr9qA=;
        b=CqthdUK3I5f1pgMbLDofd4KnjLcPFrqkN9aDucnvupiA1OVhLJf7fiU9qJpf7ye2GT
         RbW1RNJFPP/itRtlczIUYEZnt/BZbeyMOTY+mA9Q3Br/G3SfnGCP4iMUnQIBll/n1pik
         D/0MwAQdtPTxdxt/k0w3VOygmGrY+l6w3VCNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRuVoGQyiTr9OUVJXnZ+mSEFCM9DeRijbw8KeVVr9qA=;
        b=Ju7rZ3VDEo6HehQmkrEHXhPYn3eFu8IOciYLvTkHIObYYm4wNEDqvAqbyeOaNsJoc6
         a+AcQo+v83Ka40MhXYHm3WVqvOdpOf1bJUdQLfXHUzurhag9PyN22889t47/5p42+cYK
         wCKAfWZFQoiHu9fdxBF/znpWp1Sxdt91bVXR/f0+OMMJS9U/8sbDHrPhQRo8hv0JB2xZ
         iOu3PzHxzn0Ta1dWtI7nqGlEviGhWn2P/9cray+JYSM0ZqaG7rDHyeZn/sVujtHqqcCq
         czPyvPYJOOhXtEx6iJ1joMeYafGBROMMcRaFE9zK7jwaHRroS6310Q2Spe9JqDT+JvTR
         n9TA==
X-Gm-Message-State: APjAAAWnarljLgFTmSZx3nOnv6masLLtZxtVdL50avsJLkxtRkxd21Ju
        M3myM7GyvhJTS7vcOh1L05kvffzJg98=
X-Google-Smtp-Source: APXvYqx9Xu5U31JIx+tJJIsGIkU1+uFd08Aq0uIKlqIaWMtd+RGvga+aE+7g61UHNzDgQPq9ZeSV7g==
X-Received: by 2002:ac2:596c:: with SMTP id h12mr11865829lfp.101.1564194575099;
        Fri, 26 Jul 2019 19:29:35 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id d7sm8868590lfa.86.2019.07.26.19.29.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 19:29:33 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id z15so34076869lfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 19:29:32 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr46122226lft.79.1564194572710;
 Fri, 26 Jul 2019 19:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000edcb3c058e6143d5@google.com> <00000000000083ffc4058e9dddf0@google.com>
In-Reply-To: <00000000000083ffc4058e9dddf0@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Jul 2019 19:29:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=why-PdP_HNbskRADMp1bnj+FwUDYpUZSYoNLNHMRPtoVA@mail.gmail.com>
Message-ID: <CAHk-=why-PdP_HNbskRADMp1bnj+FwUDYpUZSYoNLNHMRPtoVA@mail.gmail.com>
Subject: Re: memory leak in kobject_set_name_vargs (2)
To:     syzbot <syzbot+ad8ca40ecd77896d51e2@syzkaller.appspotmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        David Miller <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, kuznet@ms2.inr.ac.ru,
        Kalle Valo <kvalo@codeaurora.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, luciano.coelho@intel.com,
        Netdev <netdev@vger.kernel.org>, steffen.klassert@secunet.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 4:26 PM syzbot
<syzbot+ad8ca40ecd77896d51e2@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 0e034f5c4bc408c943f9c4a06244415d75d7108c
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed May 18 18:51:25 2016 +0000
>
>      iwlwifi: fix mis-merge that breaks the driver

While this bisection looks more likely than the other syzbot entry
that bisected to a version change, I don't think it is correct eitger.

The bisection ended up doing a lot of "git bisect skip" because of the

    undefined reference to `nf_nat_icmp_reply_translation'

issue. Also, the memory leak doesn't seem to be entirely reliable:
when the bisect does 10 runs to verify that some test kernel is bad,
there are a couple of cases where only one or two of the ten run
failed.

Which makes me wonder if one or two of the "everything OK" runs were
actually buggy, but just happened to have all ten pass...

               Linus
