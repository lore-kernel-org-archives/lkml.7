Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2896C2D0D1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993C3222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576800064;
	bh=YSxFiz0PchVKuc7L2Gj89RDgVqtUUuac8sdiWqu/6FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IQ9hkK/9Xcp5OPykis01IistafKCIti3dWf7M9Fc7ClkLVJr6dKZd8AFocIsHhJDz
	 t6OrwOm0wmr2K4s+2A2fLgYn9FTCUNgUYZ0lMB1jrf6dq2oHLPiYvDEDV4Kx3+cAqF
	 w5OcO/eoQ6T01eMIx70EJWZGeRuVSu4A1LHxlGhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfLTABD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:01:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37091 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLTABD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:01:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so9407305otn.4;
        Thu, 19 Dec 2019 16:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ixxxBsIzEckZyMKz6FP9blKKJXoRngv5HsAGvReLZD4=;
        b=rkyHf9VrnzV+dTlmOUUaZNDYE2iWXwyf7a4/0fizOECKxqGYrP+RnJr4+lAaKBIMBH
         PC95pumHpWeG3jVzepJ7EKCcFX9ZgH03a4BkvOqg97fV/+q2U4g8W4DjlTORD5vKmh8d
         5/vflJRjtwcMBs/Cxj9Ic6KAYJZ9DvHzbw9B3mQDsFAizm+McprG3RL/x+kS2Bjss24c
         xAEJIsTbXc8Z25+3WJzgg49FYghI8jcPDaJFGPng40M560POo7F4Dw2xtJFyKKrmqmma
         NgGrORfZjEx17f35HbYarjbj/iPFGEGJlUJLgbFNaIdSXdEPjPxELAAkc37NVdGXUzpa
         weCQ==
X-Gm-Message-State: APjAAAXOXxSRyGUkULx8rdt0WTDaI8z6VDASGVMgUpKfHyaAEOFU9Jnq
        eZu+AFIP79u677En67c2jQ==
X-Google-Smtp-Source: APXvYqzEJwtRPN0UXZ/xR2ptdwnUmxXBKOPtOTRVoyqaKCSz+7WnsyzpWFMgdicP0Vvzr157+uUKXg==
X-Received: by 2002:a9d:6a5a:: with SMTP id h26mr11893681otn.103.1576800062626;
        Thu, 19 Dec 2019 16:01:02 -0800 (PST)
Received: from localhost (ip-184-205-174-147.ftwttx.spcsdns.net. [184.205.174.147])
        by smtp.gmail.com with ESMTPSA id l128sm2541590oif.55.2019.12.19.16.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 16:01:02 -0800 (PST)
Date:   Thu, 19 Dec 2019 18:01:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     openipmi-developer@lists.sourceforge.net, mark.rutland@arm.com,
        devicetree@vger.kernel.org, haiyue.wang@linux.intel.com,
        minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        robh+dt@kernel.org, joel@jms.id.au,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: ipmi: aspeed: Introduce a v2 binding
 for KCS
Message-ID: <20191220000101.GA16104@bogus>
References: <cover.fe20dfec1a7c91771c6bb574814ffb4bb49e2136.1576462051.git-series.andrew@aj.id.au>
 <8aec8994bbe1186d257b0a712e13cf914c5ebe35.1576462051.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aec8994bbe1186d257b0a712e13cf914c5ebe35.1576462051.git-series.andrew@aj.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019 12:57:40 +1030, Andrew Jeffery wrote:
> The v2 binding utilises reg and renames some of the v1 properties.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> v2: Rename slave-reg to aspeed,lpc-io-reg
> 
> Rob: After our discussion about the name of 'slave-reg' on v1 I've thought
> about it some more and have landed on aspeed,lpc-io-reg. In v1 I argued that
> the name should be generic and you suggested that if so it should go in a
> generic binding document - I've thought about this some more and concluded that
> it was hard to pin down exactly where it should be documented if it were
> generic (the generic ASPEED LPC binding is one place, but that would suggest
> that the property is still ASPEED-specific; maybe some discussion with
> Nuvoton might give some insight).
> 
> Regardless, it turns out that the address specification is really
> ASPEED-specific in this case: The KCS host interface in the LPC IO space
> consists of a data and status register, but the slave controller infers the
> address of the second from the address of the first and thus only the address
> of the first can be programmed on the BMC-side. ASPEED supply documentation
> that maps the LPC-side register layout for given LPC IO base addresses. I think
> this is esoteric enough to warrant the aspeed prefix.
> 
>  Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt | 20 +++++---
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
