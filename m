Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1642CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70D721874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389568AbfHHBIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 21:08:53 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:51591 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730467AbfHHBIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 21:08:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TYvZ9x9_1565226526;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TYvZ9x9_1565226526)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Aug 2019 09:08:47 +0800
Subject: Re: [PATCH][ocfs2-next] ocfs2: ensure ret is set to zero before
 returning
To:     Colin Ian King <colin.king@canonical.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ocfs2-devel@oss.oracle.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190807121929.28918-1-colin.king@canonical.com>
 <fb3d7441-93ea-b619-52fc-00da950c9201@gmail.com>
 <bf4d059a-94fc-d8cf-78c7-8606644185a5@canonical.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <0cee7ca9-8704-171a-ec82-ee6c16e3381b@linux.alibaba.com>
Date:   Thu, 8 Aug 2019 09:08:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bf4d059a-94fc-d8cf-78c7-8606644185a5@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/8/7 20:42, Colin Ian King wrote:
> On 07/08/2019 13:35, Joseph Qi wrote:
>>
>>
>> On 19/8/7 20:19, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> A previous commit introduced a regression where variable ret was
>>> originally being set from the return from a call to function
>>> dlm_create_debugfs_subroot and this set was removed. Currently
>>> ret is now uninitialized if no alloction errors are found which
>>> may end up with a bogus check on ret < 0 on the 'leave:' return
>>> path.  Fix this by setting ret to zero on a successful execution
>>> path.
>>
>> Good catch.
>> Or shall we just initialize 'ret' at first?
> 
> Initialized ret first may not catch subsequent coding errors where error
> returns paths have not initialized ret, so my preference is when it is
> required and not before.
> 
Okay, looks good to me.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

>>
>>>
>>> Addresses-Coverity: ("Uninitialzed scalar variable")
> 
> Can this be fixed up when applied rather sending a V2?
>>
Currently ocfs2 patches are maintained in Andrew's mm tree.
So it depends on Andrew.

Thanks,
Joseph
