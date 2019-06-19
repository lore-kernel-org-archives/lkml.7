Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66813C31E51
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354152080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtkrZat4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfFSCpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:45:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41244 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfFSCpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:45:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id 83so8739658pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 19:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=TlBSQBBbAV1ASMn6rzwZURJx1pQSgW8qwxXIhe/O8Wc=;
        b=RtkrZat4svUDkERDmBCRdYfZTYBRhqeEvZtnZrluvk2S2dWqGO2E/i1PaHBeCdvVBs
         nnR3pNuyzAlqBWvh5NbZ5HH6Ns0zwwMLUxXXBHBBrglFeF2qzY9S6CMA8kMO3d8cl4ym
         8ImfN0MtMr4d68uV9Bxjy2zLFiHhDLrtgf2mh7ZSu4LMzdCRjf+Pc31oh3IKLv0IouXi
         Ic5wFJWEUuia+zSvxHf1flDkbroKAdVrjj4byR52XcXnuaqCEBF5HaWjlvWEy93qtXSR
         JG81i0V8b+EHAK5mN7LMGSVvGvjceKHDqycEY7ePNLeZyWqEOF+Ulb8ki/cFMKfgvrLe
         5zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=TlBSQBBbAV1ASMn6rzwZURJx1pQSgW8qwxXIhe/O8Wc=;
        b=cHEVMlakA87eolDsFM657bZjcIow38NKisb2QBf6nYq6wcIfxON3c9/t4BvIF2e7j8
         ttxzMNchFL3TMJNrh9xiQwhMCLAhCNBNCjXuvxvCttjFAGEoLVU7M7fz/Z4taqTvRa4u
         YrBN5Sk+ru5UiIUJehMjXbUKDtvbWo3/AQlSV4lnjURJ0g6IX4D2v6eEo/efIXa9A2k5
         N+56cWMzmZgmC2DPBWb17SclUNiIM8FNq0YbY+PJN8Dkhb2Byl0AxonP/ae/CU1SqTcX
         UD3WuYM8bOU05ruKcHew2gGfZg7N77uMI+SvtevTiGrz9DmDJHAmIaAhtGp7ViBgYXvg
         8dgg==
X-Gm-Message-State: APjAAAXsTgypmDrBHhYMP/N6BGKdtVgIHnEktJ9+b9WE3Vj2bqax9ONx
        zkDrJ3ykwHz7HXxYDAYpMlo=
X-Google-Smtp-Source: APXvYqxKFK5Oq+nwOc3DU9FTdm6azMJZLN53AB3xMVAtZP03a9+c4qcNdHL0gzJTtLK9tF6GNqQ6ZQ==
X-Received: by 2002:a63:a61:: with SMTP id z33mr5616295pgk.154.1560912346821;
        Tue, 18 Jun 2019 19:45:46 -0700 (PDT)
Received: from localhost (193-116-92-108.tpgi.com.au. [193.116.92.108])
        by smtp.gmail.com with ESMTPSA id 27sm13036087pgt.6.2019.06.18.19.45.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 19:45:45 -0700 (PDT)
Date:   Wed, 19 Jun 2019 12:40:42 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] kernel/isolation: Asset that a housekeeping CPU comes up
 at boot time
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
References: <20190601113919.2678-1-npiggin@gmail.com>
        <1560151344.y4aukciain.astroid@bobo.none>
        <20190617155931.GK3436@hirez.programming.kicks-ass.net>
        <20190617190552.GA10264@lerouge>
In-Reply-To: <20190617190552.GA10264@lerouge>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1560911342.i8093fttpc.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker's on June 18, 2019 5:05 am:
> On Mon, Jun 17, 2019 at 05:59:31PM +0200, Peter Zijlstra wrote:
>> On Mon, Jun 10, 2019 at 05:24:32PM +1000, Nicholas Piggin wrote:
>> > Nicholas Piggin's on June 1, 2019 9:39 pm:
>> > > With the change to allow the boot CPU0 to be isolated, it is possibl=
e
>> > > to specify command line options that result in no housekeeping CPU
>> > > online at boot.
>> > >=20
>> > > An 8 CPU system booted with "nohz_full=3D0-6 maxcpus=3D4", for examp=
le.
>> > >=20
>> > > It is not easily possible at housekeeping init time to know all the
>> > > various SMP options that will result in an invalid configuration, so
>> > > this patch adds a sanity check after SMP init, to ensure that a
>> > > housekeeping CPU has been onlined.
>> > >=20
>> > > The panic is undesirable, but it's better than the alternative of an
>> > > obscure non deterministic failure. The panic will reliably happen
>> > > when advanced parameters are used incorrectly.
>> >=20
>> > Ping on this one? This should resolve Frederic's remaining objection
>> > to the series (at least until he solves it more generally).
>> >=20
>> > As the series has already been merged, should we get this upstream
>> > before release?
>>=20
>> I was hoping for feedback from Frederic, lacking that, I've queued it
>> now.
>>=20
>=20
> Sorry I just came back from vacation. Any chance we can use a WARN() inst=
ead?
> I prefer to use panic() only when data is really threatened or such.

I thought it was decided to panic here, because we don't assign a house
keeping CPU so the system is unlikely to behave properly. A warn might
scroll off the screen by the time things grind to a halt.

This is a one-time boot parameter misconfiguration, many cases of which
can cause a panic and boot stop.

No question if we can make this more dynamic that would be better, but
for near term at least can we go with this?

Thanks,
Nick
=
