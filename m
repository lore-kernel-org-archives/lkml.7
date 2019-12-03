Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078C9C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D0F2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUiQ2WxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfLCTkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:40:36 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46015 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLCTkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:40:35 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so5062152ioi.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 11:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ch+WNijaY6AsPxm0+XePiTtapq06gZNm+FnTtW+Yvk=;
        b=cUiQ2WxJYfgxGRtIYYrBFgideFa64zwJVC0xM+vPn1heDbtP8PS8yhn2SslWuKeDcv
         qhLffbJ3Uo+Xo+PBrM9d1srYRC+HpClcuPS7jDcp7nCHYvNKj3tAiPHBPOeKB6nyEJgr
         hAziOs01GF/Nm9RN1Ac/APBu0vvoX7TLuXjbEo16RDF+snyauxsyRnPMV36z/iiP3SDn
         hKDznvFTSRzqAqz2WkQLpDHNKsS+cvsRHjWorCY9fY2HMWbBfkQv7Akz/++xiyUkfxYF
         soTgico8aclq+HXraOhqfo7I5eaUa1BR59m74mMTlpG6jLAnZo16mBg2DDLjOz1EzXtX
         1Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ch+WNijaY6AsPxm0+XePiTtapq06gZNm+FnTtW+Yvk=;
        b=fgzlccU8fNwb48PMiJn78ZDoHfHCvfwiME7dQBDeOcdTwCwGTsr6Urskex5gG4zMSH
         XmAC119hQPWMA1QjLW/Ww1Y36VFPPzPjShxe2wHc/TthbJQ7DrZx02lkvl5Iaa/zqdm7
         SUfMcK0fzvSDw+jT8yyu5HqX2oVNZ2/ebWccW4MY3ZxbqlY+2Pa8bAr8k+fLWXoup9ki
         B7T9W6LhA0RJC6SR0dPAFX4jLkmEZw+owOFoD1sumPUU2lcLPYswyrnZetBwceHsV3Mg
         rPlogf7AaW8hwcjAEHF5GXItXTfSStCXaxPOumm5GU8W1CEqDZ57n3336xhKQGmVkGuz
         EdtQ==
X-Gm-Message-State: APjAAAWmih74yUne5By8Q7GYdniDri+GT5dN8qbiMaj1NEBgQ56iKcl3
        /0BayU7HCdDC085wTPTILInOe/dkA04a8S2BDDiMGg==
X-Google-Smtp-Source: APXvYqycuBVBV4ixbORLjq5bU2odtfEntOXSTXVTJDzP7mv/SVY3vXetQWjJOUPobARr4NVuoGg3ywXDKlHjyRak6ng=
X-Received: by 2002:a5e:df06:: with SMTP id f6mr3715528ioq.84.1575402034437;
 Tue, 03 Dec 2019 11:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
 <CACdnJus7nHdr4p4H1j5as9eB=FG-uX+wy_tjvTQ5ObErDJHdow@mail.gmail.com> <CAKv+Gu8emrf7WbTyGc8QDykX_hZbrVtxJKkRVbGFhd8rd13yww@mail.gmail.com>
In-Reply-To: <CAKv+Gu8emrf7WbTyGc8QDykX_hZbrVtxJKkRVbGFhd8rd13yww@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 3 Dec 2019 11:40:23 -0800
Message-ID: <CACdnJusMeC+G3wq_oDGTYi1CBMWDiuq4NdANTBmhNBTDu5zCug@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Laszlo Ersek <lersek@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 3:54 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> There is no reason this shouldn't apply to ARM, but disabling bus
> mastering like that before the drivers themselves get a chance to do
> so is likely to cause trouble. Network devices or storage controllers
> that are still running and have live descriptor rings in DMA memory
> shouldn't get the rug pulled from under their feet like that by
> blindly disabling the BM attribute on all root ports before their
> drivers have had the opportunity to do this cleanly.

Yes, whether this causes problems is going to be influenced by the
behaviour of the hardware on the system. That's why I'm not defaulting
it to being enabled :)

> One trick we implemented in EDK2 for memory encryption was to do the
> following (Laszlo, mind correcting me here if I am remembering this
> wrong?)
> - create an event X
> - register an AtExitBootServices event that signals event X in its handler
> - in the handler of event X, iterate over all PPBs to clear the bus
> master attribute
> - for bonus points, do the same for the PCIe devices themselves,
> because root ports are known to exist that entirely ignore the BM
> attribute
>
> This way, event X should get handled after all the drivers' EBS event
> handlers have been called.

Can we guarantee that this happens before IOMMU state teardown? I
don't think there's a benefit to clearing the bit on endpoint devices,
if they're malicious they're just going to turn it back on anyway.
