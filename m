Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DBCC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A22206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfHALD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:03:26 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51807 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfHALDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:03:25 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x71B2oew063046;
        Thu, 1 Aug 2019 20:02:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Thu, 01 Aug 2019 20:02:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x71B2oBn063042
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 1 Aug 2019 20:02:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: common: Fix potential Spectre v1 vulnerability
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190731185457.GA21407@embeddedor>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <96483333-99e1-dce1-864a-5456ba6350d2@i-love.sakura.ne.jp>
Date:   Thu, 1 Aug 2019 20:02:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731185457.GA21407@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Thanks for a patch, but I have a question.

On 2019/08/01 3:54, Gustavo A. R. Silva wrote:
> profile is controlled by user-space via /sys/kernel/security/tomoyo/profile,

It is true that "profile" value is given from user-space, and it will be true
that speculative execution would access "ns->profile_ptr[profile]" before whether
"profile >= TOMOYO_MAX_PROFILES" is true is concluded. But

> hence leading to a potential exploitation of the Spectre variant 1
> vulnerability.

which memory address is vulnerable to Spectre variant 1 attack? How can an attacker
gain information from memory speculatively accessed by "ns->profile_ptr[profile]" ?
Where is the memory access which corresponds to "arr2->data[index2]" demonstrated at
https://googleprojectzero.blogspot.com/2018/01/reading-privileged-memory-with-side.html ?

Since I'm not familiar with Spectre/Meltdown problem, this patch sounds as if
"Oh, let's suppress Smatch warning". I want to know whether this problem is real
and this patch is worth keeping stable@vger.kernel.org ...

> @@ -488,13 +489,15 @@ static void tomoyo_print_number_union(struct tomoyo_io_buffer *head,
>   * Returns pointer to "struct tomoyo_profile" on success, NULL otherwise.
>   */
>  static struct tomoyo_profile *tomoyo_assign_profile
> -(struct tomoyo_policy_namespace *ns, const unsigned int profile)
> +(struct tomoyo_policy_namespace *ns, unsigned int profile)
>  {
>  	struct tomoyo_profile *ptr;
>  	struct tomoyo_profile *entry;
>  
>  	if (profile >= TOMOYO_MAX_PROFILES)
>  		return NULL;
> +	profile = array_index_nospec(profile, TOMOYO_MAX_PROFILES);
> +
>  	ptr = ns->profile_ptr[profile];
>  	if (ptr)
>  		return ptr;
> 

By the way, since /sys/kernel/security/tomoyo/profile is writable by only explicitly
whitelisted domains/programs (&& by only root user by default), I think that it is
OK to treat this "profile" value as trusted.

