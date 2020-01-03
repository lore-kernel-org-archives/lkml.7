Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423E5C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F41F22B48
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578090870;
	bh=uQHvl0hodbYb4DBcSe9ogT9gHBP/kHzrDkhP9lujX7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s9W3+g32q6XTg/YMJExH/P23T9BMAQXW3JFESR0kzcRBFKPocK0WeB0/NkAGGGzjH
	 FucNOhFgeWTvLLCMF6MSbzCQEHQA32XVhCx1DHVpXGLDdcud+Bg1Yt5K4cFysJWZIH
	 S8ToMbyFsx26gZ0+bFOGfJVyXgv4+NrGhr0qINX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgACWe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:34:28 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:38581 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbgACWe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:34:26 -0500
Received: by mail-il1-f194.google.com with SMTP id f5so37864726ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 14:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z/2Xg5vRSUumZDtJtIhcj+vGbHinC6E/xmYbVuQQYS8=;
        b=XdJmHwE8y4tkW7ZKGWTJPH6oiCnglQd4vpL0q+95lsbiywtDb680ad0Zt0h+1PUhIh
         7+p06unspDXjUsxAGyPJQfn7P17xdXEE7OdkElzBDlsYUwPR+VSYs+lT/z2VYyx9NV73
         kub7kxFzqc1JVqSqkE6JR/1J/wKz5kblGxoUEo/wtD8u0fQ2QDumwk/k8whezq6V7H2y
         53klTUXxi0cnBd7Z+0sbX++K2BFgTpJqy+qnnzx0cZgy/rug0n4BNG9F/AKLrWWj18LL
         QhXpP1bDxhbC6r5chJXbGbaI/JwhVs8ckxkotu3f0jnKbca62qdS+RvaEq8ob9MFjOvz
         6vQQ==
X-Gm-Message-State: APjAAAWKzG6JP7QMM1LvbFqViYmBI+iZdPrhY3rIGm90I28hhy6wUphC
        OHOkMXE/v0npLnVOEaeywLaHBY8=
X-Google-Smtp-Source: APXvYqypK7wvm14nkKJJOjUZzMLRPz9r9VMYT38ESVlendS9DNss2qQCRU52xs/TlO+s892OGMyGAA==
X-Received: by 2002:a92:5d88:: with SMTP id e8mr78850910ilg.106.1578090865154;
        Fri, 03 Jan 2020 14:34:25 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a7sm15185879iod.61.2020.01.03.14.34.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 14:34:23 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 15:34:21 -0700
Date:   Fri, 3 Jan 2020 15:34:21 -0700
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 13/14] dt-bindings: phy: Document WIZ (SERDES wrapper)
 bindings
Message-ID: <20200103223421.GA9017@bogus>
References: <20191216095712.13266-14-kishon@ti.com>
 <20200102095631.1165-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102095631.1165-1-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020 15:26:31 +0530, Kishon Vijay Abraham I wrote:
> Add DT binding documentation for WIZ (SERDES wrapper). WIZ is *NOT* a
> PHY but a wrapper used to configure some of the input signals to the
> SERDES. It is used with both Sierra(16G) and Torrent(10G) serdes.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> [jsarha@ti.com: Add separate compatible for Sierra(16G) and Torrent(10G)
>  SERDES]
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
> Changes from v4:
> *) Fixed the indentation as suggested by Rob v4
> 
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 204 ++++++++++++++++++
>  1 file changed, 204 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
