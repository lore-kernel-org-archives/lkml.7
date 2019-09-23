Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F89C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 07:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0706E2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 07:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569222806;
	bh=x+yd3boIMCsHaSZk+TqzekVrhgOFXF6EFImnFK48aXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Duw5Rj+5N34wmViYCLtE1osDjIy3gqGQzqexbSDQZ6Jm2GoiU6Q7DsG2rxo1RFsMF
	 BgQnFea/52y4GfQEZsExVn/RdhuQFo91BOuCqI0EgTmiqMcLy+jc0bbC053T9Els9E
	 saTlz8C2OJFUtzrJp8VxcnbdEXua+nsrGt0dlNzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfIWHNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 03:13:24 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33925 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfIWHNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 03:13:24 -0400
Received: by mail-wr1-f51.google.com with SMTP id a11so12651962wrx.1;
        Mon, 23 Sep 2019 00:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VSmtFloVdT4HdH3hqBjqDRmLKrDCbhhNO9xFa74XQG8=;
        b=G3D9JQFe1aD/VVzJlK3yQVrMZ1uDbaxPU5zwYdUMeeJFm2VhiIYSh9yEdXGY9DPAuN
         lKIbFbVCtESG9c0aEpkNV7b6kAaWeQTqSlx+9BUipngGskHZsKdgi+Lx5Z0WFdYku3Jt
         M5piux6/h3te81uz4TcotcC2IA2Mu2Udml+0JlpQZq8+eWnfWRx70Vk37bWwmswdBrcX
         IxmAJNAWp88xeYgh4F1F6L3RmCoboyUvzDXijEk6lozbhFxnpnqRPo/9Dmy4aX5pdNxp
         P/oksAL7Q36C9wivQJhy34pYj6h6cYAwID48lrezQ32y7bE3qPwJUqaQd2QSrmAfR00X
         cqrA==
X-Gm-Message-State: APjAAAUrRkh7z3puhKOCH6qxUKUF9NlK9WQ7j3lza/sJq85oB+7qKbO1
        I4/GV9g1Dx4pqPHSmpuGFi4=
X-Google-Smtp-Source: APXvYqzX7JpyywmwssCCGsX2MCih3fvE8W7RgPMGaeHxIMgUzIQu7rnAOAOtO0lypZquJEuBiDcaVQ==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr9285624wrv.315.1569222800656;
        Mon, 23 Sep 2019 00:13:20 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id a18sm20701185wrh.25.2019.09.23.00.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 00:13:19 -0700 (PDT)
Date:   Mon, 23 Sep 2019 09:13:17 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [RFT v3 4/8] ARM: dts: exynos: Remove MCT subnode for interrupt
 map on Exynos4210
Message-ID: <20190923071317.GA4246@pi3>
References: <20190921170152.5033-1-krzk@kernel.org>
 <CGME20190921203810epcas3p39f3d9e3224d2c5ef61c1e18df2ab403d@epcas3p3.samsung.com>
 <20190921170152.5033-4-krzk@kernel.org>
 <c1d02aa3-b5f2-1c5b-0b7b-8749e7c0ce9a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1d02aa3-b5f2-1c5b-0b7b-8749e7c0ce9a@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 08:56:46AM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 21.09.2019 19:01, Krzysztof Kozlowski wrote:
> > Multi Core Timer node has interrupts routed to two different parents -
> > GIC and combiner.  This was modeled with a interrupt-map within a
> > subnode but can be expressed in an easier and more common way, directly
> > in the node itself.
> 
> Maybe we should simply use 'interrupts-extended' based approach and 
> simplify mct node even more (get rid of interrupt-parent, interrupts, 
> size/address cells)?

Indeed, that looks like the tool for this job. Thanks for hint, I'll try
it.

Best regards,
Krzysztof

