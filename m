Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4F9C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B5421855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554534657;
	bh=9qwoacTAtsyJ+b7JiUmjs9QVehSPQ+iSJx6SaVwKoG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N2oy754Zsqxm0wDfWqTF+DXplvutem42zg8Ra2wLNPV/MYjaBKhJTId8fvnqTm5JU
	 18lbLtEvtxsP75pKKEBDNkGL37q1/VusHz2CGtsrVwwqBP6AA1++8SJsDCKlVibCH+
	 +iZBtAu7/HnJuMmiKNzWrbc7fp2LdarK011QxEPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDFHK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 03:10:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37650 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDFHK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 03:10:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so4519642pfr.4;
        Sat, 06 Apr 2019 00:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lhkIZobirKanXQ+SUHIUuVIcEecWac3+2Xe33plcmzg=;
        b=qWDBsMmBIoP4KEfL8CLRdKk+oySGKs/2zeKEb0h8sayW4aPn0dA7HJ1MFXnWtXUKWr
         mxuMdSmOak8Pa9l5A57c1PQ3erx/jtVrTSceX0MSHUCulvogym5ldOBDVfGlZMp/NqWF
         cLVJTI9hmKzwMX5Fpyy6sIn57AUv44pluZD2oo7sdoYVjlElNq3bpXX/CPSqBi9JOiYk
         FTOQeMYMKk+jNgM+wKLPAhx9z8jd7TWF6lSttyeszA3twiSBSTG4AtozsdXgj31L4QFb
         FZtWvgS1XR6Jn7hw2F89sVRotT3qbFyf0nEyhhieIfrd2dlJl+pM8N1za0qu19WTlMkc
         M1/w==
X-Gm-Message-State: APjAAAVK3F6EYiTBuIfKzHsZDdDT81P+HFN7JcCGzkiA00K6+WTO824l
        zNNeUath2qbAxiP3uHuNuJBgFJmTgw==
X-Google-Smtp-Source: APXvYqz0r4Sh6ybhrAtRvBPgfgtqWNPWSuLgBbSaLYzsTwLTEhxP1VYYScj1uWUds/kXRgeQXysd/A==
X-Received: by 2002:a63:cc0c:: with SMTP id x12mr16421839pgf.336.1554534655451;
        Sat, 06 Apr 2019 00:10:55 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id b16sm33204586pfo.168.2019.04.06.00.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 00:10:54 -0700 (PDT)
Date:   Sat, 6 Apr 2019 02:10:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v5 1/5] dt-bindings: usb-connector: add Vbus regulator
 for Type-A/B
Message-ID: <20190406071052.GA5805@bogus>
References: <20190405205736.55177-1-icenowy@aosc.io>
 <20190405205736.55177-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405205736.55177-2-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  6 Apr 2019 04:57:32 +0800, Icenowy Zheng wrote:
> USB Type-A and Type-B connectors have a Vbus pin, which provides +5V
> power to bus-powered devices.
> 
> Add a power supply regulator property for this pin.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> New patch in v5.
> 
>  Documentation/devicetree/bindings/connector/usb-connector.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
