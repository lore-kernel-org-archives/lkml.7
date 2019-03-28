Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B413C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D016820823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553795400;
	bh=LUA58tu6cdrhLbNHPm/cmAUIPrlVl/7XraUiRIyvLlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nzpOGQK+2VvtqGNXsi4o1HSwiUFWJYME/waiZHpImUY34Qbs+SOimyhgOtS0krukx
	 O/ArJXiAjkqanKTZRx8pVc/oX3p2I4Q20XhdlNZ4Kw35AGZWBmGGVd+H7mFHlZHoXK
	 VxSkWOqt/i8nn0uZ0/2/45+ksxuNLd3bzGeZcGLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfC1Rt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:49:59 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45813 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfC1Rt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:49:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id y84so16445952oia.12;
        Thu, 28 Mar 2019 10:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ISi29fPhBoThfjpwbIx5DUElvSLFtzz4I0c0kbgrZD4=;
        b=i8p7jZALWZsSq3m4wT1dgQ17JQZ8iB6E+hMKUx6IbvrMgrnQZmPJB0AQUt4uNDuDx+
         /NXb6lf7jZMtYnbNYS6GO8gFzSu/hr1g/wZ3E5C2b1g6CnEVXCALPioQFjyVcwcWLEi/
         XtgIUoxyPobdfB4UB1yngvPSEYrG7ApS8A70Wvvddo8qMFW/2dollc6a/P7Ao5si5A+1
         SM4HxIUFf/fFmkW5kOmMEUcRLMjS0b0mjvc2FMRWwskQ2aCQSmtMDkf6L86PJSlyIcEM
         6RTrm9iqXhqLNNxeUiNcCwU1flLQfUdnpL7bMWjBXtLku/sDtOYTq9/r7/lZ7wb4Fgoz
         ZecQ==
X-Gm-Message-State: APjAAAVAvnOwKaQHOM+qcA9ITgFlxWaY+TbGsmsbeUe2XjB5Lzhh8hYI
        Y4CTbefAnnUoL8IdYKFFUg==
X-Google-Smtp-Source: APXvYqxeQNtht5vbJ1WA8Lr4s3gG0Tl/xTg71c1EugYAl0ziUMpTps/24ef8wi/ZBOI79wMOvkO+ZA==
X-Received: by 2002:aca:5242:: with SMTP id g63mr892435oib.116.1553795398549;
        Thu, 28 Mar 2019 10:49:58 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a198sm7645392oib.19.2019.03.28.10.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:49:57 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:49:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 mailbox+firmware 6/6] dt-bindings: firmware: Document
 cznic,turris-mox-rwtm binding
Message-ID: <20190328174957.GA14880@bogus>
References: <20190315005926.5994-1-marek.behun@nic.cz>
 <20190315005926.5994-7-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190315005926.5994-7-marek.behun@nic.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 01:59:26 +0100, =?UTF-8?q?Marek=20Beh=C3=BAn?= wrote:
> This adds device tree binding documentation for the driver communicating
> with the rWTM firmware on Turris Mox.
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../firmware/cznic,turris-mox-rwtm.txt        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/cznic,turris-mox-rwtm.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
