Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C113AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1D22087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552342013;
	bh=e3qeIgAvgigXCOF0/IqnwW/ef15iWRPI6wvIzNob6zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LbnFM3k9j5KATUwsgL7riwFWrWVuqUpWdhfBt1kL10osuSDoC5YAFSSp4iH7AWUa1
	 qNTcaw8Jvq3VtfEwBRuexAoWapQMEjRva6uIDxhvXryPftfMS9FlWxYevrbcNQ9xNh
	 aKNnwBvkxfXQ0x52fy5ChBR3x2KKlNnFZIzPwy+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfCKWGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:06:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38764 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfCKWGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:06:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id m1so666996otf.5;
        Mon, 11 Mar 2019 15:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JC4zTqb1x8erp06ciU6x7MCTK7JGOSkY7SX+8G3xOI4=;
        b=Q9jAo0tPZv59Ml0M5LPKbh3coDvrBGY4h4A/Rk3tIexsOKpfNHh6DILq0yRaKhbSPP
         iJPIeigkKMZjiQgLNAcgRZLNxeesfjU7QL4eH5V6OGRMI2EJQmXo3Go43A6rSTizgpFY
         vjc3FDv2oqY2SCZUO0Jleo9mPtNyr7QlHUbZpBIrlwrbT7RnbXwkysHckJLeBnNfnxGJ
         +d0Y67w5IDnmaW0GoyaCHv7+SMmA6YAMvpY/1/wTQXv00FWXqSYPp7yr1OCgvA/ddI0p
         jzNkTLp1QQlCL6TiWh8Hl/46+k9FusTq71+U/SgwoWqf4nY20OhKollZkGbflauTF4M7
         zfsA==
X-Gm-Message-State: APjAAAWB51w4+3/rTKw6BznzecvnhyxAAxkAQYUcGiux7Dtim+QWklKb
        /hUtgxNh91Beb5/vdCsYHASt3BM=
X-Google-Smtp-Source: APXvYqwrYOI/MCxwgruCtoSnd7h4OE/EAXa4gjFtjtIVIvbfWAcE9VbEZqau7hiwYN7PUxnaEMa2/g==
X-Received: by 2002:a9d:630f:: with SMTP id q15mr22071133otk.153.1552342011116;
        Mon, 11 Mar 2019 15:06:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 60sm2976093otw.50.2019.03.11.15.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:06:50 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:06:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v5 1/8] clk: samsung: add needed IDs for DMC clocks in
  Exynos5420
Message-ID: <20190311220650.GB4082@bogus>
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190305101924eucas1p1147e3895a89a72c9db7d128d90dd3daa@eucas1p1.samsung.com>
 <1551781151-5562-2-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551781151-5562-2-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Mar 2019 11:19:04 +0100, Lukasz Luba wrote:
> Define new IDs for clocks used by Dynamic Memory Controller in
> Exynos5422 SoC.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
