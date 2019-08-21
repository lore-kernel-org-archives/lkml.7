Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E5DC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE85F2339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566377470;
	bh=f3s88lPNH/dY9osiPrQr5NXYKI7UrqZXDNRWl0J91sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R+8TeB9paO9IzvYq9/qhFRkYPb+UrGXlpYvqdEUhnYV/XA0/CttT2/XN8nfUOeTWF
	 qiTqQ/sA8JqkfxPuWDggBXz+INNk8moit+tqa759sDMOYsLPSkVscGEMRQ01nscibi
	 lWPYzyjnG/6UVxG4ub5AD04JvTe3Dn7ZQaGcNInY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfHUIvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfHUIvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:51:09 -0400
Received: from linux-8ccs (unknown [92.117.239.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC0422D6D;
        Wed, 21 Aug 2019 08:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566377468;
        bh=f3s88lPNH/dY9osiPrQr5NXYKI7UrqZXDNRWl0J91sE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIMdrRd4TMB+wOCdZPMyZ+4XNb7X70hjjl6xdS3sK94U8F2PBXqHPvQ15uT2YqV+8
         vCDT8XjvnFwxgJ84AHxPOVdBVKU+USmKm85TAic0a6IKdhBymW1OqG/YI6gugQ+vZl
         k7aLEaPTU7qIuMIaBtKccr3a9gPlZTNWUA0peT5U=
Date:   Wed, 21 Aug 2019 10:51:04 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     zhe.he@windriver.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modules: page-align module section allocations only for
 arches supporting strict module rwx
Message-ID: <20190821085104.GA8668@linux-8ccs>
References: <1566312790-253213-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1566312790-253213-1-git-send-email-zhe.he@windriver.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ zhe.he@windriver.com [20/08/19 22:53 +0800]:
>From: He Zhe <zhe.he@windriver.com>
>
>We should keep the case of "#define debug_align(X) (X)" for all arches
>without CONFIG_HAS_STRICT_MODULE_RWX ability, which would save people, who
>are sensitive to system size, a lot of memory when using modules,
>especially for embedded systems. This is also the intention of the
>original #ifdef... statement and still valid for now.
>
>Note that this still keeps the effect of the fix of the following commit,
>38f054d549a8 ("modules: always page-align module section allocations"),
>since when CONFIG_ARCH_HAS_STRICT_MODULE_RWX is enabled, module pages are
>aligned.
>
>Signed-off-by: He Zhe <zhe.he@windriver.com>
>---
>This patch is based on the top of modules-next tree, 38f054d549a8.

I've applied this. Thanks!

Jessica

> kernel/module.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index cd8df51..9ee9342 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -64,9 +64,14 @@
>
> /*
>  * Modules' sections will be aligned on page boundaries
>- * to ensure complete separation of code and data
>+ * to ensure complete separation of code and data, but
>+ * only when CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
>  */
>+#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
> # define debug_align(X) ALIGN(X, PAGE_SIZE)
>+#else
>+# define debug_align(X) (X)
>+#endif
>
> /* If this is set, the section belongs in the init part of the module */
> #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
>-- 
>2.7.4
>
