Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AF821902
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="qE+PJRVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfCVArX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 20:47:23 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:45501 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfCVArW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 20:47:22 -0400
Date:   Fri, 22 Mar 2019 00:47:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1553215638;
        bh=nNc5BXbALX2X3ahd5QVFtocusnaDYL2UCqPijSNfNrM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=qE+PJRVusBMhItlWSIaP++q9ZDK4Dr8omTQ2CeUnQTAToURDvySwDE4fbipwYStD1
         5wCXyDQRsJWPyOrM/D9MK5DskxIqXGJ+e0jXSPhD66jzzfQ/QiZsU3CJ+S5n9ec0Rl
         caD8LoAy0vhAk8WwntMApBXTOTunZceLY0Shob5Y=
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
From:   Solomon Tan <solomonbstoner@protonmail.ch>
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
Reply-To: Solomon Tan <solomonbstoner@protonmail.ch>
Subject: Re: [PATCH v4] perf tools: Add missing case value
Message-ID: <vZ4GE7nXgr7nfrMHj_pp8qu6onE8B7YfoczBpbm9RA8spzbqAoEmAIT_YJXkGFXgK8tJqLdVBW_1D9D4jQ2Um51V7SWi1ZgIjrMaYxEYzqg=@protonmail.ch>
In-Reply-To: <20190321162702.GA24451@xps15>
References: <iXDQnAbT-yValKlLnwDyoyBCwymrdxjykuMsgI4Cxau_e2ib9QYVroNDbJgZz3kuxTTaPJnyzRWmEY0TpEZDVQBSdElz9K9R0tAz79Qkp2s=@protonmail.ch>
 <20190321162702.GA24451@xps15>
Feedback-ID: idpJ9Qep05LI5f2mQoaoGmmCIit-QceKL6uqbHgV_NOtNjcF0QNi56ai_biFv0uPMue2gAtmoKKy4wfiVgSKGg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday, March 22, 2019 12:27 AM, Mathieu Poirier <mathieu.poirier@linaro=
.org> wrote:

> On Thu, Mar 21, 2019 at 01:29:11AM +0000, Solomon Tan wrote:
>
> > The following error was thrown when compiling `tools/perf` using OpenCS=
D
> > v0.11.1. This patch fixes said error.
> >
> >       CC       util/intel-pt-decoder/intel-pt-log.o
> >       CC       util/cs-etm-decoder/cs-etm-decoder.o
> >     util/cs-etm-decoder/cs-etm-decoder.c: In function
> >     =E2=80=98cs_etm_decoder__buffer_range=E2=80=99:
> >     util/cs-etm-decoder/cs-etm-decoder.c:370:2: error: enumeration valu=
e =E2=80=98OCSD_INSTR_WFI_WFE=E2=80=99 not handled in switch [-Werror=3Dswi=
tch-enum]
> >       switch (elem->last_i_type) {
> >       ^~~~~~
> >       CC       util/intel-pt-decoder/intel-pt-decoder.o
> >     cc1: all warnings being treated as errors
> >
> >
> > Because `OCSD_INSTR_WFI_WFE` case was added only in v0.11.0, the minimu=
m
> > required OpenCSD library version for this patch is no longer v0.10.0.
> >
> > Signed-off-by: Solomon Tan solomonbstoner@protonmail.ch
> >
> > --------------------------------------------------------
> >
> > tools/build/feature/test-libopencsd.c | 4 ++--
> > tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 +
> > 2 files changed, 3 insertions(+), 2 deletions(-)
> > diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/featur=
e/test-libopencsd.c
> > index d68eb4fb40cc..2b0e02c38870 100644
> > --- a/tools/build/feature/test-libopencsd.c
> > +++ b/tools/build/feature/test-libopencsd.c
> > @@ -4,9 +4,9 @@
> > /*
> >
> > -   Check OpenCSD library version is sufficient to provide required fea=
tures
> >     */
> >     -#define OCSD_MIN_VER ((0 << 16) | (10 << 8) | (0))
> >     +#define OCSD_MIN_VER ((0 << 16) | (11 << 8) | (0))
> >     #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> >     -#error "OpenCSD >=3D 0.10.0 is required"
> >     +#error "OpenCSD >=3D 0.11.0 is required"
> >     #endif
> >
> >
> > int main(void)
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/pe=
rf/util/cs-etm-decoder/cs-etm-decoder.c
> > index ba4c623cd8de..39fe21e1cf93 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -387,6 +387,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder =
*decoder,
> > break;
> > case OCSD_INSTR_ISB:
> > case OCSD_INSTR_DSB_DMB:
> >
> > -         case OCSD_INSTR_WFI_WFE:
> >           case OCSD_INSTR_OTHER:
> >           default:
> >                   packet->last_instr_taken_branch =3D false;
> >
> >
> >
> > --
> > 2.19.1
>
> On my side this patch is no different from V3, i.e it doesn't pass checkp=
atch
> and it doesn't apply on my next tree.
>
> Mathieu
>
> >
>
> pub RSA 2048/C88289A6 2018-05-09solomonbstoner@protonmail.ch solomonbston=
er@protonmail.ch
>
> > sub RSA 2048/7C5E8D6D 2018-05-09

I created a new branch from `next` for the patch mentioned above. Should I
have made the patch directly on the `next` branch instead?

I ran the following 2 commands to test the files I edited:
```
perl scripts/checkpatch.pl -f tools/build/feature/test-libopencsd.c
perl scripts/checkpatch.pl -f tools/perf/util/cs-etm-decoder/cs-etm-decoder=
.c
```
The commands reported that the files "has no obvious style problems and is =
ready
for submission." For your kind advice please. Thank you.

Solomon Tan
