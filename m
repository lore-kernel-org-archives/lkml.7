Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61001C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372E921848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570026432;
	bh=1ImOMJ8oX6upXobqxOhukAIxxbBv3fnv5rBymQOCbao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EFTFU0oBn0UFmYH6hLq4seOwRDNjjoKTWd3kqQ6wAbqcI8x4SvMSNq9j4DkecepZF
	 lrzyE0ogbAq3Eganrk60GQZpjgLRMUFZFDyor1gBuYdwYANNRmIw5sLtNRIdajCyT2
	 6Kw7R2rnJE75GTRCrWIVbMSFYyIUQXCx5Xv6UV2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfJBO1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:27:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55526 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfJBO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:27:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id a6so7421845wma.5;
        Wed, 02 Oct 2019 07:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uObNUHqWJewvYqHBCnMGF7TkZjRFqm/2PPATnntgxrY=;
        b=aiRMBXFwZ2fx+4yDtABb/0BR0YGccfneZxjdhR/epXeq/VuTXoixZg4CwskzBYv1pu
         8xlEoCIkGVB5z6zXM0hXnOfgFbZ6ynIm7LwKRyKhStaLLkB15lgM4RmuhSNOfMGe2vo0
         /+D5jz1armXV7K+2FHVGTZZ1eZXDU0IgRrubdIwIs7eGX+jWYkBWz/1Kpad8crL6F0Cw
         3gC9t2Ktv188FiJeuLyWLGGtjmbNtM0Rv6KUl/U0qbUhX9ZxZQAjAGpVfJzuFtXCmTAv
         bhB2GHGElhC/CR4Fg2Z3rFAqkOZ0/yIqXRIkfz7c2Bg8MBHkGtcs0eyN5ni7JdZOoBZi
         VK0Q==
X-Gm-Message-State: APjAAAVVmfRlcWHNlktNo9EtAiax3c5hUvF2n9vnkh7ofsqVXJMTxPfX
        hxhdBDPtanoSWYMPRnYF8WU=
X-Google-Smtp-Source: APXvYqysX7HSYX87cRrnR2+oscG/k3IGiCv5SJ8a7cJKlBjiDbbsPBGuHSOfaCiO5IvNEEqeSzk9Nw==
X-Received: by 2002:a1c:a7d2:: with SMTP id q201mr3036457wme.146.1570026428477;
        Wed, 02 Oct 2019 07:27:08 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id u10sm37896458wrg.55.2019.10.02.07.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 07:27:07 -0700 (PDT)
Date:   Wed, 2 Oct 2019 16:27:04 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [RESEND PATCH v5 3/4] ARM: dts: exynos: add initial data for
 coupled regulators for Exynos5422/5800
Message-ID: <20191002142704.GA15827@pi3>
References: <20190808090234.12577-1-k.konieczny@partner.samsung.com>
 <CGME20190808090252eucas1p2afec3e288965bb7e7aa6f96f67686273@eucas1p2.samsung.com>
 <20190808090234.12577-4-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808090234.12577-4-k.konieczny@partner.samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 11:02:33AM +0200, Kamil Konieczny wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Declare Exynos5422/5800 voltage ranges for opp points for big cpu core and
> bus wcore and couple their voltage supllies as vdd_arm and vdd_int should
> be in 300mV range.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> [k.konieczny: add missing patch description]
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

The bindings were acked. Can I pick it up?

Best regards,
Krzysztof

