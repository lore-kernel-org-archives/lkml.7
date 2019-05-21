Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D2FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8E021783
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfEUG1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:27:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34132 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfEUG1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:27:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8so10703600wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 23:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dCD1dJdG/0nLQ16mvfGU1vp0j4Tn1rC4YMsDRx2jTq0=;
        b=TqYP/6cluaCgF0eJge5xdnUuQN9gRjwZEQ0NjBo2iEEdeyYVtguiNQBuBMyKJ6QdjE
         TnFx6LDFWluXPjD3nhQVmUiTDLIn9110vTy1FnhgupBZOHQQqYPE8RdzNLToT664pbow
         Fzx4UcvQzWwBA3jugTmfsrEWSC7toYaBOLC8qL9oNgnaVX1+RIzyO+EX7jQSZafNGE4I
         nVoJSE6/fyTTysX3gBbramvvEWkUbCeXuGj0164YeAj38yGAnkAmiSMzFPbSV1dm4Fpm
         kcsyNbxpdGVS/JBp3n14sD3BUaCUvfCyQszs0/y9OG+9Q5uZ97toBffwNa6EQ0mNTPbV
         d88Q==
X-Gm-Message-State: APjAAAWpCqyFRWo744EBb8k0TPk+y/G7YFPmH/uBlPbVxFaRya9UqzZj
        tgA9AZSqgfCLwD0VUoUWpc4uPw==
X-Google-Smtp-Source: APXvYqwp6x07EVQG49p3BgC/aXK1zsZJ7j3xPSToIFVel1+1/P82LoAsOXJJ9x3PUhKsQtXdfCb3OQ==
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr32869437wrj.121.1558420073023;
        Mon, 20 May 2019 23:27:53 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x187sm2312795wmb.33.2019.05.20.23.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 23:27:51 -0700 (PDT)
Date:   Tue, 21 May 2019 08:27:51 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Grzegorz Halat <ghalat@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] vt/fbcon: deinitialize resources in visual_init() after
 failed memory allocation
Message-ID: <20190521062751.vi6hlaod2gfth7ea@butterfly.localdomain>
References: <20190426144357.25826-1-ghalat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426144357.25826-1-ghalat@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, Apr 26, 2019 at 04:43:57PM +0200, Grzegorz Halat wrote:
> After memory allocation failure vc_allocate() doesn't clean up data
> which has been initialized in visual_init(). In case of fbcon this
> leads to divide-by-0 in fbcon_init() on next open of the same tty.
> 
> memory allocation in vc_allocate() may fail here:
> 1097:     vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
> 
> on next open() fbcon_init() skips vc_font.data initialization:
> 1088:     if (!p->fontdata) {
> 
> division by zero in fbcon_init() happens here:
> 1149:     new_cols /= vc->vc_font.width;
> 
> Additional check is needed in fbcon_deinit() to prevent
> usage of uninitialized vc_screenbuf:
> 
> 1251:        if (vc->vc_hi_font_mask && vc->vc_screenbuf)
> 1252:                set_vc_hi_font(vc, false);
> 
> Crash:
> 
>  #6 [ffffc90001eafa60] divide_error at ffffffff81a00be4
>     [exception RIP: fbcon_init+463]
>     RIP: ffffffff814b860f  RSP: ffffc90001eafb18  RFLAGS: 00010246
> ...
>  #7 [ffffc90001eafb60] visual_init at ffffffff8154c36e
>  #8 [ffffc90001eafb80] vc_allocate at ffffffff8154f53c
>  #9 [ffffc90001eafbc8] con_install at ffffffff8154f624
> ...
> 
> Signed-off-by: Grzegorz Halat <ghalat@redhat.com>
> ---
>  drivers/tty/vt/vt.c              | 11 +++++++++--
>  drivers/video/fbdev/core/fbcon.c |  2 +-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 650c66886c80..ec85d195678f 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1056,6 +1056,13 @@ static void visual_init(struct vc_data *vc, int num, int init)
>  	vc->vc_screenbuf_size = vc->vc_rows * vc->vc_size_row;
>  }
>  
> +
> +static void visual_deinit(struct vc_data *vc)
> +{
> +	vc->vc_sw->con_deinit(vc);
> +	module_put(vc->vc_sw->owner);
> +}
> +
>  int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  {
>  	struct vt_notifier_param param;
> @@ -1103,6 +1110,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  
>  	return 0;
>  err_free:
> +	visual_deinit(vc);
>  	kfree(vc);
>  	vc_cons[currcons].d = NULL;
>  	return -ENOMEM;
> @@ -1331,9 +1339,8 @@ struct vc_data *vc_deallocate(unsigned int currcons)
>  		param.vc = vc = vc_cons[currcons].d;
>  		atomic_notifier_call_chain(&vt_notifier_list, VT_DEALLOCATE, &param);
>  		vcs_remove_sysfs(currcons);
> -		vc->vc_sw->con_deinit(vc);
> +		visual_deinit(vc);
>  		put_pid(vc->vt_pid);
> -		module_put(vc->vc_sw->owner);
>  		vc_uniscr_set(vc, NULL);
>  		kfree(vc->vc_screenbuf);
>  		vc_cons[currcons].d = NULL;
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index cd059a801662..c59b23f6e9ba 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -1248,7 +1248,7 @@ static void fbcon_deinit(struct vc_data *vc)
>  	if (free_font)
>  		vc->vc_font.data = NULL;
>  
> -	if (vc->vc_hi_font_mask)
> +	if (vc->vc_hi_font_mask && vc->vc_screenbuf)
>  		set_vc_hi_font(vc, false);
>  
>  	if (!con_is_bound(&fb_con))
> -- 
> 2.20.1
> 

LGTM.

Reviewed-by: Oleksandr Natalenko <oleksandr@redhat.com>

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
