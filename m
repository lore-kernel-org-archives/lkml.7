Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9DEC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238EF215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="n8nFTL14";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RSYsLew4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfFMQpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:45:17 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56835 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730377AbfFMGKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:10:11 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CD11D22220;
        Thu, 13 Jun 2019 02:10:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 13 Jun 2019 02:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=8JnmSovU2YJMgNyOQM+k6Ro+zfO
        t9/fyzIfLPVbk4CA=; b=n8nFTL147DADUzSHkq5t+4clCBJzFNuXXWRzqnX0i9n
        nZ3VKr/vfJRmGn8TEsxNiKNroH2SCob8RewqpNPBBMviYxvi5KuwoqWhML1oL3JA
        GhinpIf0FGpjR/y4z6AoZuhHVfPBRSLu0WWh1OUfxzs6PDk9gQcHDaYr5FVRdsf9
        PjwAmsBtyPrlQPv70FWFGnek7JqRdz07tzgHeJJxQ+bnF5EhCPboiyORV9oaedKZ
        LQ350uoWpcpNiJd/DjaxACoiFycXMDnBnumvrc1yQrKl/EAVGsiFfk/za++fpYIx
        ohBHhb3FPEsKsp7xVm+Eq6yMPFz+6iSDQjADSN5yJJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8JnmSo
        vU2YJMgNyOQM+k6Ro+zfOt9/fyzIfLPVbk4CA=; b=RSYsLew44Ig93i6/OPrTnQ
        891H1DrASDqJlbsYulf7nncorhfoBjpSeRAgLSHrN8JSIksm49t4MppTU2tIJcVs
        G3efrmP80TI6i9sJLYYfOegOFeP+CfzITQCzZuISMrAUyeLDnuQ6oXKzzyDC6fQb
        h16/QFv38MFKL3eoCpOHDUyWoD++AT6+nm2IgWl25GOwDpphmNcUc9DKM1OcakY3
        zGZ+umNKYH/57bgutryU23+DnW+g4N3MjF9g6ilkodnRXeD/BYwg9jBOHOQqyVWg
        7l94ZmN0lFCE/j2AVfi5cXBmHPPN3qTyYrDjamLjR6QlF6eu/ZdbG0bs15fnEFwg
        ==
X-ME-Sender: <xms:vugBXT3qDm1O6rpf6g3ayd3PMePXma8gtWCnfD3gyDA1CsLcCYTpUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudehkedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrd
    dutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:vugBXfNGHuHbtGgQHKT2wq2hSJF-oHXbHyFvgN8kIabt9ejfWt5GAg>
    <xmx:vugBXS7hojMmINy7zWMzAePtennEs5KMQI0qbnre4UFoLk7SI_EpDA>
    <xmx:vugBXZ18SiOyeURqk8BheyCDqpK37prG0ccs7tX0RqkJh37CrZ0RHA>
    <xmx:wOgBXQ6sacaSZCIxmNsAi17FK4kzyE7hDHzsLOohUAyvMbROi8U7RA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 59CB6380087;
        Thu, 13 Jun 2019 02:10:06 -0400 (EDT)
Date:   Thu, 13 Jun 2019 08:10:04 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
Message-ID: <20190613061004.GA27058@kroah.com>
References: <20190613155344.64fce8b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613155344.64fce8b9@canb.auug.org.au>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 03:53:44PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   drivers/misc/vmw_balloon.c
> 
> between commit:
> 
>   225afca60b8a ("vmw_balloon: no need to check return value of debugfs_create functions")
> 
> from the driver-core tree and commits:
> 
>   83a8afa72e9c ("vmw_balloon: Compaction support")
>   5d1a86ecf328 ("vmw_balloon: Add memory shrinker")
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
> diff --cc drivers/misc/vmw_balloon.c
> index fdf5ad757226,043eed845246..000000000000
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@@ -1553,15 -1942,26 +1932,24 @@@ static int __init vmballoon_init(void
>   	if (x86_hyper_type != X86_HYPER_VMWARE)
>   		return -ENODEV;
>   
> - 	for (page_size = VMW_BALLOON_4K_PAGE;
> - 	     page_size <= VMW_BALLOON_LAST_SIZE; page_size++)
> - 		INIT_LIST_HEAD(&balloon.page_sizes[page_size].pages);
> - 
> - 
>   	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
>   
> + 	error = vmballoon_register_shrinker(&balloon);
> + 	if (error)
> + 		goto fail;
> + 
>  -	error = vmballoon_debugfs_init(&balloon);
>  -	if (error)
>  -		goto fail;
>  +	vmballoon_debugfs_init(&balloon);
>   
> + 	/*
> + 	 * Initialization of compaction must be done after the call to
> + 	 * balloon_devinfo_init() .
> + 	 */
> + 	balloon_devinfo_init(&balloon.b_dev_info);
> + 	error = vmballoon_compaction_init(&balloon);
> + 	if (error)
> + 		goto fail;
> + 
> + 	INIT_LIST_HEAD(&balloon.huge_pages);
>   	spin_lock_init(&balloon.comm_lock);
>   	init_rwsem(&balloon.conf_sem);
>   	balloon.vmci_doorbell = VMCI_INVALID_HANDLE;


Looks good, thanks!

greg k-h
