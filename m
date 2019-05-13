Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5049BC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D532208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXx8pNJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfEMLyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:54:25 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34113 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfEMLyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:54:25 -0400
Received: by mail-vs1-f65.google.com with SMTP id q64so7810334vsd.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyWZcQ9xuv1ePUmeginCRniFMdb4kDi9LqXon/ofAQQ=;
        b=jXx8pNJkE0BbTjzMl7ivd+4vUnwuWMZXoLK6dKwCD5Px7FRMEWcLN5UBHSs+iWUJFq
         NzWQIAGGOq2HyielWqQqbyC9NUXNi1TYrbMQ/wR45z5Jy5zwO0G7VznGT3+nejtB49+M
         0FRchXIaofI7FZ911LZh7NxZNk+Ry4+UPlQk0x5UX4Botj5meRNgCts9JYBJx2TUha4F
         VwbZWM+Q4L1BNKyH2M1N1OabEDxPZYz9eQUXqvINeGa+9LIudp8X7+cpC+tKagpQ66yo
         0wZNfw/YGz+ZaeN6/KeNasPFsGfzCDDv+5cCyZAeyg9d8c6w9ko2ys5YL/kyKJKSir/I
         VJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyWZcQ9xuv1ePUmeginCRniFMdb4kDi9LqXon/ofAQQ=;
        b=OnGWFKEbV0aSacZATkyr7aeF6gzLj/ZzavvezlnlrMjaLI04HuP8NX/RXkADfwZe7T
         xfulSja7uvI4wCosGnzwYftFSetGN6zGvkZVavQm09MZTnHcbCdEG+AvePPHagiu69xt
         /3RbGVwaULG4TQLWfKmWz4kUSelnMY3E3Y1AWO7ScZHfuf9JUQ5oZAHLjvZFYWCvsjX7
         oYLbpFUvvENncBuh23jNHFM594by7EsuyY2Bn0UsocS30h1oyC1FQihLM4qP8PoQuFZu
         XY76Stbq5bttFcB517qWnflC6paY/kcUhiD/RnrmpcjlAcqr+3J3Yj2Y/51kjsZPMENq
         2btA==
X-Gm-Message-State: APjAAAX/SimmfRgVCPRKWzYZ3A0JRLk6e1xy5345M5V4lce6+UVXj+xP
        2c2Nrb0QDt+JLM+eSkVGXVduIxZ7E/TUDiOW12MhhQ==
X-Google-Smtp-Source: APXvYqzugMbTKcBWpzewm/jUTUzXq5+L8CGcnLBtnVt4w0TEMGBFhW70BFIFHoPzTLLVog4IeFDAAaphVr/Cc8c4cSo=
X-Received: by 2002:a67:f34d:: with SMTP id p13mr11993272vsm.95.1557748463269;
 Mon, 13 May 2019 04:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190114184255.258318-1-mka@chromium.org> <CAHLCerP+F9AP97+qVCMqwu-OMJXRhwZrXd33Wk-vj5eyyw-KyA@mail.gmail.com>
In-Reply-To: <CAHLCerP+F9AP97+qVCMqwu-OMJXRhwZrXd33Wk-vj5eyyw-KyA@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 13 May 2019 17:24:12 +0530
Message-ID: <CAHLCerPZ0Y-rkeMa_7BJWtR4g5af2vwfPY9FgOuvpUTJG3rf7g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add CPU topology
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: multipart/mixed; boundary="000000000000cdd7180588c393b1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cdd7180588c393b1
Content-Type: text/plain; charset="UTF-8"

On Mon, May 13, 2019 at 4:31 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Tue, Jan 15, 2019 at 12:13 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > The 8 CPU cores of the SDM845 are organized in two clusters of 4 big
> > ("gold") and 4 little ("silver") cores. Add a cpu-map node to the DT
> > that describes this topology.
>
> This is partly true. There are two groups of gold and silver cores,
> but AFAICT they are in a single cluster, not two separate ones. SDM845
> is one of the early examples of ARM's Dynamiq architecture.
>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>
> I noticed that this patch sneaked through for this merge window but
> perhaps we can whip up a quick fix for -rc2?
>

And please find attached a patch to fix this up. Andy, since this
hasn't landed yet (can we still squash this into the original patch?),
I couldn't add a Fixes tag.

Regards,
Amit

> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 38 ++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index c27cbd3bcb0a6..f6c0d87e663f3 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -192,6 +192,44 @@
> >                                 next-level-cache = <&L3_0>;
> >                         };
> >                 };
> > +
> > +               cpu-map {
> > +                       cluster0 {
> > +                               core0 {
> > +                                       cpu = <&CPU0>;
> > +                               };
> > +
> > +                               core1 {
> > +                                       cpu = <&CPU1>;
> > +                               };
> > +
> > +                               core2 {
> > +                                       cpu = <&CPU2>;
> > +                               };
> > +
> > +                               core3 {
> > +                                       cpu = <&CPU3>;
> > +                               };
> > +                       };
> > +
> > +                       cluster1 {
>
> This shouldn't exist.
>
> > +                               core0 {
>
> Rename to core4, 5, etc...
>
> > +                                       cpu = <&CPU4>;
> > +                               };
> > +
> > +                               core1 {
> > +                                       cpu = <&CPU5>;
> > +                               };
> > +
> > +                               core2 {
> > +                                       cpu = <&CPU6>;
> > +                               };
> > +
> > +                               core3 {
> > +                                       cpu = <&CPU7>;
> > +                               };
> > +                       };
> > +               };
> >         };
> >
> >         pmu {
> > --
> > 2.20.1.97.g81188d93c3-goog
> >

--000000000000cdd7180588c393b1
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-arm64-dts-sdm845-Fix-up-CPU-topology.patch"
Content-Disposition: attachment; 
	filename="0001-arm64-dts-sdm845-Fix-up-CPU-topology.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jvmb7ded0>
X-Attachment-Id: f_jvmb7ded0

RnJvbSA5ZTdkNjBiY2FiYWQ3NTk0YTFkYTQzOTgyYmJjOWZkYTA0NjY5NzE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8OWU3ZDYwYmNhYmFkNzU5NGExZGE0Mzk4MmJiYzlm
ZGEwNDY2OTcxNy4xNTU3NzQ4NDM3LmdpdC5hbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc+CkZyb206
IEFtaXQgS3VjaGVyaWEgPGFtaXQua3VjaGVyaWFAbGluYXJvLm9yZz4KRGF0ZTogTW9uLCAxMyBN
YXkgMjAxOSAxNzowODozMyArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIGFybTY0OiBkdHM6IHNkbTg0
NTogRml4IHVwIENQVSB0b3BvbG9neQoKU0RNODQ1IGltcGxlbWVudHMgQVJNJ3MgRHluYW1pcSBh
cmNoaXRlY3R1cmUgdGhhdCBhbGxvd3MgdGhlIGJpZyBhbmQKTElUVExFIGNvcmVzIHRvIGV4aXN0
IGluIGEgc2luZ2xlIGNsdXN0ZXIgc2hhcmluZyB0aGUgTDMgY2FjaGUuCgpGaXggdGhlIGNwdS1t
YXAgdG8gcHV0IGFsbCBjcHVzIGludG8gYSBzaW5nbGUgY2x1c3Rlci4KClNpZ25lZC1vZmYtYnk6
IEFtaXQgS3VjaGVyaWEgPGFtaXQua3VjaGVyaWFAbGluYXJvLm9yZz4KLS0tCiBhcmNoL2FybTY0
L2Jvb3QvZHRzL3Fjb20vc2RtODQ1LmR0c2kgfCAxMCArKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvcWNvbS9zZG04NDUuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9z
ZG04NDUuZHRzaQppbmRleCBlZjdjZTYzZWVmNGUuLmEzMGZhNTRiZmNjZCAxMDA2NDQKLS0tIGEv
YXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NkbTg0NS5kdHNpCisrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvcWNvbS9zZG04NDUuZHRzaQpAQCAtMjQ2LDIyICsyNDYsMjAgQEAKIAkJCQljb3JlMyB7
CiAJCQkJCWNwdSA9IDwmQ1BVMz47CiAJCQkJfTsKLQkJCX07CiAKLQkJCWNsdXN0ZXIxIHsKLQkJ
CQljb3JlMCB7CisJCQkJY29yZTQgewogCQkJCQljcHUgPSA8JkNQVTQ+OwogCQkJCX07CiAKLQkJ
CQljb3JlMSB7CisJCQkJY29yZTUgewogCQkJCQljcHUgPSA8JkNQVTU+OwogCQkJCX07CiAKLQkJ
CQljb3JlMiB7CisJCQkJY29yZTYgewogCQkJCQljcHUgPSA8JkNQVTY+OwogCQkJCX07CiAKLQkJ
CQljb3JlMyB7CisJCQkJY29yZTcgewogCQkJCQljcHUgPSA8JkNQVTc+OwogCQkJCX07CiAJCQl9
OwotLSAKMi4xNy4xCgo=
--000000000000cdd7180588c393b1--
