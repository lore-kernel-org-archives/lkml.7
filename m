Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28820C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05A22070B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567106195;
	bh=ze0ga2rgVIqiQy3IsYmgK4+YoXPC+a1fFkqJsuMMCVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DSfg2P842YBCmca8nA/1wXO3IvQ2vioQz0CRe1sBoJaGoN5FAX/w/wZvcM85nwCY/
	 D7AnWWYDFNDw7QR15i9nIVNWbcvWOITdyr3gAPKFTM0JnFcY55i5BMLA6qI8pBmUkC
	 WRPKACkFYcAXW3LYqubuHu+RTSTqqfIZr4Q0xdzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfH2TQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:16:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36113 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfH2TQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:16:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id k18so4570331otr.3;
        Thu, 29 Aug 2019 12:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qXXfSWb8r+ekX6AnOeZMT+WDuuUjHIsf04zXphaqwHY=;
        b=qxOMyKU6lo3pwk88ln2CmmFBaxrRo8rIC+tJLttekgcz9M1M/fLnFPUDE8VxUxeHEQ
         jTX7qzN7sEUS/Fy26BCWWJQSPW/04JqKaNWi43C1Is6iKL9N7HKVk8Jd1+tZ2Le8bm6m
         Yrdmz7nJZuwGDsLjZtoL55X4yaFRz28toMImkHWccIxzyvXlAiILD204cIm6LwUFnqXK
         zdQ5o5F8WOHqT+8jOpv0iyjB/dIcDLSgFTLI6eogBgF0u6H5f/OufB+S18/UheXGfBgy
         aVH97LwCUQAnFUXhQ378GaRBPG/HkuCbpVAleff/MWT+a6NK+I1vZrK5t0GQPm/8oa9J
         B6Tg==
X-Gm-Message-State: APjAAAVjuZ1rjGRRtMxm6F3MuJvf90XIayAeH8O/NM601arwPWgiQaJl
        zd9kFqswkItk5toUU1j9xQ==
X-Google-Smtp-Source: APXvYqw3wayppmtwe4suZgP9c/BFmJes13dE7GUWcARKQZLPrkt0xRRa40WAmFF2sKNFSuU8OEACug==
X-Received: by 2002:a05:6830:1345:: with SMTP id r5mr9441701otq.158.1567106192618;
        Thu, 29 Aug 2019 12:16:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q85sm931405oic.52.2019.08.29.12.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 12:16:31 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:16:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Henry Chen <henryc.chen@mediatek.com>
Subject: Re: [PATCH V3 01/10] dt-bindings: soc: Add dvfsrc driver bindings
Message-ID: <20190829191631.GA15714@bogus>
References: <1566995328-15158-1-git-send-email-henryc.chen@mediatek.com>
 <1566995328-15158-2-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566995328-15158-2-git-send-email-henryc.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 20:28:39 +0800, Henry Chen wrote:
> Document the binding for enabling dvfsrc on MediaTek SoC.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/dvfsrc.txt    | 23 ++++++++++++++++++++++
>  include/dt-bindings/soc/mtk,dvfsrc.h               | 14 +++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
>  create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
