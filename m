Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B347C74A51
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E153A21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562836650;
	bh=BJaqNQiaWz4IxMifm+8jkrjlESYxJn/dng2qMZSFyTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C6KIv6jpi3dCv1TV3Z0MkQHHUXWt1J+YhWF6UPW6eQV+9NA4Xnj4tmauNhS1FByXN
	 YL1hezjwQtn0L7LPBd80Defxgkrj48Rdf4FE2nBLyLr8fqW0YNSb+Rlwg6mkBE2WWI
	 5/M6KGUSArzO9bmBivy2J7wdKrpl1QB8j/kyH66M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfGKJR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 05:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbfGKJR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 05:17:28 -0400
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9000B21537;
        Thu, 11 Jul 2019 09:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562836648;
        bh=BJaqNQiaWz4IxMifm+8jkrjlESYxJn/dng2qMZSFyTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yll/OcT24z/unZKChbj3v+bkPTEA1e678eVnFAxCeW2RUFxNS8mz8Tr9TMv42wVEz
         GA2Gdp8DD89ezkFOAArBdHQK/59cTzhgrlPAYlsDTE/jQv6iapTLvkqq+ET3YvQOCP
         EyYq9dIhBdYKK8vZMOOQjHD3qhMPFJZyIBCdrao8=
Date:   Thu, 11 Jul 2019 11:17:23 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     rusty@rustcorp.com.au, kay.sievers@vrfy.org,
        clabbe.montjoie@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        wangxiaogang3@huawei.com, zhoukang7@huawei.com,
        Mingfangsen <mingfangsen@huawei.com>
Subject: Re: [PATCH v2] module: add usage links when calling ref_module func
Message-ID: <20190711091723.GA28411@linux-8ccs>
References: <4fec6c3b-03b8-dd57-4009-99431105a8a5@huawei.com>
 <20190709161039.GA3501@linux-8ccs>
 <de919fd8-afd8-244c-d316-19d5a3895406@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de919fd8-afd8-244c-d316-19d5a3895406@huawei.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Zhiqiang Liu [11/07/19 14:03 +0800]:
>
>
>On 2019/7/10 0:10, Jessica Yu wrote:
>> +++ Zhiqiang Liu [03/07/19 10:09 +0800]:
>>> From: Zhiqiang Liu <liuzhiqiang26@huawei.com
>>>
>>> V1->V2:
>>> - remove incorrect Fixes tag
>>> - fix error handling of sysfs_create_link as suggested by Jessica Yu
>>>
>>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>>> Suggested-by: Jessica Yu <jeyu@kernel.org>
>>> Reviewed-by: Kang Zhou <zhoukang7@huawei.com>
>>> ---
>>> kernel/module.c | 18 ++++++++++++++----
>>> 1 file changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/module.c b/kernel/module.c
>>> index 80c7c09584cf..672abce2222c 100644
>>> --- a/kernel/module.c
>>> +++ b/kernel/module.c
>>> @@ -837,25 +837,26 @@ static int already_uses(struct module *a, struct module *b)
>>>  *    'b' can walk the list to see who sourced them), and of 'a'
>>>  *    targets (so 'a' can see what modules it targets).
>>>  */
>>> /* Module a uses b: caller needs module_mutex() */
>>> int ref_module(struct module *a, struct module *b)
>>> {
>>> +    struct module_use *use;
>>>     int err;
>>>
>>>     if (b == NULL || already_uses(a, b))
>>> @@ -866,9 +867,18 @@ int ref_module(struct module *a, struct module *b)
>>>     if (err)
>>>         return err;
>>>
>>> -    err = add_module_usage(a, b);
>>> +    use = add_module_usage(a, b);
>>> +    if (!use) {
>>> +        module_put(b);
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    err = sysfs_create_link(b->holders_dir, &a->mkobj.kobj, a->name);
>>
>> Sigh. This ultimately doesn't work because in load_module(), we use
>> ref_module() in resolve_symbol(), and mod->mkobj.kobj doesn't get
>> initialized until mod_sysfs_init(), which happens much later in
>> load_module(). So what happens is that the ref_module(mod, owner) call
>> in resolve_symbol() returns an error because sysfs_create_link() fails here.
>> We could *maybe* move sysfs initialization earlier in load_module()
>> but that is an entirely untested idea and I would need to think about
>> that more.
>
>Thank you for the reply.
>I have tested the patch through livepatch. Maybe I miss somethings.
>I will rewrite the patch and test it entirely before sending the v3 patch.

Thanks Zhiqiang. A boot test and testing loading modules with
dependencies would be really appreciated.

Thanks!

Jessica
