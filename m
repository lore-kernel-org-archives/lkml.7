Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18437C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AF02168B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5Enin/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfIKNG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:06:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51491 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbfIKNGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:06:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so3413926wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vM9T7JPTYaG7Q5phhjKWs9t8a740OJg6gDLyXdDlwy0=;
        b=I5Enin/54z24EJiVGsjC9LBUp7DWLfqpIT7jKxNc6AR3TZtq81lDcq13DBQttTGJt7
         vPD2PNtx66V200oc3BMwabrgL3o4m/cJQ1ehNZoSv90Cf06sRMjziKVZW+ZH9PrvrYil
         gZxsW2TCCQswOahMWFtcHYYUlNy3su48MsoLV7kJSeaD760lYOsF1xCX+/H4NxwRVwe/
         6LLzQTDo+lYiyVXTbC/SdEoieE4oehs91mafDcPNdHvDHI+RVpOA2SwCNwfY+4hHMHjg
         LYqggun0YLgEr+dbnodTJAfx6Wr8E8XdZ7AgsXnaI+MKJcx+PGxz9fanOhjcsWILwS9O
         qvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vM9T7JPTYaG7Q5phhjKWs9t8a740OJg6gDLyXdDlwy0=;
        b=JozFADulTbESisZ3KZoCOY0ts0flMd65MOpcm+sBqfv7CzArZ93lx/CRjFbWK86YuA
         WaRnicVbm+GcGr0/97n9B7EvUiKys82mBJUxDNYHUjNQ7Ww8MXjRqb5PqkkuGZCqph8I
         wLyRFAusqh9bmrFeHN0fNgQP3BYprrrx8okSDkDxpKLDFy00X4/jqBXM+hprqjfOgIx0
         BMuN78/bv/dEFhipcqe1lMFZ/xF0FmOs8gXkb+JPMgqcrgXNoE6z8R+Njp2eTlJQEkK/
         b56w7RtUghCNaNYLbDjrStwNGOXk/xOVDheopub3q7eGyrMs1btUO5xu+g4XQWvFqLFy
         7/nA==
X-Gm-Message-State: APjAAAUMx4sNb1UDx6pf4JZQfLCaVtX3b/v4PoeDhSyOpnLP6IKcgLPc
        pabAOKS8KkhQlPZcqpfpAwNiCwu83/fuxAagr30=
X-Google-Smtp-Source: APXvYqxNKQL9xaxjmnWNWWXNRC6dWIh/CBKe7WZ4qYZ9SB53ifIDuCCxYRz0tpQWXrnndjDe+dtrLY6hF32GB2U9TzM=
X-Received: by 2002:a05:600c:2047:: with SMTP id p7mr4157887wmg.13.1568207213658;
 Wed, 11 Sep 2019 06:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190830215910.31590-1-daniel.baluta@nxp.com> <20190906012938.GB17926@Asurada-Nvidia.nvidia.com>
 <20190911110017.GA2036@sirena.org.uk>
In-Reply-To: <20190911110017.GA2036@sirena.org.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 11 Sep 2019 16:06:41 +0300
Message-ID: <CAEnQRZAid2xXu+6PxWDCBNDwS6c8DfNXEcNqseDPAsVJ7kEHeg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_sai: Implement set_bclk_ratio
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 2:01 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Sep 05, 2019 at 06:29:39PM -0700, Nicolin Chen wrote:
> > On Sat, Aug 31, 2019 at 12:59:10AM +0300, Daniel Baluta wrote:
>
> > > This is to allow machine drivers to set a certain bitclk rate
> > > which might not be exactly rate * frame size.
>
> > Just a quick thought of mine: slot_width and slots could be
> > set via set_dai_tdm_slot() actually, while set_bclk_ratio()
> > would override that one with your change. I'm not sure which
> > one could be more important...so would you mind elaborating
> > your use case?
>
> The reason we have both operations is partly that some hardware
> can configure the ratio but not do TDM and partly that setting
> TDM slots forces us to configure the slot size depending on the
> current stream configuration while just setting the ratio means
> we can just fix the configuration once.  I'd say it's just a user
> error to try to do both simultaneously.

Yes, exactly. We wanted to have a better control of bclk freq.
Sorry for the late answer, I'm traveling.
