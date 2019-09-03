Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27592C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AB921881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567530754;
	bh=/wdQ1YhXsTvuDiWZTQITULzZHMbY+cl0uiFulxQoW6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bum3bLcVaL8UQJ4rNlXyJZJRFM4RGQv0Rb5wflBDauScLNZYSW7pjFXSlzmA57AEp
	 xyVewtJdd93zjY1S9y0zMWjlcWh2IOId4K9hs3ovig+KrWMXnDaHGb2TWEdBhwy3Qd
	 L16Q8HWXnZdgiURrIeqhLRWCoKO/5nVeciQmHU/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfICRMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbfICRMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:12:32 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AACA2339D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 17:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567530751;
        bh=/wdQ1YhXsTvuDiWZTQITULzZHMbY+cl0uiFulxQoW6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mva18n3MRZ/TlzdcC5FSQiScaVxm5H2GoC7okBNeqLeHRiydEvAtmvwZ+nPpmAbgQ
         9GE0rivo3Mz4yKUHcu155m/J7PS+FgQjOACVQvmVissBDLW2OGs+g3GLCduffIdi/c
         Zm77bHIIEsG+gW4PWciTGULVTnMo3Ik8EzS02VO8=
Received: by mail-wr1-f46.google.com with SMTP id u16so18344956wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 10:12:31 -0700 (PDT)
X-Gm-Message-State: APjAAAWchY3K8sq45n5iduhQ4ASpSIslUjEL56VaMIqSE+uqvkNhP+6J
        xYa36p9xwbjPdWC7v8rMh1G+hsw/mG+LoQ39M5k=
X-Google-Smtp-Source: APXvYqxKRabkSSRgWU+32cKIIPNwz26js4n2SGBqfmD4T68CUkwoKtbvmcEzwVjsMzCDpREJg3bMZpt/VNlH4XEWLlg=
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr24120785wrr.343.1567530749864;
 Tue, 03 Sep 2019 10:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190903113651.3862-1-kw@linux.com>
In-Reply-To: <20190903113651.3862-1-kw@linux.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 4 Sep 2019 01:12:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT-woTmWe4aqOLUemK6agTRHxXqWKoOAxeJ8XPiAJ+UzQ@mail.gmail.com>
Message-ID: <CAJF2gTT-woTmWe4aqOLUemK6agTRHxXqWKoOAxeJ8XPiAJ+UzQ@mail.gmail.com>
Subject: Re: [PATCH] csky: Move static keyword to the front of declaration
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx,

Acked by: Guo Ren <guoren@kernel.org>

You may also modify others'

=E2=9E=9C  linux-next git:(linux-next-for-v5.4) =E2=9C=97 grep "const stati=
c" * -r
arch/csky/kernel/perf_event.c:const static struct of_device_id
csky_pmu_of_device_ids[] =3D {
arch/nds32/kernel/perf_event_cpu.c:const static struct of_device_id
cpu_pmu_of_device_ids[] =3D {
drivers/gpu/drm/amd/display/dc/core/dc.c:const static char
DC_BUILD_ID[] =3D "production-build";
drivers/gpu/drm/msm/dsi/dsi_cfg.c:const static struct
msm_dsi_host_cfg_ops msm_dsi_v2_host_ops =3D {
drivers/gpu/drm/msm/dsi/dsi_cfg.c:const static struct
msm_dsi_host_cfg_ops msm_dsi_6g_host_ops =3D {
drivers/gpu/drm/msm/dsi/dsi_cfg.c:const static struct
msm_dsi_host_cfg_ops msm_dsi_6g_v2_host_ops =3D {
drivers/leds/leds-ti-lmu-common.c:const static int ramp_table[16] =3D
{2048, 262000, 524000, 1049000, 2090000,
drivers/leds/leds-lm3532.c:const static int
als_imp_table[LM3532_NUM_IMP_VALS] =3D {37000, 18500, 12330,
drivers/leds/leds-lm3532.c:const static int
als_avrg_table[LM3532_NUM_AVG_VALS] =3D {17920, 35840, 71680,
drivers/leds/leds-lm3532.c:const static int
ramp_table[LM3532_NUM_RAMP_VALS] =3D { 8, 1024, 2048, 4096, 8192,
drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:const static u8
he_if_types_ext_capa_sta[] =3D {
drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:const static struct
wiphy_iftype_ext_capab he_iftypes_ext_capa[] =3D {
drivers/net/ethernet/qlogic/qed/qed_iwarp.c:const static char
*iwarp_state_names[] =3D {
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:const static char
*g_dsaf_mode_match[DSAF_MODE_MAX] =3D {
drivers/pci/pci-bridge-emul.c:const static struct
pci_bridge_reg_behavior pci_regs_behavior[] =3D {
drivers/pci/pci-bridge-emul.c:const static struct
pci_bridge_reg_behavior pcie_cap_regs_behavior[] =3D {
fs/ceph/export.c: const static int snap_handle_length =3D
fs/ceph/export.c: const static int handle_length =3D
fs/ceph/export.c: const static int connected_handle_length =3D
fs/unicode/utf8-selftest.c:const static struct {
fs/unicode/utf8-selftest.c:const static struct {

On Tue, Sep 3, 2019 at 7:36 PM Krzysztof Wilczynski <kw@linux.com> wrote:
>
> Move the static keyword to the front of declaration of
> csky_pmu_of_device_ids, and resolve the following compiler
> warning that can be seen when building with warnings
> enabled (W=3D1):
>
> arch/csky/kernel/perf_event.c:1340:1: warning:
>   =E2=80=98static=E2=80=99 is not at beginning of declaration [-Wold-styl=
e-declaration]
>
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
> Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com
>
>  arch/csky/kernel/perf_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.=
c
> index 4c1a1934d76a..bc33e4ed189d 100644
> --- a/arch/csky/kernel/perf_event.c
> +++ b/arch/csky/kernel/perf_event.c
> @@ -1337,7 +1337,7 @@ int csky_pmu_device_probe(struct platform_device *p=
dev,
>         return ret;
>  }
>
> -const static struct of_device_id csky_pmu_of_device_ids[] =3D {
> +static const struct of_device_id csky_pmu_of_device_ids[] =3D {
>         {.compatible =3D "csky,csky-pmu"},
>         {},
>  };
> --
> 2.22.1
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
