Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B296ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D935F206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570805088;
	bh=b0TeRaA2Z1L1IRbscM7IdWaz2G4DgR2SWsjbqEMhuQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wcce+OezaVGZUEw+EP8pm9Pf2O8FryWskBkBOqnGZMwxn4FtxIp2M7NxJsQoaMYbZ
	 vFD/B+zhoda7dNjjAmm/ert3LbzRar3PH+A/9a39UfYlZ3tY9wO/gZp2GSONgngFwX
	 5sB4JnmzUVS8748PT+QZ/HTZjI8TqUArttBzz2MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfJKOor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:44:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39979 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfJKOor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:44:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id y39so8161885ota.7;
        Fri, 11 Oct 2019 07:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=phJrdsvrMRbz/mV66eCzb3QAhHr1D1SaioSI8xCNhC8=;
        b=aBdi3g4gEJu75zGI0cr+jmI38y+U8zShmU8Dyh6SMtJdAu1zDtrJZq6A25cKnAfPFY
         uc/WX5LQwV9GCOlGxbAsib0DF2sPJ029/O2StwAMXts6Y4wEEbL11AfsLQevV2zEMKI8
         qw9yy+vYosLBy9SPZByJgfwwJXs/wXzw2w/uFMl6mxUA6FKlS6yWspjD9bpPdKpH8Msy
         5dsuGWU6QhpjESFh+XG9ehc6p/aoxfPIX1FYghdifb9NEAb3hMfJ6xHhciiKEpZTvNOk
         UbTKSn1a/BuN43nwX2EIk0vueBZpVy+bKqMEfmMJCZFBeZ6dtx2zFfbvTuQ0KMxf8zSW
         e20g==
X-Gm-Message-State: APjAAAWedcmz2H1gbutwuy7rPcpkOs9iCYjKMi/7RA+H1fmkJYk3yRsK
        2YwMiTKBUPqhUi/OPNlNvTLiO7k=
X-Google-Smtp-Source: APXvYqxkYBd0e9PRpOsG2+jeAtb9kPih7R7dN+N+CZabl/97Cin9YxLSpFF7SMhUpOReyysHSoilmQ==
X-Received: by 2002:a05:6830:11cc:: with SMTP id v12mr12320371otq.362.1570805086355;
        Fri, 11 Oct 2019 07:44:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y30sm2787225oix.36.2019.10.11.07.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:44:45 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:44:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biwen Li <biwen.li@nxp.com>
Cc:     peda@axentia.se, leoyang.li@nxp.com, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [v2,2/2] dt-bindings: i2c-mux-pca954x: Add optional property
 i2c-mux-never-disable
Message-ID: <20191011144445.GA2340@bogus>
References: <20190930032503.44425-1-biwen.li@nxp.com>
 <20190930032503.44425-2-biwen.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930032503.44425-2-biwen.li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 11:25:03AM +0800, Biwen Li wrote:
> The patch adds an optional property i2c-mux-never-disable
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v2:
> 	- update documentation
> 
>  Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> index 30ac6a60f041..71b73d0fdb62 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> @@ -34,6 +34,7 @@ Optional Properties:
>      - first cell is the pin number
>      - second cell is used to specify flags.
>      See also Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +  - i2c-mux-never-disable: always forces mux to be enabled.

Either needs to have a vendor prefix or be documented as a common 
property.

IIRC, we already have a property for mux default state which seems like 
that would cover this unless you need to leave it in different states.

Rob
