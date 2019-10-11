Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F993C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48893214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570801347;
	bh=Kpza/eBjEaZT13hYRNNdMuihcyrxbT101E0T+IenNZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IW1XWK/T3zl6zfMh201oq52DtPf3JKdqPULzQF3c1QDnJtVfkJqV064BhPT0ztkHE
	 PdZLLPNDB6QoujI/6eVrqgEmsfXTKUHA8WXR2A3V9/7rZ7CwPiKCI76txUTGGpPcKj
	 /kycac/lSMswDkRrtore7qR8qul539T3swubtGMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfJKNm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:42:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47060 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbfJKNmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:42:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id 89so7954758oth.13;
        Fri, 11 Oct 2019 06:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A2jWyPbfNSsGzEcZc8pDfV2hbWN91PiBfqFemzkg21w=;
        b=bhDhD3/bXt0ZBj7a5kWF7tTcwJOEDHzZQk6EQpf6cicP0ypFJifmUU6was6H95Cpd2
         40ZwEux0vPxsM2hLBMsbj23l1VVpXwzTtebbiE1/SBYxm59/AVJIfE4XhG4XtVunPKXa
         JbblMhnJU+UTbSJSDMeDlKF7rBHpsXjCQIpzgASBt+LoOiVo7jSBn5yGIZ5LeBgXXGri
         HUhEsyEj4UEaq+5dd/HLIM6L3xchIW2YvYABfLowOvY5egd4x0AP2tePc4FmlQRHNruu
         XyzfEm1x+OrQ6DTqaM7g+sWQPUBJyM41s6GaufXy1pH83ulKCLvRzrc+5qMARjcsmxqz
         vjIg==
X-Gm-Message-State: APjAAAXtot3rglWD8dqZfssXQ6WdmOd9MxK+L/xfBrIqM/GBlV3/xDc2
        GQq4ynHPZtgikwsipJ9xVA==
X-Google-Smtp-Source: APXvYqzFpuY6SYxxReU6IXWAObu4ooMdRgFt7J2dhKY9oNlNtPKZsvvflWNH0VtVB33wqyYVsXBjsA==
X-Received: by 2002:a05:6830:1f09:: with SMTP id u9mr13002364otg.310.1570801344612;
        Fri, 11 Oct 2019 06:42:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t10sm2608427oib.49.2019.10.11.06.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 06:42:23 -0700 (PDT)
Date:   Fri, 11 Oct 2019 08:42:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     robh+dt@kernel.org, maz@kernel.org, mark.rutland@arm.com,
        arnd@arndb.de, bp@alien8.de, mchehab@kernel.org,
        james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, paulmck@linux.ibm.com,
        talel@amazon.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        dwmw@amazon.co.uk, benh@kernel.crashing.org, hhhawa@amazon.com,
        ronenk@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        amirkl@amazon.com, barakw@amazon.com
Subject: Re: [PATCH v6 1/2] dt-bindings: soc: al-pos: Amazon's Annapurna Labs
 POS
Message-ID: <20191011134223.GA11275@bogus>
References: <1570707681-865-1-git-send-email-talel@amazon.com>
 <1570707681-865-2-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570707681-865-2-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 14:41:20 +0300, Talel Shenhar wrote:
> Document Amazon's Annapurna Labs POS SoC binding.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  .../bindings/edac/amazon,al-pos-edac.yaml          | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
