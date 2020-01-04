Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE003C00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A290220866
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578096056;
	bh=Hwu+QnSdIVdx0UuxPRoPNhfoaYKuuFW50yLkebINuMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O9ldhDyFGwcjYtT6ZVJMqsXDFmcqJUO4RsgV2tTGhJk6XYA8pZJ3id3+tPVkeCX+S
	 qSoePwZz0A3MHgYI4wuRlzU6lkcoRTIc/m09/c8TrgtnfFh94iWGyi3UKfZiT7C1LM
	 9Qr/L8fHwhfeBnEFRRjOjZ2CM25elHWrWyQkvYBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgADAAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:00:55 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45149 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgADAAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:00:55 -0500
Received: by mail-il1-f194.google.com with SMTP id p8so37958693iln.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xmFf6L8ePvGKyOz/wpH8wXZ5AKBsBj34hi1vb6ky2dA=;
        b=dXFVlFbqFR3boF0SzITFPU3QPBo3PTq3e15eFPTa8bqqnFFLfBcYXBaO343/gZSahZ
         GhWfaE1RN24wT/GJgsJetBXoGP6ez5K9c9/RM2u0O2r+//shCn4ZtHSaGeMy/eq/lYtf
         c/rZlNw7mFcksxADMhM9ig+SAC9FMYAXrg2S5xFvjUylAVhBmNg9XrZ1vPExVuAn0XUx
         SQ/9Qt8xtpoqMbyF+xoSFrUD1cr39t991g2tCWXjci3WtSxEc+6agUPEKXRaR7Iv7nAc
         ZKP50QKOY+zJJ84csK5VCq82AkjL4TbB6HF6hNDgTnRPpclcVa31ZJT4f+0dw1oWPsEn
         dlxg==
X-Gm-Message-State: APjAAAVq917qb0P1PWDQCzDk4JnlP7lMvSbH/plTHYMfhw1/Mwdngrxh
        OIp6zNYSfwSkvN6fzVImBHXil3E=
X-Google-Smtp-Source: APXvYqzUQyUGsXfWpCeCUiKx6GMvNpiBfsMRx1vTWetcRs3S4NqfqDt8jHbATyjMzdgCMqpWgyrTYw==
X-Received: by 2002:a92:c50e:: with SMTP id r14mr78037856ilg.52.1578096054051;
        Fri, 03 Jan 2020 16:00:54 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g6sm21620172ilj.64.2020.01.03.16.00.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:00:53 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 17:00:52 -0700
Date:   Fri, 3 Jan 2020 17:00:52 -0700
From:   Rob Herring <robh@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v3 12/12] dt-bindings: media: venus: delete old binding
 document
Message-ID: <20200104000052.GA17596@bogus>
References: <20191223113311.20602-1-stanimir.varbanov@linaro.org>
 <20191223113311.20602-13-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223113311.20602-13-stanimir.varbanov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019 13:33:11 +0200, Stanimir Varbanov wrote:
> After transitioning to YAML DT schema we don't need this old-style
> document.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,venus.txt  | 120 ------------------
>  1 file changed, 120 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/qcom,venus.txt
> 

Acked-by: Rob Herring <robh@kernel.org>
