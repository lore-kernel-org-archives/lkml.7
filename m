Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C362FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725EA2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571321325;
	bh=TTN2YDG1+b1SSHFTL7eXEC+At944oHbPZj+ZEwKq5zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rhpmAZSNjknvMLIB+4n188/lpBYOZm+egZRcWf+wVuJtd2h45962suTKHpJgWBMcj
	 ILTf0faw0yOSDstvFpXL+DQ3wLqR1XfDRfERHqyLfQsJmsfvt1j/ZlMPUGY3Qlq2Iw
	 nj/fuhQAKK0pGcQ4WbSCKyM34CBqupwNOJdFAGdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394566AbfJQOIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:08:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44315 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfJQOIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:08:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id 21so1965769otj.11;
        Thu, 17 Oct 2019 07:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4LaxdzcWVgTMeshGXRDImrA5EwGUcbpIabxr8Z7hfxY=;
        b=l3zD5PNY7CkOMQVysxowSv5P/mhHsPul41RD1O18r6sDVvokb7iSWrO1LIjqIId4y5
         xFMsfb0ea4rHhkvWNcHTETtd4ehzmfj8V/Mu3lQ1EXd+5rcA03V2QMt4vtlWjxz0vSPk
         i/p+5lyrkyzNfQEEk6P3M9irR+XggTYyzsOYdeYqT/X8NFVwSBr1cynRP2aZAve1qoLz
         b8Oxxo54I3sxQtYnYyql7dVGpmw7X7aQn4i/7HLs8IIoawqi+rYvTiR0v3WACUuOo1+c
         zbOdAbhyOgBgJmJ+Dpya6kmABw7hNHKW869gUnUM0SSXftLzGq49d2jGyUk247/hfT95
         Zfjw==
X-Gm-Message-State: APjAAAWojthhuwGAinu5ABLchTuoejvleUZYTGaLzXS6CgVETPrinRiP
        Iovl5h6ai8i1qQF2K7GSBNSGJEA=
X-Google-Smtp-Source: APXvYqzWR4t2orXzG34Y3uK5tLGUXivPJ3U/zljrWoSmEsG8YVlKGN5S+DXwZjmsakg5G35UsjPEqQ==
X-Received: by 2002:a05:6830:1510:: with SMTP id k16mr3207388otp.197.1571321322294;
        Thu, 17 Oct 2019 07:08:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 91sm639337otn.36.2019.10.17.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 07:08:41 -0700 (PDT)
Date:   Thu, 17 Oct 2019 09:08:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     min.guo@mediatek.com
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tony@atomide.com,
        hdegoede@redhat.com, Min Guo <min.guo@mediatek.com>
Subject: Re: [PATCH RESEND v7 1/6] dt-bindings: usb: musb: Add support for
 MediaTek musb controller
Message-ID: <20191017140841.GA20279@bogus>
References: <20191017082554.27953-1-min.guo@mediatek.com>
 <20191017082554.27953-2-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017082554.27953-2-min.guo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019 16:25:49 +0800, <min.guo@mediatek.com> wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> This adds support for MediaTek musb controller in
> host, peripheral and otg mode.
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
> changes in v7:
> 1. Modify compatible as
> - compatible : should be one of:
>                "mediatek,mt2701-musb"
>                ...
>                followed by "mediatek,mtk-musb"
> 2. Change usb connector child node compatible as "gpio-usb-b-connector" 
> 
> changes in v6:
> 1. Modify usb connector child node
> 
> changes in v5:
> suggested by Rob:
> 1. Modify compatible as 
> - compatible : should be one of:
>                "mediatek,mt-2701"
>                ...
>                followed by "mediatek,mtk-musb"
> 2. Add usb connector child node
> 
> changes in v4:
> suggested by Sergei:
> 1. String alignment
> 
> changes in v3:
> 1. no changes
> 
> changes in v2:
> suggested by Bin:
> 1. Modify DRC to DRD
> suggested by Rob:
> 2. Drop the "<soc-model>-musb" in compatible
> 3. Remove phy-names
> 4. Add space after comma in clock-names
> ---
>  .../devicetree/bindings/usb/mediatek,musb.txt      | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
