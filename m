Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90856C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6230D2064A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5mkG8Xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfFGQ1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:27:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35711 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbfFGQ1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:27:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so1493830pfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqyZx9iWQSohVD4pOTPBFDt/riunHpxurkj2Ho1xanY=;
        b=O5mkG8Xz6c0aSCpHQl5CUNP9F4sa04/6eEwgbg11oS4zsnlYr/4kt+6kPEOj/W/s1K
         HoREQuZ5fedTxfZ0oPJER12yuy9xT4nEJZFJuamYtN0blVEep3BjpHURl9TFr1K39aNi
         nRQ0L2FYopbECGm9MnJoefxRTAbgYcJBUCrxXpaKxEYT+tjIXJcDF6NWwWYTtYU7BiNJ
         TNi+0JH9Muzb4W5LkG3HkoMlRVUGlBPJEAUFAI1Gu/gYfW0/mS9aOv374hLxsxMvgZME
         jeFtL7YOeskSA+xiCfzrwt0PVSw5HXOTOS35kSvVV73joezUDzwf9CrgbcZs5CF0IelP
         SBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqyZx9iWQSohVD4pOTPBFDt/riunHpxurkj2Ho1xanY=;
        b=MllYFe99pE0rvA5FBQjENPhiPx1CSPueN6L5bynGq4k1H07Mdl8M+KeYhOpGuQ2bvk
         LbyBOdsba5Ny8jV2FUWNgMka3ZdUqxIgkdtEL3sMGKWaKnbNGRxpfZLVwYqa3tQiSDZt
         SuXaGLRKBeMHInfAIokYIyopyXNUIm9p4Hg2P6Es/zimpV8vlIYPwlcCUL6liIZiAuv6
         wyAzfIy3LndCHiNh9DYQ2M0ykmqTqwImGz6QYwKu0k30rNO7T1DRBVCxKXDpjiK0GHYH
         jNH6jjCtp3hPNGCAslYLX/EXeSsQh9nhOgAMFinF2r4V115Bex4Rc7OxiuFVc1mrrKiK
         W1KQ==
X-Gm-Message-State: APjAAAWj3F40E4lfqDJL4g9FPHyAdGMOq3fUHVlzC37lBZENNBEV3Mco
        ip8emMs+V/rQkxP+1319mT7Rwu8AlSREW2GxuYGqOg==
X-Google-Smtp-Source: APXvYqyzrRMSqaqwsV0Po3zPJV8/o7msAVJpp+Avm7yDigimd3u39ivzLigKuLzto8lyalxe4W7ehLmTWc1DMrKYZlI=
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr3601408pgm.10.1559924870758;
 Fri, 07 Jun 2019 09:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190607161201.73430-1-natechancellor@gmail.com>
In-Reply-To: <20190607161201.73430-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Jun 2019 09:27:39 -0700
Message-ID: <CAKwvOdmV2Z77hKHCg-Mn5DK+3Zdpj0sY2uRc2Or0Y20UkS8UHw@mail.gmail.com>
Subject: Re: [PATCH] arm64: Don't unconditionally add -Wno-psabi to KBUILD_CFLAGS
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 9:12 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> Use cc-disable-warning so that it gets disabled for GCC and does nothing
> for Clang.

Thanks for the quick fix.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
