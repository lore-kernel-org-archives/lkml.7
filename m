Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165EEC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE0321774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574961557;
	bh=0eDcF33MHbh3guelUltnLjg7ZZiO5V4fJN2AmHy9rEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N6GXZunLg68C5yBBiTTF/VHmY6wxl8HxX8o/ksrC+PGb4AeoDgSFKBxOBhJbW4aN/
	 hg2buuWiFjlE1ahwBHbMaH3RE0tWvJjNXyOa/IldDx1ZijiMOBCH8aBCbFpQN8U17g
	 6cFOsGnbRfOLg9ZHmDfmd8iX8dw+/Kyjz8y9L9uI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfK1RTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 12:19:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfK1RTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 12:19:16 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B1B21739;
        Thu, 28 Nov 2019 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574961554;
        bh=0eDcF33MHbh3guelUltnLjg7ZZiO5V4fJN2AmHy9rEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wGB5qa8GwmRs4uVVxB+IqfF3A9vdWuLHf2V2ZARa/dfI36r/7qzVipa1D51UOSxBK
         uMyXK5VtJD3XG5hScvFF+eN1fg02rY3Wfyg6gklSP5PsJ6kX232bb+JDT40kM5hRsa
         elNy3vFa1JVSC9jLgIf+s9BkkiyQKNw4wwVaKUQM=
Date:   Thu, 28 Nov 2019 18:19:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     tanhuazhong@huawei.com, stable-commits@vger.kernel.org
Subject: Re: Patch "net: hns3: fix error handling int the
 hns3_get_vector_ring_chain" has been added to the 4.19-stable tree
Message-ID: <20191128171910.GA3471498@kroah.com>
References: <20191128150014.3202521787@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191128150014.3202521787@mail.kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 10:00:11AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     net: hns3: fix error handling int the hns3_get_vector_ring_chain
> 
> to the 4.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      net-hns3-fix-error-handling-int-the-hns3_get_vector_.patch
> and it can be found in the queue-4.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 4b01732de5278618d8b013fa300638742392d507
> Author: Huazhong Tan <tanhuazhong@huawei.com>
> Date:   Tue Dec 18 19:37:48 2018 +0800
> 
>     net: hns3: fix error handling int the hns3_get_vector_ring_chain
>     
>     [ Upstream commit cda69d244585bc4497d3bb878c22fe2b6ad647c1 ]
>     
>     When hns3_get_vector_ring_chain() failed in the
>     hns3_nic_init_vector_data(), it should do the error handling instead
>     of return directly.
>     
>     Also, cur_chain should be freed instead of chain and head->next should
>     be set to NULL in error handling of hns3_get_vector_ring_chain.
>     
>     This patch fixes them.
>     
>     Fixes: 73b907a083b8 ("net: hns3: bugfix for buffer not free problem during resetting")
>     Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
>     Signed-off-by: Peng Li <lipeng321@huawei.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index 3708f149d0a6a..2f1c4adf1734d 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -2597,9 +2597,10 @@ err_free_chain:
>  	cur_chain = head->next;
>  	while (cur_chain) {
>  		chain = cur_chain->next;
> -		devm_kfree(&pdev->dev, chain);
> +		devm_kfree(&pdev->dev, cur_chain);
>  		cur_chain = chain;
>  	}
> +	head->next = NULL;
>  
>  	return -ENOMEM;
>  }
> @@ -2671,7 +2672,7 @@ static int hns3_nic_init_vector_data(struct hns3_nic_priv *priv)
>  		ret = hns3_get_vector_ring_chain(tqp_vector,
>  						 &vector_ring_chain);
>  		if (ret)
> -			return ret;
> +			goto map_ring_fail;
>  
>  		ret = h->ae_algo->ops->map_ring_to_vector(h,
>  			tqp_vector->vector_irq, &vector_ring_chain);

This breaks the build:
../drivers/net/ethernet/hisilicon/hns3/hns3_enet.c: In function ‘hns3_nic_init_vector_data’:
../drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:2675:4: error: label ‘map_ring_fail’ used but not defined
 2675 |    goto map_ring_fail;
      |    ^~~~


So I'm going to drop it from the tree.

thanks,

greg k-h
