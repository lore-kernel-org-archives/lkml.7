Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA66BC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94922222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578091464;
	bh=L5tbYYAmX0Q/f7Xsyf5mSs9zpysnyX9RcFdoD/DisA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R4gXVu7DaSEEVeqNInpKzZVC2k1I1xcc7pab41jwGteILYjRfQHSEtRAnUmQnOPrx
	 2p+UVaEZhIWNsX5dhTa5XIcnQv3rOSgnP+RWe3Sgh6muvybR5hjpGYIx0KnT3Hiwni
	 i86CI2iE3dZiZLAXoIGTYcQiM8yZhBXYj/NnSfZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgACWoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:44:23 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43940 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgACWoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:44:23 -0500
Received: by mail-il1-f194.google.com with SMTP id v69so37835145ili.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 14:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zL7lXPN6EMBAnzsaSWaNynU9nZ8SUyCQnluhdY1uUrg=;
        b=YU+fHeErmsn1qfDuIKmwwhsNj0Ochzf3le3WK0ioj71T822NJU530DllmBptMZJ2tH
         DtblT+mkMVlUstUtx2qrz4zrjUOyD0dFjbh9TV3G3s6yEElquP8ye8CyyBcHuANpKFRR
         2Eo8oC8ti8KD0aE2g85HmYcPPW0WW0BmL/DUBF8AUsAvkTxBPDv06CF+3nJ0g1bozDB6
         f4+ewyd92GK7YGKuTvlVwWk14JTGXq5i0aL8E4RG8Fw/ABdHrZS4152TrDUxDFaTYcje
         5jg7TjaxSfiCGCR8d4vVGUACpjMzr3wyuzX3HiF6wa2owNgaiWwFMwh9HYG0V8cSgbv2
         Yhmg==
X-Gm-Message-State: APjAAAXWWO65jBFRlpNjGDZdpX/Mn7b4rtkKDViJxQ4v3Pd0KhL6aNlT
        ntPtlfvM+NDG6phpPLyh5gst6MI=
X-Google-Smtp-Source: APXvYqztaTnYWk5EEYaHrUBqt2I9bhHeKtcWMOo4PJEgzKUxdWFzv6pKskqyQogw5F4gWKnMtkEHHA==
X-Received: by 2002:a92:9107:: with SMTP id t7mr77894812ild.51.1578091462362;
        Fri, 03 Jan 2020 14:44:22 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id k11sm4806516ion.32.2020.01.03.14.44.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 14:44:21 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 15:44:20 -0700
Date:   Fri, 3 Jan 2020 15:44:20 -0700
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: display: Document the Xylon LogiCVC
 display controller
Message-ID: <20200103224420.GA24988@bogus>
References: <20191203150606.317062-1-paul.kocialkowski@bootlin.com>
 <20191203150606.317062-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203150606.317062-2-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Dec 2019 16:06:04 +0100, Paul Kocialkowski wrote:
> The Xylon LogiCVC is a display controller implemented as programmable
> logic in Xilinx FPGAs.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../display/xylon,logicvc-display.yaml        | 313 ++++++++++++++++++
>  1 file changed, 313 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
