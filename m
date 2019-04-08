Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A817EC282DE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF912083E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554702168;
	bh=Eam6bwVOBxBj+UrgngXB1E43VfbW4J8B+X6oHMeLd3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C9UeOKFN9iDqnLOLwybTYq202QXg7FYtjBnhHPnnJt/tdHKYEuaV2VxIDZ9AG4xkW
	 l1wLQlTZ2TBhqupSEJ64QEwSW2sULagFh2EofUqG61HXedZ2RdaSC1IvYOSvjvC8n9
	 bkOE7W/3ZnjqsDg9qcxKfGYeJ+sa27qiatQsr8lo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDHFmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:42:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:53054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbfDHFmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:42:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F0A8AEDF;
        Mon,  8 Apr 2019 05:42:45 +0000 (UTC)
Date:   Mon, 8 Apr 2019 07:42:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     akpm@linux-foundation.org, rafael@kernel.org, david@redhat.com,
        rafael.j.wysocki@intel.com, osalvador@suse.de, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, bsingharora@gmail.com,
        gregkh@linuxfoundation.org, yangyingliang@huawei.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RESENT PATCH] mm/memory_hotplug: Do not unlock when fails to
 take the device_hotplug_lock
Message-ID: <20190408054238.GB18103@dhcp22.suse.cz>
References: <1554696437-9593-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554696437-9593-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08-04-19 12:07:17, zhong jiang wrote:
> When adding the memory by probing memory block in sysfs interface, there is an
> obvious issue that we will unlock the device_hotplug_lock when fails to takes it.
> 
> That issue was introduced in Commit 8df1d0e4a265
> ("mm/memory_hotplug: make add_memory() take the device_hotplug_lock")
> 
> We should drop out in time when fails to take the device_hotplug_lock.
> 
> Fixes: 8df1d0e4a265 ("mm/memory_hotplug: make add_memory() take the device_hotplug_lock")
> Reported-by: Yang yingliang <yangyingliang@huawei.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  drivers/base/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index d9ebb89..0c9e22f 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -507,7 +507,7 @@ static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
>  
>  	ret = lock_device_hotplug_sysfs();
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	nid = memory_add_physaddr_to_nid(phys_addr);
>  	ret = __add_memory(nid, phys_addr,
> -- 
> 1.7.12.4
> 

-- 
Michal Hocko
SUSE Labs
