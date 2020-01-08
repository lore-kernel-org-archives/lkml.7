Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EE0C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F273120880
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578502729;
	bh=ev4OtAv5m7KBEoeVj5ulwIojbIh9mARQUXB6SdZeY1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mZbgjwjf4mbsdo5TGDHO9ula9bIh9XrzyVEhWNRt/wQnaYuCyaOe1DW+Nsg76Zp/u
	 tkPW33paEPWuI6iTC+JXeHYuaIl1JzBXXOptXPsra9vQjDEfIBCVr4oavwbwopsXPH
	 TrePPmjQN/poiRRL4lqzTVs6tfM/pK6OGavl2y1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgAHQ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:58:48 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45543 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbgAHQ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:58:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so3195964oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:58:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TEWqrKckxXi7QmpFNDQI2lr/8vlOr4RUJSG6WcBUQm8=;
        b=Mun5Ycx9Ta8NdTSMYQZDWQlXYAAU+9t6Y3rmrf582ZZDERua7oLJRs2/JgU5MeizVJ
         MJpJcxH5VuoRQrm8qp/X9408iwr0ot9MxszYZnCcll8GJDiRm/va3AZUqEzIXkG7U1nj
         QMMWMt+RBfdyuVL3Z4mzywjpWsgqIPP+m6Kc3pfS/q++q4AGBkhUeRax88If9XpVZDAi
         spEb+xQnI5TIDSH09z3m6V+u9URCZQAFOdaAqz3jHDF44gRr6quPBz7d+jowv5nQI/r3
         c1KyNaIHBVWn+0CNBlxTricaE+fOCeJYwxe7v8VrXOmHb1t80S+Zdk/VvF3Ja0g1Safp
         vgQw==
X-Gm-Message-State: APjAAAUBL+lYD/wVduBfYKFx57Yn66CBl3/eXN9PgnuronLmgg42x456
        X9uie/hq5XS3py99mY96eUu8nps=
X-Google-Smtp-Source: APXvYqzF7jj1fQpDwfgrousSnrWTkzLM/X96frmc68A1q7iy5mqARNoJIIA0WKKcxTauk8t1vBQG0A==
X-Received: by 2002:aca:5fc1:: with SMTP id t184mr4124043oib.20.1578502727125;
        Wed, 08 Jan 2020 08:58:47 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a19sm1283259oto.60.2020.01.08.08.58.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:58:46 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:58:45 -0600
Date:   Wed, 8 Jan 2020 10:58:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: iommu: Add binding for MediaTek MT8167
 IOMMU
Message-ID: <20200108165845.GA8360@bogus>
References: <20200103162632.109553-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103162632.109553-1-fparent@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Jan 2020 17:26:31 +0100, Fabien Parent wrote:
> This commit adds IOMMU binding documentation for the MT8167 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iommu/mediatek,iommu.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
