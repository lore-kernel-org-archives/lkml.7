Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA54C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25C1205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QoDVimnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfEFW47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:56:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40203 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEFW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:56:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id o16so10337002lfl.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/WaaNfj9uQg4GryTK10qiR1OxO5joqp6K8QA9QYZtME=;
        b=QoDVimnn8QHOXdN2QkfK6VzCJDeVnIwLrzgqElZtLPiU7cL/oyYMZH6s1M7qoUb4Iy
         XHdUlx6prmQytEtQ5Kvf4vij9oDEs2PgrVda4PhTWlz8tgsm71D73/5Tr3ccowET08Rh
         jYwwKrBm6uJTfoA8FFhN0LXX5shsZ5w7bAcSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WaaNfj9uQg4GryTK10qiR1OxO5joqp6K8QA9QYZtME=;
        b=G7jjmkmf6FJ0aoBWbSJ8zVSnVLNFB5J0H+ME4LOk4SXTFAom2Rp6nGCy32+FwTDQVt
         Pp0DozEAem5q71Uz51dYHYFLUYZl11elCuzegDYUFgCxsVN8uUAxn/i4NH177IO645sg
         T8jePx014fmqZ256PXzoJzzKYNoMExMs/9SNuT/lj68eH5qiVMH6IMp4n0ZmK3Zlabyr
         fehWKWRJa5TifupfFFwjZlNE7gO+gxJ0zurULvXee5jQIzuCXKP5NrzPsIgLTzWWrfKD
         W92TfKQtnFkdbx6teGguq2j6mHRNu5XFR5V5fw6OQd44d8BRj9CKXcuUp0Iv21jT1KmY
         Vgyw==
X-Gm-Message-State: APjAAAXjoTCq3TB0AHxy2ZRFbe82CzzbJjQ20PYx8TEl9W/T3fF87hlq
        1kmeTAJ+qNgepvtW9fN9bfsU9915M+Y=
X-Google-Smtp-Source: APXvYqxf59by1lWN7jhV5OdWa6rKJy5PtxK+7hfMhNIjWwcxgFfr+PkBwe6DlXpfJXGU1n7X3brHnQ==
X-Received: by 2002:a05:6512:309:: with SMTP id t9mr14188515lfp.103.1557183417070;
        Mon, 06 May 2019 15:56:57 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q16sm1726281lfm.9.2019.05.06.15.56.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 15:56:56 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id n22so2810748lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:56:55 -0700 (PDT)
X-Received: by 2002:a19:1dc3:: with SMTP id d186mr13761297lfd.101.1557183415092;
 Mon, 06 May 2019 15:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190506225321.74100-1-evgreen@chromium.org>
In-Reply-To: <20190506225321.74100-1-evgreen@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 6 May 2019 15:56:18 -0700
X-Gmail-Original-Message-ID: <CAE=gft6HNYqm7Jvh4hwgCLEaRVZ+95AJdYEncRKsq_ZmBidiqg@mail.gmail.com>
Message-ID: <CAE=gft6HNYqm7Jvh4hwgCLEaRVZ+95AJdYEncRKsq_ZmBidiqg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] ASoC: Intel: Add Cometlake PCI IDs
To:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, Jenny TC <jenny.tc@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 3:53 PM Evan Green <evgreen@chromium.org> wrote:
>
>
> This small series adds PCI IDs for Cometlake platforms, for a
> dazzling audio experience.
>
>
> Evan Green (2):
>   ASoC: SOF: Add Comet Lake PCI ID
>   ASoC: Intel: Skylake: Add Cometlake PCI IDs
>
>  sound/soc/intel/Kconfig                |  9 +++++++++
>  sound/soc/intel/skylake/skl-messages.c |  8 ++++++++
>  sound/soc/intel/skylake/skl.c          |  5 +++++
>  sound/soc/sof/intel/Kconfig            | 16 ++++++++++++++++
>  sound/soc/sof/sof-pci-dev.c            |  4 ++++
>  5 files changed, 42 insertions(+)
>
> --
> 2.20.1
>

I should have mentioned that I based this off of linux-next next-20190506.
-Evan
