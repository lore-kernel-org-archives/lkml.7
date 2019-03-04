Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80027C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B55B206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551721930;
	bh=XN98+D5gbw1pc30bDaFbg45JEEaPqeNXKhfBuMF63Zg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ANFknR6AlbxmYF1jgmLbg/F4KJ0aXsEjC32mdYu28g2PbGrYrRuWKDAV1sZa18ji+
	 XyRXM417HGHYb/hQhDusDi207PSAY8SOk68Ewl3vr5CfLVmXIXUtXNodCVg4Gs26GQ
	 9JfNbIEKV3sL5hiWUm4DriZgw4FCItEge2nsZKDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfCDRwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfCDRwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:52:08 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2198B2146E;
        Mon,  4 Mar 2019 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551721927;
        bh=XN98+D5gbw1pc30bDaFbg45JEEaPqeNXKhfBuMF63Zg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SmTfKeT2l2FNJbzv18gg4wy7J0RpsC9WES4Z3gLF2p86cx4GhRfiT5L+YYIdiTdiM
         CmxSMgAQSgrgT6y0Zkuuh6cUiLmUOa7qWNiXbu01aTb1palNJvnsMOlSk+pZGtwU3A
         USXlHvrMfmk5WJFunEfVCQNLfp1J8CjQXo18uYHQ=
Received: by mail-qt1-f178.google.com with SMTP id y4so6055566qtc.10;
        Mon, 04 Mar 2019 09:52:07 -0800 (PST)
X-Gm-Message-State: APjAAAUevnpOLbo8jfXjZDPBmY2jfv4xHs+zmMsdW1vOlL5nJmSqqQVo
        cUHE2z7pRLid9kHOUMMUzWWMqLosMfu7IqjY+g==
X-Google-Smtp-Source: APXvYqzkpBfsfpjMj6yuvUtfeTDH9r0unzVPvf8mimwSTIYtBGwaXXtx6UGIICLfiHuD1BnGGoS7qddEhTP8hgrMERI=
X-Received: by 2002:ac8:25d1:: with SMTP id f17mr14929040qtf.38.1551721926271;
 Mon, 04 Mar 2019 09:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20190221084729.101784-1-pihsun@chromium.org> <20190221084729.101784-2-pihsun@chromium.org>
 <20190222144316.GA19284@bogus> <CANdKZ0d+2CqbVEwruW+pbqUeRMBwzXV7tFC7Cp7i+98CWiB_4w@mail.gmail.com>
In-Reply-To: <CANdKZ0d+2CqbVEwruW+pbqUeRMBwzXV7tFC7Cp7i+98CWiB_4w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 4 Mar 2019 11:51:55 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rqeJX9LHOvVi7rPUzCeWhM2QjicJXyJyn23-gBo=Qcg@mail.gmail.com>
Message-ID: <CAL_Jsq+rqeJX9LHOvVi7rPUzCeWhM2QjicJXyJyn23-gBo=Qcg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: Add a binding for Mediatek SCP
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Erin Lo <erin.lo@mediatek.com>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 12:15 AM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>
> On Fri, Feb 22, 2019 at 10:43 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Feb 21, 2019 at 04:47:24PM +0800, Pi-Hsun Shih wrote:
> > > From: Erin Lo <erin.lo@mediatek.com>
> > >
> > > Add a DT binding documentation of SCP for the
> > > MT8183 SoC from Mediatek.
> > >
> > > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > > ---
> > > Changes from v4:
> > >  - Add detail of more properties.
> > >  - Document the usage of mtk,rpmsg-name in subnode from the new design.
> > >
> > > Changes from v3:
> > >  - No change.
> > >
> > > Changes from v2:
> > >  - No change. I realized that for this patch series, there's no need to
> > >    add anything under the mt8183-scp node (neither the mt8183-rpmsg or
> > >    the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
> > >    directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
> > >    created by SCP name service.
> > >
> > > Changes from v1:
> > >  - No change.
> > > ---
> > >  .../bindings/remoteproc/mtk,scp.txt           | 37 +++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > > new file mode 100644
> > > index 00000000000000..8cf8b0e0d98a4c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > > @@ -0,0 +1,37 @@
> > > +Mediatek SCP Bindings
> > > +----------------------------------------
> > > +
> > > +This binding provides support for ARM Cortex M4 Co-processor found on some
> > > +Mediatek SoCs.
> > > +
> > > +Required properties:
> > > +- compatible         Should be "mediatek,mt8183-scp"
> > > +- reg                        Should contain the address ranges for the two memory
> > > +                     regions, SRAM and CFG.
> > > +- reg-names          Contains the corresponding names for the two memory
> > > +                     regions. These should be named "sram" & "cfg".
> > > +- clocks             Clock for co-processor (See: ../clock/clock-bindings.txt)
> > > +- clock-names                Contains the corresponding name for the clock. This
> > > +                     should be named "main".
> > > +
> > > +Subnodes
> > > +--------
> > > +
> > > +When CONFIG_RPMSG_MTK_SCP is enabled, subnodes of the SCP represent rpmsg
> >
> > Bindings can't depend on kernel config options.
> >
>
> What's the recommendation here if the subnode only has effect when the
> config is enabled? Should I just skip the sentence "When ... is
> enabled"?

Sure.

>
> > > +devices. The names of the devices are not important. The properties of these
> > > +nodes are defined by the individual bindings for the rpmsg devices - but must
> > > +contain the following property:
> > > +
> > > +- mtk,rpmsg-name     Contains the name for the rpmsg device. Used to match
> > > +                     the subnode to rpmsg device announced by SCP.
> >
> > I don't think this belongs in DT, but without some examples I'm not
> > really sure.
> >
>
> This is similar to the qcom,smd-channels property in
> Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt, a example DT
> for this:

QCom has lots of strange buses and communication channels. Probably
not the best place for inspiration.

> scp {
>         compatible = "mediatek,mt8183-scp";
>         ...
>         cros_ec {
>                 compatible = "google,cros-ec-rpmsg";
>                 mtk,rpmsg-name = "cros-ec-rpmsg";

Why do we need the same string twice? It's just the compatible string
minus the vendor prefix.

>
>                 cros_ec_codec {
>                         compatible = "google,cros-ec-codec";
>                         ...

What's this? I can't review bindings piece by piece.

>                 };
>         };
> };
>
> > > +
> > > +Example:
> > > +
> > > +     scp: scp@10500000 {
> > > +             compatible = "mediatek,mt8183-scp";
> > > +             reg = <0 0x10500000 0 0x80000>,
> > > +                   <0 0x105c0000 0 0x5000>;
> > > +             reg-names = "sram", "cfg";
> > > +             clocks = <&infracfg CLK_INFRA_SCPSYS>;
> > > +             clock-names = "main";
> > > +     };
> > > --
> > > 2.21.0.rc0.258.g878e2cd30e-goog
> > >
