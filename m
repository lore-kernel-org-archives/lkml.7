Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDB6C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0917D20650
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567776878;
	bh=ZL7K6EY/Tb5BCpmLi1+uFwypuJTHioF9TInqvs7lW2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hn8kh7YrfJ2QO61fWWUoo5RFHNFgOmzOP5ensjpGvOW4/ZuxCz7uv+bmYIW3/udH1
	 Ln30bQw4wUFkF6F/hxBvKB0QSBmBvFGbYloeFUV/OvPhe7jXEa1VXSCymLHV94VYq+
	 siaue4azDdafgCe07JCtG6Pn4sYBHBf158E4WlTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405150AbfIFNeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:34:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45158 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405138AbfIFNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:34:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id l16so6570829wrv.12;
        Fri, 06 Sep 2019 06:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+3PJsjCXNDOqrcoh72izbEswidXP+TmFzzy5ZV1VQY=;
        b=IC7ehVCV7D7FEifGRfAf5mdGasd6YA8Zur/6SWPWfT+JgDmf5V23z6pfOhYMfotZZ/
         K1dO5Vh66pauhjm7J7w+1ADVcxkCdZr7mJAZJ/PHNxB2Nf/dT/WPbfwPQ3j/BQJfEe8+
         B/1Myb9ozH4Qnw3dzNZpEQYhoAA3ykZ+rKXgjsI35bBd+MhFVl6Wg0yBN9eMvPh2uqFe
         MT4dUH3+uNkyIXiczuqVCVexDmR7d9Xl9pu0LG3D9GRoUmjV/gYrTQGB0j1UkSKLcYQ2
         lNRcgO8Py6vNsJTYUcpZO0jNHjFthENB66aeygDOkyRXK6BNA/ax3gTtjsM3mmGpLSUv
         CYBg==
X-Gm-Message-State: APjAAAUlrnrqoyCLJz6hUjMXeqFZ4L+kRFT8ZleSBDMo/vAl1sRm0Dxc
        BSzg64Of/tFVDFeKNmTfS8kpV1xgrA==
X-Google-Smtp-Source: APXvYqxo3CRRMOOb/pXKjiUP/AwCwS3zo+BXCHzRBhu63dJyJ5P8p6QXvaweU7/OgZXu/lRKNT+2SQ==
X-Received: by 2002:adf:e605:: with SMTP id p5mr7067657wrm.105.1567776875251;
        Fri, 06 Sep 2019 06:34:35 -0700 (PDT)
Received: from localhost ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id n8sm8986763wma.7.2019.09.06.06.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 06:34:34 -0700 (PDT)
Date:   Fri, 6 Sep 2019 14:34:34 +0100
From:   Rob Herring <robh@kernel.org>
To:     jamestai.sky@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        CY_Huang <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>,
        "james.tai" <james.tai@realtek.com>
Subject: Re: [PATCH] dt-bindings: cpu: Add a support cpu type for cortex-a55
Message-ID: <20190906133434.GA3272@bogus>
References: <20190905081435.1492-1-james.tai@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905081435.1492-1-james.tai@realtek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Sep 2019 16:14:35 +0800, jamestai.sky@gmail.com wrote:
> From: "james.tai" <james.tai@realtek.com>
> 
> Add arm cpu type cortex-a55.
> 
> Signed-off-by: james.tai <james.tai@realtek.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks.

Rob
