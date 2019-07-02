Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D58C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4669218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rouFNaQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfGCAoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:44:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40391 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGCAoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:44:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so683105wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiKm32fbrJXvadhbbH8R2AC30oRr6R/vtBXdk9UU6tg=;
        b=rouFNaQrAD+LVzdQfwSGl8KyN3XCFATAsscS1nSiY3nqrVKn88L+2X9hpP8G0LkkWC
         NbXBVmKrNM2i/FYXzVyY65owea83CsnsL2EYq3GhtYm+wIktVkTqWtRAWOulqc+2Eijb
         tNZhEVAQRLz89yF0sk+uF/rQSzJNULI8c49x9De777zT65pYsUUSurWdrSNR9lmy2NEt
         9eY0VkqUb2j+lxdkUSL9dhgUIzql3NanYjEhvjtxJVfIfVj1EIEm0MIgXIiUzfQXV33O
         rHDGqg4EVcvtwueBiup5u0kebQrjrGClyg1D+nX2fPJPU7N/NtWIDb7JpF1b7OEh92lu
         QbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiKm32fbrJXvadhbbH8R2AC30oRr6R/vtBXdk9UU6tg=;
        b=JKr04Y4DRGCkWPLOLqEaC1kMlZUa4uNdrqoGLUETFt+4u1MOf68bJDLER26LwYqe17
         +TvkgZLt84dnHIEwwVbFsIV9g2U/P3AMsW/oeXRrjU1qUzB2WxUVKBOSNq3DsieJVSjv
         oq10GR/cnWn3+GAGRtDW/htNB7QwPhN9y2H6cteadCn/sjH3tIRMHSAtcdgI+sf6Vr0p
         I8M2uRa/tLa1EPy7U7MyHVWfg3OFBi496R0eujP/kPo5zlsfQr+DxN8QtvUiEJe2mSev
         ZSWnZImq6jY5e9080o6G+AUwgB164iQuLIhknlSHlh0e4/1wJEoDZBhYnyf/dlso64nv
         xdbQ==
X-Gm-Message-State: APjAAAWx+Urcjda4n8Si8NBxLEKzPR8m2qqoDhg6sq1/kK4WOC05zyOA
        tHIorT/9VRHxMp8kXIPCHIBb1lgRzulSyxGu99XU+1a4Z2A=
X-Google-Smtp-Source: APXvYqyzF5MuwoPkI10B4TbfC/rzEV0YiPHBluGmH1/zHhhFfHwqiAfVyxlK7Fj4GY/VFsoeVVgftVQDaSC75isjmzg=
X-Received: by 2002:adf:b69a:: with SMTP id j26mr17416154wre.93.1562099731858;
 Tue, 02 Jul 2019 13:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190630203614.5290-1-robdclark@gmail.com> <20190630203614.5290-3-robdclark@gmail.com>
 <CAKv+Gu_8BOt+f8RTspHo+se-=igZba1zL0+jWLV2HuuUXCKYpA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_8BOt+f8RTspHo+se-=igZba1zL0+jWLV2HuuUXCKYpA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Jul 2019 22:35:16 +0200
Message-ID: <CAKv+Gu-KhPJxxJA3+J813OPcnoAD4nHq6MhiRTJSd_5y1dPNnw@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi/libstub: detect panel-id
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Julien Thierry <julien.thierry@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 at 22:26, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Sun, 30 Jun 2019 at 22:36, Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > On snapdragon aarch64 laptops, a 'UEFIDisplayInfo' variable is provided
> > to communicate some information about the display.  Crutially it has the
> > panel-id, so the appropriate panel driver can be selected.  Read this
> > out and stash in /chosen/panel-id so that display driver can use it to
> > pick the appropriate panel.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Hi Rob,
>
> I understand why you are doing this, but this *really* belongs elsewhere.
>
> So we are dealing with a platform that violates the UEFI spec, since
> it does not bother to implement variable services at runtime (because
> MS let the vendor get away with this).
>

To clarify, the above remark applies to populating the DT from the OS
rather than from the firmware.

> First of all, to pass data between the EFI stub and the OS proper, we
> should use a configuration table rather than a DT property, since the
> former is ACPI/DT agnostic. Also, I'd like the consumer of the data to
> actually interpret it, i.e., just dump the whole opaque thing into a
> config table in the stub, and do the parsing in the OS proper.
>
> However, I am not thrilled at adding code to the stub that
> unconditionally looks for some variable with some magic name on all
> ARM/arm64 EFI systems, so this will need to live under a Kconfig
> option that depends on ARM64 (and does not default to y)
>

... but saving variables at boot time for consumption at runtime is
something that we will likely see more of in the future.
