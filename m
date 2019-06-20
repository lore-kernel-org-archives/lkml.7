Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD6CC48BE2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B412147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FWFagoGW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NH2ynAJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfFTGUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:20:09 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47807 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbfFTGUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:20:09 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4521B22474;
        Thu, 20 Jun 2019 02:20:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 20 Jun 2019 02:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=gobjRewc4RKw7NYE7kGu3NAWpJz
        CZXN3bcZC1ebFokw=; b=FWFagoGWRbU7EyW0KCrHfGdVQzoXAIh9EFHyOQt5Tti
        QaGg2p8vMeAQ7KQSbLYno5ORQTMwEdTVIK9o34WitabBxXxzaeNXObNzKdVd3uxB
        ikjV1Ya7xG2p+hSaeAkvyurUQlphTO19LbVKWpleTOTjQsoCe1oKizdpVqAe0W+c
        r1dduNA3sPpmFoDHDkt5kO0nhDApuQK2o3a6i665WUixC7MhHJnNk+/6KI1mrq/8
        oiqECmQsLIAA/+UfFIciPhIJvnZcqfvxMijEWmxQwuk4E25FKs1HgrupJ65AvW5p
        HetXPSFmJTps2Est+T0fiOOAiRv4742a7Fs8gvhETtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=gobjRe
        wc4RKw7NYE7kGu3NAWpJzCZXN3bcZC1ebFokw=; b=NH2ynAJpzefd0TmAR9NDwU
        7hbJaJSxFDpq1lIY2QXx/ItXS6STprkJ1LrSz8GrVBX6fQ+1wiBrIglcbBm5jXXl
        OyLSGUe20JL6fX085mFiwQExouMse4j7wo54iThn2IEK0SmTuezuCnNuXiLuGe3S
        19L/rgoZZpqF+DWi1toh0hPr+vKJQyCvvdag4KUNvsmx1uZjeCuJnZeSVsGbPu7Q
        lurZidX+rlouY7HKjVY7W6eoGBVd/Huc9f5aNuGKUmHC/VzPAcUuM41sOiKvgYy+
        hFU2utq3L7eKelYd2HTOx6K04RUZu2QK1A2dLbzKGKxCkTVMLCX18UHOhGmjeIvw
        ==
X-ME-Sender: <xms:lyULXZEFjkq2XkAulaPB8duEeNrIFyEbJA8PPFnzFIUKiHhKMEDXeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrtdefgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:lyULXRHxbl9sItHKXS4-KsDCeN-gG-uCoxiEuggR69qjsce9Mi5_Gw>
    <xmx:lyULXYCF2ttfqoyU1iWW-h_eAB-ZAOwnwp64hs1HVMAz7OiY-ejqZQ>
    <xmx:lyULXWmI-v4Aelcrbfzz4vFKVJ8RCX9kR2RM7HhaLklXBoJPHydzHQ>
    <xmx:mCULXasIgXDGgkkbkWdCXPaeTWgQHKjAOaSjHJCf0V_MI0_U0QWCmw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id C035280059;
        Thu, 20 Jun 2019 02:20:06 -0400 (EDT)
Date:   Thu, 20 Jun 2019 08:20:04 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190620062004.GA5485@kroah.com>
References: <20190620153552.1392079c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620153552.1392079c@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 03:35:52PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   drivers/misc/mei/debugfs.c
> 
> between commit:
> 
>   5666d896e838 ("mei: no need to check return value of debugfs_create functions")
> 
> from the driver-core tree and commit:
> 
>   b728ddde769c ("mei: Convert to use DEFINE_SHOW_ATTRIBUTE macro")
> 
> from the char-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/misc/mei/debugfs.c
> index df6bf8b81936,47cfd5005e1b..000000000000
> --- a/drivers/misc/mei/debugfs.c
> +++ b/drivers/misc/mei/debugfs.c
> @@@ -233,22 -154,46 +154,21 @@@ void mei_dbgfs_deregister(struct mei_de
>    *
>    * @dev: the mei device structure
>    * @name: the mei device name
>  - *
>  - * Return: 0 on success, <0 on failure.
>    */
>  -int mei_dbgfs_register(struct mei_device *dev, const char *name)
>  +void mei_dbgfs_register(struct mei_device *dev, const char *name)
>   {
>  -	struct dentry *dir, *f;
>  +	struct dentry *dir;
>   
>   	dir = debugfs_create_dir(name, NULL);
>  -	if (!dir)
>  -		return -ENOMEM;
>  -
>   	dev->dbgfs_dir = dir;
>   
>  -	f = debugfs_create_file("meclients", S_IRUSR, dir,
>  -				dev, &mei_dbgfs_meclients_fops);
>  -	if (!f) {
>  -		dev_err(dev->dev, "meclients: registration failed\n");
>  -		goto err;
>  -	}
>  -	f = debugfs_create_file("active", S_IRUSR, dir,
>  -				dev, &mei_dbgfs_active_fops);
>  -	if (!f) {
>  -		dev_err(dev->dev, "active: registration failed\n");
>  -		goto err;
>  -	}
>  -	f = debugfs_create_file("devstate", S_IRUSR, dir,
>  -				dev, &mei_dbgfs_devstate_fops);
>  -	if (!f) {
>  -		dev_err(dev->dev, "devstate: registration failed\n");
>  -		goto err;
>  -	}
>  -	f = debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR, dir,
>  -				&dev->allow_fixed_address,
>  -				&mei_dbgfs_allow_fa_fops);
>  -	if (!f) {
>  -		dev_err(dev->dev, "allow_fixed_address: registration failed\n");
>  -		goto err;
>  -	}
>  -	return 0;
>  -err:
>  -	mei_dbgfs_deregister(dev);
>  -	return -ENODEV;
>  +	debugfs_create_file("meclients", S_IRUSR, dir, dev,
> - 			    &mei_dbgfs_fops_meclients);
> ++			    &mei_dbgfs_meclients_fops);
>  +	debugfs_create_file("active", S_IRUSR, dir, dev,
> - 			    &mei_dbgfs_fops_active);
> ++			    &mei_dbgfs_active_fops);
>  +	debugfs_create_file("devstate", S_IRUSR, dir, dev,
> - 			    &mei_dbgfs_fops_devstate);
> ++			    &mei_dbgfs_devstate_fops);
>  +	debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR, dir,
>  +			    &dev->allow_fixed_address,
> - 			    &mei_dbgfs_fops_allow_fa);
> ++			    &mei_dbgfs_allow_fa_fops);
>   }
> - 


Looks good to me, thanks!

greg k-h
