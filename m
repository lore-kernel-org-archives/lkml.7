Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D025C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335E6214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZzwEIDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfLLPqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:46:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45638 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfLLPqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:46:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so3206974wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxsBMZ6WbR7V0yuuMk21Fb3OoOTmsXkSh9qn9LWUugE=;
        b=iZzwEIDi+TWzVINbxcfauAo67Jg2SQE1ZRriGcl+mSfqJ16DT6GTCr7SuTscMzxf0g
         /MVW0kE+2YtToTVoueMbRn7oC9wcWfS3q1DyjlAJnRNYZOfwz6pexJuXxJmA/hMOTubK
         mYWDx+co4CVm1qN2NfCTma8estYI7icXwCc+KDtLTKprfYpRAJ4+vAUpOAwJmgkGPZZ1
         8KCk521yBqYveb1kzxJyB110rA/yOSyjbABKc44fk/W8P73+/wBpWA6RRBuMQUWCyGzr
         D+5lPVORNXw1IIPMkn+m2L/TNS9LrbTycWBwwTb/cQVyzhxj/nryOWJTINkLXiFojFEg
         38EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxsBMZ6WbR7V0yuuMk21Fb3OoOTmsXkSh9qn9LWUugE=;
        b=FffwqqwZnJzwd+45SpWJkfrgtanXt06AuCTjpEUJ/6Ddk342ygOLciqwxvpL4K7gXq
         2A8TINUNlyhGlhSqhPrt/EMnMIzW2A0A6Qls4DoDVgdf2YoZbiiIpZSdUrxWfKTa+4Df
         2cDPmnXnRWhGIkqXLzzdkdT1X1Hb/8zV0iqBPwveCz5walNlJu5wraAgp0+fErZVlKaw
         S0XtQEinWp/d4WDU45WGwPXdfvX2oYfmj8qn3crv29xR54Cow0wcLHoIkmSMLrMryELG
         WrTHAaeq1yKkVWxKmrlJdAvnhTJ4cQfdIojSMOeLvncauAW6K5QtLOdrkiAUrMQb+F5C
         /HSQ==
X-Gm-Message-State: APjAAAVC7oAZzoX8l3GXIuuvstZO/9kRmyZqPPrF2q1CAiCegr36qeQ1
        FRKYKSHPb45n8GgzzoWG6w5pnOiBS9OdrPFrMhKz+Q==
X-Google-Smtp-Source: APXvYqwMRwhuu8E+XbLgvlzzM2FTbIs/x7tJxkkEb6lo21GfuTVfgXBGocjpi9FnOde8dYUZjcASFfH232/ywUAOEEA=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr7281055wrw.246.1576165604385;
 Thu, 12 Dec 2019 07:46:44 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
 <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
 <CACdnJuv50s61WPMpHtrF6_=q3sCXD_Tm=30mtLnR_apjV=gjQg@mail.gmail.com>
 <CALCETrWZwN-R=He2s1DLet8iOxB_AbuSGOJ3y7zW=qUmx33C=A@mail.gmail.com> <CACdnJuvTR2r_myJX2bQ8XTDw_HxM-EgqhVLaUJVCa+VQS+6Qrg@mail.gmail.com>
In-Reply-To: <CACdnJuvTR2r_myJX2bQ8XTDw_HxM-EgqhVLaUJVCa+VQS+6Qrg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 12 Dec 2019 16:46:32 +0100
Message-ID: <CAKv+Gu-7H7AmMGk8_safU83KZZiJJpQ4X+o7V9Pv24AOh3g5ug@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Matthew Garrett <mjg59@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019 at 20:56, Matthew Garrett <mjg59@google.com> wrote:
>
> On Wed, Dec 4, 2019 at 11:50 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> > Wouldn't it also be applicable in the much simpler case where the
> > firmware hands over control with no IOMMU configured but also with the
> > busmastering bit cleared.  Does firmware do this?  Does the kernel
> > currently configure the iOMMU before enabling busmastering?
>
> We already handle this case - the kernel doesn't activate busmastering
> until after it does IOMMU setup.

Build issues aside (which we already handled off list), I think we
should consider the following concerns I have about this patch:
- make it work on ARM (already done)
- make the cmdline option an efi=xxx one, this makes it obvious which
context this is active in
- I would prefer it if we could make it more obvious that this affects
PCI DMA only, other masters are unaffected by any of this.
- I don't think the presence of the IOMMU is entirely relevant - even
in the absence of an IOMMU, I would prefer bus mastering to be
disabled until the OS driver takes control. This is already part of
the EFI<->handover contract, but it makes sense to have this on top
just in case.
- What about integrated masters? On the systems I have access to,
there are a lot of DMA capable endpoints that sit on bus 0 without any
root port or PCI bridge in between
- Should we treat GOP producers differently? Or perhaps only if the
efifb address is known to be carved out of system memory?

If we come up with a good story here in terms of policy, we may be
able to enable this by default, which would be a win imo.
