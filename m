Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48160C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB82206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HI0GSgTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfCDKfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:35:10 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40452 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCDKfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:35:09 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so4627839qta.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 02:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y3yFt0bRkNO1CZ1zSHw7o3RPV+xGhD9D2clw1RudC2Y=;
        b=HI0GSgTBCxJN3nICnRvaUqmPx9yvsczBHKAluTCeC/ILoTt/f/5Cz3DHeC39dlf4nQ
         2SveXRVckO9ExOueHLj+2SgvTSPVm/eFD3GSW4ukrWJKi6ln+b79U+b9Mf2WO2oDsB54
         xC8MIZG1KIoGPIY1BNUu38wgDiAbRxAPj2/IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y3yFt0bRkNO1CZ1zSHw7o3RPV+xGhD9D2clw1RudC2Y=;
        b=hiHcnoyTKmhTrhxuZyhgb/ceYFT6SYObXxQriojZdtdf/TKQKwRbknkX6AHrqtdH+1
         iROzqGXig2RA6Hik/+Qqa2Xk9KiTGBqUn2TqsIgdtByBc11saSgXUs5LYcwmVAUyclJM
         UL7t6u6wWh7q5yVd72Ud9Do9X8xK+6o1rX32/W5VFz03pfb0b2vE1dAqxqkzDwhYLQBs
         Qz1PyN3QTGqw2cJpIGAEbffwbCthAoKSy/tvhs/cSIbhNGPUp57FfbaNXDcsnXf4oU/t
         0UYVFUyuzbm6yJGJhizDeP2ZUNb/nma8MBq+fTv843fglaCY9VMP56yRhBCFlihMfBSA
         ywXA==
X-Gm-Message-State: APjAAAUlJmbA8SyDIFmP64+kKwQFqAt+VAVMkrapUbeG0wPs8Yko3aP4
        EM6nVyZOWkuE9UdqLf2ypViq1rgZM01w2SK99hGnJQ==
X-Google-Smtp-Source: APXvYqwO8/+YAY8I38JsaA+1E6YJhWZpxAM2VVtSxVUy+mGMu1m45l94uwxZ7j2IvdFKUP6B5QKZ5uO5X8gmNT2b0ho=
X-Received: by 2002:ac8:2805:: with SMTP id 5mr14167485qtq.75.1551695707778;
 Mon, 04 Mar 2019 02:35:07 -0800 (PST)
MIME-Version: 1.0
References: <1541747389-28544-1-git-send-email-prpatel@nvidia.com>
 <CAL_JsqKOH0SQRXuRW5Y5dmWeUTSxhf2Nmn_0uNLeKXFPRc549Q@mail.gmail.com>
 <39d4161b-bcc0-0f1c-e7a3-5ad552fae724@nvidia.com> <CANMq1KDU=rTbwBdej+E0=RaWGQCOJrtKo_0W6kc=EdomNrKzog@mail.gmail.com>
In-Reply-To: <CANMq1KDU=rTbwBdej+E0=RaWGQCOJrtKo_0W6kc=EdomNrKzog@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 4 Mar 2019 17:34:56 +0700
Message-ID: <CANMq1KDr7QdP3oJR2+w4mh_Gf3JUUNmV8h_KffBRjN7kA3P4EA@mail.gmail.com>
Subject: Re: [PATCH] of: reserved_mem: disable kmemleak scan on removed memory blocks
To:     Prateek Patel <prpatel@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>, matt@codeblueprint.co.uk,
        Catalin Marinas <catalin.marinas@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, talho@nvidia.com,
        Stephen Warren <swarren@nvidia.com>, vdumpa@nvidia.com,
        snikam@nvidia.com, Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 4:56 PM Nicolas Boichat <drinkcat@chromium.org> wro=
te:
>
> On Tue, Jan 22, 2019 at 4:46 PM Prateek Patel <prpatel@nvidia.com> wrote:
> >
> >
> > On 11/10/2018 2:58 AM, Rob Herring wrote:
> > > On Fri, Nov 9, 2018 at 1:09 AM Prateek Patel <prpatel@nvidia.com> wro=
te:
> > >> From: Sri Krishna chowdary <schowdary@nvidia.com>
> > >>
> > >> Memory reserved with "nomap" DT property in of_reserved_mem.c
> > >> removes the memory block. The removed memory blocks don't have
> > >> VA to PA mapping created in kernel page table. Kmemleak scan on
> > >> removed memory blocks is causing page faults and leading to
> > >> kernel panic. So, Disable kmemleak scan on the removed memory
> > >> blocks.
> > >>
> > >> Following is the observed crash log:
> > >> [  154.846370] Unable to handle kernel paging request at virtual add=
ress ffffffc070a00000
> > >> <1>[  154.846576] Mem abort info:
> > >> <1>[  154.846635]   Exception class =3D DABT (current EL), IL =3D 32=
 bits
