Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A91AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C490207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfI0HOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:14:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfI0HOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:14:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 557223090FD3;
        Fri, 27 Sep 2019 07:14:55 +0000 (UTC)
Received: from [10.72.12.30] (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52410608A5;
        Fri, 27 Sep 2019 07:14:44 +0000 (UTC)
Subject: Re: [PATCH] vhost: introduce mdev based hardware backend
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     mst@redhat.com, alex.williamson@redhat.com,
        maxime.coquelin@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        lingshan.zhu@intel.com
References: <20190926045427.4973-1-tiwei.bie@intel.com>
 <1b4b8891-8c14-1c85-1d6a-2eed1c90bcde@redhat.com>
 <20190927045438.GA17152@___>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <49bb0777-3761-3737-8e5b-568957f9a935@redhat.com>
Date:   Fri, 27 Sep 2019 15:14:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927045438.GA17152@___>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 27 Sep 2019 07:14:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/27 下午12:54, Tiwei Bie wrote:
>>> +
>>> +		/*
>>> +		 * In vhost-mdev, userspace should pass ring addresses
>>> +		 * in guest physical addresses when IOMMU is disabled or
>>> +		 * IOVAs when IOMMU is enabled.
>>> +		 */
>> A question here, consider we're using noiommu mode. If guest physical
>> address is passed here, how can a device use that?
>>
>> I believe you meant "host physical address" here? And it also have the
>> implication that the HPA should be continuous (e.g using hugetlbfs).
> The comment is talking about the virtual IOMMU (i.e. iotlb in vhost).
> It should be rephrased to cover the noiommu case as well. Thanks for
> spotting this.


So the question still, if GPA is passed how can it be used by the 
virtio-mdev device?

Thanks

