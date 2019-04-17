Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50B5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DC4217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uz3AChrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbfDQS6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:58:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39241 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbfDQS6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:58:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so33310078wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FojubWmNMeB2V9f+sYtEMSMYaZHbBpTkgkUdpBzRNAI=;
        b=uz3AChrE6WTGUUS90yK+Jl6V8CvwV571cgcUpAcvjL8EODOPr5nO+1S0V9bKf4QysJ
         0qs8DrL1D3D38eRC7iFbVLkuVgtXNt407glB4C1CLwGO/VhZ7v5WAcCJZAofcpor5AkU
         48TJE1Tqv5x8JxN2iIbbvpp9cK4na/y0Z7OI295Mi7uoOqmQzaNwYrMwACGaa849CGui
         B0w52cKoem0Q7BPpXj3TRryCyxLRON1Smydrrdcr+AJGhngJJO+lCVKjtCUoffXxefjO
         eqM8qGWlkYnEdCZUeCApMXhx5w3KMfZF6L7gxExyR1LcuctUMR8Q4XQ9PBwdEc63jXOV
         ChRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FojubWmNMeB2V9f+sYtEMSMYaZHbBpTkgkUdpBzRNAI=;
        b=EHHSU+Bmakl3wQVDxG7ae3XTvwT+VGzIYNPD8OB0DNMcouJv/PlvHog/hptcsDW3qb
         mMlhc/TEZ4+1aYYtQ3HiRu3CL0ZUoKaYxyHb8SUJ9SG67CHA9B+1GjjsJyVE/xgB7Lmz
         UgsceiJluE1P3ZpqCIh3n86ZXgkhD/AYZFvQhRF0ZyCvwjW6jHRiuH8s3G7RbH1htdmH
         zB8Pjrh+7izZmUUf0O2M6lYvrmbaoGu6/rmgWzym4ymlwKzO/mk+liHCPQJ011IVUfxX
         y037bKDPLtwlJvEUrCkH4zebSA6xeU+NA2KGH2ipLoiOhFc2/MsdfEfYs5IApMuQjD9T
         o4Zw==
X-Gm-Message-State: APjAAAWLiy4+vHRZTkFilZa0JakU6UjBJGQBOT/4FiuqLS0g8nkadHM0
        nR+d2oVUvYnQeWtBDKvnfvk=
X-Google-Smtp-Source: APXvYqxr87NnY9ACQSi5NG7YjfxvsOwxQzuKXUm7IYG4vCKYqXBPorS5UZ2B4AUbatjtaeV7vsL57g==
X-Received: by 2002:adf:f488:: with SMTP id l8mr56198802wro.213.1555527520482;
        Wed, 17 Apr 2019 11:58:40 -0700 (PDT)
Received: from localhost.localdomain ([86.124.23.100])
        by smtp.gmail.com with ESMTPSA id s21sm36034617wra.45.2019.04.17.11.58.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 11:58:39 -0700 (PDT)
Message-ID: <3228ff50862b0bad95561bd5276cbfcad5d6213c.camel@gmail.com>
Subject: Re: [PATCH -next] ASoC: fsl_micfil: Remove set but not used
 variable 'osr'
From:   gabrielcsmo@gmail.com
To:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux-ALSA <alsa-devel@alsa-project.org>
Date:   Wed, 17 Apr 2019 21:58:37 +0300
In-Reply-To: <20190417183518.GA5073@Asurada-Nvidia.nvidia.com>
References: <20190417150915.37968-1-yuehaibing@huawei.com>
         <CAEnQRZAug2kQoFTN6W47URBKwHcU5Zmmy=04smOtMomuzz6_TA@mail.gmail.com>
         <20190417183518.GA5073@Asurada-Nvidia.nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-17 at 11:35 -0700, Nicolin Chen wrote:
> On Wed, Apr 17, 2019 at 06:25:11PM +0300, Daniel Baluta wrote:
> 
> > Looks good to me. Just one question for Cosmin:
> > > diff --git a/sound/soc/fsl/fsl_micfil.c
> > > b/sound/soc/fsl/fsl_micfil.c
> > > index 40c07e7..f7f2d29 100644
> > > --- a/sound/soc/fsl/fsl_micfil.c
> > > +++ b/sound/soc/fsl/fsl_micfil.c
> > > @@ -151,12 +151,9 @@ static inline int get_clk_div(struct
> > > fsl_micfil *micfil,
> > >  {
> > >         u32 ctrl2_reg;
> > >         long mclk_rate;
> > > -       int osr;
> > >         int clk_div;
> > > 
> > >         regmap_read(micfil->regmap, REG_MICFIL_CTRL2,
> > > &ctrl2_reg);
> > 
> > I noticed now that we also read ctrl2_reg without using it. Is this
> > as intended?
> 
> For Cosmin,
> 
> Same question here.
> 
> Btw, I just noticed that the initial patch of adding this driver
> did not seemly include most of FSL maintainers/reviewers. Please
> run get_maintainer.pl to add all listed reviewers when sending a
> change to the maillist.
> 
> Thanks
> Nicolin

Hello,

The regmap_read is not used anymore in this implementation and I've
forgot to remove it - it can be safetly removed.

Nicolin, I am pretty sure I've ran the get_maintainer.pl script but
I will pay more attention next time... sorry if I forgot to add you.

Best regards,
Cosmin

