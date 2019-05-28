Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEC6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA2B20989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg7Oc40U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfE1HOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:14:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42386 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfE1HOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:14:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id 33so7440798pgv.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 00:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r1FatOp08eZVWsQPZh9iebz5bH/kKuOBcpebc8XwEuo=;
        b=dg7Oc40UXgXulZy8g9KFZp0pGxBh4V1kuchdu6VxszmlQ68x8aAEzWNCmdt1QSmfsL
         +GxwEM3fiooKXscLQcaf9602gbPHZcXiovzk3tRvq4LhJ4gV3XJUsSBvVtX/x3nP00xP
         6yA8NOpw+t71USU/Kjms8pOnER7LTb1VBSYxQA9LhDDHdYxt+Xo9t4maEfEzLYHRDtIQ
         gtb7OneeGFZbhlRRR8PCatAjYfE/WH1YxwJaVgawU1QIykVqftVMzuV6Jxi1kmu/3Ax2
         3nx6yZOOx18eH86fjtdyD2+kEiGJWDTQZ9lD8A7kuWKbU7BXRh9hChjnV4uajRe+jtD6
         vtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r1FatOp08eZVWsQPZh9iebz5bH/kKuOBcpebc8XwEuo=;
        b=F9eOokLskaC9HRdAuV6+lkABn6bMwSWfbwj7YGXzWtT9STd8NW3mayP7nc8E/3xS16
         6iHuyGiA+4Mv7oBZ134h1Y2ur3ClwAqcXaUjUD4vS/4bJWlr1RPR+p3lVWEcbsUBYR8W
         tx2DDPHjuDGaXFSO7k1kItStwwfE62Iid73SHPViJ7f9Uc46d1iPSr4ogy0+Hwh8XobS
         y7P0IpzAOfp+wEWb68sboY0/Z6FB9OkthL0HEmSNBoEEtiBZxyYLewBVzaLT2mCnPUkG
         zTtQFp6Ue2tngMFald9VIc452xN7emL5quzZM205NqLPqn9wkz5SQx6fCwE/oZ/Zt+0w
         Qiug==
X-Gm-Message-State: APjAAAWy3TMTXdn3fIqgB2uYCHK88npJP9OczgdZZfyz0Hn78/VhdJPv
        T9mWnoiKv0W9g3TmSBfFnl/mQpTK
X-Google-Smtp-Source: APXvYqyjTg61XLAk9rlKsceaf28hZfxXZnn8NZ+JQs+DinFlh53VvbnxQhyQK9I2ta3Iwe/r9Zk9Wg==
X-Received: by 2002:a63:db4e:: with SMTP id x14mr116985224pgi.119.1559027654994;
        Tue, 28 May 2019 00:14:14 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id t10sm16321871pfe.2.2019.05.28.00.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 00:14:14 -0700 (PDT)
Date:   Tue, 28 May 2019 15:14:00 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Question: devm_kfree] When should devm_kfree() be used?
Message-ID: <20190528071400.GB18498@zhanggen-UX430UQ>
References: <20190528003257.GA12065@zhanggen-UX430UQ>
 <20190528064949.GC2428@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528064949.GC2428@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:49:49AM +0200, Greg KH wrote:
> On Tue, May 28, 2019 at 08:32:57AM +0800, Gen Zhang wrote:
> > devm_kmalloc() is used to allocate memory for a driver dev. Comments
> > above the definition and doc 
> > (https://www.kernel.org/doc/Documentation/driver-model/devres.txt) all
> > imply that allocated the memory is automatically freed on driver attach,
> > no matter allocation fail or not. However, I examined the code, and
> > there are many sites that devm_kfree() is used to free devm_kmalloc().
> > e.g. hisi_sas_debugfs_init() in drivers/scsi/hisi_sas/hisi_sas_main.c.
> > So I am totally confused about this issue. Can anybody give me some
> > guidance? When should we use devm_kfree()?
> 
> If you "know" you need to free the memory now, call devm_kfree().  If
> you want to wait for it to be cleaned up latter, like normal, then do
> not call it.
> 
> Do you have a driver that you think uses it incorrectly?
> 
> thanks,
> 
> greg k-h
Yes, that is my question! I do have several patches about devm_kfree() 
and debate with maintainers. e.g. you can kindly refer to this lkml:
https://lkml.org/lkml/2019/5/23/1547. 

In tegra_wm9712_driver_probe(), 'machine->codec' is allocated by
platform_device_alloc(). When it is NULL, function returns ENOMEM.
However, 'machine' is allocated by devm_kzalloc() before this site.
Thus we should free 'machine' before function ends to prevent memory
leaking.

And as mentioned above, e.g. hisi_sas_debugfs_init() in 
drivers/scsi/hisi_sas/hisi_sas_main.c, devm_kfree() is used to free 
devm_kmalloc().

So, thanks for looking into this, Greg.

Thanks
Gen
