Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26EFC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8726D2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578516592;
	bh=CkhtezZ3aI7W2ttzSwXUkCU/xpPlgbQ804mcJzg2vnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mgUJESDoqrafJFYB+gHMgWVFwwFpPO5yFAwzSQGEzKiR/gWI9lNlaOrX6704Th4bN
	 bGHBhgaEOuEsy0lgVjcnOWRhwWlL5tfYANtoWUYx5FIA0rYJZygMg6ZoKCBLrWwYae
	 d7ZWAABLQwhyOLDRpKjGkszMcUVGQu2OCkqcj5to=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgAHUtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:49:51 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37396 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgAHUtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:49:51 -0500
Received: by mail-oi1-f193.google.com with SMTP id z64so3939971oia.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 12:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y2blFDS/4xPh5DF4rW8+xU8LHc7BSZTKgnRIfuXGUCs=;
        b=pmtQC84V4vORsY8Przux8Hpue4jzbA1N+ec1YWtH4/B4sN2AtwkPz6N3U5N9VBOdjX
         qPSV7CrxrNHzKrRPgr7VAbaFmvVBSO953rni1w+Uqb3aVZWSAR5QP6AZ1O5N54T+OLga
         WRPd3ZxXSp1CPSjoOB40MLr0aTUiQHd7lRvHVk8Hv4xWKjr8mkQmhgglKP5vsb4/es2g
         JqV1DBd/L6MV0Gio6yvu2wpwz8vOCPjSXzQ5oNACk+3exbm6WSt/R3zJHp1Yuwj1kzrS
         og+EM5MmqOiqQWUnD7BuMmWUZgzsmziQzjaRG1/WwWowNrEBcW90rrHGVI/8FtkRodkJ
         8mLQ==
X-Gm-Message-State: APjAAAXbf/nR3hAZ2F4h7R9xnNpnxy0UJCRLIyrz6ZIi0oLkPmthbth/
        atDsfZiD6ULaMTh1nWEhqhs0pdA=
X-Google-Smtp-Source: APXvYqyKHW/rcfez92QXCybrOC8olgCUVILqC8E17++rJ3IB3UYBeu+SUJdOz3FLBF2z/Rij9H0ZBA==
X-Received: by 2002:a05:6808:53:: with SMTP id v19mr455572oic.18.1578516590027;
        Wed, 08 Jan 2020 12:49:50 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q13sm1511630otc.5.2020.01.08.12.49.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 12:49:49 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 14:49:48 -0600
Date:   Wed, 8 Jan 2020 14:49:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org,
        hminas@synopsys.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, m.szyprowski@samsung.com,
        amelie.delaunay@st.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3] dt-bindings: usb: Convert DWC2 bindings to json-schema
Message-ID: <20200108204948.GA9782@bogus>
References: <20200107091630.12796-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107091630.12796-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 10:16:30 +0100, Benjamin Gaignard wrote:
> Convert DWC2 bindings to DT schema format using json-schema.
> DWC2 is widely use but a couple of compatibles and properties
> (vusb_d-supply,vusb_a-supply) were missing in dwc2.txt, the
> patch add them.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> CC: Minas Harutyunyan <hminas@synopsys.com>
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> 
> changes in version 3:
> - put Rob Herring as maintainer
> - change the example to use one of the listed compatible
> 
> changes in version 2:
> - put Minas Harutyunyan <hminas@synopsys.com> as maintainer
> - remove type and description from phy property
> - remove description from compatible items
> - simplify samsung,s3c6400-hsotg compatible handling
> 
>  Documentation/devicetree/bindings/usb/dwc2.txt  |  64 ----------
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 151 ++++++++++++++++++++++++
>  2 files changed, 151 insertions(+), 64 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/dwc2.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/dwc2.yaml
> 

Applied, thanks.

Rob
