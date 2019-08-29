Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E7AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D062070B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567106203;
	bh=0YScc8xMPrF/1mM7Kjj+Whmw6FNa1K2JqV1NnMS6O1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mqJAejGc0B1e82/ZJZL2zyi+A0gXBAaShpDt8b67odQvah04iikEvSHi4N+B1pQpk
	 CtSt3n/BVHqSV3tCDXwV58pFUzNxsZiIt+encsiCL7lQcJ0Bv8AZR1nCurqtmucz00
	 OZzpK1LO5aN+HvVSGocpiqnnb9vGXlgV8ym2AzBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfH2TQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:16:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36121 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfH2TQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:16:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id k18so4570765otr.3;
        Thu, 29 Aug 2019 12:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F5mi1nP24C4HDFRh6fdf/ps2HQjngM3tY75i7SznJm0=;
        b=jXYZWYRoCpsI2wkHKZJQ+0LJjy4aM+jKNlWAJ+0Y8ShammXnWTQjypoiRULbBQ+6qr
         zKgGflSP48vru68dSsNruz2jwkARMSFUYX3LAh3sFJ5fpZppnanyQvCdlT5a08nceRtn
         W75y68Xp9HXJ+W1B80lTHTnkI8IbomMd5tsKC2KJEGM0puxuZ2Bjwo4c4TTUBe9bXADt
         LJjiCb39Fw8ijylNULfN7RoOyQNGKB61cgfvp+D17FyGXiy+T3cof8uoLR0kYv8UV6QE
         8X7023H/eRnQ8npiMS7vNBSfFl8brVaT2PnsUh+yavMt9733hBEOZGMXeFvLXbhaqb7g
         nO3Q==
X-Gm-Message-State: APjAAAUBvPQ+B5SmELMDDyurZ9gHqbJjEBnBh+IRpWC1epRCE/4Mkers
        AudXB6fdlfFSlTjR0DyNA8DHNTc=
X-Google-Smtp-Source: APXvYqzlwbv36ZyaxAhri1jX+/W0xd5toeYw80HuVeTBAP03TtFgxz2umcWIojobopVFLMFOTYT4nw==
X-Received: by 2002:a05:6830:1209:: with SMTP id r9mr558071otp.128.1567106201477;
        Thu, 29 Aug 2019 12:16:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e52sm328209ote.39.2019.08.29.12.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 12:16:41 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:16:40 -0500
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
Subject: Re: [PATCH V3 02/10] dt-bindings: soc: Add opp table on scpsys
 bindings
Message-ID: <20190829191640.GB15714@bogus>
References: <1566995328-15158-1-git-send-email-henryc.chen@mediatek.com>
 <1566995328-15158-3-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566995328-15158-3-git-send-email-henryc.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 20:28:40 +0800, Henry Chen wrote:
> Add opp table on scpsys dt-bindings for Mediatek SoC.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
