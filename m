Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23718C2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 02:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8E12073D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 02:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="SXb/Zp7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLNCLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 21:11:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37852 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfLNCLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 21:11:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so733366lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 18:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ySR7TYBQhTmVu6KMG+j74j9+ZRg88KrNjUFtJErf2/0=;
        b=SXb/Zp7fUVFOXqfsfn1Ioi/WCk64YO6dsh3bicKU9wV4cG/gEi+dbN5rIl0dnqNrhV
         hj7Pekuq1K/ayYHab9CbuM/ujPP8uKnHBwwEwB0NYmiMBmcQAgQdGCjKDi6PV941gJrp
         GbTgKumeOWmxeIRrA432U8eUyQzwl5vuupxwSUlwolCL2LXLTwjdQeLiLMwvTr55s8XK
         IfyfzAaaN0D3Pjojv/MIQ+Bw/ZGf6wYdEd4WI10MM48Z925uAGyqIHxqQNf/Bqo/2SFe
         cft5eLFeHCbYDPztS2t7tmfzWLQ9WjLGol5lFyuV3jgdVCNFcp8bSmaM1ILwTSUBpi/V
         +K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ySR7TYBQhTmVu6KMG+j74j9+ZRg88KrNjUFtJErf2/0=;
        b=uYqG+0aI6S+7I3Z3VK5OG++vItlfDfnO7Lbh2+blsfA3IJvWUm9haqhth8iUidI+sA
         6yDQn/5ev4T5Gsb5dtnZnZrVBFVIQXY7VBlGVxyttzlpO+i/ZgVymKfrAj4ji4H4pg+N
         LGDPEQjRjbNyiopfWZQN9sYlFBmfuhVqbfbrvlIGvX1YJVSo3LZ4H0SblnAWj4sDHYS5
         EsXwnfrOe0+cB1RThQXHkHs2BtodyWHV1yOwxJILyfpa6zz0RHc1DOz1zdjEuPTCFRx4
         tc2gQ+1vTsh8XlihUrzlKKROkljgk/cdm+y0+RzQWImO94GTlBLVKS3S9zcs0M9CsSHr
         wgdA==
X-Gm-Message-State: APjAAAUsEJ2+MwONxFykYAUc8C+Ks1ZcwI8B/ulIpOEV/FtNHZGSdwUi
        c/4naowFUDl8cI04bpTTRtofSQ==
X-Google-Smtp-Source: APXvYqx31c9AbeMwEq7DpSSfHmn+XAWX9b/tCrkJXLP1y/F+yXyKvwm6s4HTOnIAjWUHUq9asiCdQQ==
X-Received: by 2002:a2e:978d:: with SMTP id y13mr11738378lji.103.1576289460426;
        Fri, 13 Dec 2019 18:11:00 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id x13sm5268984lfe.48.2019.12.13.18.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 18:11:00 -0800 (PST)
Date:   Fri, 13 Dec 2019 18:10:51 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: don't init workqueues on error
Message-ID: <20191213181051.0f949b17@cakuba.netronome.com>
In-Reply-To: <20191210152454.86247-1-mcroce@redhat.com>
References: <20191210152454.86247-1-mcroce@redhat.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 16:24:54 +0100, Matteo Croce wrote:
> bond_create() initialize six workqueues used later on.

Work _entries_ not _queues_ no?

> In the unlikely event that the device registration fails, these
> structures are initialized unnecessarily, so move the initialization
> out of the error path. Also, create an error label to remove some
> duplicated code.

Does the initialization of work entries matter? Is this prep for further
changes?

> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  drivers/net/bonding/bond_main.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index fcb7c2f7f001..8756b6a023d7 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -4889,8 +4889,8 @@ int bond_create(struct net *net, const char *name)
>  				   bond_setup, tx_queues);
>  	if (!bond_dev) {
>  		pr_err("%s: eek! can't alloc netdev!\n", name);

If this is a clean up patch I think this pr_err() could also be removed?
Memory allocation usually fail very loudly so there should be no reason
to print more errors.

> -		rtnl_unlock();
> -		return -ENOMEM;
> +		res = -ENOMEM;
> +		goto out_unlock;
>  	}
>  
>  	/*
> @@ -4905,14 +4905,17 @@ int bond_create(struct net *net, const char *name)
>  	bond_dev->rtnl_link_ops = &bond_link_ops;
>  
>  	res = register_netdevice(bond_dev);
> +	if (res < 0) {
> +		free_netdev(bond_dev);
> +		goto out_unlock;
> +	}
>  
>  	netif_carrier_off(bond_dev);
>  
>  	bond_work_init_all(bond);
>  
> +out_unlock:
>  	rtnl_unlock();
> -	if (res < 0)
> -		free_netdev(bond_dev);
>  	return res;
>  }
>  

I do appreciate that the change makes the error handling follow a more
usual kernel pattern, but IMHO it'd be even better if the error
handling was completely moved. IOW the success path should end with
return 0; and the error path should contain free_netdev(bond_dev);

-	int res;
+	int err;

	[...]

	rtnl_unlock();

	return 0;

err_free_netdev:
	free_netdev(bond_dev);
err_unlock:
	rtnl_unlock();
	return err;

I'm just not 100% sold on the improvement made by this patch being
worth the code churn, please convince me, respin or get an ack from 
one of the maintainers? :)
