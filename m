Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163C3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3251206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYm3jIgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfFDXNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:13:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37527 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDXNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:13:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh12so2860292plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 16:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5A1oQW2zEmTGlil5PX6ZgxMyrNMDmkKoK9pr4QFXIFg=;
        b=iYm3jIgWYnzVYAyhEA93tszC3hr2XfumPIFAW/dw5CQQM27l88HF5pQG+UBSTfMlOm
         nCuYDdvTpwLQ7acBWNEFy2MN3JRuHVWi1CqtJ5jB1KvvrUjXNCk9KtcgV23NaoCvpVRq
         hArOVrYZsdD3dqBNjNdGxCFIKVwhJ2OvMR4ZA3kWXXFA/13vTZYsOaE7UT06tQvVScyx
         4T9hYsru3W6ICnHc3CuVYv7v24kqUBKXrFMLXA6YVB4n1hUjCRP+2+yLQRfO8sUYvrj0
         QcjFyVuqZBGBQ6GbQMeNoKHMd/kaMlW5T7JishOiTxzTpkLL7jvXomPGbRuWlc74/L5U
         Sarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5A1oQW2zEmTGlil5PX6ZgxMyrNMDmkKoK9pr4QFXIFg=;
        b=HsjBKE5QGQj5NrOEKOb78sr3DqFG+Rr7ZmeEcXCmY3GdIx+uJ27i+J8O8878qyaoaR
         WPMY/mBe2Aqea7vQqfUO5lBf5evm3fDWwXBnOIcEttTlfi6Ikp1/2pcZ8w3R/3e/TUjW
         usCRIqedHF3PhFpAFiDT2fWITcqYURAfGyc7EiiaQc1jk0tpEr5w52O1+Zf+j0GK4xQO
         83JA3SIi+M9xgdqDK4ZfDBuL4+fkxJhiUrrWFyndeyh1vu6xqIEdkBIiMcymz/+4fjba
         5I6TTTKscNytTiVWP1HvGY/qw3bQTc/yJmnwhqLwEaqZF3ZgWV+evy6Cou3sEmdirkFS
         Z8VA==
X-Gm-Message-State: APjAAAWEw9361n+QJc7l7SxGsZueNgnCzBwkEb3xtkNjU4WfvPTjDe2f
        qLzgPX32Fpzzf7ceiaKNVSOSVilCKC498r/5ZXzwclYQ
X-Google-Smtp-Source: APXvYqyLRxAg47zb9tpmqBHEiBXvilkJfBzmKJNLF7nL1K21T8UPq5JiU6h4Zn/rmhfOvnttd5Fo5gz+Dh+0HowTbXc=
X-Received: by 2002:a17:902:aa0a:: with SMTP id be10mr32310325plb.27.1559689985095;
 Tue, 04 Jun 2019 16:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAES_P+8ASijfmugGEL5am540nQTRATdYFmYgtYdkJnmLSVdt_w@mail.gmail.com>
In-Reply-To: <CAES_P+8ASijfmugGEL5am540nQTRATdYFmYgtYdkJnmLSVdt_w@mail.gmail.com>
From:   noman pouigt <variksla@gmail.com>
Date:   Tue, 4 Jun 2019 16:12:53 -0700
Message-ID: <CAES_P+9v6MPK2AhzQobHV5CPysk_Tnf=M3yo71BYXPdVC5Fk6w@mail.gmail.com>
Subject: Re: deadline scheduler BUG_ON trigger
To:     linux-kernel@vger.kernel.org, juri.lelli@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Juri

