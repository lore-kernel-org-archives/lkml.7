Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCCEC388F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A620321850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569595609;
	bh=+KaGiiABbHBO3dgDicqG8pPa18O0gP0pFJhWMqNuR2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vX61fWIH7UKV2/yLtqr26YM5G2JCiGD72GimthEgSGetq/wPiAqU8TTwYD+z5XIvh
	 kgxV2ceEqnGVJxR3aHBdub+4OPyUXxx/KSjFhxZJj29QklN4lZc5yEGGql+n77W8Oh
	 HoEfob5VZTJ0ugfJbH7m8rDtj4k5+pZb5D68S3Ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfI0Oqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:46:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43074 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0Oqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:46:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id t84so5389837oih.10;
        Fri, 27 Sep 2019 07:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=aZlVgMJaT7rOPZiM8w7rcStZg44fT5gbKnaXVG1cXG4=;
        b=d/dLiEYpc/VR3Zpbi2P2OY4kiOvD0OO06NNNQ4pS+DvKyhRyaie/gXPPWnJ4ioSQt1
         zoKR+U41LI7efmlJSoAey0eoCCjmgdLmtevdMzIEE0D1a7BzmiqOKFi/UpFIlv0hzl0y
         YFxef7G9mCZ22QAh80zbrWbv9w5+tAMrUCWDeMsqvZkNXS6MVc5yvWFgjsXHbPwgPq2u
         F4asSAUlbyAIgn+zBLvUsWpQgPu8C6eY4S7D73VIZR1KnMcONJU1Mhs+z6afF/Avo/S6
         tbhOy6f22ck4TDOms1p5HyTJaH25fkScTWR2avmZTasoL/pm8g0ywj470YfbOPGqde7e
         N5Yg==
X-Gm-Message-State: APjAAAXR3rdb0KcMgxTNvjGB2TgNSP86koqNfGFBqFqyeMI05aLdmadY
        zo+H0hpc06RvK9KHvNrZqQ==
X-Google-Smtp-Source: APXvYqxPbMBIvHsxs6cuZVhSV/0Gm2UOo+hy9NETZjaT93OQV818ipXiGvv3w5uchztu7d7QZeGISw==
X-Received: by 2002:aca:5ad7:: with SMTP id o206mr7532882oib.59.1569595607838;
        Fri, 27 Sep 2019 07:46:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 38sm1025737otw.28.2019.09.27.07.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 07:46:47 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:46:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V9 1/2] dt-bindings: mailbox: add binding doc for the ARM
  SMC/HVC mailbox
Message-ID: <20190927144646.GA1921@bogus>
References: <1569377224-5755-1-git-send-email-peng.fan@nxp.com>
 <1569377224-5755-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569377224-5755-2-git-send-email-peng.fan@nxp.com>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 02:09:08 +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> The ARM SMC/HVC mailbox binding describes a firmware interface to trigger
> actions in software layers running in the EL2 or EL3 exception levels.
> The term "ARM" here relates to the SMC instruction as part of the ARM
> instruction set, not as a standard endorsed by ARM Ltd.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/mailbox/arm-smc.yaml       | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
>

Reviewed-by: Rob Herring <robh@kernel.org>
