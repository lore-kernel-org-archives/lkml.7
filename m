Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578EDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1581020850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+xYGohk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCTRUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:20:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46792 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCTRUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:20:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id a22so2241582pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KO0XpscKrYt+xQV/EBrujKL2kyg4+vBWQN+QTHCDpFQ=;
        b=J+xYGohk1v5b+oRiQyQ4OZNI/AmKSZUWv1iUzGu4bN2wap6nyMie0rLZpnJ7ERWiM6
         LxeHRE0buGmH95dRLM+3niJ6jLeMDnpB+9eNsEGqTnoqrY/4bm8gcQM1lsRuMpAdLOoa
         9p0WgBFJ2ttNqC3IwYvMeH/0tfYpUc1RuB0wf8iUgxx26S5Xep5MDCAWUPVaMlkJpSPV
         w1vBCPRBy+vz0jjxcwqehcO3H3ZoVU0QYG/YjE+LCLXs+kbohxum71sbsyfjOCKzXKBW
         ukDQlOPO30kpN7EmJB/63s7tYtP/tTsntk0/g2HPQuqYU7awJhX3i7iZR7PRbHn66AaL
         IWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KO0XpscKrYt+xQV/EBrujKL2kyg4+vBWQN+QTHCDpFQ=;
        b=nw5SLkNOpQVNhDOBHT37lNXY2nkVIicFRG+tmKDZfuy/bkTsow9aUbFsrxNUmi6y6x
         vI7oGyJqzOg6SboBM4Tx6HfY3WWFOD1bvn+vXXoxMH4xKGctOILZOSp8PIezNhQo9HGo
         NecVAtnqAD8PySoI4rdjaJF45KfvrAja/+04zEMrBorniUpEW6WZQeiLd53w+13QhYqy
         2+SQ1MJAQ9tG8PVTkzXGIOGL4NExNHhf+LfViPACytyMB/xVU5EyayhH4zDU+pUqXu8y
         JMVoknnciNCvKfqEdivme7dhKyHH6Pdnsm1JU3XP2F1QHW4dvhaNFYw4OlnQXrYlswDQ
         YmQA==
X-Gm-Message-State: APjAAAU+Lqb/VYj+WvKzEYNZHbqPqnEAEXToh7HKOkw0yKm8H0G2CWYY
        BY3QRqLARJ11ygrCQhkLA6Xttt26dDlGlJ2nz/48dw==
X-Google-Smtp-Source: APXvYqyD4CSS/g5FWsIRjZP+IUbQNM2lsdUX1+b+FAYyrayPZQ/qr3Nz/h4k+KzpXuW0AjpP+7plBJAUXkXsZTsHz5w=
X-Received: by 2002:a63:5a20:: with SMTP id o32mr8099535pgb.225.1553102399905;
 Wed, 20 Mar 2019 10:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190320005406.GA16412@archlinux-ryzen> <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190320043440.GA23335@archlinux-ryzen> <63518f1f-b808-77b0-aac6-ee1ece669c4b@amd.com>
In-Reply-To: <63518f1f-b808-77b0-aac6-ee1ece669c4b@amd.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Mar 2019 10:19:48 -0700
Message-ID: <CAKwvOdnQa-DnBqm7LgSaPZUeC2JP4UcCJD=piOZd5hdzHPc3ew@mail.gmail.com>
Subject: Re: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 2:37 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 20.03.19 um 05:34 schrieb Nathan Chancellor:
> > On Wed, Mar 20, 2019 at 01:31:27AM +0000, Pan, Xinhui wrote:
> >> these two enumerated types are same for now. both of them might change in the future.

Please consider if the YAGNI principle applies here.
https://martinfowler.com/bliki/Yagni.html

> >>
> >> I have not used clang, but would  .block_id =  (int)head->block fix your warning? If such change is acceptable, I can make one then.

My preference on solutions, in order:
1. One enum (this is the simplest most type safe solution).  Add
another enum when you actually need it.  Otherwise, YAGNI.
2. Safe casting function (like the one Nathan supplied, maybe with
WARN_ONCE rather than WARN).  This ensures that at least if the types
diverge you get a runtime warning.  A compile-time warning would be
preferred, but I haven't taken the time to think through how that
might be implemented.
3. Cast to int (this has been used in other places throughout the
kernel, but provides the weakest type safety and doesn't catch future
divergence).
4. Disabling the warning. (I almost never advocate for this).

> Another question is if it is such a good idea to just silence the warning?

For the kernel, it seems that each maintainer can choose what to apply
to their subsystem.  I would recommend against disabling additional
warnings that aren't disable kernel-wide for most cases.
-Wenum-conversion has spotted many bugs.  While the enums in question
today are not different, they MIGHT eventually diverge and lead to
bugs, like the others we've found and fixed throughout the kernel.  So
I would recommend fixing now, and be insulated in the future.

-- 
Thanks,
~Nick Desaulniers
