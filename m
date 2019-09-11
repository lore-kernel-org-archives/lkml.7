Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F61ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333F6208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568187295;
	bh=oTsJLHFP7zjZe20JbH2yE7Wsvq3hvHECLsJ+7aK1evg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tpq8frB4WB4bVZLjoEaN5uFrFRcOVOafDN/MWh0MgQFlLvZXzCvTAAxupzElXKGxt
	 v1tVSW+E0k0CYs+xwJo+WuCoN/i60HsZ+R+rJPI2IBEJmKbW2zgiDvOB8VeoJfcouy
	 Aa6UmL7XXBDpB/oAvJ55w+okUM8XchIlRdvLaHu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfIKHey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:34:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:34836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbfIKHey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:34:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9410BAD7F;
        Wed, 11 Sep 2019 07:34:52 +0000 (UTC)
Date:   Wed, 11 Sep 2019 09:34:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190911073451.GM4023@dhcp22.suse.cz>
References: <20190910093114.GA19821@kroah.com>
 <34feca56-c95e-41a6-e09f-8fc2d2fd2bce@huawei.com>
 <20190910110451.GP2063@dhcp22.suse.cz>
 <20190910111252.GA8970@kroah.com>
 <5a5645d2-030f-7921-432f-ff7d657405b8@huawei.com>
 <20190910125339.GZ2063@dhcp22.suse.cz>
 <20190911053334.GH4023@dhcp22.suse.cz>
 <ca590101-bfc8-3934-d803-537aacb707e0@huawei.com>
 <20190911064926.GJ4023@dhcp22.suse.cz>
 <3b977388-5f25-d0b5-bdc9-f963a9be2bd1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b977388-5f25-d0b5-bdc9-f963a9be2bd1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-09-19 15:22:30, Yunsheng Lin wrote:
[...]
> It seems that there is no protection that prevent setting the node
> of device to an invalid node.
> And the kernel does have a few different check now:
> 1) some does " < 0" check;
> 2) some does "== NUMA_NO_NODE" check;
> 3) some does ">= MAX_NUMNODES" check;
> 4) some does "< 0 || >= MAX_NUMNODES || !node_online(node)" check.
> 
> We need to be consistent about the checking, right?

You can try and chase each of them and see what to do with them. I
suspect they are a result of random attempts to fortify the code in many
cases. Consistency is certainly good but spreading more checks all over
the place just adds more cargo cult. Each check should be reasonably
justified.

-- 
Michal Hocko
SUSE Labs
