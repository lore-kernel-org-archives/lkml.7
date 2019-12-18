Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C226C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B69C21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu9okZqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLRIIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:08:37 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36901 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRIIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:08:36 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so514075pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 00:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AtCdbC9tz17+3Iqi46yQPht3TnYEo3eyAfKZRFa8DSw=;
        b=Uu9okZqb35R1qqZLyQd/TYzmHo11HPUoOtCXArpqyI27qg5lsStSN5EoTw/bLj9hc+
         aRVBqbR64FtoqPkYlFP9/U6w3qFfDpnlArNyFzijpy7+KLN8fLpWvvEyW3ay61H43cCQ
         mzCwYC7orfMubgq7XyMDeZy5E6zcFxDPJMEI1lITSPxqbjvzalFUGZ/sgOiK0pu5V75J
         bhjqv0njVq6X16d9GTahB+LRc8GnWmGa78ZNASHwW3JdPCEng+3SdVk71rsfcKCXh35k
         nFP7LO1tbHbePAxGCzppwSey9bMVwQh9ea+H3hgoSck8idZZ3HqjLYm9bQu1n+VwBwlv
         WOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AtCdbC9tz17+3Iqi46yQPht3TnYEo3eyAfKZRFa8DSw=;
        b=ASPokNfHWBIRrqhTdWki7UQAD/mLmS1CGg6VqdJqbT9h42d0xnDPbAagbQJuLjJizd
         adcT13eiwHRfzSUOwVBgkYIufn8qGvGNl3aj5/0Dt/o5Eut5hjQrFOVfNkvY60Hdhpts
         44NBk2eIsCU4e9vur5dN0sOd+q7M6r/BYXUOFCe6jdWiP2+iOvhTOClGZp4LFPpxAF/f
         q1wWBqz6YmTky3lEoEaWQRDPjvRRCs0EpLKXWDiq09Tmn7Dh9/j3MQ8pD8bKUrpubxl+
         dQlONmZQj63Fm9lU+T7qBlWr5ZoGUOwq4+2PPg6sP7iksOtfUl2EqCZhTSXrp7l/YbWx
         nnvA==
X-Gm-Message-State: APjAAAV9hDjmbwQqFragGrFZUG+W8itHIjJdNjTX1QLMX3RUh1K3Vdsu
        mzmHSSigpo421m9fIji8NP8=
X-Google-Smtp-Source: APXvYqwbhmCf/rOFPQ881Ib2+3RCKMKAYN/te5ELG8JvndET+33eWOAuHzeLltWSrBwtSUoGQ2S9/A==
X-Received: by 2002:a17:902:b496:: with SMTP id y22mr1380247plr.158.1576656515550;
        Wed, 18 Dec 2019 00:08:35 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id q6sm1943218pfq.27.2019.12.18.00.08.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Dec 2019 00:08:35 -0800 (PST)
Date:   Wed, 18 Dec 2019 16:08:32 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/exit: do panic earlier to get coredump if
 global init task exit
Message-ID: <20191218080832.GA8408@cqw-OptiPlex-7050>
References: <1576466324-6067-1-git-send-email-qiwuchen55@gmail.com>
 <20191216172841.GA10466@redhat.com>
 <20191216174410.xiqurqnqyipbuy4e@wittgenstein>
 <20191217105042.GA21784@cqw-OptiPlex-7050>
 <20191217142515.GB23152@redhat.com>
 <20191217145620.GA26585@cqw-OptiPlex-7050>
 <20191217152333.GC23152@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217152333.GC23152@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 04:23:33PM +0100, Oleg Nesterov wrote:
> On 12/17, chenqiwu wrote:
> >
> > But in fact, I think atomic_read()
> > can avoid the racy even if both threads exit in parallel, since it is
> > an atomic operation forever.
> 
> Hmm, not sure I understand. atomic_read() is just READ_ONCE(), it can't be
> re-ordered but that is all.
> 
> How can it avoid the race if it is called before atomic_dec_and_test() ?
> 
> Again, suppose that we have 2 exiting threads and signal->live == 2. With
> your patch each thread does atomic_read() before atomic_dec_and_test(),
> both threads can observe atomic_read(signal->live) == 2 simply because
> the counter was not decremented yet.
> 
> Oleg.
>

Yeah, I agree your idea.
Now, if there are no further questions, I will resend this as a proper patch for v3.
