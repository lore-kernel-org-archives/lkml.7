Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780D9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44400218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1i+zhn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfCVCAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:00:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43217 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfCVCAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 22:00:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so667599lja.10;
        Thu, 21 Mar 2019 19:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=16iO+yaf28okeWToT2HKfRunhhzYTrhwD4shI1XL4To=;
        b=s1i+zhn5R95thHpnOYE4uhJWxDzLi/rkEgEAzsPMnmwAkqxcmGK/kPxOSO02b85g3F
         Kn+vGl2aVQkcpYPQ8MQK6kYCdRQVB0k7g1PEdVOPndOY3Fc9ykgM2N0UOixhpu6WoqGT
         5QgHr7Ouw54knrjG7ByPXyiU+bhiXnChZ8HCTQQys1G0wbVSZ8VxHs9krtDWG7zoaxpH
         U1bXCLmWnYhdwAuD73VQVhKu1fu04E8Pnehez38uP7xVsNh2P13w+SH4tnGJDPojNfBi
         NHTbttVwc99Z0IbLwCF7EeH7P9HMvaa+ZZvd9Z+syTcp5rKqo/xrRmpsMqxc/91qhqCC
         Nkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=16iO+yaf28okeWToT2HKfRunhhzYTrhwD4shI1XL4To=;
        b=uG5xSE/JcTUrgQ5sgD2vObXjO4YmRz84byPQaW79YxbCAuYuQRDdhDNA5P1jNpgzKt
         bED8VRjGfP21Tn7NALmzz2L8wXBP9otFu8wtma0qWL6+OgQuQT9YwBwOeBblzP8jX2g/
         ETjZeM6SiVw7wCBUIdw6s2OSk5XRPPWmLWJn/i3wBEGvZHJ7TL1ypoLa0t9L6dEQAb7a
         o38y2MQbZNVUoRptvBEmb+1DOU864ZAOy/EEvc9iSC4AIHNU9+kEiNV9JhOaTWSKs6KD
         JIGBSUH+ZRXM47Ftt2Y2mOmqttE0xJCNNJf68SYL7ww/via47Czo2uQIyuMMFHa6830L
         Halw==
X-Gm-Message-State: APjAAAVbOg8pRz1rF5ovvNnQK1dRFlvlstVJDZSPZgh1U5P5Z4M1m4a+
        R1dif87CffECys28aPgsEI7vyIpnnDPAVgFXrnY=
X-Google-Smtp-Source: APXvYqwQxMLOMrvRSt0NFAgIBQ/+S+qY1eOD/98GvprQjcg0ZYkDungF9GLXSxztPk0KC4JLHgvlSPBpRsnJ/7YY19k=
X-Received: by 2002:a2e:899a:: with SMTP id c26mr3682427lji.192.1553220021975;
 Thu, 21 Mar 2019 19:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
 <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
 <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
 <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175> <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
 <20190322011155.GO12513@dragon>
In-Reply-To: <20190322011155.GO12513@dragon>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 Mar 2019 23:00:18 -0300
Message-ID: <CAOMZO5CBjG_xZWjZof_VOKaLLOCxFz3g7Gz1uTVzD=D5GeQb4g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use rgmii-id
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Thu, Mar 21, 2019 at 10:12 PM Shawn Guo <shawnguo@kernel.org> wrote:

> > So yes, we currently have lots of broken dtb's in mainline and I am
> > wondering what is the proper fix here.
>
> So can we have a single patch fixing all broken i.MX DTBs?

Unfortunately, just by looking at the dts files we do not know if a
board uses an AR803x PHY or not, so I am afraid we can not do an
automatic conversion.
