Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71419ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473562064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571146618;
	bh=Lh3gUOxuzxYIzfbryzFH5J8YBK8MTzOYjOrLSH1iECQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gmZjTJ/izSHEFAw0Luu4lmO9POa0cTQE6020yEsplIO6SYzOXhfZ/TxbvVSB7XTry
	 zs1s0lSUCDPk267SGO8kvNMF1bHooUCelDnpMCIaJu0lG5qbisi/u9C6+PL2j6xtXo
	 Wu7rHXRl9k1DXCXiHocpUY//OfYk9il7+yIopTjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbfJONgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:32964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbfJONgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:36:53 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09CD321A49;
        Tue, 15 Oct 2019 13:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571146612;
        bh=Lh3gUOxuzxYIzfbryzFH5J8YBK8MTzOYjOrLSH1iECQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SVdKnnRtv6N+AuRGXmT+CvC20RbJvOKot2xgYuMq/RpeAQtfMWF0SDW5rI8S4oiyj
         783MHOK0MeowEn1QmynwKJS5kH+7ig+RbSPpaQpU/Y1FYLuBNG32oEjt6FFGKkh+vC
         qSMVGlxG7opZINeoK0zcStHvzDntbyrWMN08u5SU=
Received: by mail-qk1-f170.google.com with SMTP id f16so19152385qkl.9;
        Tue, 15 Oct 2019 06:36:52 -0700 (PDT)
X-Gm-Message-State: APjAAAWR7HJRWAg1v3seqP5GRVy7Z0mHyd1NOZ+8YJpAVY4ywnolD3mE
        WcIO9ZeaJqkdLvCN0Kfc+pQv0sACCOJ7CS0s/A==
X-Google-Smtp-Source: APXvYqypirVCKVCRTL7nRtAYwMId0v/R2tSXy313ZY3pYHRXJuh7KZFwlJGt2xV9T7SPrVcWBZmRcO4Mo8Wu7toa2tg=
X-Received: by 2002:a05:620a:12f1:: with SMTP id f17mr4163163qkl.152.1571146611108;
 Tue, 15 Oct 2019 06:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
 <20191011154423.2506-2-srinivas.kandagatla@linaro.org> <20191014171241.GA24989@bogus>
 <76be1a0d-43ea-44c3-ef6c-9f9a2025c7a2@linaro.org> <CAL_Jsq+ZBhh2A3yLtOyReHHAET_bvM-ygBtRXeFihAxf0jvDKQ@mail.gmail.com>
 <f7977140-c103-7d0d-9523-2212e1029598@linaro.org>
In-Reply-To: <f7977140-c103-7d0d-9523-2212e1029598@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Oct 2019 08:36:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJLmPGBxEkmZMTBMpp5xsnHq0SYg8+RQPsjnUfbHrrf5Q@mail.gmail.com>
Message-ID: <CAL_JsqJLmPGBxEkmZMTBMpp5xsnHq0SYg8+RQPsjnUfbHrrf5Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: soundwire: add bindings for Qcom controller
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vinod <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        spapothi@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 7:22 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 15/10/2019 12:35, Rob Herring wrote:
> > On Mon, Oct 14, 2019 at 12:34 PM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> >>
> >> Thanks Rob for taking time to review,
> >>
> >> On 14/10/2019 18:12, Rob Herring wrote:
> >>> On Fri, Oct 11, 2019 at 04:44:22PM +0100, Srinivas Kandagatla wrote:
> >>>> This patch adds bindings for Qualcomm soundwire controller.
> >>>>
> >>>> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
> >>>> either integrated as part of WCD audio codecs via slimbus or
> >>>> as part of SOC I/O.
> >>>>
> >>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >>>> ---
> >>>>    .../bindings/soundwire/qcom,sdw.txt           | 167 ++++++++++++++++++
> >>>>    1 file changed, 167 insertions(+)
> >>>>    create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> >>>
> >>> Next time, do a DT schema.
> >>>
> >> Sure! I can do that in next version!
> >
> > I meant the next binding you write, not v4. However, ...
> >
> > [...]
> >
> >>>> += SoundWire devices
> >>>> +Each subnode of the bus represents SoundWire device attached to it.
> >>>> +The properties of these nodes are defined by the individual bindings.
> >>>
> >>> Is there some sort of addressing that needs to be defined?
> >>>
> >> Thanks, Looks like I missed that here.
> >>
> >> it should be something like this,
> >>
> >> #address-cells = <2>;
> >> #size-cells = <0>;
> >>
> >> Will add the in next version.
> >
> > You need a common soundwire binding for this. You also need to define
> > the format of 'reg' and unit addresses. And it needs to be a schema.
> > So perhaps this binding too should be.
>
> We already have a common SoundWire bindings in mainline for this
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml?h=v5.4-rc3

Indeed... :)

> Should this binding just make a reference to it instead of duplicating
> this same info here?

Yes, that should be sufficient.

Rob
