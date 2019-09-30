Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3972EC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C30215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569859620;
	bh=MvE8LLynRjUl+94cJb0CyjZtG13OGXEK4Bl34WJDU9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PIKmUjemvDi4lAoQYlgSr9IrM2RBlfhSFwHzhQMczezTyb977SpdExOT3zo2KBeI3
	 ALolKTTZL3hTIr5g24vu1ayJ79k/JMDDiwfzi+fyjj+Y7mlR2q1+WKPhmzz53VqhHm
	 ++nv3XKaxKdOwntqxyj+DQqGRfbj0ytCqFmq8hIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbfI3QG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:06:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37635 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfI3QG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:06:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id l21so10104925lje.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLe2kylkHRDEIZkqma6Y17kUgB/cRkjjQz4tSwgXeyQ=;
        b=ItUevwyV7K+5wlAC7uIMaBiq4O5RQHwz6gB4j41pmGvLNHJJDpjra6dNJkzZoLazfE
         E5vl2dbYUovDvSBxCVhMf2rkaldW6y6OXJpInRFLlK1dq2tUcHdFH2M5OXWmdotbJ2pB
         JxBSQE34E7oJiQd1SzU7G3iqevwk7iUZeeLmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLe2kylkHRDEIZkqma6Y17kUgB/cRkjjQz4tSwgXeyQ=;
        b=XMcHVZMhyYND84DRqqI5r/NzP23qZu/VDlwqZaOV5q3HdT36jTz3RldZQ1buZeVwYu
         k9aC/G4BqbJ1UFzYz2UteLRmstD9ZRZ02mFk0njChBSXSLxOE7qSlkgSrYBMdcq5HDkf
         YDziD6V8B9mPbq/5rO0Q+iJ6ATnAdrwRL/MCKtzKttsP9/MkHo8kebf9d2MYQbABWKIF
         uyX7yZ7NmbMeFawPS+bQTz8VA2/z+dB5+ZhwelahQSq0RXfzuzqzv3Djp4fTwBbg/7R1
         c9Oe/uXQvEx2RlU0lKz8d0MOjPrwOfiA5A/F9TJq80gS4YL+x3K2AnSjQ6lxYxSk3T49
         KLpA==
X-Gm-Message-State: APjAAAX5eh7vKPjzSzr31ZAXXVkZfJbAlHeSii7rGkDRHaHGoKRBDBjf
        hsCb2aCdBOhf9Vm4eWgs6gdu8xaB4js=
X-Google-Smtp-Source: APXvYqzE3zVh9oxw3oiYUIcGrWpBa4n2AXR79T/IiouqPFS27x5+r2izITq50kZz3i7p5OjBlFlkXQ==
X-Received: by 2002:a2e:9702:: with SMTP id r2mr12858423lji.190.1569859614465;
        Mon, 30 Sep 2019 09:06:54 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id v7sm3312846lfd.55.2019.09.30.09.06.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 09:06:53 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id r134so7448652lff.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 09:06:52 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr12078157lfp.134.1569859612393;
 Mon, 30 Sep 2019 09:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
 <CAHk-=whKhD-GniDqpRhhF=V2cSxThX56NAdkAUoBkbp0mW5=LA@mail.gmail.com> <20190930061014.GC29694@zn.tnic>
In-Reply-To: <20190930061014.GC29694@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Sep 2019 09:06:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfLfnOyGkHM+ZRn6bc6JD6CU3Ewix3cJDqCqjbMO5PNA@mail.gmail.com>
Message-ID: <CAHk-=wjfLfnOyGkHM+ZRn6bc6JD6CU3Ewix3cJDqCqjbMO5PNA@mail.gmail.com>
Subject: Re: x86/random: Speculation to the rescue
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 11:10 PM Borislav Petkov <bp@alien8.de> wrote:
>
> so sshd does getrandom(2) while those other userspace things don't. Oh
> well.

Well, that's actually what systems _should_ do. Presumably sshd
actually wants secure randomness, and nothing else waits for it.

Obviously, that can be a problem if you then need sshd in order to get
into a headless box, so my patch fixes things for you too, but at
least your box doesn't show the problem that Ahmed had, and the boot
completing presumably means that you got more entropy from other disk
IO being done by the rest of the boot.

If you want to test my hacky "do /dev/urandom too", it was this one-liner:

  --- a/drivers/char/random.c
  +++ b/drivers/char/random.c
  @@ -2027,6 +2027,7 @@ urandom_read(struct file *file, char __user
*buf, size_t nbytes, loff_t *ppos)
        static int maxwarn = 10;
        int ret;

  +     if (!crng_ready()) try_to_generate_entropy();
        if (!crng_ready() && maxwarn > 0) {
                maxwarn--;
                if (__ratelimit(&urandom_warning))

and that should get rid of the warnings.

It's not using the full "wait_for_random_bytes()", because in the
absence of a cycle counter, that would introduce the boot-time lockup
for /dev/urandom too.

Doing something like the above to /dev/urandom is likely the right
thing to do eventually, but I didn't want to mix up "we can perhaps
improve the urandom situation too" with the basic "let's fix the boot
problem". The urandom behavior change would be a separate thing.

Also, talking about "future changes". Right now
"try_to_generate_entropy()" is actually uninterruptible once it gets
started. I think we should add a test for signal_pending() too, but it
should generally complete really fairly quickly so I left it without
one just to see if anybody even notices.

                 Linus
