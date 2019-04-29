Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E388C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27FB20693
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556505718;
	bh=v5W8ScpvZ1h+jU+TL4WwGpo2qLxsX8PxBtUB94OTtOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AgRznBtfOpCkJm49uTQKy6X81gVncFPZuZ/P2CwA81cJCjhuHI43Qm65NTTbgusBV
	 iRzuPeZUauPdUiOjO9/g6TM/KVt0reDqyHY5AFHxHbSPH0Dlc0HLvRzFc+iiRpZuz6
	 SwEA8WzLzFW2wdreyEJEQ4LfN3lCDOTy+ERakD+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfD2Cl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 22:41:57 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:41506 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfD2Cl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 22:41:57 -0400
Received: by mail-lj1-f169.google.com with SMTP id k8so7908132lja.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 19:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gq0Kmcl4mOgSlNzh50O36MLVAt4+kKSq62znrv8IbtE=;
        b=a1KfzonGU5LsPeNbWXC0G1capE2w+AQaMH0R4JyD1w1G46NX6x3qAG543Z5HMMemB5
         Y+3imuesz1kPxvPAYVayxT6+9qenwRKzQw/nOQJ2Q6yygR1F3gLlY2CPecRez/70rvTq
         08Kzx4WpA/jSuAPPfpYcBoWFDyNskYuEBAFj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gq0Kmcl4mOgSlNzh50O36MLVAt4+kKSq62znrv8IbtE=;
        b=N8rvUo7d59H6AvH0wrfk8sioBHVe1nWD/Xe6AlH5k/CLpfukcheXzHzjBWdDZCQ4Jf
         5TV1MXlupwMdZ0PuQpNE4sX6IxX4LigpgVnz2fe9cT+w9Z9qQMgnS3TrbOrGxliS2wgS
         ydNOT1vd6ce4gDzTp4RVAqqiMhIPFX27XlMkk2x1zGFSUDwd0K9J/R9S4lDeVCUnUzUo
         5w3FwYM/2W+U3EBzFiA3iZiNbyikvq55ovVyPS8vOI/MihjM2pUJdiWl3bdXbWkzEpis
         Yt/J2qWlcpWeIljRjSMl6V0EtuAQvS6z4jzxdlzeL23jeyeQNs37zHWh4RFNvJlBfvZf
         g+ug==
X-Gm-Message-State: APjAAAUpgaSfkd5xEXM6FDfpeogPjyV/jKuBfEKe5Bx8KHIzowQKtREU
        XJcjHBbl+5RTaLFN3wPtGGP490mjbNU=
X-Google-Smtp-Source: APXvYqw57a5QW/7HK+1N2apVg6PVrZx3ya15Sv03Bp9eEoXwi7xe8/AvEAzheglHtQoUOuDDWyO3vQ==
X-Received: by 2002:a2e:9c89:: with SMTP id x9mr12941524lji.28.1556505714575;
        Sun, 28 Apr 2019 19:41:54 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id r26sm4394803lfa.62.2019.04.28.19.41.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 19:41:53 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id j11so6768875lfm.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 19:41:53 -0700 (PDT)
X-Received: by 2002:a19:f50e:: with SMTP id j14mr5131635lfb.11.1556505712950;
 Sun, 28 Apr 2019 19:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190428212557.13482-1-longman@redhat.com> <CAHk-=whU83HbayBmOS-jbK7bQJUp87mvAYxhL=vz5wC_ARQCWA@mail.gmail.com>
 <3f8fd44d-1962-e309-49b5-bb16fd662312@redhat.com> <CAHk-=wg_facR6y3gnmtGwBSJYZdHm5rWSPpPhJG6XswW4+mO1Q@mail.gmail.com>
 <604c8751-5269-de29-0b7f-b3e93b6df4ca@redhat.com>
In-Reply-To: <604c8751-5269-de29-0b7f-b3e93b6df4ca@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Apr 2019 19:41:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi70jyU5_3y9XB9B7kJCR6QeNPgTaxnuPE7gm3i472e4A@mail.gmail.com>
Message-ID: <CAHk-=wi70jyU5_3y9XB9B7kJCR6QeNPgTaxnuPE7gm3i472e4A@mail.gmail.com>
Subject: Re: [PATCH-tip v7 00/20] locking/rwsem: Rwsem rearchitecture part 2
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 5:28 PM Waiman Long <longman@redhat.com> wrote:
>
> Not really, this is a serious problem that have to be backported to
> earlier stable releases and downstream. The clever code is helpful in
> those cases.

Fair enough, I guess the code will live in the stable trees for a longish while.

               Linus
