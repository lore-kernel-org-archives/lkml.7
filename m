Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154A6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE7021873
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014530;
	bh=mDJxvrejQskEh4+YaAcJuC+1k3IT4RJhEg+a+6xwLnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HPEXTbBXfCuB1BoSwlHc03F32JCeOWQ79pVurJoeoDbDtqIu7Gw29LLB5yxmtrrKi
	 h4vfhETw9vJlpDSgjGUtwsjap0a6zFubuFmKSYVpZYynFJ6+Wl9+Lr9HoT4EEV4nCZ
	 IA/4gcNZu0PP3so07e4BKDDepxqYTVVlt48GULeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbfCaGmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33442 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731371AbfCaGmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:42:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so2990005pfd.0;
        Sat, 30 Mar 2019 23:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zgWlWhNebV4DAis4oYThAM+4V5ib2u6j9U07JrmMSZQ=;
        b=rEEN7xj0PYWRR2UWEqmQ9AvNQRQpeRC6pXsQvXB1Z9IGnWixcYzqhBN2LWZSZ6fgLe
         oSzpX4s1r1mC/rUsSmmm19rak+fqNO7096QmG62llyK1fIrbdosUiz5EpksSStR09uxR
         liM6hPKsdgDuhSQxiPZrPuNxupiLrcXOOcmS2KrIFho5Fsq0Ef4KZLhBHP6gqiYXyJDF
         vVqR8FMbhVswpRqTUdXQBs9bwWQAzt9KgryEVkscExsdZoZmKNDWAXqP0h2svK1LPVyi
         EH+2NrawFe4mIuNq2E+8pMvJZXo/4IoBdEXJlgWsH6XVcHDT6Nq5zqr9epyOg6+3vmu5
         FaWg==
X-Gm-Message-State: APjAAAVO1QqmLFHqbb/1wjcPmxgnkGFk4y3S24Fjj9WEBTmEcCBzPOcy
        ERjP0uuVPHkXTHb16342wA==
X-Google-Smtp-Source: APXvYqwrnZY/ZPBJLbDeb8J+pMauGOF8476+x1xC/ThJIOQhcOUCG6I/0CibhrbwLYk77SV7OeluBQ==
X-Received: by 2002:a63:c605:: with SMTP id w5mr16749080pgg.355.1554014526923;
        Sat, 30 Mar 2019 23:42:06 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id a129sm19398038pfa.152.2019.03.30.23.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:42:06 -0700 (PDT)
Date:   Sun, 31 Mar 2019 01:42:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shinji Kanematsu <kanematsu.shinji@socionext.com>
Cc:     jic23@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: counter: Add Milbeaut Updown
 Counter
Message-ID: <20190331015228.GA27625@bogus>
References: <1553581989-13525-1-git-send-email-kanematsu.shinji@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553581989-13525-1-git-send-email-kanematsu.shinji@socionext.com>
X-Mutt-References: <1553581989-13525-1-git-send-email-kanematsu.shinji@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 03:33:09PM +0900, Shinji Kanematsu wrote:
> Add documentation for Milbeaut Updown Counter device
> quadrature encoder and counter binding.
> 
> Signed-off-by: Shinji Kanematsu <kanematsu.shinji@socionext.com>
> ---
>  .../bindings/iio/counter/milbeaut-updown_cnt.txt   | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt b/Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt
> new file mode 100644
> index 0000000..6771567
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/counter/milbeaut-updown_cnt.txt
> @@ -0,0 +1,22 @@
> +SOCIONEXT Milbeaut Updown counter
> +
> +Required properties:
> +- compatible:       Must be "socionext,milbeaut-updown-counter".
> +- reg:              Offset and length of the device's register set.
> +- clocks:           Phandle to the clock used by the Updown counter module.
> +- clock-names:      Must be "mux".
> +- interrupts:       SPI number of the device's set.
> +- cms_type:         connected_device
> +                     1: updown button  (updown counter mode)
> +                     2: rotary encoder (phase difference counter mode)

We should have a common property for describing what's attached. 
IIRC, just had a similar binding recently.

> +
> +Example:
> +
> +	updown0: updown@1e002000 {
> +		compatible = "socionext,milbeaut-updown-counter";
> +		reg = <0x1e002000 0x20>;
> +		clocks = <&clk 4>;
> +		clock-names = "mux";
> +		interrupts = <0 104 0x4>;
> +		cms_type = <1>;
> +	};
> -- 
> 1.9.1
> 

