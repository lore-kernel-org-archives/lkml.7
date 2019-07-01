Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7093BC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425382173E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561989368;
	bh=xHYHwRu047LRNEZ0hfMwddr1wPSrP4HvmOSYmeKOh4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VwHcUkzSY1Fh45mt46M/Q8jPtBt3wOuiNWmLKrQgU+MPFkm69DBDHsr3+Lt7C4nBV
	 3zxQye6NIxnEQYkftabWAkAzzBHej+DhfBPd/15j/LREBwW2JbTi51+h2bg/gdvhmw
	 c+v5BIAd9LN+gNBOywylvfbvu6T4VnCE4P8+/Ark=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfGAN4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbfGAN4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:56:06 -0400
Received: from linux-8ccs (ip5f5ade8b.dynamic.kabel-deutschland.de [95.90.222.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 427A121721;
        Mon,  1 Jul 2019 13:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561989365;
        bh=xHYHwRu047LRNEZ0hfMwddr1wPSrP4HvmOSYmeKOh4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EtFpnG8aR9TUgbf3xWCGa+vcjbnRi9F7wLPxpliR0Uykt9ylLqESGePaDuWpziwMo
         1QCuzZ//4Ky5kK6uFgas+Fiu+sY8JZzp2VP69nSJHNfGIzXuH1dhhWdwlXPi7UGdSU
         8zlznE8M173BcsQ2phPhvWoUG6q/7wwLC2tBl4Ss=
Date:   Mon, 1 Jul 2019 15:55:57 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     rusty@rustcorp.com.au, kay.sievers@vrfy.org,
        clabbe.montjoie@gmail.com, linux-kernel@vger.kernel.org,
        "wangxiaogang (F)" <wangxiaogang3@huawei.com>,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>
Subject: Re: [PATCH] module: add usage links when calling ref_module func
Message-ID: <20190701135556.GA25484@linux-8ccs>
References: <8d7aa8b1-73a2-db7a-82c8-06917eddf235@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8d7aa8b1-73a2-db7a-82c8-06917eddf235@huawei.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Zhiqiang Liu [28/06/19 20:32 +0800]:
>From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>
>Problem: Users can call ref_module func in their modules to construct
>relationships with other modules. However, the holders
>'/sys/module/<mod-name>/holders' of the target module donot include
>the users` module. So lsmod command misses detailed info of 'Used by'.
>
>When load module, the process is given as follows,
>load_module()
>	-> mod_sysfs_setup()
>		-> add_usage_links
>	-> do_init_module
>		-> mod->init()
>
>add_usage_links func creates holders of target modules linking to
>this module. If ref_module is called in mod->init() func, the usage
>links cannot be added.
>
>Here, we will add usage link of a to b's holder_dir.
>
>Fixes: 9bea7f239 ("module: fix bne2 "gave up waiting for init of module libcrc32c")

I think we can drop this tag; it doesn't fix a bug specifically
introduced by that particular commit.

>Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>---
> kernel/module.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 80c7c09584cf..11c6aff37b1f 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -871,6 +871,11 @@ int ref_module(struct module *a, struct module *b)
> 		module_put(b);
> 		return err;
> 	}
>+
>+	err = sysfs_create_link(b->holders_dir, &a->mkobj.kobj, a->name);
>+	if (err)
>+		return err;

We need to fix the error handling here - the module_use struct
allocated in the call to add_module_usage() needs to be freed (you
could just modify add_module_usage() to return the use pointer so that
it's easier to free from within ref_module()), module_put() needs to
be called, and the use struct should be removed from its respective
lists (see module_unload_free()).

Thanks,

Jessica

