Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D577FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99844218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgmp6BvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfCUEoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 00:44:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46400 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfCUEoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 00:44:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id o1so5073631wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 21:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iEtkszVLLNU+sqaVLD9f4N/eDcLXgaVMKWhv+59yX1A=;
        b=Dgmp6BvVdsUF/rhGWEPPHi9ZCS9XL149R3uMnLGVXkGoF5H1iN42EJRZe/aZCOTPL+
         G4zWc/OKQ6dcnOGnOZsSEa0mZCreYuy6A6yP9MgEk7culj5BUKcTtid1OPs2yELE5/Qz
         uu/4iWiXUANbngZ0xYikD3Th1Zsruw3+am6Off/K68LJrNB8VD/lEHuspl0ET/zuK47Y
         QIyP+6M7HaNrzVpZxjGAZGdu9efXSbj51cwjbe8AR9+O29I5iI9yUB3BHPBM/z+2Jmlx
         74htqMGGdv4MpIBnngIN55KgApr72iGObErQffgk8PkmSQijlAv/zwr5Q/fIwO3b621n
         mXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iEtkszVLLNU+sqaVLD9f4N/eDcLXgaVMKWhv+59yX1A=;
        b=Q5S/0oR8BccZpkfrNPFU3zPtEh8nrschekexFzlgeCtVI345aJZlpNO82fKvMHe6tB
         KuB5zSeLkip+sXKvfqdFieNYBgMVhYlBw7aJRxNxcqrVNOEcaF/MjZZcllhb0Gg1aolh
         +uL+sBw6qA40hkuDoEeZFaZNl9NdYk37YT83T/OW0T0F9/HJpvVO1pE+CVf+W6XUGjuz
         mtYBepcyJ35UymeEG+vq4TNV6AmV4CENLsW8trb5/F2sYP/+moir2OG8B3jAon33GVnX
         xfJZGS+aI7RV9N2Ou5s1cEh1KclJpW+O/Ccdz4AmtrLNOzqxhcLvQQam+U4c1rGdi6jk
         GceQ==
X-Gm-Message-State: APjAAAXwwj9aMEb5k/JbolBsvN7dbfvTzYpZUyJIfyPvOIgUdIwLFZVt
        CDsWkhIQGnD3HPhk2dwa7G25DB99rUlSzuOkBT8=
X-Google-Smtp-Source: APXvYqwCVF2FPTbjTmw3vvtSldWv3T320M+OFFXuJESUH7fFiCyG73ZzZnnKEN873pb5n+YlsSe29W98aNIAq4FbxhI=
X-Received: by 2002:adf:dbc2:: with SMTP id e2mr940523wrj.317.1553143461233;
 Wed, 20 Mar 2019 21:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190320005406.GA16412@archlinux-ryzen> <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190320043440.GA23335@archlinux-ryzen> <63518f1f-b808-77b0-aac6-ee1ece669c4b@amd.com>
 <CAKwvOdnQa-DnBqm7LgSaPZUeC2JP4UcCJD=piOZd5hdzHPc3ew@mail.gmail.com>
In-Reply-To: <CAKwvOdnQa-DnBqm7LgSaPZUeC2JP4UcCJD=piOZd5hdzHPc3ew@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 21 Mar 2019 00:44:08 -0400
Message-ID: <CADnq5_PTfJXJ99gFhxeMZ3RKigkipwjH5jLqfNM3mv49Z=d7Bw@mail.gmail.com>
Subject: Re: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 4:49 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Mar 20, 2019 at 2:37 AM Koenig, Christian
> <Christian.Koenig@amd.com> wrote:
> >
> > Am 20.03.19 um 05:34 schrieb Nathan Chancellor:
> > > On Wed, Mar 20, 2019 at 01:31:27AM +0000, Pan, Xinhui wrote:
> > >> these two enumerated types are same for now. both of them might change in the future.
>
> Please consider if the YAGNI principle applies here.
> https://martinfowler.com/bliki/Yagni.html
>
> > >>
> > >> I have not used clang, but would  .block_id =  (int)head->block fix your warning? If such change is acceptable, I can make one then.
>
> My preference on solutions, in order:
> 1. One enum (this is the simplest most type safe solution).  Add
> another enum when you actually need it.  Otherwise, YAGNI.

It make sense to have two enums.  One is a firmware interface that is
only used by some asics and the other is for the general driver
interface (non-asic specific for the ras features.

> 2. Safe casting function (like the one Nathan supplied, maybe with
> WARN_ONCE rather than WARN).  This ensures that at least if the types
> diverge you get a runtime warning.  A compile-time warning would be
> preferred, but I haven't taken the time to think through how that
> might be implemented.

I'd prefer this one.

Alex

> 3. Cast to int (this has been used in other places throughout the
> kernel, but provides the weakest type safety and doesn't catch future
> divergence).
> 4. Disabling the warning. (I almost never advocate for this).
>
> > Another question is if it is such a good idea to just silence the warning?
>
> For the kernel, it seems that each maintainer can choose what to apply
> to their subsystem.  I would recommend against disabling additional
> warnings that aren't disable kernel-wide for most cases.
> -Wenum-conversion has spotted many bugs.  While the enums in question
> today are not different, they MIGHT eventually diverge and lead to
> bugs, like the others we've found and fixed throughout the kernel.  So
> I would recommend fixing now, and be insulated in the future.
>
> --
> Thanks,
> ~Nick Desaulniers
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
