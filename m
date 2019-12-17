Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B504C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 23:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361F021835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 23:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576626543;
	bh=bfLq0zjiMQPFWm4rp7k31jTDtIZZHlaC17DpzM/tp9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W52xwGLXnUvdVNrcNwexmARTIEGxtZwcYatlbmAcv15tfRmvcm5G8HGefiDgietaB
	 k3gforeAwKQp1m3SCB6YVlf706kqEMy5fI3lktBz9S0iP7eMMqz1QMnc7/Jg4y/+5J
	 ZG4YvtrExcMHXnpirBQsKOOgY7AYudOKW6m2npnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfLQXtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 18:49:02 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42931 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfLQXtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 18:49:02 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so52499otd.9;
        Tue, 17 Dec 2019 15:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jlg2ki2yobPLE5+Iz6CrZ9HDHot4jm6bFyP7eLrU3qQ=;
        b=FqvyGhL7of1GOVREgL/8ejZuNuqIPJTFRMX4xCIXw0we4NM053Q0qZ/np3717xs+EL
         pY7iBu+ixQtSX5z0w2J1BetHrLbHLkU+0umS7KUm4+5OobkgS4SwMy0LVzdagLOYawao
         AFJTZqWXraRvn+1+irNhBVGS7UejBbAuZdnzXkPRgmSeWgTO6+pjz72frMz5OAYtFDRU
         Ajlv1RpcfNGJTTQwL8hIqwohgTiHOYBf0BplwEQL7oKOM9thAZUnKF1MF8+TNicYg1bY
         LaOi7KkrQPS398/1QA8QXgX9wjI9FQOghBCkFsW+s/jQiBwy/2DywbTF+ICZBiBsZ2Qw
         0I9Q==
X-Gm-Message-State: APjAAAX/Hat2pBn9/dxEWIKqMfd0Tm1mR3kC+AwJq9LSb8qg9cL/I5B3
        uCGVqmDzeefm7fjxoNcjRQ==
X-Google-Smtp-Source: APXvYqw+ktR6zmWC15DCzXWZThyq8OS0sep09XrYuNDJkj8QrlsDYGIEMrNnc9m27AMPyfWoF5gKSw==
X-Received: by 2002:a05:6830:22e2:: with SMTP id t2mr81055otc.129.1576626541083;
        Tue, 17 Dec 2019 15:49:01 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g8sm116989otq.19.2019.12.17.15.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 15:49:00 -0800 (PST)
Date:   Tue, 17 Dec 2019 17:49:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v2] dt-bindings: stm32: convert mlahb to json-schema
Message-ID: <20191217234900.GA429@bogus>
References: <20191217082415.14844-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217082415.14844-1-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 09:24:15 +0100, Arnaud Pouliquen wrote:
> Convert the ML-AHB bus bindings to DT schema format using json-schema
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
> V2: Add "ranges" property as mandatory
> ---
>  .../devicetree/bindings/arm/stm32/mlahb.txt   | 37 ----------
>  .../bindings/arm/stm32/st,mlahb.yaml          | 70 +++++++++++++++++++
>  2 files changed, 70 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
> 

Applied, thanks.

Rob