Patch(sched/deadline: don't replenish from a !SCHED_DEADLINE entity)
introduced  fixed the case when the task is deboosted and it is normal
priority task so as to avoid getting replenished from it.However,
what is the intention of BUG_ON? How does it help in fixing the
problem when indeed it is normal priority task and this BUG ON
is getting triggered. We should just return, no?

On Mon, Jun 3, 2019 at 1:30 PM noman pouigt <variksla@gmail.com> wrote:
>
> Folks,
>
> I am using sched deadline in the case of audio recording over SPI to
> maintain the consistency in reading the data.
>
> However, getting this BUG_ON triggered rarely. Is it because the calculated
> runtime is less than actual runtime? I only have one SCHED_DEADLINE task
> in the entire system.
>
> .sched_runtime = 5 * 1000 * 1000
>
> <6>[  354.001991] ------------[ cut here ]------------
> <2>[  354.002006] kernel BUG at
> /mnt/build/workspace/fireos_main_nougat_neptune-build/VARIANT/userdebug/label/PRODUCT_BUILD_DUAL_EXEC/kernel/qcom/msm-4.4/kernel/sched/deadline.c:1035!
> <6>[  354.002071] ------------[ cut here ]------------
> <2>[  354.003880] kernel BUG at
> /mnt/build/workspace/fireos_main_nougat_neptune-build/VARIANT/userdebug/label/PRODUCT_BUILD_DUAL_EXEC/kernel/qcom/msm-4.4/kernel/sched/deadline.c:1035!
> <0>[  354.004491] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> <6>[  354.006429] Modules linked in: wlan_mt76x8_sdio(OE)
> btmtksdio(OE) wlan_mt76x8_sdio_prealloc(POE)
> <6>[  354.008166] CPU: 2 PID: 298 Comm: spi1 Tainted: P           OE
> 4.4.21+ #1
> <6>[  354.008211] Hardware name: Amazon Vesta Neptune proto-3 (DT)
> <6>[  354.009057] task: ffffffd936d9a580 ti: ffffffd936da8000 task.ti:
> ffffffd936da8000
> <6>[  354.009805] PC is at enqueue_task_dl+0x2fc/0x33c
> <6>[  354.010713] LR is at enqueue_task_dl+0x2c/0x33c
> <6>[  354.011297] pc : [<ffffff83c8cddf3c>] lr : [<ffffff83c8cddc6c>]
> pstate: 800001c5
> <6>[  354.011837] sp : ffffffd936dab9a0
> <6>[  354.012781] x29: ffffffd936dab9a0 x28: ffffffd9364a3c48
> <6>[  354.013814] x27: ffffffd936d9ab90 x26: 0000000000000000
> <6>[  354.014477] x25: ffffffd93e0ea100 x24: 0000000000000001
> <6>[  354.015138] x23: ffffffd93e0c0100 x22: ffffffd886e77090
> <6>[  354.015801] x21: 0000000000000001 x20: ffffffd886e77080
> <6>[  354.016462] x19: ffffffd886e77368 x18: 0000000000000044
> <6>[  354.017125] x17: 0000007c4cbe7f50 x16: ffffff83c8d1b20c
> <6>[  354.017786] x15: 0000000000000000 x14: 0000007c49f6e940
> <6>[  354.018448] x13: 000000000019fe5a x12: 0000000001312d00
> <6>[  354.019109] x11: 000000526c14c33c x10: ffffffd93e0eab40
> <6>[  354.019772] x9 : ffffffd93e0eab50 x8 : 0000000000000000
> <6>[  354.020434] x7 : 0000005573c60000 x6 : 0000000000000004
> <6>[  354.021095] x5 : 0000005573c36000 x4 : 000000052a5b36ce
> <6>[  354.021758] x3 : ffffff83c8cddc40 x2 : 0000000000000000
> <6>[  354.022418] x1 : ffffffd886e77080 x0 : 0000000000000078
> <6>[  354.023082]
> <6>[  354.023082] PC: 0xffffff83c8cddefc:
> <6>[  354.023114] defc  aa1503e0 97fffe20 f9445ae0 eb14001f 540002c0
> b943a680 7100041f 5400026d
> <6>[  354.024731] df1c  aa1703e0 aa1403e1 97fffeb4 1400000f 910ba001
> 17ffff59 7100405f 54000040
> <6>[  354.025751] df3c  d4210000 b9433e80 35000100 17fffffd d4210000
> 17ffff72 d4210000 17ffffb6
> <6>[  354.026770] df5c  f9419401 17ffffe0 a94153f3 a9425bf5 a94363f7
> f94023f9 a8c67bfd d65f03c0
> <6>[  354.027791]
> <6>[  354.027791] LR: 0xffffff83c8cddc2c:
> <6>[  354.027814] dc2c  17ffffed a94153f3 a9425bf5 a8c37bfd d65f03c0
> a9ba7bfd 910003fd a90363f7
> <6>[  354.029428] dc4c  aa0003f7 aa0103e0 a90153f3 f9002fa2 aa0103f4
> a9025bf5 f90023f9 940045e0
> <6>[  354.030449] dc6c  910ba293 f9402fa2 b40000a0 b9433e81 34000061
> b9405001 37f81541 b9405280
> <6>[  354.031469] dc8c  36f81540 aa1303e1 b9433680 34000040 36201642
> f9417699 eb19027f 54000040
> <6>[  354.032489]
> <6>[  354.032489] SP: 0xffffffd936dab960:
> <6>[  354.032512] b960  c8cddc6c ffffff83 36dab9a0 ffffffd9 c8cddf3c
> ffffff83 800001c5 00000000
> <6>[  354.034126] b980  3e0c0100 ffffffd9 39411400 ffffffd9 ffffffff
> ffffffff c8cce2fc ffffff83
> <6>[  354.035147] b9a0  36daba00 ffffffd9 c8cc6738 ffffff83 86e77080
> ffffffd8 3e0c0100 ffffffd9
> <6>[  354.036168] b9c0  00000001 00000000 86e77090 ffffffd8 3e0c0100
> ffffffd9 00000001 00000000
> <6>[  354.037186]
> <0>[  354.037203] Process spi1 (pid: 298, stack limit = 0xffffffd936da8020)
> <6>[  354.037409] Call trace:
> <6>[  354.038194] Exception stack(0xffffffd936dab7d0 to 0xffffffd936dab900)
> <6>[  354.038485] b7c0:
> ffffffd886e77368 0000008000000000
> <6>[  354.039314] b7e0: ffffffd936dab9a0 ffffff83c8cddf3c
> ffffffd93844c808 0000000000000002
> <6>[  354.040290] b800: ffffffd9385bf200 ffffffd93844d800
> 0000000000000001 0000000000000000
> <6>[  354.041266] b820: 0000000000000001 ffffff83ca48a100
> ffffffd93844c808 0000000000000002
> <6>[  354.042242] b840: ffffff83cac06a04 0000000000000000
> ffffffd936da8000 ffffffd9335a6400
> <6>[  354.043219] b860: ffffffd936dab8a0 ffffff83c969ca30
> 0000000000000078 ffffffd886e77080
> <6>[  354.044195] b880: 0000000000000000 ffffff83c8cddc40
> 000000052a5b36ce 0000005573c36000
> <6>[  354.045173] b8a0: 0000000000000004 0000005573c60000
> 0000000000000000 ffffffd93e0eab50
> <6>[  354.046149] b8c0: ffffffd93e0eab40 000000526c14c33c
> 0000000001312d00 000000000019fe5a
> <6>[  354.047126] b8e0: 0000007c49f6e940 0000000000000000
> ffffff83c8d1b20c 0000007c4cbe7f50
> <6>[  354.048103] [<ffffff83c8cddf3c>] enqueue_task_dl+0x2fc/0x33c
> <6>[  354.049078] [<ffffff83c8cc6738>] activate_task+0x74/0x124
> <6>[  354.049790] [<ffffff83c8cdeabc>] push_dl_task.part.35+0x160/0x1c0
> <6>[  354.050453] [<ffffff83c8cdee30>] push_dl_tasks+0x20/0x30
> <6>[  354.051212] [<ffffff83c8cc4160>] __balance_callback+0x3c/0x5c
> <6>[  354.051888] [<ffffff83c99cc6d8>] __schedule+0x4c4/0x770
> <6>[  354.052587] [<ffffff83c99cca08>] schedule+0x84/0xa4
> <6>[  354.053217] [<ffffff83c99ce91c>] __rt_mutex_slowlock+0x80/0xd8
> <6>[  354.053826] [<ffffff83c99cea40>] rt_mutex_slowlock+0xcc/0x170
> <6>[  354.054565] [<ffffff83c99ceb2c>] rt_mutex_lock+0x48/0x50
> <6>[  354.055292] [<ffffff83c90d7664>] update_bw_adhoc+0x30/0x1d8
> <6>[  354.055964] [<ffffff83c90d3294>] msm_bus_scale_update_bw+0x20/0x4c
> <6>[  354.056628] [<ffffff83c9254c14>] msm_spi_clk_path_vote+0x2c/0x34
> <6>[  354.057408] [<ffffff83c9254b44>] msm_spi_set_cs+0x5c/0xe4
> <6>[  354.058177] [<ffffff83c924f03c>] spi_set_cs+0x50/0x5c
> <6>[  354.058837] [<ffffff83c924fb4c>] spi_transfer_one_message+0x358/0x410
> <6>[  354.059470] [<ffffff83c9250438>] __spi_pump_messages+0x5f8/0x624
> <6>[  354.060271] [<ffffff83c9250478>] spi_pump_messages+0x14/0x1c
> <6>[  354.061032] [<ffffff83c8cb9078>] kthread_worker_fn+0xb4/0x130
> <6>[  354.061736] [<ffffff83c8cb8fbc>] kthread+0xdc/0xe4
> <6>[  354.062440] [<ffffff83c8c845f0>] ret_from_fork+0x10/0x20
> <0>[  354.063028] Code: 910ba001 17ffff59 7100405f 54000040 (d4210000)
> <4>[  354.063711] ---[ end trace c62a47584ac7d903 ]---
>
> Thanks,
> variksla