> > >> <1>[  154.846737]   SET =3D 0, FnV =3D 0
> > >> <1>[  154.846796]   EA =3D 0, S1PTW =3D 0
> > >> <1>[  154.846859] Data abort info:
> > >> <1>[  154.846913]   ISV =3D 0, ISS =3D 0x00000006
> > >> <1>[  154.846983]   CM =3D 0, WnR =3D 0
> > >> <1>[  154.847053] swapper pgtable: 4k pages, 39-bit VAs, pgd =3D fff=
fff8009df7000
> > >> <1>[  154.847228] [ffffffc070a00000] *pgd=3D000000087fff5803, *pud=
=3D000000087fff5803, *pmd=3D0000000000000000
> > >> <0>[  154.847408] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> > >> <4>[  154.847511] Modules linked in: nvs_led_test nvs_bmi160 nvs_cm3=
218 nvs_bh1730fvc nvi_bmpX80 nvi_ak89xx nvi_mpu cdc_acm uas lr388k7_ts imx2=
68 imx318 imx204 imx274 imx185 lc898212 ov23850 ov10823 ov9281 ov5693 tc358=
840 pca9570 nvs snd_soc_tegra_machine_driver_mobile lp855x_bl spidev input_=
cfboost pwm_tegra tegra_cryptodev tegra_se_nvhost tegra_se_elp tegra_se gha=
sh_ce sha2_ce sha1_ce aes_ce_ccm cryptd nvgpu cpufreq_userspace snd_soc_teg=
ra186_alt_dspk snd_soc_tegra186_alt_asrc snd_soc_tegra186_alt_arad snd_soc_=
tegra210_alt_ope snd_soc_tegra210_alt_mvc snd_soc_tegra210_alt_dmic snd_soc=
_tegra210_alt_amx snd_soc_tegra210_alt_adx snd_soc_tegra210_alt_afc snd_soc=
_tegra210_alt_mixer snd_soc_tegra210_alt_i2s snd_soc_tegra210_alt_sfc snd_s=
oc_tegra210_alt_adsp snd_soc_tegra210_alt_admaif snd_soc_tegra210_alt_xbar
> > >> <4>[  154.882606]  snd_soc_tegra_alt_utils snd_hda_tegra
> > >> <4>[  154.888133] CPU: 2 PID: 8079 Comm: sh Not tainted 4.14.53-tegr=
a-05132-g9c33465 #2
> > >> <4>[  154.895983] Hardware name: e3360_1099 (DT)
> > >> <4>[  154.900447] task: ffffffc7d62dda00 task.stack: ffffff800e2b000=
0
> > >> <4>[  154.906502] PC is at scan_block+0x7c/0x148
> > >> <4>[  154.911234] LR is at scan_block+0x78/0x148
> > >> <4>[  154.915689] pc : [<ffffff8008271724>] lr : [<ffffff8008271720>=
] pstate: 804000c9
> > >> <4>[  154.923290] sp : ffffff800e2b3b80
> > >> <4>[  154.927228] x29: ffffff800e2b3b80 x28: ffffffc7d62dda00
> > >> <4>[  154.932999] x27: ffffff8009aaa000 x26: ffffffc070c00000
> > >> <4>[  154.938769] x25: 00000000000000c0 x24: ffffff8009d90608
> > >> <4>[  154.944287] x23: ffffffc7dc6c6000 x22: ffffff8009d90000
> > >> <4>[  154.950320] x21: ffffff8009aeb320 x20: ffffffc070a00ff9
> > >> <4>[  154.955919] x19: ffffffc070a00000 x18: 00000000bec4c3f2
> > >> <4>[  154.961438] x17: 0000002224777924 x16: ffffff80080bb0e0
> > >> <4>[  154.967124] x15: 0000000000000000 x14: 0000000000000f75
> > >> <4>[  154.973069] x13: 000fffffffffffff x12: ffffffbf1e9f4240
> > >> <4>[  154.978670] x11: 0000000000000040 x10: 0000000000000ad0
> > >> <4>[  154.984107] x9 : ffffff800e2b3ab0 x8 : ffffffc7d62de530
> > >> <4>[  154.989958] x7 : 0000000780000000 x6 : 0000000000000018
> > >> <4>[  154.995645] x5 : 0000000000000000 x4 : 0000000000000000
> > >> <4>[  155.001245] x3 : ffffff8009aaa000 x2 : 00000047f6712000
> > >> <4>[  155.006846] x1 : ffffffc7d1ae6900 x0 : 0000000000000000

[snip]

For reference, there is another patch series that fixes the problem,
by Mike Rapoport (https://lore.kernel.org/patchwork/patch/1041790/),
already in linux-next (through mmotm):
42c9c0ac24393c of: fix kmemleak crash caused by imbalance in early
memory reservation
48ec6d51f7d3f2 of: fix parameters order for call to memblock_find_in_range(=
)

If anyone is interested, I backported these patch to our 4.19 tree
here, and they fix the issue:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
1496707
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/=
1496708

Thanks,
