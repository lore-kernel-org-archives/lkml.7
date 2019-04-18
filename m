Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AEDC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B37F205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555599875;
	bh=1obieSZeAqxPEBqp/zIDu8H8hmwx7rRo80arlcHa6UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K6NsfvE81gqPJqt2BzYGcD49upicWme0nGbziQUmbfO3U01b1LvQ+A7FwNGQR9eze
	 pCccO1vVleMu428WgUrWst8UG51rlgIz7GTmH5cTJquJjYlI/wBAjUcnv0N0mXsrbo
	 vYOdIYnyqkXY7QfjgonHYE1d5Rzj+UBtPLdWHeJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389394AbfDRPEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:04:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46836 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbfDRPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:04:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id x188so1821158oia.13;
        Thu, 18 Apr 2019 08:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8yYHZR9XsTRngB6MgERHQ/m026i3HmmJTeQkFP57/Vk=;
        b=ebXMb1rQ/CAWEwDZPpJoy5+BjPR1t1l4J9T+oX4y83PulCOROi9ZyXZiuZAUxhSHX2
         xf/wpPK6qSY2QQJ0G4PZqcG2feSsbPErGtCYhpAtwFyeArpC/eRFo+tjlVWs7qTB0fT6
         RXZvKEOHFxhqxSy4rGUcZe+cmISl9kzAAYLc5MdH5oz/EZ94NydvjJTY0JlxTZrBNaaL
         /F+Qb9fLBtJMkjajA5Ql/Btr26evVlSQdAfUVu8St1+RGE0HyEc5rjDgXAxXk/W7Xrd7
         8NXWrk73ANsJrSg5UyNCu0PXbaB1fpSAMfiOXazlkHWHQn1Sq/TtMltRrJJS1j0eHjmP
         vafg==
X-Gm-Message-State: APjAAAXbG4DXcLKZYPQ+B1zqYM6JuuxXDuCLkK9iJm0P9uv9ZmBXHvcs
        vtW8xoOu1Ys7MsN6lxkOCg==
X-Google-Smtp-Source: APXvYqwhqCO/+ZmlCFLaLOnozBaaltgv6HFqhBwn22K0cMBcZb0P5sYLb/X62uMUaA2jwW3Xk+hkvA==
X-Received: by 2002:aca:cc8c:: with SMTP id c134mr2376193oig.172.1555599872743;
        Thu, 18 Apr 2019 08:04:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l5sm848892otr.53.2019.04.18.08.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 08:04:32 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:04:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, m.felsch@pengutronix.de,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Jacky Bai <ping.bai@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 3/3] dt-bindings: arm: fsl: Add the imx8mq boards
Message-ID: <20190418150431.GA32345@bogus>
References: <20190417165514.18689-1-angus@akkea.ca>
 <20190417165514.18689-4-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417165514.18689-4-angus@akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 09:55:14AM -0700, Angus Ainslie (Purism) wrote:
> Add an entry for imx8mq based boards
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
