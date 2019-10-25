Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1F4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED8C21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406637AbfJYHOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:14:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406555AbfJYHOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:14:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3B05BC9B8F20A4332C18;
        Fri, 25 Oct 2019 15:14:50 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 15:14:44 +0800
Subject: Re: [PATCH] audit: remove redundant condition check in
 kauditd_thread()
To:     Paul Moore <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        <hushiyuan@huawei.com>, <linfeilong@huawei.com>
References: <7869bb43-5cb1-270a-07d1-31574595e13e@huawei.com>
 <16e0170d878.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <a700333e-53b8-1a28-b27d-2ba3f612df2a@huawei.com>
Date:   Fri, 25 Oct 2019 15:14:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <16e0170d878.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/25 13:43, Paul Moore wrote:
> On October 23, 2019 3:27:50 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
>> Warning is found by the code analysis tool:
>>  "the condition 'if(ac && rc < 0)' is redundant: ac"
>>
>>
>> The @ac variable has been checked before. It can't be a null pointer
>> here, so remove the redundant condition check.
>>
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>> kernel/audit.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Hello,
> 
> Thank you for the patch.  Looking quickly at it, it appears to be correct, unfortunately I'm not in a position to merge non-critical patches, but I expect to merge this next week.
> 
ok, thanks.

> 
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index da8dc0db5bd3..193f3a1f4425 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -830,7 +830,7 @@ static int kauditd_thread(void *dummy)
>>  rc = kauditd_send_queue(sk, portid,
>>  &audit_hold_queue, UNICAST_RETRIES,
>>  NULL, kauditd_rehold_skb);
>> - if (ac && rc < 0) {
>> + if (rc < 0) {
>>  sk = NULL;
>>  auditd_reset(ac);
>>  goto main_queue;
>> @@ -840,7 +840,7 @@ static int kauditd_thread(void *dummy)
>>  rc = kauditd_send_queue(sk, portid,
>>  &audit_retry_queue, UNICAST_RETRIES,
>>  NULL, kauditd_hold_skb);
>> - if (ac && rc < 0) {
>> + if (rc < 0) {
>>  sk = NULL;
>>  auditd_reset(ac);
>>  goto main_queue;
>> --
>> 2.7.4.3
> 
> --
> paul moore
> www.paul-moore.com
> 
> 
> 
> 
> 
> 

