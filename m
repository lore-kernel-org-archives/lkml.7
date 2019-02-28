Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C575EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905152070B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551378253;
	bh=K1qAn4vFvJIHCuR2fzsn4niKtQQXqspJ8fYehU4oKD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u3QFgU5EqVF8iSRbo+fQAUTrilifIRIpYRd2qHJBpFqHdAnNxu5MNpmWCttdZJw/3
	 RU5OMk88RNJmeXxUPBImUuPcIFk1JREx296DTAAffWb6JfValIBE06+2TZKwi1IEdF
	 TbkNsAXEx93v3shZ0WuufsJJiKwOAvjKYQG8yKjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbfB1SYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:24:12 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35086 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfB1SYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:24:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id z19so18580476otm.2;
        Thu, 28 Feb 2019 10:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ucn6HmMNAstPj8g03QkHR9PsQlpdzwekMb2Oly/4j8o=;
        b=Yp5/cV8RQTb0w813pIGYxwXEl6C/mcE7JvI9WAZhyNgaD3B97mRUnB/GEPnWOLZe50
         WenkHY2rSGXmWeOUOYFN1FBEAHDys8yZMXxJmUNypQYsS/LpybJccFkXhPynJyjstxVI
         Htsi4eabAo+huyXNXCRR7VQ8usZoMCQq6APUx+YSL4yAYcq/TyMY5WcKjhWYRpGvvNHo
         DuwZGAMb6N7v+dn2a6s3Fi+xPyv4R+bXAuUStNLeQfs9W9eUGrMFif7HqrAzzKGuj8R6
         Q2vmdnWNMKyByR2iQi4sc9IeAP3Pre2k+EoTRTYvEivy9nT0oO78Twg5TEhTwvyIDag/
         dqdQ==
X-Gm-Message-State: APjAAAXd8qkG+905GOp4i2C+ep8GjNL6J+1f9d/4rHCuPN6WETNaQPHb
        DmNgdwpATDYkwppVu9Yvgw==
X-Google-Smtp-Source: APXvYqxH9zlN7A4Vy6xIJjVeQB8YBo8fveLpCXSu0uBo4yR5o+VI2zQr7NViKyJ6E0nA76uGKUi0Vg==
X-Received: by 2002:a9d:6a08:: with SMTP id g8mr668730otn.191.1551378251051;
        Thu, 28 Feb 2019 10:24:11 -0800 (PST)
Received: from localhost (ip-184-203-129-180.hstntx.spcsdns.net. [184.203.129.180])
        by smtp.gmail.com with ESMTPSA id q25sm7394305otl.15.2019.02.28.10.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:24:09 -0800 (PST)
Date:   Thu, 28 Feb 2019 12:24:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tudor.Ambarus@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, bbrezillon@kernel.org,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Tudor.Ambarus@microchip.com
Subject: Re: [PATCH 03/11] dt-bindings: memory: atmel-ebi: add sam9x60
 compatible
Message-ID: <20190228182408.GA20310@bogus>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
 <20190213085930.31578-4-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213085930.31578-4-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 08:59:52 +0000, <Tudor.Ambarus@microchip.com> wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Add compatibility string for the sam9x60 EBI.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
