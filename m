Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F212C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C8020818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ02SC2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfEPJAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:00:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35026 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEPJAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:00:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id g5so1302283plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tsRvQ0ICVvL80K/llewLglNoh6LkE76YZlYz4k786T4=;
        b=bJ02SC2+DLGQFnjhjfGLXa0GpC6fzBI58qPoOXXDddWPbG2SYKa3VWR2sGKswVGv/C
         OMYvH8o89GaE/aEBZsZE8HnAGTfFQBK9Uff1LpPXT5gHEwDVZMc6ngYN7kDUQlHet9oY
         KvAvLbR576fs+ZA48EcuSvfLsft3KPi1iqdrhSVMz6bqFKjOlhphsizoNZrCkfHR0F6A
         TXYLhWw2D065WMf5QTI0Z4uGLCYwuUvPccDajFuDmTRIpLsie6cQAfsS412YqyQ0NHxg
         Nxe/jJ7cuJWEfeTIlNQc5iQuC5tUJzt2ETtnGLufdPdg9DKah2Fe7tp+ZZlQ8OzE/T/j
         99jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tsRvQ0ICVvL80K/llewLglNoh6LkE76YZlYz4k786T4=;
        b=Nhg84c8KYeaXpfflBXEJop2uWN9p2YkvMBR8MoommqpfJFZtzAm8dathrriWfWrOZ0
         Chi0hOpfw+3NgJlD2H0GeUmrEAJ6iyU6wWOzLRmRfyjT9Auc4w9zVj2QQOWyLPmgxjGT
         pE4L1ZUkajGeNdDfz03SSS7ZkZZqwNR/h+S4k9AUetSpL9xuGe88N2CTsCZWoMaBeX9G
         3i7btjRVBkOxjuuW70mmNxM45yFDVLQQEotKB3reveVzuTNU2o9HJAZ7rZX3slABJUpp
         DPbfZz9DoTdi3yEhhrAcPRhcqZiEYx+IMjOVeYbDT/PTz32SLkgnw/kbISSFOb7ve7ql
         s4rA==
X-Gm-Message-State: APjAAAX+Ev+hVs4u7Q1x/rUtyWi1yaT5z1e9XMRo7reUALZLutehqmkT
        KrfFYeLVPoA53OoWOPyI8UUqVXpHDwM=
X-Google-Smtp-Source: APXvYqy7mWZPcvgEGfnai2/0Oe+KXnlLgoRS/IZIOMQhPkTBeu6DMSVcU51P9P+JPqTv+diaT86JZQ==
X-Received: by 2002:a17:902:a988:: with SMTP id bh8mr48808665plb.243.1557997207431;
        Thu, 16 May 2019 02:00:07 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id u76sm5917793pgc.84.2019.05.16.02.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 02:00:07 -0700 (PDT)
Date:   Thu, 16 May 2019 16:59:57 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [Patch] hdac_sysfs: Fix a memory leaking bug in
 sound/hda/hdac_sysfs.c file of Linux 5.1
Message-ID: <20190516085957.GA3107@zhanggen-UX430UQ>
References: <20190516084003.GA20821@zhanggen-UX430UQ>
 <s5hzhnmn5qw.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzhnmn5qw.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 10:49:43AM +0200, Takashi Iwai wrote:
> On Thu, 16 May 2019 10:40:03 +0200,
> Gen Zhang wrote:
> > 
> > tree->root and tree->nodes are allocated by memory allocation 
> > functions. And tree is also an allocated memory. When allocation of 
> > tree->root and tree->nodes fails, not freeing tree will leak memory. 
> > Thus we should free tree in this situation.
> 
> No, the leftover is freed in the caller side by calling
> widget_tree_free().
> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > 
> > ---
> > diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
> > index fb2aa34..5d8a939 100644
> > --- a/sound/hda/hdac_sysfs.c
> > +++ b/sound/hda/hdac_sysfs.c
> > @@ -370,12 +370,12 @@ static int widget_tree_create(struct hdac_device *codec)
> >  
> >  	tree->root = kobject_create_and_add("widgets", &codec->dev.kobj);
> >  	if (!tree->root)
> > -		return -ENOMEM;
> > +		goto free_tree;
> >  
> >  	tree->nodes = kcalloc(codec->num_nodes + 1, sizeof(*tree->nodes),
> >  			      GFP_KERNEL);
> >  	if (!tree->nodes)
> > -		return -ENOMEM;
> > +		goto free_tree;
> >  
> >  	for (i = 0, nid = codec->start_nid; i < codec->num_nodes; i++, nid++) {
> >  		err = add_widget_node(tree->root, nid, &widget_node_group,
> > @@ -393,6 +393,9 @@ static int widget_tree_create(struct hdac_device *codec)
> >  
> >  	kobject_uevent(tree->root, KOBJ_CHANGE);
> >  	return 0;
> > +free_tree:
> > +	kfree(tree);
> > +	return -ENOMEM;
> >  }
> >  
> >  int hda_widget_sysfs_init(struct hdac_device *codec)
> > ---
> > 
It is freed in the caller site :)
But it is really a rare free usage.
Thanks
Gen
