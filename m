Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBA7C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCC1206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565893134;
	bh=jMzwekg0d9pAeBgkOsS3QfOFRGq068v+00mxvY/pD9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aeKVB9hQw+KcKw8q5xP0wz/AOb/52PRWN/DEjHIdsDUvk9rotJZxSooqsroB8rWNa
	 SrlJ5Ps1szgxE3fyzHBF0/sUG6xRBDmfkKpnxmbDjafll5D+v7t5V2P8iqR4AeQ06f
	 s619Cm5FfzLlQ3qkTLpmn6zdKWYtYIKSHVigzXeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbfHOSSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:18:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36371 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHOSSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:18:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so2019670wme.1;
        Thu, 15 Aug 2019 11:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5leAgXssmuJq/e90a7MyYuV3K+kXUHUhhkOK+kGTeCI=;
        b=BnnimLP4qlW5AnZuZHBLi6MSPvT+eQNFFh81qGkSRNGZ4JluQDg+Yi9I4xpi6ns8yH
         r58eWqh1mX6B5QBq9eDcGBUqU+JD76Je0iSidlbSfNheIlaAQvlwKTnlm6WP4ioh4y7/
         +Sh133iZ4Yhc25P6ubrYTHmzgGGVVi6cJEb+dnPRAFdmsuKcCH+y5eUstX2GxnmwsRAY
         4xNSrtXCu/yLCszeloTI3BhxfioLxDYPWyllGvxdWLkty1rdAIeX819VOOG/iiEl4fVA
         LtaCXNZLW7onrL4/mmWsmKwLrNdDWEcAb4VmbK3p20tiG9mazREaF93U+9C1hAHdMuhr
         VNaA==
X-Gm-Message-State: APjAAAV9cD4czObNnB5nZmhV/DKT6+Pup0YA38Lwsy2ZWQaNNzBoxvtQ
        9x+KyvsggXE3vQvxbiS6mHk=
X-Google-Smtp-Source: APXvYqzE6ItclCocP3PgZPG+mo57YgFsf9InExOzUcHhgjzT41/UMFtc8ufAeRAqH3HuEm/VsIuTiA==
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr4016971wmc.95.1565893130728;
        Thu, 15 Aug 2019 11:18:50 -0700 (PDT)
Received: from kozik-lap ([194.230.155.124])
        by smtp.googlemail.com with ESMTPSA id v65sm2874829wme.31.2019.08.15.11.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 11:18:50 -0700 (PDT)
Date:   Thu, 15 Aug 2019 20:18:48 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v3 1/9] soc: samsung: Add exynos chipid driver support
Message-ID: <20190815181848.GB14360@kozik-lap>
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
 <CGME20190813150850eucas1p2aff64b5edb49ffb6626433de1c9e58ec@eucas1p2.samsung.com>
 <20190813150827.31972-2-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190813150827.31972-2-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 05:08:19PM +0200, Sylwester Nawrocki wrote:
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> Exynos SoCs have Chipid, for identification of product IDs and SoC
> revisions. This patch intends to provide initialization code for all
> these functionalities, at the same time it provides some sysfs entries
> for accessing these information to user-space.
> 

Thanks, applied.

Best regards,
Krzysztof

