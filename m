Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B86E2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800012;
	bh=IdFfT9hZxOYJkbtJE5rzMLB86CH9hOdie+m3fN8Ta0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VfxwSCr5ScJXUm+JJdGyUWTcxX7X2x0kbe3/x/QH7fXA4PLJjThN7E6HIiQ+rUuYM
	 3pZlJGEizQ44P+tmE4Fv4OOGc55ZQppCfxip2fzwoDy8PO7SUl02BJZjt6/iD8D4sk
	 e+U/scGVW6jy4wmTMBix96kqZbazGRSb8Kie497k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfC1TGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:06:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43926 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1TGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:06:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id u15so19368052otq.10;
        Thu, 28 Mar 2019 12:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2jZu64+Nni6/IeLnEx4LX1mewJ6SA77TRofzaLrQ5lY=;
        b=eWl7upoGS6UOrrEPGxym4k4pMXi76LextmQQoRx23Yizylzt/Ju1f8ieeFqy2FdkGq
         +t0zVrT44dPZeVhu75MJeQsC97AH3is5yICVSsokHFzDYIi3+8S/Hksor35IE+jR870l
         i3vFt6miooF0R1jmPJ/2Y03lIE42cMQNo0dtW0rl/xHbS+TwyxHSRBp4Gqy+PY6C/3LT
         QghtoSemUP7mQi3tYlaKIaVRYhcqSMGXRGtx6NvC2E3inzprtuJpSnzdOy1M3DgoD+gj
         mKx6erpNFpEHAoa/0rgu0uzKAzwXp0LHNJhXMBKDtjaJqt5zIJog5jBC70suW1piPx+y
         yWSA==
X-Gm-Message-State: APjAAAXVMqD8gVzgriTWvtqSSlpiCoLSa1s7CzZjPhMPpfg3chAAUc6p
        IBewBcV/qQ77XTIaut/oQg==
X-Google-Smtp-Source: APXvYqxLU7eYKhMKH0G2mVTOjcxcfMyX1T44Aou9yUJHTuOI9g8ItUTMJg//TU2EkgiC9dVoddJR9A==
X-Received: by 2002:a9d:600d:: with SMTP id h13mr31618765otj.114.1553800009916;
        Thu, 28 Mar 2019 12:06:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q67sm9977946oif.40.2019.03.28.12.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 12:06:48 -0700 (PDT)
Date:   Thu, 28 Mar 2019 14:06:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        Wanglai Shi <shiwanglai@hisilicon.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: coresight: Support static funnel
Message-ID: <20190328190648.GA24389@bogus>
References: <20190328023509.22242-1-leo.yan@linaro.org>
 <20190328023509.22242-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328023509.22242-2-leo.yan@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 10:35:08 +0800, Leo Yan wrote:
> Document DT binding for static (non-configurable) funnel and give an
> example for it.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Wanglai Shi <shiwanglai@hisilicon.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../devicetree/bindings/arm/coresight.txt     | 45 +++++++++++++++++--
>  1 file changed, 42 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
