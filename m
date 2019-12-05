Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E05C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D57224648
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WVUhFM/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfLEQkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:40:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39346 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbfLEQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:40:35 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so4268338ioh.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 08:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnSZ1HocZmFXibZc/RmleTCK7QzGnhXUqE2Wqe01NTg=;
        b=WVUhFM/Gu50kF5obPXp291eiDa3l4PfApYvEAiDm+pzyIVPqSFwEvdshHnE49VWUtV
         0sxHOexRG8QRvCbiheB/EO7/MV32WnC2flHRnrWoKjYhEsxjhPWB+CmnYEpWJjjslWXY
         JbNCfR5Ddm3do9T9YzQyeAGUjLjRvcbc0gz2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnSZ1HocZmFXibZc/RmleTCK7QzGnhXUqE2Wqe01NTg=;
        b=es4j+u4zRP6wZIuATQTJpSRqU/+c5crxZCNbnK01dQctutMBDdDiJVrnddPYuzhIMs
         wEXx6/QDwrRVCgs/cuzkG3YchvZ6BHTqf6U1rTI6+dP6ru5w/UfqjJA8ZtcaalYEEZph
         WluEPSAZta145Tm27k+DhOJB7YEohJvi1qe342Bm3sU5CTcR4amd9lKnF97Hggv7amw6
         gFEE+xL7FqH6DENmhp54XC1w6Vg+ULFY0D+Vp7BNExppCc5wEcWBjzcOXFFxfKg/tXKa
         u8lYDwWGXLxigEy9F7+hO8pao7/KffzL6/dGIRa0cjikmsZJOwQ2A/1tPBrRVc2fGcjx
         VHvA==
X-Gm-Message-State: APjAAAUIQiOVRwg3rtJ+Uy5JWtjK6Kc3Ly6QJeHs9qqZ0xyspvHgPvsJ
        IFmubSntnp84Ygsn3g1zXvN9pLVWOWIsY1CyS1TmnQ==
X-Google-Smtp-Source: APXvYqwvrkf93Tp7ZF+8isPCaGzNcsH1taXJLgkRqEuBouTDgW9mh284rB06SYQo3eRERN3v/u2u6S4p0JdI9cJgNBQ=
X-Received: by 2002:a02:9f09:: with SMTP id z9mr8866500jal.119.1575564034137;
 Thu, 05 Dec 2019 08:40:34 -0800 (PST)
MIME-Version: 1.0
References: <157554844882.11018.13436399905210284553.stgit@devnote2>
In-Reply-To: <157554844882.11018.13436399905210284553.stgit@devnote2>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 5 Dec 2019 08:40:23 -0800
Message-ID: <CAJ-EccNKk30b_wtvz=PUVmMVfF8YNagXMcy3Uhj53DzFbgmb6A@mail.gmail.com>
Subject: Re: [BUGFIX PATCH v2 0/3] selftests: safesetid: Fix some bugs in
 safesetid test
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jaswinder.singh@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 4:20 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi,
>
> Here is the v2 series to fix build warnings and erorrs on
> kselftest safesetid.
> This version includes a fix for a runtime error.
>
> Thank you,
>
> ---
>
> Masami Hiramatsu (3):
>       selftests: safesetid: Move link library to LDLIBS
>       selftests: safesetid: Check the return value of setuid/setgid
>       selftests: safesetid: Fix Makefile to set correct test program

These 3 fixes look good, thanks. Were you thinking they would go
through my SafeSetID tree or is there a dedicated one for selftests? I
guess if you're not sure someone else on here can chime in, or I can
just take them through my tree if I don't hear anything.

>
>
>  tools/testing/selftests/safesetid/Makefile         |    5 +++--
>  tools/testing/selftests/safesetid/safesetid-test.c |   15 ++++++++++-----
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
