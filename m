Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0A6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7F020661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SOaWdXbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfCEDxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:53:14 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46023 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCEDxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:53:13 -0500
Received: by mail-ed1-f65.google.com with SMTP id f19so6009616eds.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 19:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryQtAhmoNkR7ovOQhim3M73IYVBavqaVDnev4iVPIVc=;
        b=SOaWdXbDLMRI+phUUFAeCHj3QalQoRU+7M96nYSOyLLdih//Mw7ja/vuWnQz/GCniW
         4qZNnMOf0/btPKynoAhwuExeOfY+bq3uOu1BjMt4PXwZBG78cxfXCywpb+MNQAP1JtyZ
         LbtDMmowHzrLcepHESyedxfG1uIV7h6cJLaB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryQtAhmoNkR7ovOQhim3M73IYVBavqaVDnev4iVPIVc=;
        b=q/gv687Oj1s9v5BZ10PDjdwdsTQnr3ZewPK1FREZvRvf+H4T6wFtUqWZZDXTnlvrjH
         HgTRVRqy0WyB5FcnG4nzg+UBCMt28xMtqC/9dUDM5OEdVyQOE8rgk4IPo++Hbyke3UnV
         DuqmVmT6dtxMbY5gZzf+qQoFvQS+Lr0cKK3IMIozX12UpqoaEtj/SfFdFIyp8bTh4uko
         MVaHra8zhXfZQxgN+2+I7IETnvni/SPg0BgSE/HDKUFuvaccHla7al5YDPYRdlAv0DSN
         p1fPNHp5oUgHj8jHxrDzW4lVaWhz69S0KTDfArIcFTah3sk/p3plpAnt/l+N8UXZ9Nxa
         1Dow==
X-Gm-Message-State: APjAAAXQER2zku85/V+Fnkr6BjSRtlOcvIhO9Jca2YzjjtSPMI85TXPX
        zFRq7g1OthSZ0algzmAR5n7Tx5WfTh6P2PjJSVDLbw==
X-Google-Smtp-Source: APXvYqynydrCs6zqydS4VXB3jKCB9L+iScylw9U5sLG2Vlh6/vpE7tx1KYJFEG/IX7CyUkeEOfKAMhW7qUA7Y3LzJO4=
X-Received: by 2002:a17:906:52d0:: with SMTP id w16mr15003060ejn.6.1551757991095;
 Mon, 04 Mar 2019 19:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20190221084729.101784-1-pihsun@chromium.org> <20190221084729.101784-2-pihsun@chromium.org>
 <20190222144316.GA19284@bogus> <CANdKZ0d+2CqbVEwruW+pbqUeRMBwzXV7tFC7Cp7i+98CWiB_4w@mail.gmail.com>
 <CAL_Jsq+rqeJX9LHOvVi7rPUzCeWhM2QjicJXyJyn23-gBo=Qcg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+rqeJX9LHOvVi7rPUzCeWhM2QjicJXyJyn23-gBo=Qcg@mail.gmail.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Tue, 5 Mar 2019 11:53:00 +0800
Message-ID: <CANdKZ0dg_yXPh8VJOnN3v4zf_XAWjK4qTXv_o16rTVYrhTqvGw@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: Add a binding for Mediatek SCP
To:     Rob Herring <robh@kernel.org>
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

