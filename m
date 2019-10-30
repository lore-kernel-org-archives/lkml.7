Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE90CCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FB620656
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572445795;
	bh=K5ytgmxZF/cvacltd3pzbd6c3lkbJfhuVIHHxIhD918=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wRmFVT2j+U9PUvvj38R8kVmLOSwSUPujlbkdDTiytvLcxFnrqgFifY3boQjY961cr
	 HL8QyrsGbIrdASjN+bUSD34BHhE3rUEAZshTvtRKzX8B+WB7sQ7pXvLK04ueX857Av
	 BZQFszMrmhAVgaJxP8YRNPhiUEJTHazoCe4VmI6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfJ3O3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:29:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46971 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJ3O3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:29:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id 89so2228737oth.13;
        Wed, 30 Oct 2019 07:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LMfeOlvx6eLj9u8wcVjU8j/3tqXZ55VLld17C/fRM+o=;
        b=KXgQhjcQ6o+d1I35/G5kwAlyytym1XvmL30MxV8CKXiMEyoGyqlJx/gcWLBA1vLSN7
         xqmNr0DH/snI+fdkwzhc1akCZItqMXZq5+BjJhmEprY2do+zbgMl55PSENysI2rxRb9G
         67OT7Y8x4qqoahcoW86t9VYfVeJlysuN28TU3T2ph7HD7CUxr6QN3bkqckxz1eevJz8D
         uxqU9moCK6DVKvI9eA5Pqt/nAPxaPt10WbKGmHWlFId2zLatg3/tIi5NWRFzPQ3S7+/s
         RhXxb6iYJqjEHrWKOYP8mYUFX+qz1WlqtQ0b3M+o24IiW42dL9BS5STOVlE5NHWL4v6C
         a9yg==
X-Gm-Message-State: APjAAAXovf7x06qSWFlhxLTMRoe0Kx/lyRC2j91p64/4XAv95DWrApfE
        KgqLXTvn+E9dN2OKMWJidlGXmvol4w==
X-Google-Smtp-Source: APXvYqx+eBfjpYHuthtmmpS/yKuaO2Fxm/sTUZz0uJRp1IDCuerAIXzxDA1q1VJzYfDKZiAUqvmNqQ==
X-Received: by 2002:a9d:7ac5:: with SMTP id m5mr138924otn.356.1572445793274;
        Wed, 30 Oct 2019 07:29:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w33sm75635otb.68.2019.10.30.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 07:29:52 -0700 (PDT)
Date:   Wed, 30 Oct 2019 09:29:52 -0500
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
Message-ID: <20191030142952.GB31293@bogus>
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
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/logictechno,lt161010-2nhc.yaml b/Documentation/devicetree/bindings/display/panel/logictechno,lt161010-2nhc.yaml
> new file mode 100644
> index 000000000000..0dfe94d38a47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/logictechno,lt161010-2nhc.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0

Except the license for new bindings should be: 

(GPL-2.0-only OR BSD-2-Clause)

Rob
