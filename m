Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC23C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49D820878
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbkzR/Hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKRUY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:24:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37198 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfKRUY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:24:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so21092440wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 12:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TP0OA6qAUarvzHjPaXa1q3NuiVFGsPfLMvD1RhmmCY=;
        b=AbkzR/HkTUrIdzHZR1Hn4Mw0IXd15Hbl8V3PLYisq2ODU1nwdZ9uSlzIdR1VbZ/LVG
         HgSmQcT3uDM15WcvVJ+/UPy8zZ8sqsKYQs1dPR8elnvEZ2/yawvQDqIplgLUwg5b+oGa
         H++5CFDB8Djm1Oc6rX/BFY8LBBI30stVNS2SlIqCR/i8IkVg/dVGsYkHSG0QLv0bapcx
         nTYMmGaRPh/IgaZV/xxDLCpY+UaOBCh+EXc3uH9vNLOIPhmREpWZ0SiXc7k5rZizpiqI
         nDekWyJeZWZzxhrZpPwBm7kCnvWIrZ+IZ3OX9xfuaAALOtAo7RwMA4Xam3lhhvu4AMrV
         TC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TP0OA6qAUarvzHjPaXa1q3NuiVFGsPfLMvD1RhmmCY=;
        b=iMG/D8R8axU29egG+0ToPAWzM5G9g10Dg00/Af8JIqgz5e2HLBeKXLLneVhelvSLCf
         nRbBaY4HJSxuxQdMewzFRUstRTg0IBdfI74MldDwiwx7QOoI23JmfSC58MbvHqyEvER3
         dCnpNgL1AA1FBgExA6hZKJYuNM7f25MWuEdLNgHTVlXKAPVwAVl6OQXQ+Dr2wmqJmutD
         CyBVZpT1swKKzLsQ3d6qMm8GOQsx5JPdWVfKz3RT3fQ3K//T0/Zo0ldWu1N3uQ/qrzsS
         0USUF6WsL5E7lWiPDlIJ8IO1LOonVpc0K5iqrgD5zamu3xmeO4m3kxSiXQ4VvLXTezV/
         ywjA==
X-Gm-Message-State: APjAAAXIfs8sqFDkP4mef37o8BSpar8913UKwDSXgThgMRPo/E1dUZe/
        YQVbcTfwFgKAfjjcSsDnCI4rLeIHE4gVsPctY4g=
X-Google-Smtp-Source: APXvYqyWKIvojuyIkn9PhBUmCnA+BIbkZlyEb9tBgjPQlLDHLHnK6Mn8Li8qCQVenOtWz4sjXqxHztqmgocAHdd4TPs=
X-Received: by 2002:adf:e444:: with SMTP id t4mr9612725wrm.50.1574108667374;
 Mon, 18 Nov 2019 12:24:27 -0800 (PST)
MIME-Version: 1.0
References: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
 <1574064214-109525-1-git-send-email-chenwandun@huawei.com> <MN2PR12MB3344BBBA7F72F9625D71329EE44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3344BBBA7F72F9625D71329EE44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Nov 2019 15:24:13 -0500
Message-ID: <CADnq5_OYLYxwDsiqmDn0tJqrvdHc119LOGPSLuG=g2ShL4_oFQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/powerplay: return errno code to caller when
 error occur
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     Chen Wandun <chenwandun@huawei.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Nov 18, 2019 at 3:15 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: Chen Wandun <chenwandun@huawei.com>
> > Sent: Monday, November 18, 2019 4:04 PM
> > To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org; dri-devel@lists.freedesktop.org
> > Cc: chenwandun@huawei.com
> > Subject: [PATCH v2] drm/amd/powerplay: return errno code to caller when
> > error occur
> >
> > return errno code to caller when error occur, and meanwhile remove gcc '-
> > Wunused-but-set-variable' warning.
> >
> > drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c: In
> > function vegam_populate_smc_boot_level:
> > drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1364:
> > 6: warning: variable result set but not used [-Wunused-but-set-variable]
> >
> > Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> > ---
> >  drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> > b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> > index 2068eb0..50896e9 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> > @@ -1371,11 +1371,16 @@ static int vegam_populate_smc_boot_level(struct
> > pp_hwmgr *hwmgr,
> >       result = phm_find_boot_level(&(data->dpm_table.sclk_table),
> >                       data->vbios_boot_state.sclk_bootup_value,
> >                       (uint32_t *)&(table->GraphicsBootLevel));
> > +     if (result)
> > +             return result;
> >
> >       result = phm_find_boot_level(&(data->dpm_table.mclk_table),
> >                       data->vbios_boot_state.mclk_bootup_value,
> >                       (uint32_t *)&(table->MemoryBootLevel));
> >
> > +     if (result)
> > +             return result;
> > +
> >       table->BootVddc  = data->vbios_boot_state.vddc_bootup_value *
> >                       VOLTAGE_SCALE;
> >       table->BootVddci = data->vbios_boot_state.vddci_bootup_value *
> > --
> > 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
