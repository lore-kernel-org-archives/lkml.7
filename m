Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1703C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA6A20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FnGJ92n/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfDCP1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:27:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCP1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S6NYoJrZ/veLL2w7VR6EZsl0qg+PNL9w8W7cjvQvY6Q=; b=FnGJ92n/3MH+49wCKz493YBAj
        cZzxZoKEF/Vxv3SSxwUUS4nmmTIj9KouBb17sJllgaFCVqSzlOFt6+yOKgD34OlozgiNfDZOTNFYs
        Hrvcvii4cOYLLKNi94P/7bHznuhNChihDoWaPDOaGe2Aj3Ys1yOF1NBFTUH0XEbQ2HGfBiBM3/V4i
        fWT3drdY57OrIRucCxUNm/nzP81Q1+wluKlK4Vyuew1VKjyNATjRBYkaM0vNMASnFlZnGIRPcsTsB
        mT0TOIraxW01HkCTCL7Va4nvn2bJaMPtLmfmyFQJKQTGpGlz/bxe5B8vEJpmMRho7Ad+tHrBQXqxl
        ywWZhavWA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBhnL-0002Eg-7L; Wed, 03 Apr 2019 15:27:19 +0000
Date:   Wed, 3 Apr 2019 08:27:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     trong@android.com
Cc:     oberpar@linux.ibm.com, akpm@linux-foundation.org,
        ndesaulniers@google.com, ghackmann@android.com, linux-mm@kvack.org,
        kbuild-all@01.org, rdunlap@infradead.org, lkp@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] gcov: fix when CONFIG_MODULES is not set
Message-ID: <20190403152719.GH22763@bombadil.infradead.org>
References: <20190402030956.48166-1-trong@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402030956.48166-1-trong@android.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:09:56AM +0700, trong@android.com wrote:
> From: Tri Vo <trong@android.com>
> 
> Fixes: 8c3d220cb6b5 ("gcov: clang support")

I think this is the wrong fix.  Why not simply:

+++ b/include/linux/module.h
@@ -709,6 +709,11 @@ static inline bool is_module_text_address(unsigned long addr)
        return false;
 }
 
+static inline bool within_module(unsigned long addr, const struct module *mod)
+{
+       return false;
+}
+
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
 #define symbol_put(x) do { } while (0)

