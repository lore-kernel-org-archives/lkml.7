Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC59C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722612077B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578500659;
	bh=AyZDBjBocC+JhoC3jD/7qgF1YLP3XWBZtmk2w6NbWac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oJjsiDES/zBl74txGno9gMBTqD68qL/Id8u1SXudl4NgqHqapDmUXo1zwfryicFe0
	 vV8oNZf7tEfLYwVXzlgp67iX6ugbxVuFSS09eq87ADWvtz33N7KlLDsqQRks8xUvgH
	 AU6LfR4iq6DrksPUn8Vjxq+mK2BbkVecNnvqaBZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAHQYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:24:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgAHQYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:24:18 -0500
Received: from linux-8ccs (x2f7fcda.dyn.telefonica.de [2.247.252.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 704A02073A;
        Wed,  8 Jan 2020 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578500657;
        bh=AyZDBjBocC+JhoC3jD/7qgF1YLP3XWBZtmk2w6NbWac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uyJe6V3QLr8RurNjtkir+jhSsDNMC6vX/zU8V2moHR9Fz16neK8AIDepB+eab7aX+
         ln1RmzBoN3lSyws4rXmplzV7polKkGFNp0Pz6qt1DY/JWpUJAtOxdX+VY5YddlpimR
         SnoyQAvDOaHowFyeg+NxHubnQxjveIzFSChawZDw=
Date:   Wed, 8 Jan 2020 17:24:12 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mbenes@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: Fix memleak in module_add_modinfo_attrs()
Message-ID: <20200108162412.GA12869@linux-8ccs>
References: <20191228115455.24088-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191228115455.24088-1-yuehaibing@huawei.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ YueHaibing [28/12/19 19:54 +0800]:
>In module_add_modinfo_attrs() if sysfs_create_file() fails
>on the first iteration of the loop (so i = 0), we forget to
>free the modinfo_attrs.
>
>Fixes: bc6f2a757d52 ("kernel/module: Fix mem leak in module_add_modinfo_attrs")
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks!

Jessica

>---
> kernel/module.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index c3770b2..8ec670e 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1784,6 +1784,8 @@ static int module_add_modinfo_attrs(struct module *mod)
> error_out:
> 	if (i > 0)
> 		module_remove_modinfo_attrs(mod, --i);
>+	else
>+		kfree(mod->modinfo_attrs);
> 	return error;
> }
>
>-- 
>2.7.4
>
>
