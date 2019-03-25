Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047B220879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfCYIMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:12:52 -0400
Received: from relay.sw.ru ([185.231.240.75]:51752 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbfCYIMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:12:52 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1h8Kis-0002DJ-S4; Mon, 25 Mar 2019 11:12:47 +0300
Subject: Re: [PATCH net] netlink: fix a memory leak on error path
To:     cgxu519 <cgxu519@gmx.com>, davem@davemloft.net
Cc:     keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190322105845.25046-1-cgxu519@gmx.com>
 <2acfd376-7b25-5eeb-2770-413b880bd4d9@virtuozzo.com>
 <786f1aec-fe47-f060-6f6e-4307ecaff82d@gmx.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <84e65ccd-d2ee-ed7c-e758-06a8a74312e3@virtuozzo.com>
Date:   Mon, 25 Mar 2019 11:12:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <786f1aec-fe47-f060-6f6e-4307ecaff82d@gmx.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.2019 04:19, cgxu519 wrote:
> On 3/22/19 7:03 PM, Kirill Tkhai wrote:
>> Hi, Chengguang,
>>
>> On 22.03.2019 13:58, Chengguang Xu wrote:
>>> In genl_register_family(), when idr_alloc() fails,
>>> we forget to free family->attrbuf.
>>>
>>> Note, some callers call genl_unregister_family() to clean up
>>> on error path, it doesn't work because the family is inserted
>>> to the global list in the nearly last step.
>>>
>>> Fixes: 2ae0f17df1c ("genetlink: use idr to track families").
>>> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
>> have you seen https://patchwork.ozlabs.org/patch/1059834/ ?
> 
> Sorry, I didn't notice that because I'm mainly working on linus-tree.
> Please just ignore this patch.

Not a problem.

Some information about network development process you may find in

https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt

Kirill
