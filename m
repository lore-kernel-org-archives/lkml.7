Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFFCCA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31512087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572445719;
	bh=oaYnZmZRcM2LsxNLwkNVfadGBs4Nk2Xwe92NDi411Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lEWvsyfgs9kiarQGnl0ftQ5oMCTLO1I3LYi8RugSawPz0PiLknXUR4uMl7WVcmG2w
	 /mrjIXsRY6GpFPa74SFXcbbrLCl735bmxqn+ePvME5g7GrCdGs7XxDBPp1Iu6JvBBL
	 Gu9pxbnssaAKuWpYF0+zVBON+AqoS1G29N6DG5bQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfJ3O2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:28:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40638 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJ3O2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:28:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id d8so2260880otc.7;
        Wed, 30 Oct 2019 07:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bW80wTMWJnpVpgOpjaVD9ZbgzCWI+5I23NN62yxmGYQ=;
        b=fnK7G1Kz7WG2ckepOhi9GGk24+jvK26CFJGo8+ffHBoEjt7DnEYlsXFJ99usDQTjoc
         QAR9BfNTOW6ehOKCZV5JPE3dzQHSlrvKKhvYZuex+SY8S0m7Zl9EGxy8RAPTzIARy1nl
         zzi/dUUgoH2MAntR5a6iVm1zpnpgtKHFvJ/u14QJYgSUwSDiQd3aMBNY3pzVc8tX8Exv
         YyuWfU6o5UQ8yx69sP+PzGdixmjqDIzGTaVYpdzU9yYquxQpDYW6+XFpp79uEJn0Cm4o
         OT1PcYYYSIy0gg76Qg94fT9t/hApigyxhhlzgFmMNWkZ8kfVVIkqARuB3UxA3VojOLYG
         MI0g==
X-Gm-Message-State: APjAAAUIWOeu0PotFoW/rhNkkCcgm8jUobXId5BebS7+uErukFuK8sQl
        rL1cmzIeXqa09Uf9DUOVGw==
X-Google-Smtp-Source: APXvYqxmqH9kTAnk/HxofrVjAyXVfX3xEDWkc4rGDKItWjGmqJb4+9InITGk7GXL2ERyL6kbU4blSQ==
X-Received: by 2002:a05:6830:128f:: with SMTP id z15mr109418otp.285.1572445717155;
        Wed, 30 Oct 2019 07:28:37 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r14sm55572oij.6.2019.10.30.07.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 07:28:36 -0700 (PDT)
Date:   Wed, 30 Oct 2019 09:28:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        info@logictechno.com, j.bauer@endrich.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: display: panel: add bindings for
 logic technologies displays
Message-ID: <20191030142835.GA31293@bogus>
References: <20191027142609.12754-1-marcel@ziswiler.com>
 <20191027142609.12754-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027142609.12754-3-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 03:26:09PM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add bindings for the following 3 previously added display panels
> manufactured by Logic Technologies Limited:
> 
> - LT161010-2NHC e.g. as found in the Toradex Capacitive Touch Display
> 7" Parallel [1]
> - LT161010-2NHR e.g. as found in the Toradex Resistive Touch Display 7"
> Parallel [2]
> - LT170410-2WHC e.g. as found in the Toradex Capacitive Touch Display
> 10.1" LVDS [3]
> 
> Those panels may also be distributed by Endrich Bauelemente Vertriebs
> GmbH [4].
> 
> [1] https://docs.toradex.com/104497-7-inch-parallel-capacitive-touch-display-800x480-datasheet.pdf
> [2] https://docs.toradex.com/104498-7-inch-parallel-resistive-touch-display-800x480.pdf
> [3] https://docs.toradex.com/105952-10-1-inch-lvds-capacitive-touch-display-1280x800-datasheet.pdf
> [4] https://www.endrich.com/isi50_isi30_tft-displays/lt170410-1whc_isi30
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - New patch adding display panel bindings as well as suggested by Rob.
> 
>  .../panel/logictechno,lt161010-2nhc.yaml      | 44 +++++++++++++++++++
>  .../panel/logictechno,lt161010-2nhr.yaml      | 44 +++++++++++++++++++
>  .../panel/logictechno,lt170410-2whc.yaml      | 44 +++++++++++++++++++
>  3 files changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/logictechno,lt161010-2nhc.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/panel/logictechno,lt161010-2nhr.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/panel/logictechno,lt170410-2whc.yaml

I would just put these into 1 document as the compatible is the only 
difference. Either way:

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
