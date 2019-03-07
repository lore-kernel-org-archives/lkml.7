Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176122064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfCGCqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:46:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfCGCqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:46:07 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65AF7C05090A;
        Thu,  7 Mar 2019 02:46:07 +0000 (UTC)
Received: from [10.72.12.83] (ovpn-12-83.pek2.redhat.com [10.72.12.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0A7C1001DD9;
        Thu,  7 Mar 2019 02:45:59 +0000 (UTC)
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org, aarcange@redhat.com
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190306092837-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
Date:   Thu, 7 Mar 2019 10:45:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306092837-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 07 Mar 2019 02:46:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/7 上午12:31, Michael S. Tsirkin wrote:
>> +static void vhost_set_vmap_dirty(struct vhost_vmap *used)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < used->npages; i++)
>> +		set_page_dirty_lock(used->pages[i]);
> This seems to rely on page lock to mark page dirty.
>
> Could it happen that page writeback will check the
> page, find it clean, and then you mark it dirty and then
> invalidate callback is called?
>
>

Yes. But does this break anything? The page is still there, we just 
remove a kernel mapping to it.

Thanks

