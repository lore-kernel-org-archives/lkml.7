Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF83C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B7E206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRzXPzDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbfJIXGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:06:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40852 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbfJIXGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:06:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id d17so2890785lfa.7;
        Wed, 09 Oct 2019 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8s1tJBc8q1/SxFYyW+OjF++gC55iovEKVHxLXRLrnfo=;
        b=CRzXPzDAp1BKUeBcS1UensR6cHYpzE5XLAbY3Zb/7M7ednucPx/CAXgJf5GHYz/Qju
         EypVX/9ssK1GNOP9MO5LjJPoh1j7vcT0MxxXiSOgLsnO6SvKxMLk2hRxjP9ptbXiH2OE
         IbpFJTVGq4vVmdk4gs6AkirZrdwvFx8CQnAUO3uZX2QE+e8xyA58Nxjj0LxBFFRM1f4F
         YvD1RraSbJ5IhOtm2TlyzVOXnY70u82mFoaMFQB8eEfBenjLJvcnjD5vpDBXPabEso3A
         gdAca78SfKwGBsqhT/WgWvLHXXaGDh4WV1PEz5nWh6+1Cx4UvTIj3nhJgs0Z0C2xXqBe
         VD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8s1tJBc8q1/SxFYyW+OjF++gC55iovEKVHxLXRLrnfo=;
        b=MWLiowEOw0CqmP6BsuNF81Xnn4Z1RvrD8IlSE/gDVegGQuq1U2E8iYlhs3vpr6cUC/
         69V4Cq26wUVObvqqaX8IwFHPuHRSt55inVwj8l+yA+u49t5sZ1BSfJErdRgeiiLPVkYG
         S3NhApKEdvqFM9oWIe5QOUzPnxVRax9/aaUCOe16MLqB3ovhQ1NWNfaxf6AD0txhM8WI
         YK6ViugvRMqlMJ+h+cAbzcJ+Cgg9AOqK5TvNGkvxFuTH2lMDk9ZLJZPrZK6O4phRviem
         mttM57s/fb28CxdLtl7HCkFfBvzm5wIIK2ZeFG43eLj/PJxU2iHMpxpAbIO21oVe4Rhv
         ZsmQ==
X-Gm-Message-State: APjAAAWg082g8BwxCrY5bGK5VxuAUMMeBRv4ZOgl9V4AFlW2RxxyWp5v
        /G1y+DKTJFVX79n8/rWXsX2JF2jCXzwEuAV3pGcleJAy
X-Google-Smtp-Source: APXvYqymXWGFSkjOPo78KkUgEyC48GdyaAYZYft9mouAKyQ7MxTcxaQrKP80m2SS6/4wA4F3HLLEuNTCuhthf1d5PmY=
X-Received: by 2002:a19:4f06:: with SMTP id d6mr3702768lfb.15.1570662390203;
 Wed, 09 Oct 2019 16:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191009160907.10981-1-christian.brauner@ubuntu.com>
In-Reply-To: <20191009160907.10981-1-christian.brauner@ubuntu.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 9 Oct 2019 16:06:18 -0700
Message-ID: <CAADnVQJxUwD3u+tK1xsU2thpRWiAbERGx8mMoXKOCfNZrETMuw@mail.gmail.com>
Subject: Re: [PATCH 0/3] bpf: switch to new usercopy helpers
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 9:09 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Hey everyone,
>
> In v5.4-rc2 we added two new helpers check_zeroed_user() and
> copy_struct_from_user() including selftests (cf. [1]). It is a generic
> interface designed to copy a struct from userspace. The helpers will be
> especially useful for structs versioned by size of which we have quite a
> few.
>
> The most obvious benefit is that this helper lets us get rid of
> duplicate code. We've already switched over sched_setattr(), perf_event_open(),
> and clone3(). More importantly it will also help to ensure that users
> implementing versioning-by-size end up with the same core semantics.
>
> This point is especially crucial since we have at least one case where
> versioning-by-size is used but with slighly different semantics:
> sched_setattr(), perf_event_open(), and clone3() all do do similar
> checks to copy_struct_from_user() while rt_sigprocmask(2) always rejects
> differently-sized struct arguments.
>
> This little series switches over bpf codepaths that have hand-rolled
> implementations of these helpers.

check_zeroed_user() is not in bpf-next.
we will let this set sit in patchworks for some time until bpf-next
is merged back into net-next and we fast forward it.
Then we can apply it (assuming no conflicts).
