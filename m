Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB72C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456AA207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfJNHI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:08:58 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:47143 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729966AbfJNHI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:08:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=zhiyuan2048@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Teyix93_1571036934;
Received: from houzhiyuandeMacBook-Pro.local(mailfrom:zhiyuan2048@linux.alibaba.com fp:SMTPD_---0Teyix93_1571036934)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Oct 2019 15:08:54 +0800
From:   Zhiyuan Hou <zhiyuan2048@linux.alibaba.com>
Subject: Re: [PATCH net] net: sched: act_mirred: drop skb's dst_entry in
 ingress redirection
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191012071620.8595-1-zhiyuan2048@linux.alibaba.com>
 <2ad15b96-156d-7b71-0e37-74ceeacade35@cogentembedded.com>
Message-ID: <20b0aafe-4c1c-1c7a-5563-56eb43ebb409@linux.alibaba.com>
Date:   Mon, 14 Oct 2019 15:08:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <2ad15b96-156d-7b71-0e37-74ceeacade35@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/10/13 3:34 上午, Sergei Shtylyov wrote:
> Hello!
>
> On 10/12/2019 10:16 AM, Zhiyuan Hou wrote:
>
>> In act_mirred's ingress redirection, if the skb's dst_entry is valid
>> when call function netif_receive_skb, the fllowing l3 stack process
>    Following or flowing?
Sorry, it should be following. I will change it in next version.
>> (ip_rcv_finish_core) will check dst_entry and skip the routing
>> decision. Using the old dst_entry is unexpected and may discard the
>> skb in some case. For example dst->dst_input points to dst_discard.
>>
>> This patch drops the skb's dst_entry before calling netif_receive_skb
>> so that the skb can be made routing decision like a normal ingress
>> skb.
>>
>> Signed-off-by: Zhiyuan Hou<zhiyuan2048@linux.alibaba.com>
>> ---
>>   net/sched/act_mirred.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
>> index 9ce073a05414..6108a64c0cd5 100644
>> --- a/net/sched/act_mirred.c
>> +++ b/net/sched/act_mirred.c
> [...]
>> @@ -298,8 +299,10 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
>>   
>>   	if (!want_ingress)
>>   		err = dev_queue_xmit(skb2);
>> -	else
>> +	else {
>> +		skb_dst_drop(skb2);
>>   		err = netif_receive_skb(skb2);
>> +	}
>     If you introduce {} in one *if* branch, {} should be added to the other branches as well,
> says CodingStyle.
I will change it in next version . Thanks.
> [...]
>
> MBR, Sergei
