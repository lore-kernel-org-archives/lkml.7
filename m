Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684B1C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A2E2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVdCJlvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfKUJNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:13:19 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46317 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUJNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:13:19 -0500
Received: by mail-qt1-f194.google.com with SMTP id r20so2841894qtp.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 01:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NcdjicditjmfyWi+GeSCelrI2pCMNcp5zsDjzvV7ISo=;
        b=kVdCJlvtQj7GEYvaRxCTynENkGAuOqE0fgXhqXjZX3Ok9dJeAYEsszWqOcQNVZgIpl
         N5Hf96j30qCEl3XYc3fO0h/Uzi7lwD/a57z9IH71QLqgfRAvOMcDGUXGPOYBDrXMzdgT
         t/DuA2IXS4mtk+lTC7g7cK7hSSVR8FvoIV4j1IJ0y5UeO++jva9S8C3kNszCT4Ee7KKz
         vK+9dr3H5rrrT8hxO3tHZREMV60csIWaZXrIM4uGPknZpZ8ZmKjtdL90vVOo85Ewr3qJ
         sVg4HR3Bh/1qYoXy1fDXjCDRbb4kn5uYxnhervg7WqLWMNNhJqiA8giNG/7velhOxHrN
         2h1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NcdjicditjmfyWi+GeSCelrI2pCMNcp5zsDjzvV7ISo=;
        b=AdmtU0BO0L+CLUbP37uW+T3M2Y45wxAaNPSDwbhj5swP/TitAUq9GBl51Zeo8ZFrdj
         H7mqMz7vNIKXlzHQGAuEB+xrTydiCyk6CCKM5s6WXYG5kmm7ix6PHRZ5+DwvUFIHS2Me
         Ocx9lvlKVNIdL0n3dkvQWk5YnN2cWJSmYAznNOLlYd2U9SNweinqNbeho7GLMvLzRSbU
         07pKPu6+BTANno6QkvHJTvQJ0875v9m2KH/Q/vwekYDRsABIdJPKZT343PnFXf0PnDFa
         hntltDvy36WXVMVTOnAIJ+twH4V3mPQ38qUaL4jrnMrICChkrEuzIOTjBVehrnSYfhwK
         TYXg==
X-Gm-Message-State: APjAAAWWgNdmPaDPlRAPFhosNg6Nes/q09dE9Ut3Bc6bLwDFrofuy4oT
        ciyOiXcqZ8nxKTlwbLA0Z3KGqph+2SajkxN4EEM=
X-Google-Smtp-Source: APXvYqzIwWcNFEIKnXcu2rncMeN3JIjiyBPOOkvS158/LQiIz5dhvPbbID+0OWweTSJ7l1CvFqytGhBAyPEXOceXt1A=
X-Received: by 2002:ac8:1084:: with SMTP id a4mr7441268qtj.114.1574327597933;
 Thu, 21 Nov 2019 01:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20190904235216.18510-1-kw@linux.com>
In-Reply-To: <20190904235216.18510-1-kw@linux.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Thu, 21 Nov 2019 17:12:41 +0800
Message-ID: <CAEbi=3fpNQC+2qnDuX51gij4ooNbHNNnrQQQPXKzafVbcYoV+A@mail.gmail.com>
Subject: Re: [PATCH] nds32: Move static keyword to the front of declaration
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Wilczynski <kw@linux.com> =E6=96=BC 2019=E5=B9=B49=E6=9C=885=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=887:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Move the static keyword to the front of declaration of
> cpu_pmu_of_device_ids, and resolve the following compiler
> warning that can be seen when building with warnings
> enabled (W=3D1):
>
> arch/nds32/kernel/perf_event_cpu.c:1122:1: warning:
>   =E2=80=98static=E2=80=99 is not at beginning of declaration [-Wold-styl=
e-declaration]
>
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
> Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com
>
>  arch/nds32/kernel/perf_event_cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/nds32/kernel/perf_event_cpu.c b/arch/nds32/kernel/perf_=
event_cpu.c
> index 334c2a6cec23..0ce6f9f307e6 100644
> --- a/arch/nds32/kernel/perf_event_cpu.c
> +++ b/arch/nds32/kernel/perf_event_cpu.c
> @@ -1119,7 +1119,7 @@ static void cpu_pmu_init(struct nds32_pmu *cpu_pmu)
>                 on_each_cpu(cpu_pmu->reset, cpu_pmu, 1);
>  }
>
> -const static struct of_device_id cpu_pmu_of_device_ids[] =3D {
> +static const struct of_device_id cpu_pmu_of_device_ids[] =3D {
>         {.compatible =3D "andestech,nds32v3-pmu",
>          .data =3D device_pmu_init},
>         {},

Thanks, Krzysztof.
Acked-by: Greentime Hu <green.hu@gmail.com>

I will queue it in nds32 next tree.
