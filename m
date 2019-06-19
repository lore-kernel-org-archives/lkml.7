Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5414FC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F322063F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560953248;
	bh=Gv7KaRBWqiqr3hW8zTUm5eDPSIyUp9V9W3hE/9RwchI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yuTXuI+iPPu+9SAhDPVghV6Zq8s/JGjJLNqHxMVssGuVfUPkBsJzGzqRGzYILh2hG
	 6LWKTeB03HI8gZ3qqeZJdtSNkmqr8k2gGggTlyG2m/d5kGxuowuY4eyxx5PHBJkEBs
	 lN5pPJ2NTcqvsVEI5+SHGO8Md3Fa9UJjZkyD/JCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfFSOH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfFSOH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:07:26 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BCC220645;
        Wed, 19 Jun 2019 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560953244;
        bh=Gv7KaRBWqiqr3hW8zTUm5eDPSIyUp9V9W3hE/9RwchI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ebHr6ZJnDUdRxTmLYwVgZWVw2cuDekuQMurelaVmvUxad7olctK7riRoGsa5LgR9J
         i5uxAXpMzEkYK4dkvPkri1khmIAyvl+KYKnL7wp4kxhHTfcj/IjDo3dLpcRroofOSY
         aHlVppyz5OgrlfmDW2mooBYVNFQhv7Zj64ZsFV64=
Received: by mail-qt1-f176.google.com with SMTP id p15so20029944qtl.3;
        Wed, 19 Jun 2019 07:07:24 -0700 (PDT)
X-Gm-Message-State: APjAAAWo00mKM8PtUk9wy1Ntbe8Em/psP6yMJGRcB5xrUXj/Wypsd749
        tr9ZYiQtdh7Y+jDQPPAxVQl+V6pEfQFbxeg7SA==
X-Google-Smtp-Source: APXvYqwvt27LPCNKqYdTaksDB3XZrSVKGXUlUZqYHZQFzDcc2DcbrKLZm3Rpj9gJvYsnzw4i6A/E6B7YVSBCmxedYAQ=
X-Received: by 2002:a0c:8a43:: with SMTP id 3mr34267465qvu.138.1560953243742;
 Wed, 19 Jun 2019 07:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190508103703.40885-1-wen.he_1@nxp.com> <20190613200813.GA895@bogus>
 <DB7PR04MB5195E49670279C9A28C28A5EE2EB0@DB7PR04MB5195.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB5195E49670279C9A28C28A5EE2EB0@DB7PR04MB5195.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 19 Jun 2019 08:07:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJnBw+OqEX46CC1E2=9CDmeT8hQtvMpufsnU8z3+1RoBQ@mail.gmail.com>
Message-ID: <CAL_JsqJnBw+OqEX46CC1E2=9CDmeT8hQtvMpufsnU8z3+1RoBQ@mail.gmail.com>
Subject: Re: [EXT] Re: [v1 1/4] dt-bindings: display: Add DT bindings for
 LS1028A HDP-TX PHY.
To:     Wen He <wen.he_1@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 7:45 PM Wen He <wen.he_1@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: 2019=E5=B9=B46=E6=9C=8814=E6=97=A5 4:08
> > To: Wen He <wen.he_1@nxp.com>
> > Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; shawnguo@kernel.org; Leo Li
> > <leoyang.li@nxp.com>
> > Subject: [EXT] Re: [v1 1/4] dt-bindings: display: Add DT bindings for L=
S1028A
> > HDP-TX PHY.
> >
> > Caution: EXT Email
> >
> > On Wed, May 08, 2019 at 10:35:25AM +0000, Wen He wrote:
> > > Add DT bindings documentmation for the HDP-TX PHY controller. The
> > > describes which could be found on NXP Layerscape ls1028a platform.
> >
> > Drop the hard stop (.) from the subject.
> >
> > >
> > > Signed-off-by: Wen He <wen.he_1@nxp.com>
> > > ---
> > >  .../devicetree/bindings/display/fsl,hdp.txt   | 56 +++++++++++++++++=
++
> > >  1 file changed, 56 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/display/fsl,hdp.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/fsl,hdp.txt
> > > b/Documentation/devicetree/bindings/display/fsl,hdp.txt
> > > new file mode 100644
> > > index 000000000000..36b5687a1261
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/fsl,hdp.txt
> > > @@ -0,0 +1,56 @@
> > > +NXP Layerscpae ls1028a HDP-TX PHY Controller
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +The following bindings describe the Cadence HDP TX PHY on ls1028a
> > > +that offer multi-protocol support of standars such as eDP and
> > > +Displayport, supports for 25-600MHz pixel clock and up to 4k2k at 60=
MHz
> > resolution.
> > > +The HDP transmitter is a Cadence HDP TX controller IP with a
> > > +companion PHY IP.
> >
> > I'm confused. This binding covers both blocks or is just one of them?
> >
>
> Hi Rob,
>
> This binding covers both blocks(HDP TX PHY and HDP TX Controller),
> Because they are belong to the one IP.

In that case, you should also have an output port to a DP connector
node (or DP panel).

Rob
