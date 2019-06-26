Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8039C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB7A20659
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfFZDgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:36:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbfFZDgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:36:38 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C40E1D7433C33B160F3E;
        Wed, 26 Jun 2019 11:36:35 +0800 (CST)
Received: from [127.0.0.1] (10.133.205.80) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Jun 2019
 11:36:27 +0800
Subject: Re: [PATCH] modules: fix compile error if don't have strict module
 rwx
To:     Jessica Yu <jeyu@kernel.org>
References: <1561455628-50795-1-git-send-email-yangyingliang@huawei.com>
 <20190625192115.GA27913@linux-8ccs>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <namit@vmware.com>, <cj.chengjian@huawei.com>,
        <sfr@canb.auug.org.au>, <linux-next@vger.kernel.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5D12E83B.9000209@huawei.com>
Date:   Wed, 26 Jun 2019 11:36:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190625192115.GA27913@linux-8ccs>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.205.80]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/26 3:21, Jessica Yu wrote:
> +++ Yang Yingliang [25/06/19 17:40 +0800]:
>> If CONFIG_ARCH_HAS_STRICT_MODULE_RWX is not defined,
>> we need stub for module_enable_nx() and module_enable_x().
>>
>> If CONFIG_ARCH_HAS_STRICT_MODULE_RWX is defined, but
>> CONFIG_STRICT_MODULE_RWX is disabled, we need stub for
>> module_enable_nx.
>>
>> Move frob_text() outside of the CONFIG_STRICT_MODULE_RWX,
>> because it is needed anyway.
>
> Maybe include a fixes tag?
>
> Fixes: 2eef1399a866 ("modules: fix BUG when load module with rodata=n")
OK, I will add it in v2.
>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>> kernel/module.c | 13 +++++++++----
>> 1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index c3ae34c..cfff441 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -1875,7 +1875,7 @@ static void mod_sysfs_teardown(struct module *mod)
>>     mod_sysfs_fini(mod);
>> }
>>
>> -#ifdef CONFIG_STRICT_MODULE_RWX
>> +#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
>
> Could you please explain why you introduced a new
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX #ifdef block instead of just moving
> frob_text() and module_enable_x() outside of CONFIG_STRICT_MODULE_RWX?
If CONFIG_STRICT_MODULE_RWX is not defined, it has two reasons, one is 
that the
arch don't have strict module rwx and the other reason is that 
CONFIG_STRICT_MODULE_RWX
is disabled. So I introduce CONFIG_ARCH_HAS_STRICT_MODULE_RWX #ifdef 
block to
distinguish this two cases.

>
> I do not have anything against it, although the nested #ifdef's are a
> bit painful to read. But I could not find a better way to do it :/
> It's awkward because we need module_enable_x() and frob_text()
> regardless of of CONFIG_STRICT_MODULE_RWX for x86, but other arches
> don't need to call module_enable_x(), they usually just call the empty 
> stub.
Yes, you are right.
Actually, I was thinking moving all frob_* outside of 
CONFIG_STRICT_MODULE_RWX,
because they all should be regardless of of CONFIG_STRICT_MODULE_RWX. 
But current
only frob_next() is used, move other frob_* outside of 
CONFIG_STRICT_MODULE_RWX
will cause a compile warning if CONFIG_STRICT_MODULE_RWX is disabled, so 
I left them
in CONFIG_STRICT_MODULE_RWX.  We can move them outside of 
CONFIG_STRICT_MODULE_RWX
if they are used in future.
>
> But I think having the CONFIG_ARCH_HAS_STRICT_MODULE_RWX block is OK,
> for the reason of limiting the scope of the calls rather than
> blanketly calling frob_text() andd module_enable_x() for arches that
> don't need to call them. Was that your reasoning as well?
Yes,  it's my reasoning.


Thanks,
Yang
>
> Thanks,
>
> Jessica
>
>
>> /*
>>  * LKM RO/NX protection: protect module's text/ro-data
>>  * from modification and any data from execution.
>> @@ -1898,6 +1898,7 @@ static void frob_text(const struct 
>> module_layout *layout,
>>            layout->text_size >> PAGE_SHIFT);
>> }
>>
>> +#ifdef CONFIG_STRICT_MODULE_RWX
>> static void frob_rodata(const struct module_layout *layout,
>>             int (*set_memory)(unsigned long start, int num_pages))
>> {
>> @@ -2010,15 +2011,19 @@ void set_all_modules_text_ro(void)
>>     }
>>     mutex_unlock(&module_mutex);
>> }
>> -#else
>> +#else /* !CONFIG_STRICT_MODULE_RWX */
>> static void module_enable_nx(const struct module *mod) { }
>> -#endif
>> -
>> +#endif /*  CONFIG_STRICT_MODULE_RWX */
>> static void module_enable_x(const struct module *mod)
>> {
>>     frob_text(&mod->core_layout, set_memory_x);
>>     frob_text(&mod->init_layout, set_memory_x);
>> }
>> +#else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
>> +static void module_enable_nx(const struct module *mod) { }
>> +static void module_enable_x(const struct module *mod) { }
>> +#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
>> +
>>
>> #ifdef CONFIG_LIVEPATCH
>> /*
>> -- 
>> 1.8.3
>>
>
> .
>


