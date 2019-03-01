Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54098C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2187020818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551459120;
	bh=NLcVGvDoCTEt+fV4NtCoXneeJa+nHwd/7+TY01svfd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BLsPGomhyp33bNKzAcUujvmJO7Yc+jpqLJxJrRLrDanly1THvddthRN25IQ748YIj
	 viS2zL92rciKTDmQl1CiSJ9GAIjgXP92/427GRgLJ9zDkOd7lNeXFnE4arGk0jABql
	 apFUylspDbUZ/BjPLKVA4+u+bG1sqI4CI2Ho7c/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbfCAQv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:51:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46291 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbfCAQv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:51:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id v16so20969102ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ez8ADp+Mbfs/OYuDUMwZpFL/duMhSwowVHyMrrx/aWQ=;
        b=dMZDY89USSjVC3BrjDUiNDxmXLXR2c5MVYzMgTm8R6TT/aH7ikqz7ielZTAtnoDDeo
         WLPOKLzpKu9mIUjwptn/X79xPfnTO+SIK7op63EGn7GcJ4htGu0n52c0Yiwt0douUDSE
         adpuCC3/cSzuQd29SoqZUWMW62er83MTxib4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ez8ADp+Mbfs/OYuDUMwZpFL/duMhSwowVHyMrrx/aWQ=;
        b=oUZo8XEj1rEva8Q8DoEzb8sXIya1PyGuAC/HrF/0NqeRp9CQYZ8dLhSgm+UBJt5e6w
         0pqnGg8V6ApIccZyAK0QkYgh6WnBql/Tx/hlYGc25pzd7G+90uaVH3VvHvOpAE4/GP6I
         H/fc1F6knEC4pMedElSCRJyZWhnZhngzHxcY13zrZ6HsUSQPAIwFar6uvCE1b0FATsE7
         3zeMIjdPe8CxptU+sgS8rmFKu62mMmSpWjJ7nd4vFJ4e67Qf6VYBTUd7rzGzP74wPl3e
         Kw1HizYlj1IhtnqZTpcqx8ZmCXer9nUnD5tNZsUZZUtRC1cCVRE/R8NCMFtBy8jPKVgk
         Ob2Q==
X-Gm-Message-State: APjAAAVextc1RdhTwYHYWTFjwdK+4pWWoipJUb6rvyj2AjcPefnAGnmO
        6wA9p2tiRKxIfmW6mQF8hXR+Q0d2pEI=
X-Google-Smtp-Source: APXvYqx242/WqfiFH5Lc7kVQfByNiweB2tddXlKtejrtuwmVoz9eaOnoep9AaYQklNaIXe/MGBOYow==
X-Received: by 2002:a2e:a28f:: with SMTP id k15mr3320690lja.160.1551459115646;
        Fri, 01 Mar 2019 08:51:55 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id o7sm3624817lff.73.2019.03.01.08.51.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 08:51:54 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id d26so1824409lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 08:51:54 -0800 (PST)
X-Received: by 2002:ac2:415a:: with SMTP id c26mr3761301lfi.62.1551459114173;
 Fri, 01 Mar 2019 08:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20190228171242.32144-1-frederic@kernel.org> <CAHk-=wh5MQiXNUBCN6VKNGRR2gDekhXpaTc914D3y4=dHpmh4Q@mail.gmail.com>
 <20190301034536.GA19200@lenoir>
In-Reply-To: <20190301034536.GA19200@lenoir>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Mar 2019 08:51:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgOZuGZaVOOiC=drG6ykVkOGk8RRXZ_CrPBMXHKjTg0dg@mail.gmail.com>
Message-ID: <CAHk-=wgOZuGZaVOOiC=drG6ykVkOGk8RRXZ_CrPBMXHKjTg0dg@mail.gmail.com>
Subject: Re: [PATCH 00/37] softirq: Per vector masking v3
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 7:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> Numbers are indeed missing. In fact this patchset mostly just brings an
> infrastructure. We have yet to pinpoint the most latency-inducing
> softirq disabled sites and make them disable only the vectors that
> are involved in a given lock.

Note that I think we pretty much know that already: the people who
have had issues have never actually really had issues with the actual
"disable softirq" paths, they've all been about actually *running* the
softirq's (and that in turn being a latency issue for running _other_
softirqs, and in particular for delaying them into softirqd).

Now, it may well be that yes, we'll have "block softirqs" code that
has issues too, but it's absolutely been swamped by the latencies for
actually running them so far.

Note that this is all really fairly independent of the whole masking
logic. Yes, the masking logic comes into play too (allowing you to run
a subset of softirq's at a time), but on the whole the complaints I've
seen have not been "the networking softirq takes so long that it
delays USB tasklet handling", but they have been along the lines of
"the networking softirq gets invoked so often that it then floods the
system and triggers softirqd, and _that_ then makes tasklet handling
latency go up insanely".

See the difference? Not the latency of softirq's disabled, but the
latency of one group of softirqs causing problems for another when
they all get batched together (and soft-scheduled to another context
together).

                  Linus
