Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9846AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4D6222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576851369;
	bh=ozdmvQULKSXokLNWdk7mYphvTDazwayXgBTn7Ekeph4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bPhU8SFAYEAw9rTJTb7zYtYqHTu333wBSyKFzL6kF0KvNGm10IjDibSADo+Ihaope
	 meYsKUvWWkzfyL07F7a1134nC4f37Xdteyn3+bR/ZrwOjoA8/PaRCJ/dPoR8VUsWYl
	 ESlcPc6XamWekXS5GRKH/ZdscrlGmNJXB23i8VE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLTOQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:16:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfLTOQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:16:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C23021D7D;
        Fri, 20 Dec 2019 14:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576851367;
        bh=ozdmvQULKSXokLNWdk7mYphvTDazwayXgBTn7Ekeph4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rUYD7y0xQ0rgIYMrq8VaVZBlDMYXr2sK+cPuFusKHMyLPgsIlq/Ce/UpiwToV+sLN
         MiLXt8kUQfbwiwfhBBPQWfBw5Pp4ECdqFwvV4NuUZWGUF9+cQCmvCdKijw873h5uPO
         Kdt2zLejmQFIX21VRVEHX7Hmbw8zbkVd3WihSxvg=
Date:   Fri, 20 Dec 2019 15:16:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
Message-ID: <20191220141605.GA2292734@kroah.com>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
 <20191220140655.GN2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220140655.GN2827@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 03:06:55PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 20, 2019 at 11:19:27AM +0100, Marc Gonzalez wrote:
> > Would anyone else have any suggestions, comments, insights, recommendations,
> > improvements, guidance, or wisdom? :-)
> 
> Flip devres upside down!
> 
> **WARNING, wear protective glasses when reading the below**
> 
> 
> struct devres {
> 	struct devres_node	node;
> 	void			*data;
> };
> 
> /*
>  * We place struct devres at the tail of the memory allocation
>  * such that data retains the ARCH_KMALLOC_MINALIGN alignment.
>  * struct devres itself is just 4 pointers and should therefore
>  * only require trivial alignment.
>  */
> static inline struct devres *data2devres(void *data)
> {
> 	return (struct devres *)(data + ksize(data) - sizeof(struct devres));
> }
> 
> void *alloc_dr(...)
> {
> 	struct devres *dr;
> 	void *data;
> 
> 	data = kmalloc(size + sizeof(struct devres), GFP_KERNEL);
> 	dr = data2devres(data);
> 	WARN_ON((unsigned long)dr & __alignof(*dr)-1);
> 	INIT_LIST_HEAD(&dr->node.entry);
> 	dr->node.release = release;
> 	dr->data = data;
> 
> 	return dr;
> }
> 
> void devres_free(void *data)
> {
> 	if (data) {
> 		struct devres *dr = data2devres(data);
> 		BUG_ON(!list_empty(dr->node.entry));
> 		kfree(data);
> 	}
> }
> 
> static int release_nodes(...)
> {
> 	...
> 	list_for_each_entry_safe_reverse(dr, ...) {
> 		...
> 		kfree(dr->data);
> 	}
> }
> 

Ok, that's my queue to walk away from the keyboard and start drinking, I
think the holiday season has now officially started.

ugh.  crazy.

but brilliant :)

greg k-h
