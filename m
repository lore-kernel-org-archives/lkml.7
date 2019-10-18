Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E664ECA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A4D222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571357269;
	bh=KGUwgbrSrcRabFAXqNoJDzTfWljrn6ul+unKIrpgego=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x/jeDNC/cMkCEu3kPRCu17mB19Cu8aRCGQn4fuvUV0kMoHfeG9ySfDywJBJ6OVRx+
	 S/7f5ldA81kej/GrgkCxFzaTed5Fn3D3WsGIUpvc80ECaaLVoyOnvrfCGDFfxuhp/1
	 jgayueNS9FfiBjVowKr7D0k6uk6Y3JTicYQ0RhyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441847AbfJRAHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:07:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33726 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438763AbfJRAHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:07:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id y127so3278717lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k57WvexPDzWhZ12Of1tOHrp0702fGU2Gj8454jm70nc=;
        b=Ad9lRUGdbedhRZCYVLx3Ld+8Vb8YQ9pzptyJsMjKTj+qGH2s9TQhwWB0mAQQldc0zz
         Aoi1l0RHkbkMBHPFuO2iD4GUS7g6GpvYJF/+rvwqsR0GYO+ZbU8VOsL8jTdkgih+e7SN
         rxkRVhOwYaejpJHeojcMBN63yYEk4IJMz+9ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k57WvexPDzWhZ12Of1tOHrp0702fGU2Gj8454jm70nc=;
        b=NabRjjS/35dd+RwQGOq1Ka+McS8+nGKyH43PxydqD54NeB0XfaoDKg0fLUsDHRCFwM
         Gg+mEeiybezejfEgCHqCu25WnVYkoWjCC41ugJsBOVgXh3Jo9YHEz1Uk+S7YMEm6HlwV
         j3eArHVXwi56ZpV3ItHdAzavEawt4+zK3DFBk5xqPDQ3BKBpswiO2jCwr1rDXGRRP9SU
         /rjVWkWl9GrAQ+cpsAtj1GXgnXA30rEU8aFSIkHODo9bz+4DbU90BTV37m0kMfdp5808
         dRbbInZcSIpYg42EE8CgfbU7aS3gkDkuq7hq90LlC/lyygNxn7yRSVHt2MsyRUlEe7VJ
         rtPg==
X-Gm-Message-State: APjAAAWtvi6E0girlzyvYMAkdnKNa91DiGolaK+Fur2XSZxVZnY0LnRn
        kEV9fvXo9dqq5LmaSLiU3mNlf9AfhZw=
X-Google-Smtp-Source: APXvYqxv6NeA8IQCHpqsgBi5PWcxlHqHDJj8u93ooBhQHB1Hm7LHf6zkSKC9kHtgYDFxjHVtSD+1Tg==
X-Received: by 2002:ac2:4283:: with SMTP id m3mr4082323lfh.41.1571357232162;
        Thu, 17 Oct 2019 17:07:12 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id q24sm1984730lfa.94.2019.10.17.17.07.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 17:07:10 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id t8so3228644lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:07:10 -0700 (PDT)
X-Received: by 2002:ac2:43a8:: with SMTP id t8mr4026546lfl.134.1571357230358;
 Thu, 17 Oct 2019 17:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191017234348.wcbbo2njexn7ixpk@willie-the-truck>
In-Reply-To: <20191017234348.wcbbo2njexn7ixpk@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Oct 2019 17:06:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPZYxiTs3F0Vbrd3kRizJGq-rQ_jqH1+8XR9Ai_kBoXg@mail.gmail.com>
Message-ID: <CAHk-=wjPZYxiTs3F0Vbrd3kRizJGq-rQ_jqH1+8XR9Ai_kBoXg@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: Fixes for -rc4
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 4:43 PM Will Deacon <will@kernel.org> wrote:
>
> Note that the workaround code ended up being based on -rc2, so I had a
> bit of a faff trying to generate the right diffstat for this pull request
> after merging that branch into our fixes branch based on -rc1. In the end
> I had to emulate the pull locally because I couldn't figure out how to
> drive request-pull correctly despite the shortlog being correct. I'd love
> to know what I should've done instead.

You did the right thing.

When there are multiple merge bases, a regular "git diff" doesn't work
since it's fundamentally about two end-points (well, it _can_ work
almost by mistake, but doesn't work in the general case). So the only
way to get a "proper" diff is to do a merge and then diff the result.

That said, I also accept the output of "git diff" which will then have
a lot of noise from all the _other_ work done between the two merge
bases. I can figure out what happened, and do my own two-endpoint diff
and see what happened, and still se that "yes, that's what the pull
request meant, and that's why the diffstat is garbage".

What you did is the "good quality" pull request, though.

In general, people who aren't doing fancy things with git should never
get to the "multiple merge bases" situation, and then the regular pull
request logic works fine.

And people likme you who are doing multiple branches and know what
they are doing are also able to them handle the "uhhuh, I need to do a
merge to get a good diffstat" situation.

            Linus
