Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3A8C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB45206C1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 09:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl8SyZ3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfD1JxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 05:53:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33593 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfD1JxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 05:53:11 -0400
Received: by mail-io1-f65.google.com with SMTP id u12so6557895iop.0;
        Sun, 28 Apr 2019 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mrjoLB3/jtI5jqEi/ydYyCCjyNdzpn6OvBS3steifLY=;
        b=Zl8SyZ3FZJQcjJnYc4f8rStzNJwBUNjZgSSMmAZRQ5lhl0+5dw610ANYnvX+MqTATw
         Umky+zr7OfDRa+7dmuUNsXg9ZQ14c4b0FUfMPULL/J3htxxESfOneYtQdzzkBIFznkUE
         Kh3sBe8+Abo543yYtKEDVKi5rJoLjktDkR0mvAFFUBUiyLaXol8OW2i4CbKoOONRi7V4
         Yya0ZXv0OKPYWBtSpu41tEgYnCxR9ypKV7+m4IicNa6VXcQwuWB0bnPOuBx0ChtFg5iu
         fmYbbu8MvzEPi4MRSKnS0Nvzx79dH4byrjzKvd1VctJYpIziDko8ttaiudwSnZbIZ1yW
         gvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mrjoLB3/jtI5jqEi/ydYyCCjyNdzpn6OvBS3steifLY=;
        b=kOR1P4PuxaWGXDpyMrg0tG5aCK11HZBwP7AH8qJA2VbT2arecUhkB8ohdCsdCa+qrm
         aAMT7V+fuC2jIDjg0bIGUiBn8jZjWXRSlUp7k0W7nPuw5Z+Pz6wHhxHY9UB1AHpDMPzw
         ArdX9Ona9UyUMbIPkJNfqnX9D6xc41gjt4+xy90wVsfxO14bPK5DIdcU4lQsmQHQVG3a
         e/CKXOYjZaEgr/OiGPsWOYBLarvef8n2+sU6EEg2n1YtKobsI6Aa2u9Idq5kPcNCRGpy
         eI7GvgNaA2k4oU9YIs5J7HHn1Vqc7mp11Yw1xkWK19AmWvzaO+82Q1ktjqjZy9UDdl7V
         9iaQ==
X-Gm-Message-State: APjAAAWKnFtMsfHs5NMjkhzom1TooYtHuai+DtlDlVpehflb7lM/fyuT
        UCGzhoXDmYVZpker4aQSCZ6CO2/xBgtwwPEiY/8=
X-Google-Smtp-Source: APXvYqyb4275QBINybmElDXHkdyvUfwyJnFJPm/jb+IRVjHSMuHo1H8b8RFIg2M23blRxG9GuqZz/LU9PEuEMR2XlFA=
X-Received: by 2002:a6b:c8d1:: with SMTP id y200mr3349440iof.225.1556445190264;
 Sun, 28 Apr 2019 02:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190410174139.20012-1-tiny.windzz@gmail.com> <20190410174139.20012-3-tiny.windzz@gmail.com>
 <20190426211540.GA890@bogus>
In-Reply-To: <20190426211540.GA890@bogus>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 28 Apr 2019 17:53:05 +0800
Message-ID: <CAEExFWs2UwPLzgyO0apMOZf56um5isdZmf+7-wj_TqMozxZJQg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: cpufreq: Document allwinner,cpu-operating-points-v2
To:     Rob Herring <robh@kernel.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        mark.rutland@arm.com, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 5:15 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Apr 10, 2019 at 01:41:39PM -0400, Yangtao Li wrote:
> > Allwinner Process Voltage Scaling Tables defines the voltage and
> > frequency value based on the speedbin blown in the efuse combination.
> > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each
> > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> >
> > The "allwinner,cpu-operating-points-v2" DT extends the "operating-points-v2"
> > with following parameters:
> > - nvmem-cells (NVMEM area containig the speedbin information)
> > - opp-microvolt-<name>: voltage in micro Volts.
> >   At runtime, the platform can pick a <name> and matching
> >   opp-microvolt-<name> property.
> >                       HW:             <name>:
> >                       sun50iw-h6      speed0 speed1 speed2
>
> We already have at least one way to support speed bins with QC kryo
> binding. Why do we need a different way?

For some SOCs, for some reason (making the CPU have approximate performance),
they use the same frequency but different voltage. In the case where
this speed bin
is not a lot and opp uses the same frequency, too many repeated opp
nodes are a bit
redundant and not intuitive enough.

So, I think it's worth the new method.

Yangtao

>
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 168 ++++++++++++++++++
> >  1 file changed, 168 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
