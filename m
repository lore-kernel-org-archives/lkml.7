Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9C9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2E720656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ObNA76ck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfEGUwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:52:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41830 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfEGUwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:52:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so15553148lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EkppjOqhFwW6IRTX5rEpsYgsXGymadylJWUfpsr+6AM=;
        b=ObNA76ck17W0C/AvaqLIKllbti1LD+xrLEE8uISEBPm+2LlbZ62NSxnnliMJIq4wIt
         1CNd6IPwYs2vBcuyfbfjvD2vx9uq0bWicBEZ9szMQkbJzpmoWpODAW0od4E0GIekRAG2
         SrXBzXRgMBJ3btVJw9Nf25NkPofpU/n5jcuxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EkppjOqhFwW6IRTX5rEpsYgsXGymadylJWUfpsr+6AM=;
        b=Oi+B+gvalImFsDSDzDtb01hbgXVUaKmeqJOBhu+fpPMM7Dy4ZEikgITinIdJo1Q9z5
         gO207369vIqluHvXZ3L+uLvVpLR+fdYdT/rfGKRMBA620gNri3mVxtmvNYucKbP24dqR
         Om6rPK4pZc8e2lVv1rBZbOPWFF0xWYy3JhR6Yuin8egTs3mEPz8JiLbM63ApdZrZxBxa
         UifZ7ZOOib53Dt48OjQEXhjyTFZ6ShG2uQ7utoccV9O+YLo0VNA+a7eQIhAdpaN4Pms7
         fIxYjC6ysChuEMKWtXoX+0i/WiNOA18KWiRNNUovoIGzopd5WCOXKz4Otf0ZwU2KU4eC
         Lwfw==
X-Gm-Message-State: APjAAAXgdWwn7hRcVNek1eaHUw4BCD9bCMRgcTWPkS/WorHJ8+fTwbXk
        DSY8bw+aTaYKdJeYOPDDiHzaEIyE8BM=
X-Google-Smtp-Source: APXvYqwmuVnHFr4NeBvzJb1Sci0P6E2HYg0anu2Ph211Kh64FACdbx7Ec6llUMzKDVxsyupWDA9tqQ==
X-Received: by 2002:a2e:1b8a:: with SMTP id c10mr12793395ljf.139.1557262342803;
        Tue, 07 May 2019 13:52:22 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o7sm3351399ljh.57.2019.05.07.13.52.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 13:52:22 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id d8so12847191lfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:52:22 -0700 (PDT)
X-Received: by 2002:a19:1dc3:: with SMTP id d186mr17099579lfd.101.1557262341496;
 Tue, 07 May 2019 13:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190506225321.74100-1-evgreen@chromium.org> <20190506225321.74100-2-evgreen@chromium.org>
 <74e8cfcd-b99f-7f66-48ce-44d60eb2bbca@linux.intel.com> <64FD1F8348A3A14CA3CB4D4C9EB1D15F30A7C756@BGSMSX107.gar.corp.intel.com>
 <5c42b741-5e5c-ce00-8321-59df1df115f1@linux.intel.com>
In-Reply-To: <5c42b741-5e5c-ce00-8321-59df1df115f1@linux.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 7 May 2019 13:51:44 -0700
X-Gmail-Original-Message-ID: <CAE=gft5TeW1h3GAT9Gkwdf8eE_p5aoywveE2ddXgYQ+fET8Sdg@mail.gmail.com>
Message-ID: <CAE=gft5TeW1h3GAT9Gkwdf8eE_p5aoywveE2ddXgYQ+fET8Sdg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v1 1/2] ASoC: SOF: Add Comet Lake PCI ID
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Rajat Jain <rajatja@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ben Zhang <benzh@chromium.org>,
        "M, Naveen" <naveen.m@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 1:26 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> > On 5/6/19 5:53 PM, Evan Green wrote:
> >>> Add support for Intel Comet Lake platforms by adding a new Kconfig for
> >>> CometLake and the appropriate PCI ID.
> >
> >> This is odd. I checked internally a few weeks back and the CML PCI ID was 9dc8, same as WHL and CNL, so we did not add a PCI ID on purpose. To the best of my knowledge SOF probes fine on CML and the known issues can be found on the SOF github [1].
> >
> > The PCI ID change is seen on later production Si versions. The PCI ID is 02c8.
>
> As I suspected, we are talking about different skews and generations of
> the chipset and a board-level change, not silicon change.
>
> The CNL PCH-LP PCI ID is 0x9DC8, the CNL PCH-H PCI ID is 0xA348 (used
> for CoffeeLake). Both are supported by SOF.
>
> What we are missing are the PCI IDs for CML PCH-LP (0x02C8) and CML
> PCH-H (0x06C8).
>
> Can we respin this patchset to add support for those last two instead of
> just the -LP case?

Sure. So just to clarify, you want the entry for 0x02c8, and you want
an additional entry for 0x06c8 under the same config. Will do.

>
> I'll send a patch to add those IDs for the HDaudio legacy driver for
> consistency.

Actually I've got that change ready to go too, I'm happy to send that out.

>
> Thanks!
> -Pierre
