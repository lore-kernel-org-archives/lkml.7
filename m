Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25CDC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE0620815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569937219;
	bh=BuBmuD+5RGgV+7Dhg8hoCJxHnR5ffSM4Man+WZ6uLlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0GV4c2CoqoT56c93IqrySol61J6aoKXF2p6IRZ1Tcl7p9twDc1+DYqEW1x6T0rmBV
	 VED0+tlOH0wyo9VORX/i27Di6XdHJir+++TWRU++p6ie5qAUFPVkurpKmQ7CckNR5L
	 ZhnoiSb11t6oADZ9jPZgHyoF7J8jx3G7mNZHkfa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbfJANkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:40:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43764 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfJANkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:40:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id o44so11541254ota.10;
        Tue, 01 Oct 2019 06:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RRxXkYDzpzlrr/tDILnG8r36TRW5Xy13NIZlvuuvkiQ=;
        b=lJ1AJsOwimPuLaJRJrTKBCs5yHO5fyUby4K9mmhIIWYv9WHCdGjU3ppL3m1Owl/zJ0
         KTTxbXOJgc0VgnVepNH5Gp7TdZw2FrGcm5zntoO8kW316WW2K0gco1of9EYjaCUOWitr
         wpAhHfKDKYvYO8p6othH6HXc6izH2UCuiAXluTwaPehSBX1Ci3ZanpTCDPFOYJm9uJjv
         yVZ605rGdRedXY5BUdc6Fl3gwmDsNemBLh9eUAqLJfLJzrLirB43rEGcai9O8SWT9Mhp
         6+S47MJZVdlzB9iTZ0YhyVBHr7X2C49TmpyEEmbCUSlZUaTeCWZ7VAo0T2ay8TA2su5h
         k+ag==
X-Gm-Message-State: APjAAAWZjcAeVGGqr3geRdP2zhPEGE12YyMOyZibvJG9Hg7F3G0UxjRd
        8f6wS120oqrEQyFt4Ubw0+eZquZJpQ==
X-Google-Smtp-Source: APXvYqwUb02Vu3JscuilkyKSKf28VLZQTBxrRbadkw9MdPRbxMvGaIb3s6X5fPeWVEthd9PTbxPlqw==
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr17263269ota.41.1569937216470;
        Tue, 01 Oct 2019 06:40:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t12sm4622067otl.35.2019.10.01.06.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:40:16 -0700 (PDT)
Date:   Tue, 1 Oct 2019 08:40:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: dmaengine: dma-common: Change
 dma-channel-mask to uint32-array
Message-ID: <20191001134015.GA14840@bogus>
References: <20190930114055.29315-1-peter.ujfalusi@ti.com>
 <20190930114055.29315-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930114055.29315-2-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2019 14:40:53 +0300, Peter Ujfalusi wrote:
> Make the dma-channel-mask to be usable for controllers with more than 32
> channels.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/dma-common.yaml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
