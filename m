Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAD0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219982070B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551378301;
	bh=Aa/O6u2WxT1p/xWQES7RZFtIS1bXWjvKHZahmsH2+IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kSlJqdKNLQi54n4gkuzM1k9k5qLLkH1v7FqBY9OkRBR/rB5kcDDaPvI8MKF/E9JJk
	 LGM1uoCexhF2QApFIu6BX2Gbz3+cGdvoc2rljmIk9Kykzu+aEQlekBi5bI8+dy0c8A
	 e6xsv7ODV+/riGvJSx5MqqjE+C9/sb8XctH0hItk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbfB1SY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:24:59 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41590 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfB1SY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:24:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id e7so17293700oia.8;
        Thu, 28 Feb 2019 10:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0jSrRIhfTa4WE1XJ9yzCZgw4zBXph8fqSTtiUCoqXHQ=;
        b=CVmMbpJF7fKkptCHB6OY9nTVfUxxM+qWR8BNmmjkAYWHY2KvIOgwAEL+8AnwBXv/Zu
         8YjY/Z5bAX+x1f5ib5lNSlPty/DvIwhCYWP1lQg2kNKZ0G0LIdABKPwogP9DBztgay5v
         +GkurSNP4YQ5Dz5FRqu+ideArsco8GHT6dOk8I/vpY1TZ2juhTgklmTsjqq2iFe6kouY
         U8qbDGO9YqWYd+KP98zlPRf7uG+8u5BrMoE6vD42Py8xGLKF8nw6fmntF5O9To1yslee
         zKM5LJaufBtkn2Mct3ocOcN4S9iGRM8GdntrDZ2skSg8UnceXcZmoM9AobUEwG4xBqGI
         sZyw==
X-Gm-Message-State: APjAAAVn69pFK67ODs6sxB3AO1kKzzxRZ6s7qF6IOpIIyj+0fbTgJjwx
        EOsANgxITjh/gZt/P0kbPA==
X-Google-Smtp-Source: AHgI3IZYrcZ80ogxEgXeBfTtEYEPD8wg6iGPdBvstlxcFtxKpLv4OFmAa9d2Ws76d5IoI4KCNH1fug==
X-Received: by 2002:aca:4e13:: with SMTP id c19mr735672oib.96.1551378298467;
        Thu, 28 Feb 2019 10:24:58 -0800 (PST)
Received: from localhost (ip-184-203-129-180.hstntx.spcsdns.net. [184.203.129.180])
        by smtp.gmail.com with ESMTPSA id q6sm5614273oia.4.2019.02.28.10.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:24:57 -0800 (PST)
Date:   Thu, 28 Feb 2019 12:24:56 -0600
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
Subject: Re: [PATCH 06/11] dt-bindings: mtd: atmel-nand: add sam9x60
 compatible
Message-ID: <20190228182456.GA21460@bogus>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
 <20190213085930.31578-7-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213085930.31578-7-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 09:00:01 +0000, <Tudor.Ambarus@microchip.com> wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Add compatibility string for the sam9x60 nand controller.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  Documentation/devicetree/bindings/mtd/atmel-nand.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
