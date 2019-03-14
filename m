Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4B1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4771121855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzqJD/j6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfCNQ7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:59:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44003 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfCNQ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:59:14 -0400
Received: by mail-io1-f65.google.com with SMTP id y6so5719498ioq.10;
        Thu, 14 Mar 2019 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1ZJF5pxHLlvonD5kwj4CQXdlk9wvpLi5Mia1fTZw9E=;
        b=rzqJD/j6zV8hQYLdmgizw1uO/WHf3X1ylOoY+PLlyDOP5r/+hAbit1ZV7bVQhMt7CN
         TmOM/K+KFwOqHpBLsPghfV+1T+bA80HtzyFX23I9OTvdn9W0vU7K1kVWFhAMDf3b/qya
         Y7wPsxexSchJu1dFj9xWi6+jnp0UdeyOnb4XtNnOYBlhqTsF9sbuompH0Gh/Gw6iSpN/
         3BVvOZ/kVGAflyXBrGYPT/3I1q925dzZVJDiw/G9Lq07+vLJAj8cD7xODzcUAPzxG5Yi
         Pc9nV9+3yDAke0LPSXdQ+pb2avCMSaxZ9fhcVBrffRDCbBcKXhm2gfRFjvkcxwVmX8fU
         nyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1ZJF5pxHLlvonD5kwj4CQXdlk9wvpLi5Mia1fTZw9E=;
        b=hM6hZpXhDaXZu5yO5cCJ8JjPEkCxVmXtbkkNDz7NaDBiwl4ji4lQBnq87KIDus9EiK
         klsSMalY1A964oLZ4NKtl59uoP6F8nd93vl1fuBKOoPNHFX+kS76L//VYSy7kAhqmSk5
         yxiJHn/QJ+RvG7b0hwMlsmM8FskB7WGsLnSQ8fSBwWW4NOhQ7n1+ayBPEzd8U5OgJAHo
         LmueLH75XbOpP9Iu7rYZULcSC2OyFBWYFd4spzr01eO2FEP8LhwKDBvEjQ5QXIgH0Lpz
         XM6YaChbHNM3KBEQFInlP4saS9CUdvwzi2AonfCLVqrETMx1CZ7YwFCk1V8nzooGj0lS
         1YLA==
X-Gm-Message-State: APjAAAVbPtO/PfWSYSqVSgQfSw5fWuCZwlNfc7yUDDbBsrJWm7HlO8JZ
        bc8gihVlF6z+h53dq5EJQzTwAOpcIDfJmI57ax8=
X-Google-Smtp-Source: APXvYqxbrbMnYkQK1hQaarIGqPkjNArWfgQTSiaNwzMOza+mzEAWPg1XgoHd1NFH8Du7CP7i57BYzNohOZf/JtIH6B0=
X-Received: by 2002:a6b:700d:: with SMTP id l13mr8198998ioc.248.1552582753038;
 Thu, 14 Mar 2019 09:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <1552414422-9568-1-git-send-email-jcrouse@codeaurora.org>
 <1552414422-9568-5-git-send-email-jcrouse@codeaurora.org> <CAF6AEGt74Hs+VMgMOMAyFw9FGk5mrY2NU07JUh=OKSOhj-h6CA@mail.gmail.com>
 <20190314052020.GC6435@tuxbook-pro>
In-Reply-To: <20190314052020.GC6435@tuxbook-pro>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 14 Mar 2019 12:59:01 -0400
Message-ID: <CAF6AEGvhYQfnP2yJ89xCX56uOzvTi6Ui+5Znxt_C4jAKBoLhUw@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v1 4/4] arm64: dts: sdm845: Add zap shader
 region for GPU
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 1:20 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 13 Mar 08:42 PDT 2019, Rob Clark wrote:
>
> > On Tue, Mar 12, 2019 at 2:14 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > >
> > > Some Adreno GPU targets require a special zap shader to bring the GPU
> > > out of secure mode. Define a region to allocate and store the zap
> > > shader.
> > >
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> > >
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index fed7a29..526456d 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -100,6 +100,11 @@
> > >                         no-map;
> > >                 };
> > >
> > > +               zap_shader_region: memory@8c415000 {
> > > +                       reg = <0 0x8c415000 0 0x2000>;
> > > +                       no-map;
> > > +               };
> > > +
> > >                 mpss_region: memory@8e000000 {
> > >                         reg = <0 0x8e000000 0 0x7800000>;
> > >                         no-map;
> > > @@ -109,6 +114,8 @@
> > >                         reg = <0 0x96500000 0 0x200000>;
> > >                         no-map;
> > >                 };
> > > +
> > > +
> >
> > I guess we don't really need this hunk..
> >
>
> I'll trim that as I pick up the patch.
>
> > other than that, the series lgtm
> >
>
> Will you pick up patch 1-3 and I'll pick patch 4 through Andy's tree?

yeah, sounds good.

BR,
-R

> Regards,
> Bjorn
>
> > BR,
> > -R
> >
> > >         };
> > >
> > >         cpus {
> > > @@ -1514,6 +1521,10 @@
> > >
> > >                         qcom,gmu = <&gmu>;
> > >
> > > +                       zap-shader {
> > > +                               memory-region = <&zap_shader_region>;
> > > +                       };
> > > +
> > >                         gpu_opp_table: opp-table {
> > >                                 compatible = "operating-points-v2";
> > >
> > > --
> > > 2.7.4
> > >
> > > _______________________________________________
> > > Freedreno mailing list
> > > Freedreno@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/freedreno
