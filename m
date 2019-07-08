Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D7EC606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A9E21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562596674;
	bh=oWp+oDcJJXv6d/8Lw2X3XDx1l88oBrL3Uk5WmOCPSkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iIRrcfg1kFIZubVTDqTS2fBvLlUtaFdz85KCsTdZQKPpEYRRkXuohj1VSObd79ZiS
	 1kMVXM+FGgKK0cuOpO0V3ycND/GdCvXGfiw8z9foy+scyqWR3zTVisE2pSXXvDuZ97
	 NJSP1ai9wW4xKTaAQZCo4iHmYEqKtB390DKpJkLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfGHOhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:37:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38502 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfGHOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:37:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id n11so18218116qtl.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xlxx8z2Kd6mbVhAes5Vdim+URDBLB+ELlLVS4awXZ9Y=;
        b=QCtZWFEv/LtisRrIoUoYOtwD3/m8z59j1MfwvEa140ZnPFZrcxcNolkffkei5eAXMV
         ZWmer8DsRRKIQZ6JjDANKYtq6RWKGK4Ico5sCJyye/vnoEfMvoqp7ZKNEd8cJqFRr2US
         kHONahrCz49ZK7/lxWQZqiaOWeZa9RmQPHx3LmHM+lYpHMqjF1nO76882BA93LL9B5VR
         cAVM7nuU8XeqD4d0QsfeiqHP4PuPO9oTic+mlxUMtkoVm9+FqIwg5WhwiwJlpD6DrcBP
         UqJxgKd0IRFYaKkLuMJXtO8YCnzkJYJ9i4SLoidzjGl26wOT64vM0whibmPGmxkQ24Xs
         s+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xlxx8z2Kd6mbVhAes5Vdim+URDBLB+ELlLVS4awXZ9Y=;
        b=MrLpa0zCMO7u72JGg/S8mhyr3fOAtaQp6l6kQvUzuDtc0fMJa1KLD2L69b6WR5J2Bh
         6Zzy/V7swycnpRl46ztkdSjtQUvRwEdqAMqfVT7HVzI4UkYdqrs0QvysS3SprFYVlu7g
         U71DUlxAITh1hO1Rx5AOybG7HHnzVtCoewlu28aKdX+tayuLQ61LbWnkycR8dKhbXgKr
         gYkurKErj5et5IfLHTwuRi74goG+04S8hIKia8YGCml+eWkJZ599SDoTosl8Ku1T8NuO
         6Ec4y+JdMDdPOx5LGwE8YNEmQs+KBge35Y9DQRxaI3J8AB+WNLvT0Xih9/mN7yPS9+4n
         D8gg==
X-Gm-Message-State: APjAAAXzaB6c2NB7JjeqJlAAV6xWnusROb7yIrSZJJQzjeS4j9kQJNC0
        M2DMTibvWBji3R+SlP5XCEE=
X-Google-Smtp-Source: APXvYqyxDMinPFx1mhUvSh89llFUSIQMspgV3DMd8UeIuHnZU0mc22OT2kYYzqlAu+Bq2GLeP16tTA==
X-Received: by 2002:ac8:f3b:: with SMTP id e56mr14584643qtk.123.1562596671308;
        Mon, 08 Jul 2019 07:37:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:fa50])
        by smtp.gmail.com with ESMTPSA id 67sm7655862qkh.108.2019.07.08.07.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 07:37:50 -0700 (PDT)
Date:   Mon, 8 Jul 2019 07:37:48 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Peng Wang <rocking@whu.edu.cn>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: fix potential null pointer dereference
Message-ID: <20190708143748.GZ657710@devbig004.ftw2.facebook.com>
References: <20190705134730.20833-1-rocking@whu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705134730.20833-1-rocking@whu.edu.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 09:47:30PM +0800, Peng Wang wrote:
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index a387534c9577..ea3fc972c48b 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -430,7 +430,7 @@ struct kernfs_node *kernfs_get_active(struct kernfs_node *kn)
>   */
>  void kernfs_put_active(struct kernfs_node *kn)
>  {
> -	struct kernfs_root *root = kernfs_root(kn);
> +	struct kernfs_root *root;
>  	int v;
>  
>  	if (unlikely(!kn))
> @@ -442,6 +442,7 @@ void kernfs_put_active(struct kernfs_node *kn)
>  	if (likely(v != KN_DEACTIVATED_BIAS))
>  		return;
>  
> +	root = kernfs_root(kn);
>  	wake_up_all(&root->deactivate_waitq);

Maybe just remove the root variable altogether?  Other than that,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
