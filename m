Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74367C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4680121655
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566411763;
	bh=cLHyExjzb+FwX3g30r9tIhmEv3tAxeOHhczvRmlL43s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2jvPttXCxpHQmwm1vilwniccGOcfkDSZJom/eOLzuU2Ih+tyrrV7E4UbpZ10FLGgo
	 8iFcJZ5TU5fntiyMT1e8/KTT37fQ9WkcpfAWRCmi7ww3SUtpuBsZ9s88CV8sU9H2FV
	 qEOnZLffq7YRiocoH7k42KPK3oCX9RSsaGfQ7SPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfHUSWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:22:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43192 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfHUSWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:22:41 -0400
Received: by mail-oi1-f194.google.com with SMTP id y8so2320740oih.10;
        Wed, 21 Aug 2019 11:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=24bxusEy7OGK0yD569NBwn/iQPay+uifjMYbDYpvsFY=;
        b=IgxmilMM7XW+LKjNNz/5YqDHZaX8FeWXmTy/GFl56tzjm5WjYdDdJm76mCQfpOwxC6
         s8uuOc7VNjyx4imIUNtV1EN1RAlEJBkwNveYsZCaWpLxu9+txP5SFuP/BJBM3fP8ed7a
         VaQHiNjTtAFIVV3QggN9n+o6t+oCQfzXQi15Cb1Lojf5EquqP8dFfmx6T7GkOn39+5dN
         9y9j3U1A52aZcJZdDGxtSS53kJhbCZuWo7hfjLbVsuo82wFYjXgjYcge6OpVsSnfCzbC
         nYe+mMXFyKVIhYtp79zTwY3vQAPIS0JOz7ohaKOM12gBcSnzKUpinyqkfVFRD0/rzAV5
         fcrA==
X-Gm-Message-State: APjAAAX7fiU37ykDCnhDmypGk/AmhIwI2zPgosJdY2jVpJzHa2neEvpe
        w6dm7G/8wtJslr667FP7fg==
X-Google-Smtp-Source: APXvYqyLyQNfTVZJAKDfvhBkeGQm8bVlglybzAEDYd7thHFToO2QW74A/RKErYiojY/6bQytG+Mv6w==
X-Received: by 2002:aca:ea45:: with SMTP id i66mr1042078oih.17.1566411760576;
        Wed, 21 Aug 2019 11:22:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r125sm6654866oif.3.2019.08.21.11.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:22:40 -0700 (PDT)
Date:   Wed, 21 Aug 2019 13:22:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: usb-xhci: Add platform specific
 compatible for Stingray xHCI
Message-ID: <20190821182239.GA5760@bogus>
References: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
 <1564568395-9980-5-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564568395-9980-5-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 15:49:54 +0530, Srinath Mannam wrote:
> Add Platform specific compatible, because xHCI of this SoC has an issue
> with HS port which has to reset on disconnect event.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
