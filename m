Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24220C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF821205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552407179;
	bh=th9PLZqRDGtFzkxzQKSlQn15coZBkVsCB5zKsLmuAwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lJaRxhFSsXM9OGYxvntvIJqNZjEc9KZfaOvqj6RMXhvq0dqQq1wG1WtYzKg6wKY4o
	 UGp9TqzGzXmNE6+m+rhWqUQSuxhi8rh04+OT7ubNIunwvsKwhdUQYti3FGlbFtEf9/
	 5d+imw43leOBh0hjHlMjJ5mOxR1h+04hQNFvaqkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfCLQM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:12:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41326 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfCLQM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:12:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id t7so2970029otk.8;
        Tue, 12 Mar 2019 09:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/lDNDcIMDtu13wO7rXHJmZjJcG14VH5l+2k1WNw0d0=;
        b=NuRbzt8jE869rb1okIwtxV8+kA8mr1G62wmypY7+1LtTtz5avvDBBrtUG0Bq9fsbZG
         68Oq3S32IneGAIqfNDyy7R9C64cEgiQPY2+NFVyNYtpRuMZa0rPPSZ22Nk17xP3N+Ztw
         OyuK87K0XneUjmsnisuh5DGfU+vR9rY2Iw0VyDp4ru9+At6ME4S1LQcEEoOwQ4IYqiEA
         JQwUuvbEqO8uG9eOAMO5bI8otdlzznN1IYnq0B3jM973m9UrGO7RPSLte0p1qXv/97/N
         UCpRYzvyZ1W15xtJ/5ZlzhYiAnsAaXKDsbHTf0bfoO6a8+d4osKFpqfcMy0WNUMhvmMG
         OQEQ==
X-Gm-Message-State: APjAAAUiykdIG9zou9ocfq2BR1C1SnW2ZTCO7wGwBE2bIcpXdk58BLHO
        faPqJzHztXqpfdhNu1jW3w==
X-Google-Smtp-Source: APXvYqzpNJxswLZ0KboFwW3OKMWz1xgCn/vRQF/Pqd19jUGDCytyEgcVOz/etbqm/DnQu07r/RdZ6w==
X-Received: by 2002:a05:6830:1053:: with SMTP id b19mr23230992otp.118.1552407177081;
        Tue, 12 Mar 2019 09:12:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o67sm1085453oia.9.2019.03.12.09.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 09:12:56 -0700 (PDT)
Date:   Tue, 12 Mar 2019 11:12:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        alexandre.torgue@st.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com,
        lionel.debieve@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: nvmem: Add STM32 factory-programmed
 romem
Message-ID: <20190312161255.GA27965@bogus>
References: <1551349196-8956-1-git-send-email-fabrice.gasnier@st.com>
 <1551349196-8956-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551349196-8956-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 11:19:51 +0100, Fabrice Gasnier wrote:
> Add documentation for STMicroelectronics STM32 Factory-programmed
> read only memory area.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - update "st,stm32f4-otp" compatible as discussed with Rob
> ---
>  .../devicetree/bindings/nvmem/st,stm32-romem.txt   | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
