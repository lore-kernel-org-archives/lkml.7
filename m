Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C254C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724EF2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfLPNN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:13:56 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727686AbfLPNN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:13:56 -0500
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 5256726D3F4AF5DAC4EB;
        Mon, 16 Dec 2019 13:13:54 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml708-cah.china.huawei.com (10.201.108.49) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Dec 2019 13:13:53 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Dec
 2019 13:13:53 +0000
Subject: Re: Suspicious RCU usage in tomoyo code
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
References: <9620521a-c197-d54e-438b-759e244d24b3@huawei.com>
 <ab0f5a5b-4ba4-7a11-3b17-e84c30be3d49@i-love.sakura.ne.jp>
 <20191216010458.GQ2889@paulmck-ThinkPad-P72>
 <e5135d83-db1d-72dc-c74f-c563520f8686@huawei.com>
 <fb986973-a443-1b57-f0d3-970e8be62138@i-love.sakura.ne.jp>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f32e108c-1e92-9522-255d-676472c3b04e@huawei.com>
Date:   Mon, 16 Dec 2019 13:13:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <fb986973-a443-1b57-f0d3-970e8be62138@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+

On 16/12/2019 10:30, Tetsuo Handa wrote:
> On 2019/12/16 18:20, John Garry wrote:
>> On 16/12/2019 01:04, Paul E. McKenney wrote:
>>>> Thank you for reporting. I was surprised that this warning did not show up.
>>>> Something has changed or only some config combination could trigger it ...
>>> Any particular reason we are having this discussion privately?;-)
>>>
>>
>> I did mention this initially - I didn't know if reporting issues in "security" domain is generally always open. Probably being very paranoid or silly of me...
> 
> Since this is not a security problem, you can post to public lists.
> Anyway, here is a patch. Will you try?
> 
>  From 8356e05a5822ffad5d374c992bc6af26ea655d6d Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Mon, 16 Dec 2019 19:16:48 +0900
> Subject: [PATCH] tomoyo: Add tomoyo: Suppress RCU warning at list_for_each_entry_rcu().
> 
> John Garry has reported that allmodconfig kernel on arm64 causes flood of
> "RCU-list traversed in non-reader section!!" warning. I don't know what
> change caused this warning, but this warning is safe because TOMOYO uses
> SRCU lock instead. Let's suppress this warning by explicitly telling that
> the caller is holding SRCU lock.
> 
> Reported-by: John Garry <john.garry@huawei.com>

Yeah, this looks to have fixed it:

Tested-by: John Garry <john.garry@huawei.com>

Thanks

> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>   security/tomoyo/common.c |  9 ++++++---
>   security/tomoyo/domain.c | 15 ++++++++++-----
>   security/tomoyo/group.c  |  9 ++++++---
>   security/tomoyo/util.c   |  6 ++++--
>   4 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
> index dd3d5942e669..c36bafbcd77e 100644
> --- a/security/tomoyo/common.c
> +++ b/security/tomoyo/common.c
> @@ -951,7 +951,8 @@ static bool tomoyo_manager(void)
>   	exe = tomoyo_get_exe();
>   	if (!exe)
>   		return false;
> -	list_for_each_entry_rcu(ptr, &tomoyo_kernel_namespace.policy_list[TOMOYO_ID_MANAGER], head.list) {
> +	list_for_each_entry_rcu(ptr, &tomoyo_kernel_namespace.policy_list[TOMOYO_ID_MANAGER], head.list,
> +				srcu_read_lock_held(&tomoyo_ss)) {
>   		if (!ptr->head.is_deleted &&
>   		    (!tomoyo_pathcmp(domainname, ptr->manager) ||
>   		     !strcmp(exe, ptr->manager->name))) {
> @@ -1095,7 +1096,8 @@ static int tomoyo_delete_domain(char *domainname)
>   	if (mutex_lock_interruptible(&tomoyo_policy_lock))
>   		return -EINTR;
>   	/* Is there an active domain? */
> -	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list) {
> +	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list,
> +				srcu_read_lock_held(&tomoyo_ss)) {
>   		/* Never delete tomoyo_kernel_domain */
>   		if (domain == &tomoyo_kernel_domain)
>   			continue;
> @@ -2778,7 +2780,8 @@ void tomoyo_check_profile(void)
>   
>   	tomoyo_policy_loaded = true;
>   	pr_info("TOMOYO: 2.6.0\n");
> -	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list) {
> +	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list,
> +				srcu_read_lock_held(&tomoyo_ss)) {
>   		const u8 profile = domain->profile;
>   		struct tomoyo_policy_namespace *ns = domain->ns;
>   
> diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
> index 8526a0a74023..7869d6a9980b 100644
> --- a/security/tomoyo/domain.c
> +++ b/security/tomoyo/domain.c
> @@ -41,7 +41,8 @@ int tomoyo_update_policy(struct tomoyo_acl_head *new_entry, const int size,
>   
>   	if (mutex_lock_interruptible(&tomoyo_policy_lock))
>   		return -ENOMEM;
> -	list_for_each_entry_rcu(entry, list, list) {
> +	list_for_each_entry_rcu(entry, list, list,
> +				srcu_read_lock_held(&tomoyo_ss)) {
>   		if (entry->is_deleted == TOMOYO_GC_IN_PROGRESS)
>   			continue;
>   		if (!check_duplicate(entry, new_entry))
> @@ -119,7 +120,8 @@ int tomoyo_update_domain(struct tomoyo_acl_info *new_entry, const int size,
>   	}
>   	if (mutex_lock_interruptible(&tomoyo_policy_lock))
>   		goto out;
> -	list_for_each_entry_rcu(entry, list, list) {
> +	list_for_each_entry_rcu(entry, list, list,
> +				srcu_read_lock_held(&tomoyo_ss)) {
>   		if (entry->is_deleted == TOMOYO_GC_IN_PROGRESS)
>   			continue;
>   		if (!tomoyo_same_acl_head(entry, new_entry) ||
> @@ -166,7 +168,8 @@ void tomoyo_check_acl(struct tomoyo_request_info *r,
>   	u16 i = 0;
>   
>   retry:
> -	list_for_each_entry_rcu(ptr, list, list) {
> +	list_for_each_entry_rcu(ptr, list, list,
> +				srcu_read_lock_held(&tomoyo_ss)) {
>   		if (ptr->is_deleted || ptr->type != r->param_type)
>   			continue;
>   		if (!check_entry(r, ptr))
> @@ -298,7 +301,8 @@ static inline bool tomoyo_scan_transition
>   {
>   	const struct tomoyo_transition_control *ptr;
>   
> -	list_for_each_entry_rcu(ptr, list, head.list) {
> +	list_for_each_entry_rcu(ptr, list, head.list,
> +				srcu_read_lock_held(&tomoyo_ss)) {
>   		if (ptr->head.is_deleted || ptr->type != type)
>   			continue;
>   		if (ptr->domainname) {
> @@ -735,7 +739,8 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
>   
>   		/* Check 'aggregator' directive. */
>   		candidate = &exename;
> -		list_for_each_entry_rcu(ptr, list, head.list) {
> +		list_for_each_entry_rcu(ptr, list, head.list,
> +					srcu_read_lock_held(&tomoyo_ss)) {
>   			if (ptr->head.is_deleted ||
>   			    !tomoyo_path_matches_pattern(&exename,
>   							 ptr->original_name))
> diff --git a/security/tomoyo/group.c b/security/tomoyo/group.c
> index a37c7dc66e44..1cecdd797597 100644
> --- a/security/tomoyo/group.c
> +++ b/security/tomoyo/group.c
> @@ -133,7 +133,8 @@ tomoyo_path_matches_group(const struct tomoyo_path_info *pathname,
>   {
>   	struct tomoyo_path_group *member;
>   
> -	list_for_each_entry_rcu(member, &group->member_list, head.list) {
> +	list_for_each_entry_rcu(member, &group->member_list, head.list,
> +				srcu_read_lock_held(&tomoyo_ss)) {
>   		if (member->head.is_deleted)
>   			continue;
>   		if (!tomoyo_path_matches_pattern(pathname, member->member_name))
> @@ -161,7 +162,8 @@ bool tomoyo_number_matches_group(const unsigned long min,
>   	struct tomoyo_number_group *member;
>   	bool matched = false;
>   
> -	list_for_each_entry_rcu(member, &group->member_list, head.list) {
> +	list_for_each_entry_rcu(member, &group->member_list, head.list,
> +				srcu_read_lock_held(&tomoyo_ss)) {
>   		if (member->head.is_deleted)
>   			continue;
>   		if (min > member->number.values[1] ||
> @@ -191,7 +193,8 @@ bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *address,
>   	bool matched = false;
>   	const u8 size = is_ipv6 ? 16 : 4;
>   
> -	list_for_each_entry_rcu(member, &group->member_list, head.list) {
> +	list_for_each_entry_rcu(member, &group->member_list, head.list,
> +				srcu_read_lock_held(&tomoyo_ss)) {
>   		if (member->head.is_deleted)
>   			continue;
>   		if (member->address.is_ipv6 != is_ipv6)
> diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
> index 52752e1a84ed..eba0b3395851 100644
> --- a/security/tomoyo/util.c
> +++ b/security/tomoyo/util.c
> @@ -594,7 +594,8 @@ struct tomoyo_domain_info *tomoyo_find_domain(const char *domainname)
>   
>   	name.name = domainname;
>   	tomoyo_fill_path_info(&name);
> -	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list) {
> +	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list,
> +				srcu_read_lock_held(&tomoyo_ss)) {
>   		if (!domain->is_deleted &&
>   		    !tomoyo_pathcmp(&name, domain->domainname))
>   			return domain;
> @@ -1028,7 +1029,8 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
>   		return false;
>   	if (!domain)
>   		return true;
> -	list_for_each_entry_rcu(ptr, &domain->acl_info_list, list) {
> +	list_for_each_entry_rcu(ptr, &domain->acl_info_list, list,
> +				srcu_read_lock_held(&tomoyo_ss)) {
>   		u16 perm;
>   		u8 i;
>   
> 

