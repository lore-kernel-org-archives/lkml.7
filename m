Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80962C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525DC2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYR0FUdE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfDBQgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:36:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34392 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbfDBQgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:36:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id k2so16031652qtm.1;
        Tue, 02 Apr 2019 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rQyLZeRLfMP2FB3W4M3jfESaKk9r/vGfg6AmMTa2GZI=;
        b=kYR0FUdE1A+a82EJDPSjX5pwJLvii0a7ePSTW5RH2BJPZpYImEnzA7Jb1fpmced9oJ
         BVV/+lh97SoiVBQfia9m+p9X7e9m0T2l4qAM98v+kgnBAmp9FozWVxXC5V0Oft9lJmw2
         0xCE4v97+WvK4Si6YutjMrW3OT8K4JeppdPbiIZWpTjI11N9rQbc5gmfOeRWwfXs0TY5
         z6rnkW3neU4Vceb8IJWiq3cDHXTzKr69E8lqPeYaof3ldBr1RskcxPv0J7h+o+5L8akM
         cpDK75TI2WSss8N29i+5IbIYS2+1Dd50zrq7St68UxcHlDOswVR1xCTwXr8vrPpRUULr
         h2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rQyLZeRLfMP2FB3W4M3jfESaKk9r/vGfg6AmMTa2GZI=;
        b=MY3vEmGQJq85pXhqG4ZIEIMk4Z+6lVqgbWiUBIN4FTW0XEzzxLIwcRJ6pozLJDrFx/
         1Rwr0mwmIZEZ9+7eOffpDJJAZw30hkLaKSAwWWQcS5sugCV2NPI5wmNtmdbPjbTlvak2
         og3FFOoR2WHfIf+zUEBIIj+xzy1w0twYxZkK7I2bpU/97a8AE2SHgN1RibFE7BQ4bz5g
         RRrMPDnRf3gE5jF2XgxibAjSv/d1uHrJ0UpbD7ZvlecgzGSgIvrhOHDLZFuFdkUpc4D3
         efxI6MQoA6UmrS7qkvfRFvtd3dGOmDOQuKqyaLpB94WP2yASoIMqMfF+FY8RZ+ErWG9+
         Y5vQ==
X-Gm-Message-State: APjAAAXDGhJpQcGVcCG64OeL3YEUdebMmALoHwGGyTn3L1+TFNgCwhoR
        LKbJNn9nhwO1B0NKgwK7WiI=
X-Google-Smtp-Source: APXvYqzei0yVpKlkjJ8WodyO8D1Xy9/iqdjbjflP6HY7WRuQBgviGYxxd1B3jV9PaHCy0UbnoT/+uQ==
X-Received: by 2002:ac8:74d5:: with SMTP id j21mr59877494qtr.232.1554222979556;
        Tue, 02 Apr 2019 09:36:19 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e15sm6424592qkl.80.2019.04.02.09.36.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Apr 2019 09:36:19 -0700 (PDT)
Date:   Tue, 2 Apr 2019 13:36:14 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     lars@metafoo.de,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        stefan.popa@analog.com, Jonathan Cameron <jic23@kernel.org>,
        knaack.h@gmx.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 4/4] staging: iio: ad9832: add devicetree documentation
Message-ID: <20190402163614.xsnut6ev7dceku55@smtp.gmail.com>
References: <20190401143807.xlz32drk367ogcxh@smtp.gmail.com>
 <CA+U=Dsq2hAo4DrQOnyVxgqov=UZ8Ch1WmzSrwkMj0zOMLNVFog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=Dsq2hAo4DrQOnyVxgqov=UZ8Ch1WmzSrwkMj0zOMLNVFog@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02, Alexandru Ardelean wrote:
> On Mon, Apr 1, 2019 at 5:38 PM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Add a devicetree documentation for the ad9832 direct digital
> > synthesizer, waveform generator.
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---
> >  .../bindings/iio/frequency/ad9832.txt         | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/frequency/ad9832.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/frequency/ad9832.txt b/Documentation/devicetree/bindings/iio/frequency/ad9832.txt
> > new file mode 100644
> > index 000000000000..6a35fdff5a48
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/frequency/ad9832.txt
> > @@ -0,0 +1,26 @@
> > +Analog Devices AD9832 Direct Digital Synthesizer, Waveform Generator
> > +
> > +Data sheet:
> > +https://www.analog.com/media/en/technical-documentation/data-sheets/AD9832.pdf
> > +
> > +Required properties:
> > +       - compatible : Must be "adi,ad9832"
> > +       - reg : SPI chip select number for the device
> > +       - spi-max-frequency = Max SPI frequency to use (< 25000000)
> > +       - clocks : The clock reference for the DDS output
> > +       - clock-names : Must be "mclk"
> 
> It's always a good idea to reference other base dt docs.
> For SPI you could:
> 
> ```
> For more information on SPI properties, please consult
>      Documentation/devicetree/bindings/spi/spi-bus.txt
> ```
> 
> For clock:
> ```
> For more information on clock bindings properties, please consult
>      Documentation/devicetree/bindings/clock/clock-bindings.txt
> ```
> 
> For regulator:
> ```
> For more information on regulator bindings properties, please consult
>      Documentation/devicetree/bindings/regulator/regulator.txt
> ```

Thanks for the advice. I'll have a look at them.

> 
> > +
> > +Optional properties:
> > +       - avdd-supply:  Definition of the regulator used as analog supply
> > +       - dvdd-supply : Definition of the regulator used as digital supply
> > +
> > +Example:
> > +       adi9832-dds@0 {
> > +               compatible = "adi,ad9832";
> > +               reg = <0>;
> > +               spi-max-frequency = <25000000>;
> > +               clocks = <&ad9832_mclk>;
> > +               clock-names = "mclk";
> > +               avdd-suppy = <&avdd>;
> > +               dvdd-suppy = <&dvdd>;
> > +       };
> > --
> > 2.20.1
> >
