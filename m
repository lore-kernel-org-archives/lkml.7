Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29454C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FC220656
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556742529;
	bh=x5uZg4yvT9eUKapsoc3sOUdOyoXkqIPi5UzguslMUHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q+JRRrg1gWAYzbOqfzeckFlRmKIgF9YA430Oih79mzoys9/v41UwA5LpaRchXVppa
	 mYyaceShp+GReExsasZgGnhgeE1r6M9luaNUhkUI8/Fwm2RrSMvi/Oq1s7EIljNFOP
	 KvYCdrZvAONvlQUj1UyrdVZp6hMjvuHRPqgo81YA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEAU2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:28:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46046 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEAU2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:28:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id a10so93812otl.12;
        Wed, 01 May 2019 13:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iM9Lzvx9eurZ7iNAk8pEFB6h2rhy/JbojZtOGoYy1fM=;
        b=UlTZFcYdtnJs7Vo+5qJrXC2ZCLB+Jn/TGb1oU/aOCyErpuBBAI3F8AOCQd2hfeMvNa
         0MF92JUr37RSKrOtZOPYkJ0JchKRxUAqS3OTsR4jX9a8v063CXCCHyu3h9qfe7JOQyPe
         9ipL6TisUMAVYITs27NVW0mh2zlgzEysVBURXxvNe7KxXtiawcehX6DL9nbwvdFAdOsr
         xcdqQPjpQWaxsRD2wEQAE75H8g7cm5mRVO2Ur1mjoOtB9sa77hRo+w81SdntyU2UG17i
         zj9+UZJK7NNCmh4swu01RuD4st6ayPu1kj+XV+7+8pMt5+jii7VtvOUK6OWSgfPq3tdc
         Gz0g==
X-Gm-Message-State: APjAAAWSC5W4IqZP2OdaHOWwFqn0kk9BDh4A8Wd4CFAGjmofd1qhHCme
        vPRhdUFAvH/qCkOqjVm3RA==
X-Google-Smtp-Source: APXvYqx+WVqWajrngCu2jyO/2REsqFPYSDsjATjmkISKqjIRUzuaY4guT01c4xi2gvLZdnu7Jl16ag==
X-Received: by 2002:a9d:22e7:: with SMTP id y94mr15193785ota.318.1556742526577;
        Wed, 01 May 2019 13:28:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n70sm6017786ota.65.2019.05.01.13.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:28:45 -0700 (PDT)
Date:   Wed, 1 May 2019 15:28:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 09/11] dt-bindings: interconnect: Add header for
 interconnect node
Message-ID: <20190501202844.GA5092@bogus>
References: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
 <1556614265-12745-10-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556614265-12745-10-git-send-email-henryc.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:51:03PM +0800, Henry Chen wrote:
> Add header file for mt8183 interconnect node that could be shared between
> the interconeect provider driver and Device Tree source files.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  include/dt-bindings/interconnect/mtk,mt8183.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/mtk,mt8183.h

This goes with the binding patch.
