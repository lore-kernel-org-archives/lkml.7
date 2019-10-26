Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFCCCA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 00:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3066B20679
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 00:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572048988;
	bh=lxiQMQRhiJ7h12cVrS4AdDCd1f4/4PZCwviYciLvcks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EjvRZ+TpG/AR9V6zdb0ff7zuiTL6+dXH7cnn/qqQAh6JD1NGwmzHAGy1yxYrSDzH0
	 bHJ348RauIozf0lujfafXOBZpkQFvdUhakfvV22zkDyjsOWNEEy3c4mJtQH7Eg0ege
	 ecNVtd1kFK6MmqOsBAtEiT5uPETXqfq0JoB+UUOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfJZAQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 20:16:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44015 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJZAQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 20:16:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id b19so889713otq.10;
        Fri, 25 Oct 2019 17:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=maK3FFwJzq/lCZMAegdLHsYC4aagUrxvxTswIaSlOUU=;
        b=obnr67zftsVZ/Z+HWvMs6a7BvQRc8pk2jkyBJoVxrzZxTCMLqGC9WxPkpkaHn7VuuV
         QI9ZFq0Ljm01qpOTgkA9XmQ3XPJQlW8QKUf5Rc0t2Qx/UpoQC9TsM4HP48ihEFB2AuAc
         yrS+hwWYwTrACtU0mfvZknABW6Z82a3nQLA1gJPAFeyNPgXAQYgX35ProDric8hdfCoK
         CxCcascbd/TKZlOC8gJO14N3BY/XzWIdyt7tGKjLt14OerK+4zupNat7iXtWTViDiF5n
         zEDCDiuT5ux0Z+4XCi4Po6YhWgSQf2P0OcijAlB4OgnETr8HydqR8i8EfGhRBDbXISUB
         s1Xw==
X-Gm-Message-State: APjAAAVcAD37mX8+3CMo3Z0IpHr7X54Y5BAEomViDlGZsubsZoRNVjTU
        eCedt6VoCJzumMMtKxaKRw==
X-Google-Smtp-Source: APXvYqyTvYVQL2eSr8VqPZVVbg+Et1I+b3zYBzX7DsBds5oAcRAE5Ipdjzk1F5veI5S8s66doEkyeA==
X-Received: by 2002:a9d:7d09:: with SMTP id v9mr4909005otn.292.1572048985772;
        Fri, 25 Oct 2019 17:16:25 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o5sm1228079otl.73.2019.10.25.17.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 17:16:25 -0700 (PDT)
Date:   Fri, 25 Oct 2019 19:16:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 02/11] dt-bindings: reset: Add Realtek RTD1195
Message-ID: <20191026001624.GA4883@bogus>
References: <20191023101317.26656-1-afaerber@suse.de>
 <20191023101317.26656-3-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191023101317.26656-3-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 12:13:08 +0200, =?UTF-8?q?Andreas=20F=C3=A4rber?= wrote:
> Add a header with symbolic reset indices for Realtek RTD1195 SoC.
> Naming was derived from BSP register description headers.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  v2: New
>  
>  include/dt-bindings/reset/realtek,rtd1195.h | 74 +++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 include/dt-bindings/reset/realtek,rtd1195.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
