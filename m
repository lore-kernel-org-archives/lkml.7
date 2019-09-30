Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50484C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E3621855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569853147;
	bh=Yn2jkve+RQOI1pcFqeYfjdGfXmUZ8CalwECDFySsi7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nINO2KlTmgy+ubEt88z6SyabJbl26o5I598RdaGKQW3RwU7O3YJYa4E3gpdjqN3cP
	 Fp7PD6cIunwXkk+stE9fJMF10JaLZwA9ww1JSBT2HkwdkMuujTrFK7SelWC13kQiiY
	 Y/rLb4+bYtVTN0/Fx7HHiT6m5feOqhgq17oy5y9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfI3OTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:19:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35177 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730923AbfI3OTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:19:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id x3so11270536oig.2;
        Mon, 30 Sep 2019 07:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k0DT0LfsMEKXZJaEs2gsY0cMR9oRvTf9oXbwRd1ldsE=;
        b=jb8680kwq2ywe+BssHq+y4jxiDEX19oKHwfuteX8pB+mqsmadUtNCPRrNSx0VUUxG7
         +raCtiroaO/kqzliJiiB8d1nl+pN1uHKr6NYztEB8pQV0JPqYRtiutAOCcu4/gUobdT4
         jIN7iBKD1s2yRg/O+4JfSvZCFKRZiXCXYuGeqIOUdkHOjO0CW8zLAgi6rBBFgyg+BGpD
         +9UONOsk+p1dk/vMwLtrWvZ1CuyvgtIeygTtiJuI1lBuxKUiWcs6/uSUDBjMcr39CAf7
         0t0EnI0C7XBZJ2Y2owiGNYG3fj1rIsyZWBYyeDtPtqGOGZZzV5Sx69ng4hzEHUfkfUi9
         knrA==
X-Gm-Message-State: APjAAAUxQ56CinDDVJgkaRBUSxZz5N473cKpSe/5lg69BS+pvit5Nxa0
        HaQhbwrAtLfhOOh27Ysz5g==
X-Google-Smtp-Source: APXvYqyX0DbYut/C7yzytLdNB/nhfcg+c7eDfYw3GZT9/xEIOAdWu3iR86HUyY4swwbj+eKMoBR/QA==
X-Received: by 2002:aca:ba06:: with SMTP id k6mr18489328oif.136.1569853145957;
        Mon, 30 Sep 2019 07:19:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w33sm3808511otb.68.2019.09.30.07.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 07:19:04 -0700 (PDT)
Date:   Mon, 30 Sep 2019 09:19:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/fdt: don't ignore errors from of_setup_earlycon
Message-ID: <20190930141904.GA19392@bogus>
References: <20190910055833.28324-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910055833.28324-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 07:58:33 +0200, Christoph Hellwig wrote:
> If of_setup_earlycon we should keep on iterating earlycon options
> instead of breaking out of the loop.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/of/fdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
