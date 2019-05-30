Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0928FC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BAA25874
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559216744;
	bh=PhpF5tEM5wgtOzjgxk8gsiTVeBRVqa+xs5QiBuiQcrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LsX/Hx6+LAiJ7OVlGPZX1JpnYoEXgizIdxvLDWVLmcGv3yThfdDHU+zgdQBOVZUya
	 FHmJlQDfr1tC8sqCBWb43QagE5kRB34OAhhsAABueov6yqbtxRiQe1YJkr2xlCO9qa
	 0CbnsKAYl0GdtabNo7znv41qBKkbMbKxoWhkWN3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfE3Lpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfE3Lpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:45:43 -0400
Received: from linux-8ccs (ip5f5adbeb.dynamic.kabel-deutschland.de [95.90.219.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB0425870;
        Thu, 30 May 2019 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559216743;
        bh=PhpF5tEM5wgtOzjgxk8gsiTVeBRVqa+xs5QiBuiQcrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dH0gu+IC0B4jHeNfuao4WOi7JoZZlITyASxX335fAyu8Uk5+341UNgBy6Cs1fUtUc
         w5pJmmMRWYkRzQjI4bUwfYhBSf2cBriWhb3O8bortGeBgm3YofafT8zLFWJUpitNzK
         nGte1hr23hVHiqm9//hCUjmlSCX4mFeX49a6ux3s=
Date:   Thu, 30 May 2019 13:45:38 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        paulmck@linux.ibm.com
Subject: Re: [PATCH] kernel/module: Fix mem leak in module_add_modinfo_attrs
Message-ID: <20190530114537.GA16012@linux-8ccs>
References: <20190515161212.28040-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190515161212.28040-1-yuehaibing@huawei.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ YueHaibing [16/05/19 00:12 +0800]:
>In module_add_modinfo_attrs if sysfs_create_file
>fails, we forget to free allocated modinfo_attrs
>and roll back the sysfs files.
>
>Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>---
> kernel/module.c | 16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 0b9aa8a..7da73c4 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1714,15 +1714,29 @@ static int module_add_modinfo_attrs(struct module *mod)
> 		return -ENOMEM;
>
> 	temp_attr = mod->modinfo_attrs;
>-	for (i = 0; (attr = modinfo_attrs[i]) && !error; i++) {
>+	for (i = 0; (attr = modinfo_attrs[i]); i++) {
> 		if (!attr->test || attr->test(mod)) {
> 			memcpy(temp_attr, attr, sizeof(*temp_attr));
> 			sysfs_attr_init(&temp_attr->attr);
> 			error = sysfs_create_file(&mod->mkobj.kobj,
> 					&temp_attr->attr);
>+			if (error)
>+				goto error_out;
> 			++temp_attr;
> 		}
> 	}
>+
>+	return 0;
>+
>+error_out:
>+	for (; (attr = &mod->modinfo_attrs[i]) && i >= 0; i--) {

I think we need to start at --i.  If sysfs_create_file() returned
an error at index i, we call sysfs_remove_file() starting from the
previously successful call to sysfs_create_file(), i.e. at i - 1.

>+		if (!attr->attr.name)
>+			break;
>+		sysfs_remove_file(&mod->mkobj.kobj, &attr->attr);
>+		if (attr->free)
>+			attr->free(mod);
>+	}
>+	kfree(mod->modinfo_attrs);
> 	return error;
> }
>
>-- 
>1.8.3.1
>
>
