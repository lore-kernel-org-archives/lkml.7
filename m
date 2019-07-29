Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ADCC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1B12075B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564393854;
	bh=b8uU2TFVwOTFei6ErM+Y6f1LMd2F2p8D4wkUO2zwyWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LgrphAiStA43Ah6fIV17U8IMMukMNz/LFYUXW60lDqG/Uz4q2CjrQWeZ2BhWuJHth
	 akzxdoGcLX7Yaz7KHU7bY62yfxck/pTgib0h7xlRCOQuNJJ674DKN097DxAgKbAUdJ
	 D//mC4RWVkQ/2GPSEVNVqmRUMVaa4/chbQTrkQtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfG2Jux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfG2Jux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:50:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A75206E0;
        Mon, 29 Jul 2019 09:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564393852;
        bh=b8uU2TFVwOTFei6ErM+Y6f1LMd2F2p8D4wkUO2zwyWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OerbQvxuSWKHGKK+jRP4HMC0+QybjVIuGpBajz4cNofhdz9ZtFm8+DQvapwrTHDbo
         REuyvW7uz/2+1xngBLsupMV0rUbJTfdqP65lU4m/8n/itmZ9zYMLuyN9E33D2E8rVm
         nLfDbV8JhNn/F167JLoj7/hbH5RVFLwYXcTae5mw=
Date:   Mon, 29 Jul 2019 10:50:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: build error
Message-ID: <20190729095047.k45isr7etq3xkyvr@willie-the-truck>
References: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matteo,

On Sun, Jul 28, 2019 at 10:08:06PM +0200, Matteo Croce wrote:
> I get this build error with 5.3-rc2"
> 
> # make
> arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.  Stop.
> 
> I didn't bisect the tree, but I guess that this kconfig can be related
> 
> # grep CROSS_COMPILE_COMPAT .config
> CONFIG_CROSS_COMPILE_COMPAT_VDSO=""
> 
> Does someone have any idea? Am I missing something?

Can you try something like the below?

Will

--->8

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index bb1f1dbb34e8..d35ca0aee295 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -52,7 +52,7 @@ ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
 
   ifeq ($(CONFIG_CC_IS_CLANG), y)
     $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
-  else ifeq ($(CROSS_COMPILE_COMPAT),)
+  else ifeq ("$(CROSS_COMPILE_COMPAT)","")
     $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
   else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
     $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
