Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C88C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FE92173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pe2CTJwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDKRfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:35:25 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42681 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKRfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:35:24 -0400
Received: by mail-vk1-f195.google.com with SMTP id 195so1556751vkx.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IFQ2qc30fvBPdVTm6E0fqqBDLHFIUqXIvbHwaJ+icCI=;
        b=Pe2CTJwFxEwXkNUoQqsrnd6W3m64wCfVEBUbQv7WMNR4tAylXbROeUT7alXM8mo9/t
         m2IZzClels8s5qkUGDdlvSMoqIfVXvtkI945pECdlC/vvzVmgGWirTG5A9reB+wMBaGz
         lHWHk/C0hob8NqiA4sl6kwSHqt0daCQ5tVleo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IFQ2qc30fvBPdVTm6E0fqqBDLHFIUqXIvbHwaJ+icCI=;
        b=a1CsuSdpFodZKxWntOQGRUJxynZzL3moW/gsqv1ThIwjIwLUfMCbxVSOWvLubT0kSr
         Z/Cri6WRjZ1nqVDWNU/YHxDV2O2MHnx86gU6f6T5wED0pXpx4lmhT/0E4HsjlpPFQiKS
         6SI5AIxhoMllssE3clOscaIGMiXP4MBr/j7FyxF1ThQHt0Lh6hAxviKaYJqiTBQ0a4H/
         pCLsEH+49o4Itz8j+mzw+68zDkHJuzpbxcUtgDdJGl+JKpZy6ywF+worqMkPV9eAUrt+
         N5C/Q6KKEsKlyRvHIUZ87KsNNKI/DEGCDfKxDZ2prRs8oX8WANzqDilQt+atKZCoygbT
         IO1w==
X-Gm-Message-State: APjAAAW7LoLMTi9JhCfBcY/gXbEV3NcQzmGKumb0gH5keYeC7CC6bZfa
        gAOed3LYk5fYc+5yXA/0O4xrbIdpzr8=
X-Google-Smtp-Source: APXvYqzwE1x3jnbx6mitTUCDmNUWTgmvdMYE1zyPD7Oqys+x64itg6jQE4zO2RI5VG32ReKC3uEX3g==
X-Received: by 2002:a1f:4ec7:: with SMTP id c190mr27782547vkb.27.1555004123305;
        Thu, 11 Apr 2019 10:35:23 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id e81sm18832592vkd.56.2019.04.11.10.35.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 10:35:21 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id s63so1555176vkg.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:35:21 -0700 (PDT)
X-Received: by 2002:a1f:29c5:: with SMTP id p188mr28647311vkp.24.1555004120656;
 Thu, 11 Apr 2019 10:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190215185151.GG7897@sirena.org.uk> <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
 <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
 <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
 <CAPcyv4hDmmK-L=0txw7L9O8YgvAQxZfVFiSoB4LARRnGQ3UC7Q@mail.gmail.com>
 <026b5082-32f2-e813-5396-e4a148c813ea@collabora.com> <20190301124100.62a02e2f622ff6b5f178a7c3@linux-foundation.org>
 <3fafb552-ae75-6f63-453c-0d0e57d818f3@collabora.com> <CAPcyv4hMNiiM11ULjbOnOf=9N=yCABCRsAYLpjXs+98bRoRpCA@mail.gmail.com>
 <36faea07-139c-b97d-3585-f7d6d362abc3@collabora.com> <20190306140529.GG3549@rapoport-lnx>
 <21d138a5-13e4-9e83-d7fe-e0639a8d180a@collabora.com> <CAPcyv4jBjUScKExK09VkL8XKibNcbw11ET4WNUWUWbPXeT9DFQ@mail.gmail.com>
 <CAGXu5jLAPKBE-EdfXkg2AK5P=qZktW6ow4kN5Yzc0WU2rtG8LQ@mail.gmail.com> <CABXOdTdVvFn=Nbd_Anhz7zR1H-9QeGByF3HFg4ZFt58R8=H6zA@mail.gmail.com>
In-Reply-To: <CABXOdTdVvFn=Nbd_Anhz7zR1H-9QeGByF3HFg4ZFt58R8=H6zA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Apr 2019 10:35:08 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+Sw2FyMc8L+8hTpEKbOsySFGrCmFtVP5gt9y2pJhYVUw@mail.gmail.com>
Message-ID: <CAGXu5j+Sw2FyMc8L+8hTpEKbOsySFGrCmFtVP5gt9y2pJhYVUw@mail.gmail.com>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
To:     Guenter Roeck <groeck@google.com>
Cc:     kernelci@groups.io, Dan Williams <dan.j.williams@intel.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Reber <adrian@lisas.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, info@kernelci.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 9:42 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Thu, Apr 11, 2019 at 9:19 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Mar 7, 2019 at 7:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > I went ahead and acquired one of these boards to see if I can can
> > > debug this locally.
> >
> > Hi! Any progress on this? Might it be possible to unblock this series
> > for v5.2 by adding a temporary "not on ARM" flag?
> >
>
> Can someone send me a pointer to the series in question ? I would like
> to run it through my testbed.

It's already in -mm and linux-next (",mm: shuffle initial free memory
to improve memory-side-cache utilization") but it gets enabled with
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y (which was made the default briefly in
-mm which triggered problems on ARM as was reverted).

-- 
Kees Cook
