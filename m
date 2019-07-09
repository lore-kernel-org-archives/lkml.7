Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799FFC73C63
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 23:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E6E2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 23:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W7h81HWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfGIXQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 19:16:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36686 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIXQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 19:16:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so216606pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 16:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awoEQfWGapBaj0Tp+LlSdruFxp5j9H2c6orS7eInq0Y=;
        b=W7h81HWxl41Yr3Uga46NxLjRsvpDv4dSeW445Z0IATWZ1bhCnuHT+wpnkG31Xfbxw/
         tS6Gm+Qm5Er+pejDfy7o/d/ETBwxS/DGvQwSmRTyYSq3wO/M5XxynHRbB1IYPvDvpn0D
         dYa0mMCLkFjMerp31H/gmw8kYQQ2oZwb4YHWD59EnYbXANtA3jitC5olNcZ72yKoBcrR
         5MkfMzwJkR5pFA5/aLonME/d8CqdyrWNYRsvqps7PlrQrJxnHRjdKraxIF9Qf3VrdJm7
         QDPZ6kZOBIXubDhXQvfbajz6lltXo4ZMZKKwWta5BwX1KqnaM9tcMc/jDqP4uAD4hd0J
         zHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awoEQfWGapBaj0Tp+LlSdruFxp5j9H2c6orS7eInq0Y=;
        b=kq0a4k9CZpofbKbme9coPsgxNKfrwYJjWlhrE9m+iHcaYd3C4WbWQ6A7VnTaHcr2tY
         OQJVdSBFl2jbS0YG05TblC8lzPjXJ847MsGoIBpnH+TT7VWvneMmEBm4X3e900aNj7yo
         j+F6l8mcYXvbfLFeNT/Dy34Tf85MlI38LCzK7yjyEMONoG4JKnztLQ9HMF2bkWf+Q1gK
         0s7pcsjDFdO31gj4B86yMzq3MdTLaJ9OyPxzMUnIYNyCy241nXx6ed2JpKYnrVrFyto7
         TlD+cScu+q0Rd+UvnkvNJMN18XuzgBX2uctiUvH8nlziY9teRqc3K///YFeqxMToGnxi
         R01Q==
X-Gm-Message-State: APjAAAWeSrNpgAgQRtVSBD8Q3fH+JZ46NDJDuybw4AWypD1Djfa51fuO
        KwvQq0HF8crBfkL1h13VndMh3a42+W4zA86n48W5iw==
X-Google-Smtp-Source: APXvYqzuij9P82r9Vkxg6ekoZihPhgvYFuu7uAZGBt/qVM63kAALo74dY78klfYLo/XtbqSd67/EdIjHnt2H8hJ/lDE=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr2872161pjs.73.1562714208253;
 Tue, 09 Jul 2019 16:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190709221312.7089-1-natechancellor@gmail.com> <20190709230552.61842-1-natechancellor@gmail.com>
In-Reply-To: <20190709230552.61842-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Jul 2019 16:16:37 -0700
Message-ID: <CAKwvOdkBshMOSezpbu_CV6CuK23W42Vgw=dNS1X6aga+KaL_cQ@mail.gmail.com>
Subject: Re: [PATCH v2] IB/rdmavt: Fix variable shadowing issue in rvt_create_cq
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 4:06 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> The function scoped err variable is uninitialized when the flow jumps
> into the if statement. The if scoped err variable shadows the function
> scoped err variable, preventing the err assignments within the if
> statement to be reflected at the function level, which will cause
> uninitialized use when the goto statements are taken.
>
> Just remove the if scoped err declaration so that there is only one
> copy of the err variable for this function.
>
> Fixes: 239b0e52d8aa ("IB/hfi1: Move rvt_cq_wc struct into uapi directory")
> Link: https://github.com/ClangBuiltLinux/linux/issues/594
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Updated the wording of the commit message to use proper terms like
>   scoping and shadowing, thanks to review from Nick (let me know if the
>   wording isn't up to snuff).

LGTM thanks for following up w/ v2.
-- 
Thanks,
~Nick Desaulniers
