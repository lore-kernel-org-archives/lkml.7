Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E21C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C7F205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555599907;
	bh=QNWy/JFKVSVqS1Oiax7CsW2ogEfydBHU6GygayAYzRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B/IwD9ImLsyZzfVGGQy5B5TdKpNcjujP/pUrm9emLoTjW6G7WW4UlHWqxLWr89vBs
	 /WRsJ0drxVEq8B380gVa4CcXwDEJ7OjO4PXqLounsyZaPYM5xyChywwpVEXMiHJUwS
	 trnRYeNdruE8IDeH5QqtZggiS61WP7O+PMurChI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbfDRPFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:05:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38817 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388535AbfDRPFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:05:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id e80so1980972ote.5;
        Thu, 18 Apr 2019 08:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V7yyMZqesOuFe8KRex8C/Gjge0wo8uE6UhNgDAxEDPE=;
        b=LofknGEgkhur7S2lN/pBPrKc/HjkhPqtTKMHH1UIHYN+lnrl1jG3N0TkTmt/lfSVkf
         FkoTlzEvSyvKW3sN99jZ0k4vy3kLJg6C3QZe3YnIZza+yarLdqBxMrEhPQQGCCvUG/+9
         lDPsnCyAQBw35C5VUF0EEHunDZYbsSSDyIy6XGJyM6iPVdbKZay8mTitScg76JLXbuOo
         l5+jW+pv3XjWp7sKwLLR0YmWDMvmkErfhQ1x1SP/dkGRs79w/rSPBUI2TScZo7DjaoPd
         a1bDq1SXjW+J6sD5ODJ3Hpl0zK9EZgBcF3D+WL/jvujL4q3LqGEABc3PcgWM66CqcnW3
         MYSA==
X-Gm-Message-State: APjAAAXLFcNglcS/b1CFSN0Vx4H92x2qZk+oJT3fOZoOIHdRv3C6uGiu
        xASKpUr/POjakUGpiXPnFw==
X-Google-Smtp-Source: APXvYqxnX+SqxhzuN9Z90GAVvPB8qzwCECqAfFNDBupi9NMvpguaaL7AqBs0B+hBaW3bOhvztohAcA==
X-Received: by 2002:a05:6830:153:: with SMTP id j19mr53931748otp.248.1555599905277;
        Thu, 18 Apr 2019 08:05:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u11sm841311otb.66.2019.04.18.08.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 08:05:04 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:05:03 -0500
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
Subject: Re: [PATCH v5 2/3] dt-bindings: Add an entry for Purism SPC
Message-ID: <20190418150503.GB32345@bogus>
References: <20190417165514.18689-1-angus@akkea.ca>
 <20190417165514.18689-3-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417165514.18689-3-angus@akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 09:55:13AM -0700, Angus Ainslie (Purism) wrote:
> Add an entry for Purism, SPC
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
