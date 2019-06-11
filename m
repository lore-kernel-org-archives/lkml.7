Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B5C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547DB20896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560290159;
	bh=d9lEGvRP+Vgue3cmiL6Pop1k22/seNQuJAFNwEk415E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JvwyGSBE8f3/GwIM/XGK6cxn5tbQHbgS2aP13o8wu5iTamDoHqifkkFZmlQV+v6IY
	 pp+do8nmjTPhrAe1f1LXuMfT8FRmXvFabNbKl7EHf6AjeLeU45YUKCdVnzzkP4Jx4v
	 1pIHVbLdS2kgRU6g83VQwoPd4DGg6jG02Z7zKeuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436691AbfFKVz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:55:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38913 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436639AbfFKVz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:55:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id i125so8695946qkd.6;
        Tue, 11 Jun 2019 14:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sPtz3BqdiTBkbWwtR0/UrKDxgV+sZMQrD6twsVTFc4U=;
        b=FO4jG95hIhQdH0bePJ1+glQ3RGN+XZEO2kRywb5ZBdGARGOV38zjVxdF3U/DxGWE1t
         QL0jYu6Dt4nd9pIjKlimjCjVmt/qgmcDduZqXjVnE13em3bdjfKINC29oR61SPRPv4PU
         Cycvbb8naO18x/Vvzb63NQvngmk/oCbMfKwX0qv5nKw72tJ++EoULEAEcoYYwFUSsRCo
         R7PXi0bunWp4/wJnzrrPDI03UQAGf7zY9dYpom3l4EszkoCLGxIl1LxHCMo9vLxwfAES
         71I8ZDn8UI6QCPuGYRziF/h84daxaNjadVB/eeaNbu2w3l9qAajnZ5BPsAKR41qpZ36i
         TwrA==
X-Gm-Message-State: APjAAAUwmQIMxymuZ5yBBRLDR55wP1oPFEY6BImGHbzOjfLAsaHMb3nw
        V+0zQhf88dycukJzEd458Q==
X-Google-Smtp-Source: APXvYqxzcnLdJ4B7Arm6EZke3/gqxzSlYdTwCd01UFloU9lha7IwBhMaG2twe1MNISi/vJK4eDe/aw==
X-Received: by 2002:a37:e402:: with SMTP id y2mr42991762qkf.200.1560290157124;
        Tue, 11 Jun 2019 14:55:57 -0700 (PDT)
Received: from localhost ([64.188.179.199])
        by smtp.gmail.com with ESMTPSA id i30sm5956849qtb.18.2019.06.11.14.55.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 14:55:56 -0700 (PDT)
Date:   Tue, 11 Jun 2019 15:55:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v5 1/2] dt-bindings: Add doc for the Ingenic JZ47xx LCD
 controller driver
Message-ID: <20190611215554.GA23791@bogus>
References: <20190603152331.23160-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603152331.23160-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Jun 2019 17:23:30 +0200, Paul Cercueil wrote:
> Add documentation for the devicetree bindings of the LCD controller present in
> the JZ47xx family of SoCs from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> Notes:
>     v2: Remove ingenic,panel property.
>     
>     v3: - Rename compatible strings from ingenic,jz47XX-drm to ingenic,jz47XX-lcd
>         - The ingenic,lcd-mode property is now read from the panel node instead
>     	  of from the driver node
>     
>     v4: Remove ingenic,lcd-mode property completely.
>     
>     v5: No change
> 
>  .../bindings/display/ingenic,lcd.txt          | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/ingenic,lcd.txt
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
