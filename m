Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882DEC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECED2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557761293;
	bh=TOgcNga7w4SAF52kDs6FtawVO6BjIetmbqaUftHi6Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jatlHOcJQThuPEB7pSMsOnNRQBaOD6ata9Wh9X11GKWyNn2QWqip30F93eCPBrydv
	 7f05WCs2Z8o1Ctj4VkDLpLbrBHqecSEuj8EQrHvuTf+t7k/NV+o6Tk60Ci0EoaCeyd
	 qs2wUAUjNX8VejO5lFLSKiLQ5y7uhdE5XraH20uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbfEMP2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:28:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41618 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfEMP2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:28:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id g8so12119150otl.8;
        Mon, 13 May 2019 08:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=erjTI6eG9SyW0rfn2c4BFHN5r2eXk7Loba80RrzT740=;
        b=b/xDzWEb3PZB9KLSuxcRqSuBAIB+rFSpUuSkkyREH/oPSJVq5LdU2xupLc+IivPNtK
         J5Gj0dPV13dQkQXQqwqz3UUm7/9SYdGlxt/q+K36GebmINPMI5aaZVZLnRsfsG1SzAxW
         kHLD4ss1NOKly/NSjJiHnJaX6e9hl7GMNw7xThlt32M/3pgBi7ferJaPjV3Wr31x8Irl
         2QB60lDyey/a0/xl2NZX45J7M5XmWzgCffj2/KHGDcs2jXp/vE25xPycOHdPymK7nuTB
         A6Jw0A9kQm82coQmvrBySO8cWoVrGPaLRd67bUKk0GKz5t4zf/kUcYfj+0B+N5acRAOP
         /0ZQ==
X-Gm-Message-State: APjAAAWl/yGb+HI2oMJWbHko1+qr4/lH9YlqiECd4wL3omwQzkUJBQNE
        DMxTA4BzvyzZsqElrwW6fw==
X-Google-Smtp-Source: APXvYqzDLdKY3K7TQEkkzjYV6fUd9fFK/P6MrGXBIn6DbJSzv7nQ7usMzPtmE/GOn4buxfVLMjxXQQ==
X-Received: by 2002:a05:6830:14cd:: with SMTP id t13mr16704956otq.25.1557761290915;
        Mon, 13 May 2019 08:28:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d70sm5923986oih.18.2019.05.13.08.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 08:28:09 -0700 (PDT)
Date:   Mon, 13 May 2019 10:28:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-mtd@lists.infradead.org, marex@denx.de,
        tudor.ambarus@microchip.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, bbrezillon@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCHv4 1/2] dt-bindings: cadence-quadspi: add options reset
 property
Message-ID: <20190513152809.GA28897@bogus>
References: <20190508134338.20565-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508134338.20565-1-dinguyen@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 08:43:37AM -0500, Dinh Nguyen wrote:
> The QSPI module can have an optional reset signals that will hold the
> module in a reset state.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v4: no change
> v3: created base on review comments
> v2: did not exist
> v1: did not exist
> ---
>  Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
> index 4345c3a6f530..b6264323a03c 100644
> --- a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
> +++ b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
> @@ -35,6 +35,8 @@ custom properties:
>  		  (qspi_n_ss_out).
>  - cdns,tslch-ns : Delay in nanoseconds between setting qspi_n_ss_out low
>                    and first bit transfer.
> +- resets	: Must contain an entry for each entry in reset-names.
> +		  See ../reset/reset.txt for details.

reset-names needs to be documented with the values and order.

>  
>  Example:
>  
> @@ -50,6 +52,8 @@ Example:
>  		cdns,fifo-depth = <128>;
>  		cdns,fifo-width = <4>;
>  		cdns,trigger-address = <0x00000000>;
> +		resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
> +		reset-names = "qspi", "qspi-ocp";
>  
>  		flash0: n25q00@0 {
>  			...
> -- 
> 2.20.0
> 