On Tue, Mar 5, 2019 at 1:52 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Feb 25, 2019 at 12:15 AM Pi-Hsun Shih <pihsun@chromium.org> wrote:
> >
> > On Fri, Feb 22, 2019 at 10:43 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Feb 21, 2019 at 04:47:24PM +0800, Pi-Hsun Shih wrote:
> > > > From: Erin Lo <erin.lo@mediatek.com>
> > > >
> > > > Add a DT binding documentation of SCP for the
> > > > MT8183 SoC from Mediatek.
> > > >
> > > > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > > > ---
> > > > Changes from v4:
> > > >  - Add detail of more properties.
> > > >  - Document the usage of mtk,rpmsg-name in subnode from the new design.
> > > >
> > > > Changes from v3:
> > > >  - No change.
> > > >
> > > > Changes from v2:
> > > >  - No change. I realized that for this patch series, there's no need to
> > > >    add anything under the mt8183-scp node (neither the mt8183-rpmsg or
> > > >    the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
> > > >    directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
> > > >    created by SCP name service.
> > > >
> > > > Changes from v1:
> > > >  - No change.
> > > > ---
> > > >  .../bindings/remoteproc/mtk,scp.txt           | 37 +++++++++++++++++++
> > > >  1 file changed, 37 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > > > new file mode 100644
> > > > index 00000000000000..8cf8b0e0d98a4c
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > > > @@ -0,0 +1,37 @@
> > > > +Mediatek SCP Bindings
> > > > +----------------------------------------
> > > > +
> > > > +This binding provides support for ARM Cortex M4 Co-processor found on some
> > > > +Mediatek SoCs.
> > > > +
> > > > +Required properties:
> > > > +- compatible         Should be "mediatek,mt8183-scp"
> > > > +- reg                        Should contain the address ranges for the two memory
> > > > +                     regions, SRAM and CFG.
> > > > +- reg-names          Contains the corresponding names for the two memory
> > > > +                     regions. These should be named "sram" & "cfg".
> > > > +- clocks             Clock for co-processor (See: ../clock/clock-bindings.txt)
> > > > +- clock-names                Contains the corresponding name for the clock. This
> > > > +                     should be named "main".
> > > > +
> > > > +Subnodes
> > > > +--------
> > > > +
> > > > +When CONFIG_RPMSG_MTK_SCP is enabled, subnodes of the SCP represent rpmsg
> > >
> > > Bindings can't depend on kernel config options.
> > >
> >
> > What's the recommendation here if the subnode only has effect when the
> > config is enabled? Should I just skip the sentence "When ... is
> > enabled"?
>
> Sure.

Ok would change this in next version.

>
> >
> > > > +devices. The names of the devices are not important. The properties of these
> > > > +nodes are defined by the individual bindings for the rpmsg devices - but must
> > > > +contain the following property:
> > > > +
> > > > +- mtk,rpmsg-name     Contains the name for the rpmsg device. Used to match
> > > > +                     the subnode to rpmsg device announced by SCP.
> > >
> > > I don't think this belongs in DT, but without some examples I'm not
> > > really sure.
> > >
> >
> > This is similar to the qcom,smd-channels property in
> > Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt, a example DT
> > for this:
>
> QCom has lots of strange buses and communication channels. Probably
> not the best place for inspiration.
>
> > scp {
> >         compatible = "mediatek,mt8183-scp";
> >         ...
> >         cros_ec {
> >                 compatible = "google,cros-ec-rpmsg";
> >                 mtk,rpmsg-name = "cros-ec-rpmsg";
>
> Why do we need the same string twice? It's just the compatible string
> minus the vendor prefix.

What I was thinking is that compatible string is used to match what
driver should be used, and mtk,rpmsg-name is used to match the node to
the rpmsg device SCP announced. It's possible (although not in the
device tree we use) that multiple subnodes of SCP node use the same
driver, and they would have different mtk,rpmsg-name and corresponds
to different rpmsg device from SCP.

>
> >
> >                 cros_ec_codec {
> >                         compatible = "google,cros-ec-codec";
> >                         ...
>
> What's this? I can't review bindings piece by piece.
>

This is a example of subnode that can be under the cros_ec binding,
and is not directly related to this particular binding document. I
just wanted to show that there's possible subnode for the cros_ec
node, sorry for the confusion.

> >                 };
> >         };
> > };
> >
> > > > +
> > > > +Example:
> > > > +
> > > > +     scp: scp@10500000 {
> > > > +             compatible = "mediatek,mt8183-scp";
> > > > +             reg = <0 0x10500000 0 0x80000>,
> > > > +                   <0 0x105c0000 0 0x5000>;
> > > > +             reg-names = "sram", "cfg";
> > > > +             clocks = <&infracfg CLK_INFRA_SCPSYS>;
> > > > +             clock-names = "main";
> > > > +     };
> > > > --
> > > > 2.21.0.rc0.258.g878e2cd30e-goog
> > > >
