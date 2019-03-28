Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D5D20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553795016;
	bh=DrioiL/NfOqrAhR6e80dQlLhHcizU97EXGw2xBpbXJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FpQbCrJoS49ow3nFDz++vfCicfYv95H9bD8wyWJ+p8SilS7KT6YOV8JHOlW55nG44
	 srEt9lX1Sd6u0GoVls6UgLOgU1YzzGPMD6Z1M8S51+lENs2iaSfgE42PpaqKBpCi1I
	 TnR9r0rInXO6K5sH3y1RinmYdQGcRLfzyHMkijKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfC1Rnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:43:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34191 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1Rne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:43:34 -0400
Received: by mail-oi1-f193.google.com with SMTP id v10so12115951oib.1;
        Thu, 28 Mar 2019 10:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w4+jBZt7o1i+BXiFGlj5UO5y5/Jdo0fIZ4a8M49K9iU=;
        b=BUxtKcZMw/KmUoELdx1IM5CpEN0B82Z/WwT+5l8PPhagX682h0Y1Ic/awZV481dyjq
         DbyJLhh47g11qJJ3tpOP1CHqWJa9Bd5ilfrn+0qlSDUa3VZKtosjdjPoHZEQMLiPuwg4
         vb5Ucw76xgY4CO+vVKMY2BcsIucBG40tI/5ROBf8r7Gg4NEqur+X2L1MZhiGxq2bvGJD
         DhBrW8WegHlEdhfANAIhmAAh3xjTHRrcDpV416VYypmfbZohgGHmilhVQUUZ9ujNgS+W
         o/fmf28HDBNHjzDMD+bJ2Ie6fMZzPgbqEhfz4dG4+6mBiscvkRZ475waOiRyzmzKmbO3
         SuWg==
X-Gm-Message-State: APjAAAVo0KGlq4b888XFbKBHjQDNYR89hZMIPmpcrsuSJsGnfnqvS6hO
        XsZ81MEh+MbpiVfoHjPfjg==
X-Google-Smtp-Source: APXvYqzIqPBrm/eLCUsulqZbE6h9iD2WITqW648w6PGNZdZVn2xj2xxu/wqf6vkBM6oREqCcsSWuWQ==
X-Received: by 2002:aca:5757:: with SMTP id l84mr898126oib.155.1553795013342;
        Thu, 28 Mar 2019 10:43:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j14sm10841205oih.28.2019.03.28.10.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:43:32 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:43:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mickael Guene <mickael.guene@st.com>
Cc:     linux-media@vger.kernel.org, hugues.fruchet@st.com,
        Mickael Guene <mickael.guene@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: Document MIPID02 bindings
Message-ID: <20190328174331.GA5863@bogus>
References: <1552373045-134493-1-git-send-email-mickael.guene@st.com>
 <1553680545-73278-1-git-send-email-mickael.guene@st.com>
 <1553680545-73278-2-git-send-email-mickael.guene@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553680545-73278-2-git-send-email-mickael.guene@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 10:55:43 +0100, Mickael Guene wrote:
> This adds documentation of device tree for MIPID02 CSI-2 to PARALLEL
> bridge.
> 
> Signed-off-by: Mickael Guene <mickael.guene@st.com>
> ---
> 
> Changes in v4:
> - Fix and clarify endpoints properties documentation
> 
> Changes in v3: None
> Changes in v2:
> - Add precision about first CSI-2 port data rate
> - Document endpoints supported properties
> - Rename 'mipid02@14' into generic 'csi2rx@14' in example
> 
>  .../bindings/media/i2c/st,st-mipid02.txt           | 82 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
