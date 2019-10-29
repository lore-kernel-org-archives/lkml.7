Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A50FCA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E24204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572369106;
	bh=G2ZLqykDC3g/ognz+lCW9lDQ0/qHmYUUbsDC9UTp8Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G2eia/p4sH2QFe2qC7SJ/TjF8WCj3ftRv92YClY3AsByO1bdt8LlHeFZkariiOASa
	 J1hVC7DNPzWFuSAGa9Cl4faf183tZj3oDHoL7mgQZFF6bnP8ApTUAeKsUXo+bP1wtP
	 E841mnPnjDXs/ZEg+xYhsAI4NleVQVr+ovAuQgI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390858AbfJ2RLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:11:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35150 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390690AbfJ2RLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:11:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id n16so7315678oig.2;
        Tue, 29 Oct 2019 10:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NFPsIkdsbi3D1LZNXNEB20h31+e7EiPY5eE6juj2uO0=;
        b=UvKWQngnHkixJhubv4E1ArGuUQ4iATtZNF/D5yM9XngmekuJZ6mgR85qvkoMeLe6LW
         pt7fRkdL/o1e/2TdjhtiP7bQSOH0wYB0TK3KDzicv8b0SDNXYGu8NGd5XmwvKkLNh6J3
         I0QaQWwZ92S0xmFoLwwc/M1ZQt8G/OSo0nsnnQWCtsEjr6znT8sPiLmxYT7Lh0Ys4D8C
         IMe64TcC41T4oDdkIsUprh5NI4W45ttg52E/isJqOFhY2uoqXboyIu6wE1UysPIX0sIf
         Xi2+XFQK7OJG5JcGuvMSiK+LmBbw/prDrn/XC5+xR89j3+IJ8g44/a+KwDpY/l2HoOyS
         JgnA==
X-Gm-Message-State: APjAAAXylmNMDA2TwbPP6qAmCuK+va1J12paJyUNJImTLyq+uj3Pxi/K
        4VeJphBcl//hioikStuTJQ==
X-Google-Smtp-Source: APXvYqwHgJ9hqd6TfHrLJc/x73zZyGn74iYBgpu0a5UXuxtb62KPGK0tIWfpo7RqOfbH0JCaMWBHAA==
X-Received: by 2002:aca:c756:: with SMTP id x83mr4829628oif.8.1572369103802;
        Tue, 29 Oct 2019 10:11:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w33sm4897380otb.68.2019.10.29.10.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 10:11:42 -0700 (PDT)
Date:   Tue, 29 Oct 2019 12:11:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, michal.simek@xilinx.com,
        anirudha.sarangi@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH -next 1/6] dt-bindings: dmaengine: xilinx_dma: Remove
 axidma multichannel support
Message-ID: <20191029171141.GA30124@bogus>
References: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1571763622-29281-2-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571763622-29281-2-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 22:30:17 +0530, Radhey Shyam Pandey wrote:
> The AXI DMA multichannel support is deprecated in the IP and it is no
> longer actively supported. For multichannel support, refer to the AXI
> multichannel direct memory access IP product guide(PG228) and MCDMA
> driver(added in the subsequent commits). Inline with it remove axidma
> multichannel optional properties i.e xlnx,mcdma and dma-channels from
> the binding description.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes since RFC:
> New patch.
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 3 ---
>  1 file changed, 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
