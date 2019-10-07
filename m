Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4449EECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1816920835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lHDLUYMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfJGUsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:48:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfJGUsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MaDRDJd0gY18fvN84d3T8W7Ycs79NWi/U73rlVIKX48=; b=lHDLUYMrYDhSJMak0iydYfXuz
        dkEEffSbsCmRSSQjk7mv3A2zl+JLVd0MM2kriRQUVz4ydnrGbJDIPKszLul00gaZ0PQfUg/VWXdbE
        dYphxvbL1BmnqwEvoYwjK0flY5NohIH3cRya8k0KhJJBUTINsb6OV/0YYGBZ17celG3wI2wCErrnJ
        15tfUAic1G6aSrkLlfD1FDsj+2TOtriXWZT5WoJ2S/GLZkY5XSvVvfdOclsVQCAe2N9OPCiVJBYl3
        PyUw9q5XtS2JHqXLPRGHox/H+K8ksFZ7kFouRy0ss+PpzOTMjTqOzg9ouI+DAipqyCuQDLBqDyiR9
        Ob0w0R6NQ==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHZvN-0003ly-In; Mon, 07 Oct 2019 20:48:10 +0000
Subject: Re: Build regressions/improvements in v5.4-rc2
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <20191007071829.13325-1-geert@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f0250c51-a653-6cac-9e6b-affa74d8559c@infradead.org>
Date:   Mon, 7 Oct 2019 13:48:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007071829.13325-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/19 12:18 AM, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.4-rc2[1] compared to v5.3[2].
> 
> Summarized:
>   - build errors: +10/-3
>   - build warnings: +152/-143
> 
> JFYI, when comparing v5.4-rc2[1] to v5.4-rc1[3], the summaries are:
>   - build errors: +5/-10
>   - build warnings: +44/-133
> 
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
> 
> Happy fixing! ;-)
> 
> Thanks to the linux-next team for providing the build service.
> 
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/da0c9ea146cbe92b832f1b0f694840ea8eb33cce/ (233 out of 242 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4d856f72c10ecb060868ed10ff1b1453943fc6c8/ (all 242 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c/ (233 out of 242 configs)
> 
> 
> *** ERRORS ***
> 
> 10 error regressions:

>   + error: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!:  => N/A

Hi Geert,

What arch & config is the above build error from?

Sorry to bug you about this.

Thanks.
-- 
~Randy
