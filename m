Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D015C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0394206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553786784;
	bh=oOwfSlxQcppO25DWRk5u3q+aHSqnaHmxWprpO3RwIE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u15ZvMThtMNPJy5t/Y3wHJmCpmZEnA0XipNOr3XQKi4oaciaFxito5dyvw47CxYB5
	 HkrQe+ob7r1048xZza9O6O1cc+XPS/0oPx4PcMotMhWOTBS3Xxsv8VDPz/8uY1EQNI
	 jbbu4qtjGsbFYsP5jK2sAkT1o7s7GaPQyJpstL+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfC1P0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:26:23 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33376 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1P0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:26:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id e5so4491276oii.0;
        Thu, 28 Mar 2019 08:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P4iI5WXlMDM3+XrE7fOsF1r063RsIWJpQtQhD554+gM=;
        b=U3DJuRyWMPHhXblOJIk+DsZOmHveGGr3m6XWed5e7os6jD9XIBYU1+3leyqXtUVqyN
         u/eUy3RtHXIGmCOe94SP8UTPgVNzxUnJMqyNAVYkEi/IQKR/VGejl+9AeZhHPtA6uBB3
         9+OZ5ygPm7Worc66U7bl12ijIoqPsW+HA2eKeNVH9yliNreiYBQq0GT8GoGKeq6M7dXc
         quuP2yWk4k92WQR+v6R3m0lx3a0VyBBBhJQwvOL6oJwn51xchu8BrObw15mgVdYTwyCL
         eKfdeABQmmFwRpCsNed+9CStBu98uHeYmJQ1G8f42YcLeKvy23ciXNORs4FM91+NiM6C
         FGOg==
X-Gm-Message-State: APjAAAUsmcOqJYbcwhXEWsJKj8DrXPaoOpzOoL7SkuVYx43PHW7Ob9LH
        4+xxFDLa9dqClNHNCxeoLDJPiUw=
X-Google-Smtp-Source: APXvYqxunEFyZV0gb6pIjteYxv6fDPQ22Yi0ku6pjidTNyXNR9wQdgx9hKliEz5jHJ1vNQnWnxVgxQ==
X-Received: by 2002:aca:5904:: with SMTP id n4mr398279oib.122.1553786782371;
        Thu, 28 Mar 2019 08:26:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a34sm2978767otc.46.2019.03.28.08.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 08:26:21 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:26:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 3/6] dt-bindings: hwlock: update STM32 #hwlock-cells value
Message-ID: <20190328152621.GA1398@bogus>
References: <1552492237-28810-1-git-send-email-fabien.dessenne@st.com>
 <1552492237-28810-4-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552492237-28810-4-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 16:50:34 +0100, Fabien Dessenne wrote:
> Use a value of 2, so users can share hwlocks.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
