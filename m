Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AFFC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C74D20879
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 11:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGrPA1vQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfDFLaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 07:30:17 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35361 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 07:30:17 -0400
Received: by mail-yb1-f196.google.com with SMTP id e12so3410204ybq.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vxJXqsSieym8cN70gf3W1DFKk5iD0BpPzH9q+ewIwvo=;
        b=BGrPA1vQgO+sWNBYBrgNC9iyy0GX8qe0U0Z40mYIAHSDc+nEGRqKvMET8fB9Ac5Y3j
         SuQ07IQOFTujhqdjUgWWSkBoWrVyJLMh0yFVdbUkGZUzXTThDBq3UOXUCVfb+zbc2mBh
         Q5HqSVutBzO1VfhSt4rK1xFN6RHL0+kb+tzXHEU/B+EaNvFIKQa+RRFyxe3goSlyhkQw
         o3xxrQ/L3Cdi20OWdEd+csGjQO+JHcVgFmzPMq8Xk4eCbPEoWWsx+d9vFu8cMugG+6/6
         r5eFxp8voRHh0XcnbyHtNPS+ThirkmO3fRdhN5y8N92GvecaLrPi/WuF2MGKMY6ejFNZ
         uupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vxJXqsSieym8cN70gf3W1DFKk5iD0BpPzH9q+ewIwvo=;
        b=Ov5o8HkEiFOtCk/wAudoCxboldeFsWhjU72BRAz8hF4zeqb6IKOqxzO+kQtiB1HudO
         auXu22/JHBInSJa6R4ucOhjcIGTxDJgsR/6yUDpGvTPGd6l59VOe7CBppD6SmmKTEki8
         U/ofYaVO8Wxh6wo4U88rYwwp9r+crHvrea0jh0yr2zcwEQVOXI9EblGim7NbuOuANPd8
         sr2dLGWuBl6mONeQ+qxn9NgplEg1Qc3P3KYsFpAXahbzfJpzXNStKtIOFowMqEYqXkGk
         Cn3kB7NkU+9/qjwcDUWzQgnFtTehiOlCZHuohwinh9E0TaLsRFnUjzFz2coAyE9hfb/4
         HzMw==
X-Gm-Message-State: APjAAAWP7XEL8mXtUp/AudGPw1gOj11H/v3nWpUixjGubGDje+NSMkR3
        KyC2DqKKghir9sjetb+bS4TkOQ==
X-Google-Smtp-Source: APXvYqyZnK2Zpvdtmd+15D303DXHVc8/Uhf9iU1KCTuF7HAIjZ6Y0QPO/gJTTw+qDynNzN7NW51Vgg==
X-Received: by 2002:a25:d344:: with SMTP id e65mr8213298ybf.286.1554550216635;
        Sat, 06 Apr 2019 04:30:16 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id z204sm9800292ywb.28.2019.04.06.04.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 04:30:15 -0700 (PDT)
Date:   Sat, 6 Apr 2019 19:29:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wanglai Shi <shiwanglai@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: arm: coresight: Unify funnel DT
 binding
Message-ID: <20190406112957.GA18883@leoy-ThinkPad-X240s>
References: <20190406112145.15184-1-leo.yan@linaro.org>
 <20190406112145.15184-4-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190406112145.15184-4-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Suzuki,

On Sat, Apr 06, 2019 at 07:21:44PM +0800, Leo Yan wrote:
> Following the same fashion with replicator DT binding, this patch is to
> unify the DT binding for funnel to support static and dynamic modes;
> finally we get the funnel DT binding as below:
> 
> Before patch:
> 
>   Static funnel, aka. non-configurable funnel:
>     Not supported;
> 
>   Dynamic funnel, aka. configurable funnel:
>     "arm,coresight-funnel", "arm,primecell";
> 
> After patch:
> 
>   Static funnel:
>     "arm,coresight-static-funnel";
> 
>   Dynamic funnel:
>     "arm,coresight-funnel", "arm,primecell"; (obsolete)
>     "arm,coresight-dynamic-funnel", "arm,primecell";
> 
> At the end of this patch, it gives an example for static funnel DT
> binding, and updates the dynamic funnel example.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Wanglai Shi <shiwanglai@hisilicon.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Though you gave the reviewing tag for patch v3, but in v4 I added a new
compatible string "arm,coresight-dynamic-funnel" and mark
"arm,coresight-funnel" as obsolete; and also changed the commit log.

For this reason I didn't add your tags in this patch, so please review
again.  Thanks!
