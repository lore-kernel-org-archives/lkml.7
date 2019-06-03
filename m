Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEBFC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B767B280BB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559558842;
	bh=Cql2az1OBhkCOJT4G/r6/wJd19LJBexin+i8h1nPh+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CeInJdu4w8yEgS8V01hKVLmbEeRN7l1VUvRmUBjGFuA67uZpJNzWFLNzCEpzFO7KU
	 hNMH6dEr1gPtglwYuYFH/wlkH9kXqZpvwDGf7bXP/k9/UR1kxLsEIj2wQfeB5pyeD0
	 yIaguw3NtVQWNOlMJThjqxR2qggGujOASIqi6jbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfFCKrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbfFCKrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:47:21 -0400
Received: from linux-8ccs (ip5f5ade7c.dynamic.kabel-deutschland.de [95.90.222.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB5C6280B9;
        Mon,  3 Jun 2019 10:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559558840;
        bh=Cql2az1OBhkCOJT4G/r6/wJd19LJBexin+i8h1nPh+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xXCKGzQDL3hP2iNqU4OyO7vRk37Le8G4Jimzfb16BbHS5FXG0fL1KFIhqn/gv28Ci
         NmNmCLxgUFW/cc4HgULvQqOIleJTD16Xrg8UtVSsa2VoOH4j738w+dC78v7mX1VMgv
         Y4cLVlQFf3kcun0H2yqiZ2NlHBECuLSy5cTmiZvA=
Date:   Mon, 3 Jun 2019 12:47:16 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        paulmck@linux.ibm.com
Subject: Re: [PATCH v2] kernel/module: Fix mem leak in
 module_add_modinfo_attrs
Message-ID: <20190603104716.GA21759@linux-8ccs>
References: <20190515161212.28040-1-yuehaibing@huawei.com>
 <20190530134304.4976-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190530134304.4976-1-yuehaibing@huawei.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ YueHaibing [30/05/19 21:43 +0800]:
>In module_add_modinfo_attrs if sysfs_create_file
>fails, we forget to free allocated modinfo_attrs
>and roll back the sysfs files.
>
>Fixes: 03e88ae1b13d ("[PATCH] fix module sysfs files reference counting")
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>---
>v2: free from '--i' instead of 'i--'
>---
> kernel/module.c | 16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 6e6712b..78e21a7 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1723,15 +1723,29 @@ static int module_add_modinfo_attrs(struct module *mod)
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
>+	for (; (attr = &mod->modinfo_attrs[i]) && i >= 0; --i) {

The increment step is executed after the body of the loop, so this is
still starting at i instead of i - 1. I think we need:

	for (--i; (attr = &mod->modinfo_attrs[i]) && i >= 0; i--)

Thanks,

Jessica

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
>2.7.4
>
>
