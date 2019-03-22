Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74178C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D40021916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kwWY2B0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCVQ33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:29:29 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35697 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCVQ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:29:28 -0400
Received: by mail-it1-f195.google.com with SMTP id w15so4246814itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ns0E0HdBA6ORaIOT+7h84dux84N8pD0sHXrnfDcxJLo=;
        b=kwWY2B0Q2pZY+foVKuz3lV6vMUfMdJRPrPYTEMv9hcUYsreSG2w31UabytSPXwm6R+
         oo70qg9Dx6fbaiuM+PUdq3GvmomGWDq6uAqENMf9q/zZiXDLLfUFYl4FUdFf+E+VgGzS
         cgXucSOYgWipkEDRJdsTaHwh3VthOtv2YwDAXsdJYPvFIVcYBYFpU7arVSUTazmBoQhp
         Cejiy5M99AgVzxHGuMB2vTzi0bFJgv8zD3E33IQRUdYyFZwEU+vppBhmzKwB2sim+eDZ
         Rh33ZOFEYq/Z1ywLxtwhd7yNmjgC1fhQExL87UNbePSACe8w8GE1kq/MD1Ye0UjOR1hM
         nBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ns0E0HdBA6ORaIOT+7h84dux84N8pD0sHXrnfDcxJLo=;
        b=co9EagJ4WTBqQA2AV46ikPX5oPu141j2/5e5f/04651NEyj3J0xUWNdKwufENXG/KP
         olSvdNHhQLeNqz+NZJkv2jQWsp80bLBMPA6zvqf5Xgcv19cea+kVEDXo/00Lg8GNPeuu
         Lups0pvnsRiJ9+LqYceA5yce69UgkCLYE1Y3aQRP5BZRiMahZML/GDqTf7JfhBYXgkKs
         0476TvXdStRM63QCUHJrVS52S8Iys9P0LbND/TplhwPZxR5bOSkfyv+b9ULQcgZ5sTj/
         JFOBmzdVxedKVk7Azb5pMmxNeJTgM/qKC4lrmBr5GiOnVynmh0cTsahAtsXeYKos6wuu
         tX4w==
X-Gm-Message-State: APjAAAVbloV+8V7MCB/u1h20eIZMSoU0g9PG0ImNEINp5WkfcZ5P4mqA
        Nbd3wzNXagxCD+0rz1yNIquAYB6IcwYNc4NRLFi/ng==
X-Google-Smtp-Source: APXvYqxdOvFtXr8ROSG4T2iTw0UujeIoMsJB5qFUtCsj689K9ptuBrxSeKIlXBWDsJ3cEYnpvI+heCJBY7ad9vhWLvc=
X-Received: by 2002:a02:9109:: with SMTP id a9mr7472584jag.36.1553272167966;
 Fri, 22 Mar 2019 09:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190322052255.GA4809@w-OptiPlex-7050>
In-Reply-To: <20190322052255.GA4809@w-OptiPlex-7050>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 22 Mar 2019 10:29:17 -0600
Message-ID: <CANLsYkynFt-3MTKUAyGV07=jDJ2SDfu6pGJpC_3pYcrCyhjtmg@mail.gmail.com>
Subject: Re: [PATCH v5] perf tools: Add missing case value
To:     Solomon Tan <solomonbobstoner@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Walker <robert.walker@arm.com>,
        Solomon Tan <solomonbstoner@protonmail.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 at 23:23, Solomon Tan <solomonbobstoner@gmail.com> wrot=
e:
>
> The following error was thrown when compiling `tools/perf` using OpenCSD
> v0.11.1. This patch fixes said error.
> ```
>   CC       util/intel-pt-decoder/intel-pt-log.o
>   CC       util/cs-etm-decoder/cs-etm-decoder.o
> util/cs-etm-decoder/cs-etm-decoder.c: In function
> =E2=80=98cs_etm_decoder__buffer_range=E2=80=99:
> util/cs-etm-decoder/cs-etm-decoder.c:370:2: error: enumeration value
> =E2=80=98OCSD_INSTR_WFI_WFE=E2=80=99 not handled in switch [-Werror=3Dswi=
tch-enum]
>   switch (elem->last_i_type) {
>   ^~~~~~
>   CC       util/intel-pt-decoder/intel-pt-decoder.o
> cc1: all warnings being treated as errors
> ```
>
> Because `OCSD_INSTR_WFI_WFE` case was added only in v0.11.0, the minimum
> required OpenCSD library version for this patch is no longer v0.10.0.
>
> Signed-off-by: Solomon Tan <solomonbobstoner@gmail.com>
> ---
>  tools/build/feature/test-libopencsd.c           | 4 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/=
test-libopencsd.c
> index d68eb4fb40cc..2b0e02c38870 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -4,9 +4,9 @@
>  /*
>   * Check OpenCSD library version is sufficient to provide required featu=
res
>   */
> -#define OCSD_MIN_VER ((0 << 16) | (10 << 8) | (0))
> +#define OCSD_MIN_VER ((0 << 16) | (11 << 8) | (0))
>  #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> -#error "OpenCSD >=3D 0.10.0 is required"
> +#error "OpenCSD >=3D 0.11.0 is required"
>  #endif
>
>  int main(void)
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf=
/util/cs-etm-decoder/cs-etm-decoder.c
> index ba4c623cd8de..39fe21e1cf93 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -387,6 +387,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *d=
ecoder,
>                 break;
>         case OCSD_INSTR_ISB:
>         case OCSD_INSTR_DSB_DMB:
> +       case OCSD_INSTR_WFI_WFE:
>         case OCSD_INSTR_OTHER:
>         default:
>                 packet->last_instr_taken_branch =3D false;
> --
> 2.19.1

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Arnaldo, please add on your side if satisfied with the code.

Thanks,
Mathieu

>
