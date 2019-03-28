Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECF9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45442173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553791908;
	bh=9OAeMI3+dMn9aFyPn/hJd1WrAIdUY/pLGMF/dFEhYZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G1AWS4hhw1Ha+raUE8LH7kfCdRV9ZX3It25t9WDDjP2DCjJZghqgictpUiMYHuChM
	 FGc5DX3u/qXUMRyST++FGgOyTEnlIGOGaj2csepg1A8yrZohZupd4YlYs1xxdi4kZa
	 xgtyDWWOL7oUHZa+bvvhqzMlqYnRRFVEcDKhusXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfC1Qvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:51:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37279 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1Qvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:51:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id c16so18991244otn.4;
        Thu, 28 Mar 2019 09:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ECk40koolZrzpUwuU5xrny1sHSm2kwPmhfs96yx6Ji8=;
        b=IPNQpGf8RM6iB+WgPyzDF6YXUdMuVvTC+VTtCoh5x8LNj7oezdNCQy7rsUqdk3+CGr
         Y/lYpQfNZ4eNRL5PAuZsH1FF7i3/U+JZ90ZpKdIrHhmlsfULx+dsG7OmmYlLbbXZe+w1
         RKw+rth7Pnn8C0iiWFTfjjH4DvKzEwPC8olRMPoVmo4u8t0+EByjR2X/96aUpTICUYsu
         F0whCt+Exn258jIXYkUl2LmyXwndBznzS7koc9D8fgcTrZleKSsE42zGTjnY7fpop/dp
         zPmn9P5Ek//HjjDmUuKyC9kbp5mg4W0TXTmwrEzx1l9yJ0zHltMwHNYuhJHsoAETIyyB
         EJxg==
X-Gm-Message-State: APjAAAXIIJul5rIAKF0XZInTPZ2tn8OYnv7bITiMBz5Kf7dHXMkmr9vF
        AbKpTqOOj2XUmI5G46cEcA==
X-Google-Smtp-Source: APXvYqzbcJNs3CNsNQtxiR+18jGZfbTxJfYUPCDIFjMTZfEkOPr41viaRjRsZnmGOzMaGxj1cMVPAw==
X-Received: by 2002:a9d:7306:: with SMTP id e6mr30251346otk.79.1553791906879;
        Thu, 28 Mar 2019 09:51:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u198sm10596253oie.26.2019.03.28.09.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 09:51:46 -0700 (PDT)
Date:   Thu, 28 Mar 2019 11:51:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V10 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Message-ID: <20190328165145.GA30395@bogus>
References: <1553582817-29519-1-git-send-email-Anson.Huang@nxp.com>
 <1553582817-29519-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553582817-29519-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 06:52:23 +0000, Anson Huang wrote:
> Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V9:
> 	- update compatible to contain SoC name;
> 	- update example;
> ---
>  .../devicetree/bindings/pwm/imx-tpm-pwm.txt        | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
