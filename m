Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48500C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B23206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555402212;
	bh=omy8/etVNGwu4Qd+wMmhCrZqRi6mgdzE98GMd5ctQCs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qtOGkVoY7/DxSmzybzf6O+kdHe7KTYN+4Rl5MHgbH2B8obNyDH/JbislNeX8RdT7i
	 LeJbspiROdy7w0vzR5WpBuEi4GsYONyqN82U9KUA/PCfOzKuILfXZc8faUTSOBaPko
	 V2ySK1TzBqJVVk+Lyj8CvHFvH75rqsncGB+T8rMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfDPIKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:10:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39703 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfDPIKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:10:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so16844003otb.6;
        Tue, 16 Apr 2019 01:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omy8/etVNGwu4Qd+wMmhCrZqRi6mgdzE98GMd5ctQCs=;
        b=koGTuLTwGVBjZhhLtrTWwu/l83Jez8UezZKVuTQswqLJeEIgG1KFZPQrxqDXw7nxKE
         lmDl2yJt8ty5M3u1PpzarAdxu2s8Q9sMQz1OiulusYQreluZRess0T3hFLFaLeHz/e52
         nfYJLw2ny4VA0o0FNjcN5bqb/ms1iwL3QGUKMz7KY2y8lTXLAYCruQbEC7rTNGTHD0R6
         hxbpT5jZYls6JX0R0nVffqEbGuMEMv/3703ylwsXedWx5OMpqo/8UwEePyZ2qJgfmDnI
         2DHK4ghf/ypqcZy6UMuNQTqibDVWhIiHv3W4C+NdA5+hStDROhaBh5wdZp06fjjfFWFW
         pBJA==
X-Gm-Message-State: APjAAAVsO/0KX470PhIXciTMtAuM9VJ3themCbO/FRi7Bhef1RdYGGJB
        sqMVe/d0v3tqK4nStB8wZAZfIrGPXp9Y2J+bNN4=
X-Google-Smtp-Source: APXvYqzJya6FMiPevXlWBCEOghCT3aGYfbfMgS3t85w/PXsrmJJP4ikN5Ta4nO+RhsPbvP5ijAmvOFNotGgziuQbS6o=
X-Received: by 2002:a05:6830:11d0:: with SMTP id v16mr16449079otq.159.1555402209366;
 Tue, 16 Apr 2019 01:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190415151857.25531-1-pierre-louis.bossart@linux.intel.com> <20190416032923.GQ28103@vkoul-mobl>
In-Reply-To: <20190416032923.GQ28103@vkoul-mobl>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Apr 2019 10:09:57 +0200
Message-ID: <CAJZ5v0jOkQ7aWn6B_yVTYd7y+78mpGSzBoGuWe3uCdzDRNE94Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI / device_sysfs: change _ADR representation to 64 bits
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        jank@cadence.com, Joe Perches <joe@perches.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 5:29 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 15-04-19, 10:18, Pierre-Louis Bossart wrote:
> > Standards such as the MIPI DisCo for SoundWire 1.0 specification
> > assume the _ADR field is 64 bits.
> >
> > _ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
> > released in 2002. The low levels already use _ADR as 64 bits, e.g. in
> > struct acpi_device_info.
> >
> > This patch bumps the representation used for sysfs to 64 bits.
> >
> > Example with a SoundWire device, the results show the complete
> > vendorID and linkID which were omitted before:
> >
> > Before:
> > $ more /sys/bus/acpi/devices/device\:38/adr
> > 0x5d070000
> > After:
> > $ more /sys/bus/acpi/devices/device\:38/adr
> > 0x000010025d070000
>
> This looks fine but the sysfs file is an ABI. Not sure if we can modify
> the value returned this way.. Though it should not cause userspace
> reading 32bits to break...

Well, IIRC using "08" instead of "016" in the format field would
preserve the existing behavior for 32-bit values, wouldn't it?
