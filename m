Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ACBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44BE2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552344478;
	bh=tZQ1MVIPrBMaGtM5X57I8wCHrEQrluOSmU5IWRM1um4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HhrP4wbpkddzFzSiXqKRDxCe/J2tP5/VidYxhB/kt+2aniA55EIQNTx1lMQivAjGu
	 M2FrMMf8+3zlXMRw11aP2SNx9W7U57+H/Pt1GLnzHuD7V98P0eIz+qPQrcvcDOPMSA
	 ttQf+T1dtYgB42e9kLLOyk4ikmW5AMglo6ZiuKEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCKWr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:47:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45934 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfCKWr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:47:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12so706739otp.12;
        Mon, 11 Mar 2019 15:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M1dZU86o/zb00gvYtMSXbvCESshMXfXrWh7L9zbZ0qA=;
        b=lnoeJ0S27f7wO7NV8kWFHV+zIr7lvd4BHxpbt3zFjQVq/Bfkfi8fUga7nWcOOb23PN
         SuBtkGBgLFokWE1MXsjmACvAgu8do3MnRKQ8MnmQnVwdZDStKRqIzFqfQwpRCXjOpv4R
         4N5XxKqfzqdlJ1UYgFSsJnMfA6MK032ZF0yEsoKYTMwcZg9iGaXVnXE4LwZ8+vKHZfDW
         c8bDShuLjJp4rajTSRny8zbMvHFZ+OOLoDBL3UJqHm2eWIEG/DIzVqlcPiVmyYZXr0Mo
         J5kyfx3XlUgsCl2h8VxFlLmZy9b+jtM88Vsh6lmJHzpZUrN+B7S2XeajUVvGUxJt+Wl+
         FEsQ==
X-Gm-Message-State: APjAAAX5Yi7Cs5ZPxB2wgjDMQK4de34v/ng4AuFSRe22TGvLrb/bhLdP
        fL6tYxT7FLuX/EFAx9/zpw==
X-Google-Smtp-Source: APXvYqyryUCZfiN+nog9fu3JCxr6H6brO22MTu7QW1dF0nlRNP6BgVNadwgOwlPSSQbEjFVdOn6OzA==
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr22859779oti.172.1552344475086;
        Mon, 11 Mar 2019 15:47:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t2sm2969906otb.79.2019.03.11.15.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:47:54 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:47:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 9/9] staging: iio: ad7780: add device tree binding
Message-ID: <20190311224753.GA32052@bogus>
References: <cover.1551358569.git.renatogeh@gmail.com>
 <ac8955ea9d903c106535d76549ff9802f527f4f6.1551358569.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8955ea9d903c106535d76549ff9802f527f4f6.1551358569.git.renatogeh@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 11:26:28 -0300, Renato Lui Geh wrote:
> Adds a device tree binding for the ad7780 driver.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> ---
>  .../bindings/iio/adc/adi,ad7780.txt           | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
