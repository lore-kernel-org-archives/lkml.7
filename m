Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04A0CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D36E208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572374495;
	bh=TA13NVzsZV4FbAI5eOr9zzqul12jHNuS6K/b8+MtCMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O36B14R7pNWETXHcso/0ZURvVhKREogLXD6WxZm8DG+Jea3BDZZ8+6GJAQTGfjrtu
	 r83FibliArV1qzvZx5f/5b0xLdJeBcYqV7lwqRxeZ2BCVcqlz3SHcfIGc9MwAA/WTY
	 5ARRrvrc98aSINtp/8WCyv+wlzH3SFn+ZHXLYm0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbfJ2Sle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:41:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43793 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfJ2Sle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:41:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id b19so8328496otq.10;
        Tue, 29 Oct 2019 11:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lCcDgbdqbuBTEikUEcKsB8OyooPRstoWxTDmJWpZKMA=;
        b=gC4Q/CRjeDW1kgKk92b+hK6FliD/yMe4gddejIRtirW3E3NAmbu8ST1NFH5iMYfQPy
         Rqe7qz3jNlfu3Ff/Dt5OwlyGOs8H1R1CXthGYqaWBpL2RKjrT8RsruWxtvobo97g9dk0
         nO0Mhh7kz+Yhn2x4ZAOWAk3q0nFH9ObpPfBxlDhVe32Ob03RTAJAVU4QL4sJCA/dUHYv
         piOMebbQiOfjp8qL+ww6L5QbbLRrmMC/y21fJdMYhwtTUnE9GQXOvTjQJlGunQ2Fj/nu
         3nJaHlizuSh16PEIXPllpCPWBpbD8ygBziRlr0alaN5MHStsMG+MRjRKp4P/MKwY5gUt
         oA1w==
X-Gm-Message-State: APjAAAWn0tnwCWWJQLfThoqeSz9ys+rHBQDtBQRQpXS1Q7j7XI9Bj2gl
        xjoy/AEgXIAPNozgUFUN5g==
X-Google-Smtp-Source: APXvYqyVgC8Gsnj0NziyjeH40B60+G7bSv4Br+vl1MPHSuG6P0wTssUrdGYhc3TeATcb8OHCX8obxw==
X-Received: by 2002:a9d:5f89:: with SMTP id g9mr18830085oti.227.1572374493211;
        Tue, 29 Oct 2019 11:41:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y4sm4155556oie.42.2019.10.29.11.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 11:41:32 -0700 (PDT)
Date:   Tue, 29 Oct 2019 13:41:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wen Su <Wen.Su@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com,
        wen.su@mediatek.com
Subject: Re: [PATCH 1/4] dt-bindings: regulator: Add document for MT6359
 regulator
Message-ID: <20191029184131.GA3733@bogus>
References: <1571218786-15073-1-git-send-email-Wen.Su@mediatek.com>
 <1571218786-15073-2-git-send-email-Wen.Su@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571218786-15073-2-git-send-email-Wen.Su@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 17:39:43 +0800, Wen Su wrote:
> From: "wen.su" <wen.su@mediatek.com>
> 
> add dt-binding document for MediaTek MT6359 PMIC
> 
> Signed-off-by: wen.su <wen.su@mediatek.com>
> ---
>  .../bindings/regulator/mt6359-regulator.txt        | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6359-regulator.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
