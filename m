Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC02C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057372077B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfCTAyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:54:02 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54459 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727047AbfCTAyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:54:02 -0400
X-IronPort-AV: E=Sophos;i="5.60,246,1549900800"; 
   d="scan'208";a="57180373"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Mar 2019 08:53:57 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id C7A4C4CD445B;
        Wed, 20 Mar 2019 08:53:26 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 20 Mar 2019 08:54:00 +0800
Subject: Re: [PATCH v3] net: xfrm: Add '_rcu' tag for rcu protected pointer in
 netns_xfrm
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
CC:     <davem@davemloft.net>, <fw@strlen.de>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1551923648-17656-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190311101006.GK3758@gauss3.secunet.de>
 <b2beff03-f789-5c8b-bd69-57ece92372f8@gmail.com>
 <20190319151503.GW6035@gauss3.secunet.de>
From:   "Su Yanjun <suyj.fnst@cn.fujitsu.com>" <suyj.fnst@cn.fujitsu.com>
Message-ID: <91cf303a-7d44-2c15-8b7a-8b2eb797a234@cn.fujitsu.com>
Date:   Wed, 20 Mar 2019 08:53:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190319151503.GW6035@gauss3.secunet.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: C7A4C4CD445B.AA078
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/19 23:15, Steffen Klassert wrote:
> On Mon, Mar 18, 2019 at 10:22:46AM -0700, Eric Dumazet wrote:
>>
>> On 03/11/2019 03:10 AM, Steffen Klassert wrote:
>>> On Wed, Mar 06, 2019 at 08:54:08PM -0500, Su Yanjun wrote:
>>>> For rcu protected pointers, we'd better add '__rcu' for them.
>>>>
>>>> Once added '__rcu' tag for rcu protected pointer, the sparse tool reports
>>>> warnings.
>>>>
>>>> net/xfrm/xfrm_user.c:1198:39: sparse:    expected struct sock *sk
>>>> net/xfrm/xfrm_user.c:1198:39: sparse:    got struct sock [noderef] <asn:4> *nlsk
>>>> [...]
>>>>
>>>> So introduce a new wrapper function of nlmsg_unicast  to handle type
>>>> conversions.
>>>>
>>>> This patch also fixes a direct access of a rcu protected socket.
>>>>
>>>> Fixes: be33690d8fcf("[XFRM]: Fix aevent related crash")
>>>> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
>>> Patch applied, thanks!
>>>
>> Has this patch ever been tested ?
> I had this on your testing system and it did
> not complain. But maybe my testcases did not
> trigger that codepath. Su, can you answer
> on Eric question?
>
Firs of all, I didn't produce it on my test machine.

Maybe we need recompile the kernel with Eric Dumazet's advise.

CONFIG_LOCKDEP=y
CONFIG_PROVE_RCU=y

The second the code path indeed doesn't do as below:
rcu_read_lock()
rcu_dereference()
...
rcu_read_unlock()

All rcu_dereference are in the follow code path:
xfrm_user_rcv_msg
  link->doit(skb, nlh, attrs)
     rcu_dereference()

I think we can add rcu protection for nlsock

xfrm_user_rcv_msg
   rcu_read_lock()
   link->doit(skb, nlh, attrs)
   rcu_read_unlock()

Any advise?



