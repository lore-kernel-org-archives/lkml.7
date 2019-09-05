Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFBCC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4251F2053B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567674175;
	bh=mmdFor1PcuA/NKVn/lYFZyPn01kc0gzg6HNtEancJ78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c2xnaOWTm1mjkO6ncCOU8Z33vDNhRCCL+dmDxZs4DQGTiY2sHUPH/ExkdnN/hnCfY
	 pYJqjEHDb3UJStbQ/NUVK8qQCFcsh7iGp0YMfM77sNknPqE5nNTy76pnvlRlDGLX3n
	 ENOwbT8wWu/n5WpHuTskCvu/o4KNfhbbw1JH0c4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbfIEJCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfIEJCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:02:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DA1C21743;
        Thu,  5 Sep 2019 09:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567674172;
        bh=mmdFor1PcuA/NKVn/lYFZyPn01kc0gzg6HNtEancJ78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8q30NhyqU9VGgtV02UIjQm6Bg813ked4SuWBacps7edAqTUIH4GsWYwnLZbXHb+3
         nbs5QMAGwuGdRHh1V6L2hOX/8am3+Bvc7MKbURzlCMO3Wa9go4BO/6gS3n58HyRaDX
         VWMVUrP1luxySIjBuCrHztG2DjUnBfVNbHHuLz20=
Date:   Thu, 5 Sep 2019 11:02:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org, mhocko@kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH RFC] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190905090249.GA28356@kroah.com>
References: <1567647230-166903-1-git-send-email-linyunsheng@huawei.com>
 <20190905055727.GB23826@kroah.com>
 <e5905af2-5a8d-7b00-d2a6-a961f3eee120@huawei.com>
 <20190905073334.GA29933@kroah.com>
 <d282774f-29fb-cffb-d606-ab678f792565@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d282774f-29fb-cffb-d606-ab678f792565@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 04:57:00PM +0800, Yunsheng Lin wrote:
> On 2019/9/5 15:33, Greg KH wrote:
> > On Thu, Sep 05, 2019 at 02:48:24PM +0800, Yunsheng Lin wrote:
> >> On 2019/9/5 13:57, Greg KH wrote:
> >>> On Thu, Sep 05, 2019 at 09:33:50AM +0800, Yunsheng Lin wrote:
> >>>> Currently a device does not belong to any of the numa nodes
> >>>> (dev->numa_node is NUMA_NO_NODE) when the FW does not provide
> >>>> the node id and the device has not no parent device.
> >>>>
> >>>> According to discussion in [1]:
> >>>> Even if a device's numa node is not set by fw, the device
> >>>> really does belong to a node.
> >>>>
> >>>> This patch sets the device node to node 0 in device_add() if
> >>>> the fw has not specified the node id and it either has no
> >>>> parent device, or the parent device also does not have a valid
> >>>> node id.
> >>>>
> >>>> There may be explicit handling out there relying on NUMA_NO_NODE,
> >>>> like in nvme_probe().
> >>>>
> >>>> [1] https://lkml.org/lkml/2019/9/2/466
> >>>>
> >>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >>>> ---
> >>>>  drivers/base/core.c  | 17 ++++++++++++++---
> >>>>  include/linux/numa.h |  2 ++
> >>>>  2 files changed, 16 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
> >>>> index 1669d41..466b8ff 100644
> >>>> --- a/drivers/base/core.c
> >>>> +++ b/drivers/base/core.c
> >>>> @@ -2107,9 +2107,20 @@ int device_add(struct device *dev)
> >>>>  	if (kobj)
> >>>>  		dev->kobj.parent = kobj;
> >>>>  
> >>>> -	/* use parent numa_node */
> >>>> -	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
> >>>> -		set_dev_node(dev, dev_to_node(parent));
> >>>> +	/* use parent numa_node or default node 0 */
> >>>> +	if (!numa_node_valid(dev_to_node(dev))) {
> >>>> +		int nid = parent ? dev_to_node(parent) : NUMA_NO_NODE;
> >>>
> >>> Can you expand this to be a "real" if statement please?
> >>
> >> Sure. May I ask why "? :" is not appropriate here?
> > 
> > Because it is a pain to read, just spell it out and make it obvious what
> > is happening.  You write code for developers first, and the compiler
> > second, and in this case, either way is identical to the compiler.
> > 
> >>>> +
> >>>> +		if (numa_node_valid(nid)) {
> >>>> +			set_dev_node(dev, nid);
> >>>> +		} else {
> >>>> +			if (nr_node_ids > 1U)
> >>>> +				pr_err("device: '%s': has invalid NUMA node(%d)\n",
> >>>> +				       dev_name(dev), dev_to_node(dev));
> >>>
> >>> dev_err() will show you the exact device properly, instead of having to
> >>> rely on dev_name().
> >>>
> >>> And what is a user to do if this message happens?  How do they fix this?
> >>> If they can not, what good is this error message?
> >>
> >> If user know about their system's topology well enough and node 0
> >> is not the nearest node to the device, maybe user can readjust that by
> >> writing the nearest node to /sys/class/pci_bus/XXXX/device/numa_node,
> >> if not, then maybe user need to contact the vendor for info or updates.
> >>
> >> Maybe print error message as below:
> >>
> >> dev_err(dev, FW_BUG "has invalid NUMA node(%d). Readjust it by writing to sysfs numa_node or contact your vendor for updates.\n",
> >> 	dev_to_node(dev));
> > 
> > FW_BUG?
> 
> The sysfs numa_node writing interface does print FW_BUG error.
> Maybe it is a way of telling the user to contact the vendors, which
> pushing the vendors to update the FW.

But is this always going to be caused by a firmware bug?  If so, ok, if
not, and it's a driver/bus kernel issue, we should not say this.

thanks,

greg k-h
