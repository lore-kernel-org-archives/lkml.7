Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E495C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA4320880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfDIG40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:56:26 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:45259 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfDIG4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:56:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 58422184F4;
        Tue,  9 Apr 2019 08:56:22 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id SieTQC0JahzT; Tue,  9 Apr 2019 08:56:21 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 5F29A184DD;
        Tue,  9 Apr 2019 08:56:21 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 468741A088;
        Tue,  9 Apr 2019 08:56:21 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ADC91A06D;
        Tue,  9 Apr 2019 08:56:21 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Tue,  9 Apr 2019 08:56:21 +0200 (CEST)
Received: from lnxjespern3.se.axis.com (lnxjespern3.se.axis.com [10.88.4.8])
        by seth.se.axis.com (Postfix) with ESMTP id 2DEC52CB9;
        Tue,  9 Apr 2019 08:56:21 +0200 (CEST)
Received: by lnxjespern3.se.axis.com (Postfix, from userid 363)
        id 2846B800E1; Tue,  9 Apr 2019 08:56:21 +0200 (CEST)
Date:   Tue, 9 Apr 2019 08:56:21 +0200
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>, jespern@axis.com,
        larper@axis.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@axis.com
Subject: Re: [PATCH -next] pinctrl: artpec6: Make two functions static
Message-ID: <20190409065621.2yfx5nqzpuxyj46p@axis.com>
References: <20190321150909.3576-1-yuehaibing@huawei.com>
 <20190408180110.GA15199@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408180110.GA15199@archlinux-ryzen>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 11:01:10AM -0700, Nathan Chancellor wrote:
> On Thu, Mar 21, 2019 at 11:09:09PM +0800, Yue Haibing wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> > -void artpec6_pmx_disable(struct pinctrl_dev *pctldev, unsigned int function,
> > -			 unsigned int group)
> > +static void artpec6_pmx_disable(struct pinctrl_dev *pctldev,
> > +				unsigned int function,
> > +				unsigned int group)
> 
> On arm32 allyesconfig:
> 
> drivers/pinctrl/pinctrl-artpec6.c:706:13: error: unused function
> 'artpec6_pmx_disable' [-Werror,-Wunused-function]
> 
> This is the second time you've introduced an unused function warning by
> making a function static[1], could you please be a little more vigilant
> in your clean ups in the future?
> 
> [1]: https://lore.kernel.org/lkml/20190327050126.12064-1-natechancellor@gmail.com/
> 
> Linus/Jesper/Lars, should this function just be deleted? I'd be happy to
> send a patch doing so if that's the right course of action.

Yes, that function is unused and can be dropped.

> Thanks,
> Nathan

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
