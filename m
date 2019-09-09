Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4250AC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205502086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406052AbfIIUvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 16:51:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42543 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406003AbfIIUvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 16:51:41 -0400
Received: by mail-qk1-f196.google.com with SMTP id f13so14596415qkm.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 13:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vhf/VH6qoGbAFq6Zh51eDwuCB0DIG+y0z43PDyN0q8A=;
        b=TnPu22lFA+qHFZ/W7Pd86taJWLahA4jst0mGpgTwxZDa6EQ7oBq8dZ9LF3cYENetnf
         GdLE4WpSTF4IecoGKJQa0dSdIl1CQ7pecnNBgJVr6cLOAah9eDB76naqxpayUMZf8AjH
         Yhn5ryHf6yjfdd+BJ72PNeqLetlo8/eyDaMsIBeu/oxsoHldWZ5OxRWx/LKbguPTB/gE
         /DJbT4C1YqaRHS4lf8DHFyvVqAHKzTnrkiymBWqCB3lAYkIGKz7r2HciBwSqm2Ly0D1c
         HqhcrDJ1eE1b00+wD+QgVjc7zh01/gG1KSHIVH+rpIcHq+6P+uACgSM0mXGDqU1K5QQ0
         eKDg==
X-Gm-Message-State: APjAAAWG9YVTIMjmL9w22okArakJUhA2IPir+sgOtd728BkZuSdnAhi7
        pIPQglsIw4SHCh3LFJWnkJRyWKobdB1T7MK/rMM=
X-Google-Smtp-Source: APXvYqxeuTRYeuG3UAIw3hBXZnoMih7mxoOVjzE2Y782n8BsFv1vUPn7JkL+YjH+hvAoxYdKHNs3DyDqbnCmQ+bVueY=
X-Received: by 2002:a37:8044:: with SMTP id b65mr3631697qkd.138.1568062299974;
 Mon, 09 Sep 2019 13:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190909195159.3326134-1-arnd@arndb.de> <3b69e0ec-63cb-4888-9faa-acb7638d71dc@linux.intel.com>
In-Reply-To: <3b69e0ec-63cb-4888-9faa-acb7638d71dc@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Sep 2019 22:51:23 +0200
Message-ID: <CAK8P3a0WDB_UvAnwfPDyR_maEefE4Qh++fHxAP61=8JfOFmy6w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: work around snd_hdac_aligned_read link failure
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Evan Green <evgreen@chromium.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 10:39 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> On 9/9/19 2:51 PM, Arnd Bergmann wrote:
> > When CONFIG_SND_HDA_ALIGNED_MMIO is selected by another driver
> > (i.e. Tegra) that selects CONFIG_SND_HDA_CORE as a loadable
> > module, but SND_SOC_SOF_HDA_COMMON is built-in, we get a
> > link failure from some functions that access the hda register:
> >
> > sound/soc/sof/intel/hda.o: In function `hda_ipc_irq_dump':
> > hda.c:(.text+0x784): undefined reference to `snd_hdac_aligned_read'
> > sound/soc/sof/intel/hda-stream.o: In function `hda_dsp_stream_threaded_handler':
> > hda-stream.c:(.text+0x12e4): undefined reference to `snd_hdac_aligned_read'
> > hda-stream.c:(.text+0x12f8): undefined reference to `snd_hdac_aligned_write'
> >
> > Add an explicit 'select' statement as a workaround. This is
> > not a great solution, but it's the easiest way I could come
> > up with.
>
> Thanks for spotting this, I don't think anyone on the SOF team looked at
> this. Maybe we can filter with depends on !TEGRA or
> !SND_HDA_ALIGNED_MMIO at the SOF Intel top-level instead?

That doesn't sound much better than my approach, but could also work.
One idea that I had but did not manage to implement was to move out
the snd_hdac_aligned_read/write functions from the core hda code
into a separate file. I think that would be the cleanest solution,
as it decouples the problem from any drivers.

> If you can share your config off-list I can try to simplify this further.

I uploaded the .config to https://pastebin.com/raw/RMBGXTky
for reference now. This is with the latest linux-next kernel, plus
a series of patches that I keep around for fixing other build
problems.

      Arnd
