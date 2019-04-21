Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08BBC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 08:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A4C20869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 08:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIjf/1px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfDUIEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 04:04:48 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:46806 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDUIEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 04:04:48 -0400
Received: by mail-pf1-f173.google.com with SMTP id 9so4313550pfj.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 01:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WqmW3jhJQbbtDKoqaBLxUuj42y/qNfwTdD7pV2EaF9o=;
        b=SIjf/1pxKngViAfyvKmJt8tPOgmdzVEDD1CCq/ygMSg49AA/NMyPCX1szEe6qNmnc6
         vV8aR5+SvefgFQNPxxsEoGRVfxkIn8U7Q/wwvLhUlRrVc4vjtZdl3Ymw5HpugKqVfpCn
         L2dfx4R5331GQ1t7jbDN92uTJo4nkMXWFnGxsQzAnnJO7nt0yPw8C3j2M/m+ukZcc8Tn
         BwLBdjnvbCiz6NFrRVFEps1EaBIM+AtCnw6rMQEEJnZJUDYVz/lo5/d7c3kxEgEoM+S5
         mB2OEZh5kEAQFeD2F3G0oC/q9aBAcL5XNT6DXP9T3zNTDw/6gbPRBX+oEcm9sKvaJUpE
         waVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WqmW3jhJQbbtDKoqaBLxUuj42y/qNfwTdD7pV2EaF9o=;
        b=BG95zzhDTTkQhG6q5Tx/q6qAB0p+/EdBC2jefKdlWLGUUYttdnv/xkKtUnXsRt96k3
         OhVJmfAAvCTHa/Nxphn4q8pgD30AFJ0Xe2lzC8B54VWaetNRxIIkQBAibmZhL4Qj5m5n
         cmizanqoYs3LegtSAy62e3fhKh/hCl8YMYZ/F07ROdral0q/PT+E824sjHkmF6C5fOsU
         gg5qKm/wkyVYByVLa3aF1pi6rE/XLtBDwtR4yOfZgYTOXv5c59GV1PQCJi2K9vw+TCcE
         qc+/jxR4OMslH44N6pTuXDVHPZmb7tcybQ2P4FlAqhDIfiOjIZOdfOLbLIp+NWawLpnI
         zr2g==
X-Gm-Message-State: APjAAAWMZFaAyQnbGlOTkX2hZbCThYXlfa/mqWFfQrRwnmL/UesJGjni
        TRxQrw8opal6CGkAE32NrME=
X-Google-Smtp-Source: APXvYqybW5n0u+5qpusipCUjI3sMOrwQQFo1uaLffNrUsfWApb5P1IWNr0t98L/j5XDQ2j7BdmHINw==
X-Received: by 2002:a63:5059:: with SMTP id q25mr6094546pgl.314.1555833887143;
        Sun, 21 Apr 2019 01:04:47 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id w3sm15640299pfn.179.2019.04.21.01.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 01:04:46 -0700 (PDT)
Date:   Sun, 21 Apr 2019 01:04:40 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
Message-ID: <20190421080439.GA8784@Asurada>
References: <20190420154038.14576-1-daniel.baluta@nxp.com>
 <20190421053749.GA5552@Asurada>
 <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 10:26:40AM +0300, Daniel Baluta wrote:
> > Firstly, according to your commit message, neither imx8qm nor
> > imx6sx has an "mclk0" clock in the clock list. Either of them
> > starts with "mclk1". So, before you change the driver, I don't
> > think it's even a right thing to define an "mclk0" in the DT.
> 
> From what I understand mclk0 means option 00b of MSEL bits which is:
> * busclk for i.MX8
> * mclk1 for i.MX6/7.

MSEL bit is used for an internal clock MUX to select four clock
inputs. However,  these four clock inputs aren't exactly 1:1 of
SAI's inputs. As fas as I can tell, SAI only has one bus clock
and three MCLK[1-3]; the internal clock MUX maps the bus clock
or MCLK1 to its input0, and then linearly maps MCLK[1-3] to its
inputs[1-3]. So it doesn't sound right to me that you define an
"MCLK0" in the DT, as it's supposed to describe input clocks of
SAI block, other than its internal clock MUX's.

> Adding a mclk0 in the DT and making it point to the correct option
> (busclk or mclk1) does no harm as the driver doesn't yet parse mclk0.

I know it's making driver easier, but unfortunately it's not a
right thing to do from my point of view.

> >
> > >               sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
> > >               if (IS_ERR(sai->mclk_clk[i])) {
> >
> > Secondly, this would break existing DT bindings of imx6sx and
> > imx7 platforms as they both have clock-names defined in DTB:
> >         clock-names = "bus", "mclk1", "mclk2", "mclk3";
> > Since there's no "mclk0", the entire probe() would error-out.
> 
> Not exactly. The probe won't error-out. It will just print a warning message

You're right about this part. I didn't look further as the patch
ends at the IS_ERR, so made a wrong assumption. Sorry.

> In my opinion, the current implementation of fsl_sai has a bug for imx6/7.
> 
> Currently, fsl_sai.c driver does:
> 
>        sai->mclk_clk[0] = sai->bus_clk;
> 
> is wrong, because on imx6/7 mclk_clk[0] should point to the same clk
> as mclk_clk[1]

You are right. It should be fixed, but not by this approach IMHO.

Thanks
