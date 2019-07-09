Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4059BC606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA522171F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562637467;
	bh=3aePCBfUrtlTh1MWtxMgeK8de64/Q8/C3XgQdor3ABw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mup/seHCasrq8pO1onbleKm43HqRdkMv6qW4RndFI8NBou6KsoceBwVIzNW3ds+Tn
	 9uu9NWBEvHwqC/YJhexLZrfX0T4eJx5moc4GLFQ9yXQ3k6Dy0Pyv1BBpul/bk/j7SA
	 ifHLFbir6cM1hJfKYuoHNI+ksPVXeynWYGSHJxJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGIB5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:57:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:47053 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfGIB5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:57:45 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so39664719iol.13;
        Mon, 08 Jul 2019 18:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZP1aQ1FRsdW6CYNzwwPiQpzEbHZzUvAyhoX9YSSaQ8E=;
        b=Pj5M3AD78QaZshEfXnb9rjL+RS8as6TR7QPuCodzgpgVVZbBycRbqKxAMAMpk5L3md
         x67MoxYbyc0vcNOK7QXUvnIFyfye0Kd+j63ya4FVV+MIT0dot7e0HzySdzqDu52tFEB2
         FdUIWGM3jv5dWa7nymY2yhyeLwGAJ4uLiU6gON1ACaa2utMG8SEnuv90hHGUGDgif+qo
         4d3/ETstKchRgRYyL4pw13QgGKjGDYp50w3X7p0q27yJKMayX60iK1cT5xZ2uXbBHZA7
         FDJqGmPWDWiC5v67wIQbkgNNzQQdObEf9zvOX7rpzyht6AcU+3YESxfPiMfxwdfGpPUG
         /U+A==
X-Gm-Message-State: APjAAAUhf+906NEOMupc0i/PnUJn7F/T8cWTV0PlIMcU+aDPeeW9b8gr
        iFmir75NETIDu2MM9160gg==
X-Google-Smtp-Source: APXvYqy9KkVJUxhfqZmRZ3M91SDJ+27dNBdX1LPZspTOOblB090f3hd6q5gx6KxFeVB4+stJbHMfyQ==
X-Received: by 2002:a02:b10b:: with SMTP id r11mr23643555jah.140.1562637464244;
        Mon, 08 Jul 2019 18:57:44 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t14sm17885628ioi.60.2019.07.08.18.57.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 18:57:43 -0700 (PDT)
Date:   Mon, 8 Jul 2019 19:57:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, tomi.valkeinen@ti.com,
        imirkin@alum.mit.edu, marek.belisko@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, letux-kernel@openphoenux.org,
        devicetree@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: drm/panel: simple: add
 ortustech,com37h3m05dtc panel
Message-ID: <20190709015742.GA2590@bogus>
References: <cover.1559905870.git.hns@goldelico.com>
 <a650cb8df1bdf58ec3c8a182532692db16b77f70.1559905870.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a650cb8df1bdf58ec3c8a182532692db16b77f70.1559905870.git.hns@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jun 2019 13:11:09 +0200, "H. Nikolaus Schaller" wrote:
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../display/panel/ortustech,com37h3m05dtc.txt        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
