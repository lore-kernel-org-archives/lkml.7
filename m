Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FA9206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfCKHN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:13:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfCKHN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:13:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BEF7630832CF;
        Mon, 11 Mar 2019 07:13:27 +0000 (UTC)
Received: from [10.72.12.54] (ovpn-12-54.pek2.redhat.com [10.72.12.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 288C75DA27;
        Mon, 11 Mar 2019 07:13:18 +0000 (UTC)
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, aarcange@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <20190308141220.GA21082@infradead.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
Date:   Mon, 11 Mar 2019 15:13:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308141220.GA21082@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 11 Mar 2019 07:13:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/8 下午10:12, Christoph Hellwig wrote:
> On Wed, Mar 06, 2019 at 02:18:07AM -0500, Jason Wang wrote:
>> This series tries to access virtqueue metadata through kernel virtual
>> address instead of copy_user() friends since they had too much
>> overheads like checks, spec barriers or even hardware feature
>> toggling. This is done through setup kernel address through vmap() and
>> resigter MMU notifier for invalidation.
>>
>> Test shows about 24% improvement on TX PPS. TCP_STREAM doesn't see
>> obvious improvement.
> How is this going to work for CPUs with virtually tagged caches?


Anything different that you worry? I can have a test but do you know any 
archs that use virtual tag cache?

Thanks

