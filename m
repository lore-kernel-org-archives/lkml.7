Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33462C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D2E2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="es4b+tIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCTQDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:03:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39510 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfCTQDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:03:20 -0400
Received: by mail-io1-f67.google.com with SMTP id e13so2479438ioq.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m948A/tQDG6Rq74ltBoveAhCRKmpnRllx2/nmUeif6I=;
        b=es4b+tIAtq50NYSAXh8jdJotUt3dntziZUM08tsm843xddm6XeRg2blxPkcUZH+8dI
         IKVozK/QTBfDowYTHZQLsab9G+gn3kY9M5pI8NFSjiXQZdF7G5G2/0nJI2s8OSkRFD7b
         Clrrt2PGRfrtXmqKqq4X+xckbfoQpPUa6b3GfjHGIFW2KhI5A8Jyw6yV8bCH7bfV6COO
         5DDo6H+nfwrb6U0AgS1ihRdflRKAF+/aTNR6X0xiFVc+7VQkbcn5JxBGfMQoNDfQT2gq
         s90wYfwaMzrKF0SUa+jsMHr/MVnLxEXseel7MXZ7myTjmhwntReci+j6pexnSP8lNDOZ
         Ye0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m948A/tQDG6Rq74ltBoveAhCRKmpnRllx2/nmUeif6I=;
        b=K6RRJxWw878vLebYe1ry2QSll0oUICJEGdxjIh44LaWFBMcvQVL4R5kOQ8gpxgr3YT
         Cy/kRr1vMIFgq/PrGqdhRWtXsR9uCqbrbHVicZ2xjbHlrZsiv6iDItOc48ocs9M4c34c
         lEOw4EHfgOfqh4jK4apiwUrqNDh9XMfa2ivg4Q/mp+cf6OL7AJwpMNZvK1fZk0/Rr+iq
         F1uFseR3k8oG3ka3KariT324vKzJTGW65rEr7VJNmPmtRUY7EZqnaMu2+1zI7mcZuI91
         RWNJSrb2PfpWKJWGnvhLdhTqgw6PRBtYe01YqFVYAYSjcV/kXUNrPH3EreHJiriHiLNJ
         aGBw==
X-Gm-Message-State: APjAAAU6JSJdq3PfnvFRPD7ny5dxWexYEGEhhqmhup5C1JoujGtr0wbr
        5PS7ctBf9Kyysq2jycxdph1DnPepMd/hnGyq9Ax/fQ==
X-Google-Smtp-Source: APXvYqwuqgF3QvYDDYRrPjir/x2nIK96IWPJ19wJJK7S5FAm9cxhfiWu784hlzjyBOY5mdSvBESaiQR00cdVSKqXcnU=
X-Received: by 2002:a6b:c3cc:: with SMTP id t195mr6266691iof.11.1553097799450;
 Wed, 20 Mar 2019 09:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <PF2cGMeKmyLsYmtoatcC6SV8XK45pcXs-AI2V6BllH1iILYBAVjIz-u2VWanTWH4pT0Qe4pdKY1h8q02Fy4yE0GhAoV3T_jnIYu4oDfsaDo=@protonmail.ch>
In-Reply-To: <PF2cGMeKmyLsYmtoatcC6SV8XK45pcXs-AI2V6BllH1iILYBAVjIz-u2VWanTWH4pT0Qe4pdKY1h8q02Fy4yE0GhAoV3T_jnIYu4oDfsaDo=@protonmail.ch>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 20 Mar 2019 10:03:08 -0600
Message-ID: <CANLsYkxHhi5uQfeb0zdM2o=v7DF9WtR895Cjpq+O=3dBnYPx7A@mail.gmail.com>
Subject: Re: [PATCH v3] perf tools: Add missing case value
To:     Solomon Tan <solomonbstoner@protonmail.ch>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "robert.walker@arm.com" <robert.walker@arm.com>,
        "acme@redhat.com" <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 at 21:20, Solomon Tan <solomonbstoner@protonmail.ch> wr=
ote:
>
> The following error was thrown when compiling `tools/perf` using OpenCSD
> v0.11.1. This patch fixes said error.
>
> ```
>   CC       util/intel-pt-decoder/intel-pt-log.o
>   CC       util/cs-etm-decoder/cs-etm-decoder.o
> util/cs-etm-decoder/cs-etm-decoder.c: In function
> =E2=80=98cs_etm_decoder__buffer_range=E2=80=99:
> util/cs-etm-decoder/cs-etm-decoder.c:370:2: error: enumeration value =E2=
=80=98OCSD_INSTR_WFI_WFE=E2=80=99 not handled in switch [-Werror=3Dswitch-e=
num]
>   switch (elem->last_i_type) {
>   ^~~~~~
>   CC       util/intel-pt-decoder/intel-pt-decoder.o
> cc1: all warnings being treated as errors
> ```
>
> Because `OCSD_INSTR_WFI_WFE` case was only added after v0.11.0, the minim=
um
> required OpenCSD library version for this patch is no longer v0.10.0.
>
> Signed-off-by: Solomon Tan <solomonbstoner@protonmail.ch>
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
>
>  int main(void)
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf=
/util/cs-etm-decoder/cs-etm-decoder.c
> index 8c155575c6c5..2a8bf6b45a30 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -374,6 +374,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *d=
ecoder,
>                 break;
>         case OCSD_INSTR_ISB:
>         case OCSD_INSTR_DSB_DMB:
> +       case OCSD_INSTR_WFI_WFE:
>         case OCSD_INSTR_OTHER:
>         default:
>                 packet->last_instr_taken_branch =3D false;
> --
>

Your patch is now technically sound.  Please run it through checkpatch
and rebase your work against the coresight next tree [1].

[1]. https://git.linaro.org/kernel/coresight.git/log/?h=3Dnext



> 2.19.1
