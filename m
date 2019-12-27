Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5487C2D0DC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 00:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FCE22522
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 00:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJXCsoTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfL0Ae0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 19:34:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46335 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfL0AeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 19:34:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id f15so19470125lfl.13;
        Thu, 26 Dec 2019 16:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0ugGKSdy996G5cCplSFEOG0vQpDh89551RLNUPVsrY=;
        b=RJXCsoTJsJ6edGiu8VS+CH+D/Dbj3WTIrX4aUJgPw9NYhOJTOvubQ0t/Ibr04akdir
         Fu6Ai+dWwPh6wOi0pbuhcbNC5hyjwFcF7b9HKCGYnkgyO1gINGyedIAR+CAZ4PPjK5rx
         NFFn9i4fsO+15oum1AQ5YLYbvJ6MGnp9mUaDgEJvGQGd5PFyjaStWnc6lD+xm66Y78c2
         UE8yLgl5l7l1Dg1HzL0pO/OTmLbf2sQbEYVaHGLCybnkkT6qEFz7SRBjj1cpeoRvkB8z
         xcCXdDZL/7k+upNyso0Vnzp8DnU4dvZprpqNC7mv4dpkCwGAqFYcjd9sWfRBreCjAYXf
         3h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0ugGKSdy996G5cCplSFEOG0vQpDh89551RLNUPVsrY=;
        b=d/X4wM73/3jipHDNmPagUER5eRNXHSIgnKzpGPVIsi8eRaUPxcOBrl+/RAsGhMWAGg
         WD0hFx45KN5x9kyFjMvIwYMTMbz5g8RNjCWXV4Sael1kV15UhyMvk72a+k6iD0+AS6C9
         uQxM82A/ku4snT1BSJCJzu3U4xX7mr0XLv20+BNqfIBpiwHG2Mh0o8vOmRMExCE/s8nF
         3psofsM8ay/k9zyth4OAoMsOe/F0NRdn45FD3EAyVGTBzLa3HcnDuLnp6STbozCWO9Bw
         97Je39rQWMdfWt9lBN+NjpVIzdmAV8N4uzIsphS2zMYjRo64QyXOTT+UJqOOwQBj68y6
         TGUQ==
X-Gm-Message-State: APjAAAUF58XASAQZDpegoa3UXhRgs3bIPxgjC5YhgWHW/xK/VjRO736d
        5ufABAvsCtNtGftaXaCUhnXkvnUcegsCniMv4Dk=
X-Google-Smtp-Source: APXvYqxY1gE2xluutA0vYW3bQC/tuQsvTnlKskNTUihkMrt/0z56p8xevQaK89OQG00nOvNGggLiZOMqj1+rHfr3cMA=
X-Received: by 2002:a19:2d0d:: with SMTP id k13mr26787903lfj.12.1577406863391;
 Thu, 26 Dec 2019 16:34:23 -0800 (PST)
MIME-Version: 1.0
References: <20191224010020.15969-1-rjones@gateworks.com> <20191224010020.15969-2-rjones@gateworks.com>
 <20191226232625.GA2186@bogus>
In-Reply-To: <20191226232625.GA2186@bogus>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 26 Dec 2019 21:34:06 -0300
Message-ID: <CAOMZO5Aj+PfzXrYoV8LxKStdQ-B0BLdMV16L3ya0NokozG479g@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: arm: fsl: Add Gateworks Ventana
 i.MX6DL/Q compatibles
To:     Rob Herring <robh@kernel.org>
Cc:     Robert Jones <rjones@gateworks.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Dec 26, 2019 at 8:26 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 23, 2019 at 05:00:16PM -0800, Robert Jones wrote:
> > Add the compatible enum entries for Gateworks Ventana boards.
> >
> > Signed-off-by: Robert Jones <rjones@gateworks.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index f79683a..a02e980 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -126,6 +126,7 @@ properties:
> >                - toradex,apalis_imx6q-ixora      # Apalis iMX6 Module on Ixora
> >                - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6 Module on Ixora V1.1
> >                - variscite,dt6customboard
> > +              - gw,ventana                # Gateworks i.MX6DL or i.MX6Q Ventana
>
> Keep entries sorted.

Just for clarification: shouldn't the entries inside fsl.yaml match
the dtb file names?

In case of the i.MX6Q based gateworks board, this should be:

gw,imx6q-gw51xx
gw,imx6q-gw52xx
gw,imx6q-gw53xx
gw,imx6q-gw5400-a
gw,imx6q-gw54xx
gw,imx6q-gw551x
gw,imx6q-gw552x
gw,imx6q-gw553x
gw,imx6q-gw560x
gw,imx6q-gw5903
gw,imx6q-gw5904

Please advise.
