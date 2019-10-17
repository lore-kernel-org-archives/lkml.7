Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019E8FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24BA205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571324075;
	bh=9aNXu7sSqm6SfsQvO/5UKy1b0Q4PhG+CQiXHYiePZXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g0KXHhlzUcxkKz2T+B9WMn0sUF29cohLsCSiuiKx/U760cO1CfflA8V8xrs0KT+XP
	 FYjqj65Vem0OP/LCsBRj2u6SoC/Eo194vq8fIRm1qhs2Wtg+UNkZmxokexVc7pdUTp
	 bfZY8qWs2nsJUNso2KSs+Ic+doSXOws6zo7gFz9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406544AbfJQOye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:54:34 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43441 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbfJQOye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:54:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id o44so2119328ota.10;
        Thu, 17 Oct 2019 07:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vmEL+aVwCsIoViTesPqeNpAnUN/dNdhAL17C5jB6yFg=;
        b=r5O/uueikEyW4ZQfl2cyaLuHVwJoj0KPVgnGbPIzmXfZ+sgv1Rsktza60WyIfqCkSm
         fB99JGKYLvpgY51UfKIr+xojumaZMYJrHDPcLnBLJnIDlS1ON4gH1QDnIaaQYWd0G4Ox
         CXdxx6H0GfYYczZJ/Ceu9SXuOa+ZBgf+DK9m2ewG52+Swl8Ygo+Hnf7YwDiBdQ+uYMN/
         vePPnvArzDw+MaVKn6AJcFSYb98KPOuOvLTdIF8ddB4vtcM6Xo8oOrBNhRIBIqyz+JQn
         i9x7oTaR8pP2SWx4j9w5md+zCLKLPhe5iBiPpNMwN/geuk6K/Ua7LjWf5C8yutXCF967
         DejQ==
X-Gm-Message-State: APjAAAWfFDe6XLms4JFxpRKG1yVJzMgvRmJwlqW3D+vYT8DJEzNLlT/F
        sPimPdoZqzcl3AX5qUbAuA==
X-Google-Smtp-Source: APXvYqwOvcqvqelTHOl4LKB+YkyfKUETgXNKFuGCWZWNe5iyOkYg/INqC9uhHB2UVUyPWg2ZYUddug==
X-Received: by 2002:a9d:6452:: with SMTP id m18mr3405400otl.325.1571324073123;
        Thu, 17 Oct 2019 07:54:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j11sm640819otk.80.2019.10.17.07.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 07:54:32 -0700 (PDT)
Date:   Thu, 17 Oct 2019 09:54:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biwen Li <biwen.li@nxp.com>
Cc:     peda@axentia.se, leoyang.li@nxp.com, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [v3,1/2] dt-bindings: i2c: support property idle-state
Message-ID: <20191017145431.GA30799@bogus>
References: <20191016040920.8511-1-biwen.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016040920.8511-1-biwen.li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 12:09:19PM +0800, Biwen Li wrote:
> This supports property idle-state

The subject should indicate this is just for pca954x.

> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v3:
> 	- update subject and description
> 	- add some information for property idle-state
> 
> Change in v2:
> 	- update subject and description
> 	- add property idle-state
> 
>  Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> index 30ac6a60f041..7abda506b828 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> @@ -25,6 +25,8 @@ Required Properties:
>  Optional Properties:
>  
>    - reset-gpios: Reference to the GPIO connected to the reset input.
> +  - idle-state: if present, overrides i2c-mux-idle-disconnect,
> +    Please refer to Documentation/devicetree/bindings/mux/mux-controller.txt
>    - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
>      children in idle state. This is necessary for example, if there are several
>      multiplexers on the bus and the devices behind them use same I2C addresses.
> -- 
> 2.17.1
> 
