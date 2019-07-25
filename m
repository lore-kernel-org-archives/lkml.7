Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CA6C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A7022BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564076437;
	bh=v5yXlm0ySbjH9KYVN6Nqcko2ymh4rZfsF2TdFPmyY7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kjYpsqslNhPFKAf46C5PAewoTOz8mv8PVkatGPkU3mipZLMmKa5bo6v5hHpCj3Arr
	 w+EOkyNMeULAAgj8U5D7hwtbGZl3641kqtJOzMpZNpwnVJ+X4pqM2hcKjG1GWi+IoE
	 fTtwVCIz7qPzl5K6+iJXXC7x+eKH91bQOJOLruvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbfGYRkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfGYRkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:40:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79AF422BE8;
        Thu, 25 Jul 2019 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564076435;
        bh=v5yXlm0ySbjH9KYVN6Nqcko2ymh4rZfsF2TdFPmyY7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cf0NrbzxwN1M9j7L43mP+u3u8SJKAyjDsM0cOYEdgJvIpWskctistAzocLZjDHkEN
         ba/45n2CQ0Z0Vu5YE8bZ1WQSq7k3lFsVvFslO0EgJItOxPoN3cpbF0XLhnLZMiHACv
         SqahQYWRTwQbD+2RwOPjk7Yu0qf8B7tBjUz8+4cA=
Date:   Thu, 25 Jul 2019 19:40:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
Message-ID: <20190725174032.GA27818@kroah.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725172335.6825-3-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:23:21AM -0600, Logan Gunthorpe wrote:
> cdev_get_by_path() attempts to retrieve a struct cdev from
> a path name. It is analagous to blkdev_get_by_path().
> 
> This will be necessary to create a nvme_ctrl_get_by_path()to
> support NVMe-OF passthru.

Ick, why?  Why would a cdev have a "pathname"?

What is "NVMe-OF passthru"?  Why does a char device node have anything
to do with NVMe?

We have way too many ways to abuse cdevs today, my long-term-wish has
always been to clean this interface up to make it more sane and unified,
and get rid of the "outliers" (all created at the time for a good
reason, that's not the problem.)  But to add "just one more" seems
really odd to me.

thanks,

greg k-h
