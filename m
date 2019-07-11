Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB33CC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43CE21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562852686;
	bh=N++HA0Suxx9LUIKShRqQi/IZ1Ui2WkJNndBcpnjBMgQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CQrHRYaV1D8YlhdKXusHSoiH79b8cD5APvJUjTfq1k/pCwSSmS4xPr7FAApOezFxx
	 zt1FK9nAnr7rXCbMuIuWqQApVfsSiIksmnrOi5beY2rTE18QLTYuI//+trK22y4HQf
	 un8Cj+6opgP2L+wMe5E2yYNFd3HtT/11KME7CYl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfGKNop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 09:44:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfGKNop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:44:45 -0400
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com [209.85.161.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9208421019;
        Thu, 11 Jul 2019 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562852684;
        bh=N++HA0Suxx9LUIKShRqQi/IZ1Ui2WkJNndBcpnjBMgQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wm3vRlDRGdEMSG3YtunRhi4IwGasCq6s62I9XVvLUlflydXVQb4uCmAgGGwUAIUTO
         MRtqyRKB01l40QErOdJ6ZbMzyh4eFCISYn5EpeNl60+hwRuAIbKG6Rd/y+J+7MnblI
         tbYQ8LE1IDxamvLGwLvxw9xlEzxS+HX8LUFIAe80=
Received: by mail-yw1-f53.google.com with SMTP id z63so3585292ywz.9;
        Thu, 11 Jul 2019 06:44:44 -0700 (PDT)
X-Gm-Message-State: APjAAAUYF7EcWqKusnNGixX1IysVFvQK018dftanlH0fvJfUxcWeoyNp
        QJwjyd3eftUAu1WBJ4DuCaQvKC895KYEucfrqw==
X-Google-Smtp-Source: APXvYqxXUf3DmAR2oJ8qhbFdfBnqovYOtOVQp9haN7U8g9xuxsnLzHC/CIkpCDNwFGMb0ePtFNApL5FEFuQ81Vj3Beg=
X-Received: by 2002:aed:3fb0:: with SMTP id s45mr2268749qth.136.1562852683872;
 Thu, 11 Jul 2019 06:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190710141611.21159-1-andrew@aj.id.au> <20190710141611.21159-2-andrew@aj.id.au>
 <CAL_JsqKrYcUbn_02z9GQO6U4rz7k=p3kB7_G0tKmv25MMZZNQg@mail.gmail.com> <3b0788cf-eee4-48b2-901d-d2ab6716ab1b@www.fastmail.com>
In-Reply-To: <3b0788cf-eee4-48b2-901d-d2ab6716ab1b@www.fastmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 11 Jul 2019 07:44:31 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+mAd=US3cbNQexFGrLxhkSyqi2XyGetyHrZV6QMd69EA@mail.gmail.com>
Message-ID: <CAL_Jsq+mAd=US3cbNQexFGrLxhkSyqi2XyGetyHrZV6QMd69EA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Document Aspeed SD controller
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryanchen.aspeed@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 6:56 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Thu, 11 Jul 2019, at 01:20, Rob Herring wrote:
> > On Wed, Jul 10, 2019 at 8:16 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> > > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > > data bus if only a single slot is enabled.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  .../bindings/mmc/sdhci-of-aspeed.yaml         | 91 +++++++++++++++++++
> >
> > aspeed,sdhci.yaml
>
> Ack. Previously I had separate documents for different compatibles, wasn't sure
> how to tackle name one document covering multiple compatibles.
>
> >
> > >  1 file changed, 91 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml b/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
> > > new file mode 100644
> > > index 000000000000..e98a2ac4d46d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
> > > @@ -0,0 +1,91 @@
> > > +# SPDX-License-Identifier: GPL-2.0-or-later
> >
> > The preferred license is (GPL-2.0 OR BSD-2-Clause) if that is okay with you.
>
> I should poke people internally again, I had asked, just haven't got a clear
> answer. What was the justification for the preference (just so I can pass that
> on)?

To use schema in non-GPL projects. *BSD, Zephyr, etc.

Rob
