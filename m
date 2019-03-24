Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0760C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18E22147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553450843;
	bh=nz+raG89T6BowVqL777gCMrpZ3eUummC3QwTDnNQiXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XXT/fAYu5//jIGN7hA/QVfKvYhtdisNlGCdp43DWJsCmmdjEXVOc2uH6UqjUDiPHk
	 wyiGVnU2PKerX4J7OCqBiu2jFl3gnDaHoL1ZzA5tPw45K8NccgY5j+phccH1EtozIw
	 MS3IVab8/sQZib3m2B52CTxk3gNwG26Gkae5faOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfCXSHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:07:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44661 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCXSHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:07:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so1366550ljg.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 11:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k0VEqFUW67Vjg9PES7Hhfwx95xrrA+t3oU072LrOAv8=;
        b=HKPgyOMM+FtbcPx3ttml+1GzInSnU4Sp6aAlT/MAxWFkWHIKDuwYJPyX/yLajXZEda
         gcNy6iFC1srYqr/WenxGSOLcZcz20KbpKt0R4OIzUcU8uUDdRt/0qqn4Ly+UAw1AZwZP
         8axKV2A09P7n4JEBE2NcfbEX81BuegZjnq/4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k0VEqFUW67Vjg9PES7Hhfwx95xrrA+t3oU072LrOAv8=;
        b=Nz7CsCm2KRnVZtksDf6SYjGvLFTNIpjr48bMeO6WOuxUH52wUVy4hkkzOERad8KaDw
         n2xHvKvJOxYfPD42whT8HEFyu2k67w1MdTfwJvY16G5UEhSsSEye9pj1Uxka1pDwH9Qj
         AExkeh5uvZePTgorgqPiu4zNeHG6yme8w78HJnU2SVV2xRnbohxnL8R+ckXSiBKbwGlI
         3f/aLUOBVYiIXdc6Umt1KSMHGnaphbqlU9tCANvNiH0bIgv7MQgk3Me0/kVFMsdfvQm4
         X3gfJyecphuCJQm0yFEiNsag0iel7u5wlOSQmVqAWTSQWJzUiFXh5IK6VHrZDCb/Vo11
         OG0Q==
X-Gm-Message-State: APjAAAWjAzd2AtYG0MMMZkiiCXbjIpP8XiQ0zY+eXeDD5IXJ7JI9IYiX
        gjfBAKtdLPE5WckJkymnWye8l14FuWw=
X-Google-Smtp-Source: APXvYqza8un3gkKMsJmEAi+jz1CDgb0XOHsY9eWPogdt0mGqP5sCsyjbT8DBE7Pi1mLYEM1eTFQrMA==
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr11042691lje.22.1553450839589;
        Sun, 24 Mar 2019 11:07:19 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id t29sm504824ljd.82.2019.03.24.11.07.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 11:07:18 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id y6so5829285ljd.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 11:07:18 -0700 (PDT)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr9835082lji.79.1553450838254;
 Sun, 24 Mar 2019 11:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
 <155343674152.28403.9250472064220526031.tglx@nanos.tec.linutronix.de>
In-Reply-To: <155343674152.28403.9250472064220526031.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Mar 2019 11:07:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgC4FQeT8Z6+gXnbsDFxRAD9sSELd8-G=6gQg4kxKKL4g@mail.gmail.com>
Message-ID: <CAHk-=wgC4FQeT8Z6+gXnbsDFxRAD9sSELd8-G=6gQg4kxKKL4g@mail.gmail.com>
Subject: Re: [GIT pull] scheduler updates for 5.1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Second more careful attempt for this set of fixes:

What? No. It's the exact same garbage as last time, with no more care
shown anywhere:

  kernel/sched/cpufreq_schedutil.c:346:26: note: in expansion of macro =E2=
=80=98min=E2=80=99
     sg_cpu->iowait_boost =3D min(sg_cpu->iowait_boost << 1,
SCHED_CAPACITY_SCALE);

I told you *exactly* what the problem was the last time, and it's
*exactly* the same now too.

Hmm. Looking closer, I see that the patch you *claim* to send me has
"min_t()". But the tree I actually got has the same old garbage.

I suspect you didn't update the git repo properly or something.

But since the -tip tree pull requests don't include the git hash
value, I can't even tell what you *meant* to send me. I assume you
also don't get the warning that "git request-pull" would give you
about mismatches..

                Linus
