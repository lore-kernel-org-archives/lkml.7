Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FBFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 03:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7023218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 03:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NQHus6+s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OYzIMBXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfC3Don (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 23:44:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38254 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbfC3Don (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 23:44:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 23EE56079C; Sat, 30 Mar 2019 03:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553917482;
        bh=93iznbvlKQ3F7xK/RPlPSlA0NlZ9shD2OCP07kE9t/M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NQHus6+s2eQCFJxzfo8wko4+qq5ffr0vsA2OP3tVGQp3hWabHAOrAMi80GCjE56AG
         oLamI49lv+OzSKe1pQ11aFTqD3ZvcK5zQHwQs1JyJXAiqJ7MIIwJfUDAgTkla3Cefr
         3aKDtVj9Kx7KkQ5Nbm87HdAaR2EiG7HORBGn94mI=
Received: from [10.204.78.89] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 887906079C;
        Sat, 30 Mar 2019 03:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553917481;
        bh=93iznbvlKQ3F7xK/RPlPSlA0NlZ9shD2OCP07kE9t/M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OYzIMBXXC322DJxTAt9nqRG48Bf1MIT85Mnifdzs4FExyQPSpzRFlH5hzCXHKILrr
         ykQcl5mBychb5k5yTR3xCQ7iezXIOXA3bfdgS1PfDkOM5i7R6PiNeTD3O8n6CqtWOE
         dYFHEp1fV3xLz9bNXHPIeR5TGHqIjlIZyh0L+pes=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 887906079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu: tree_stall: Correctly unlock root node in
 rcu_check_gp_start_stall
To:     paulmck@linux.ibm.com
Cc:     Mukesh Ojha <mojha@codeaurora.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1553858828-23097-1-git-send-email-neeraju@codeaurora.org>
 <7a9eed5a-9bcf-460c-abb9-1e9bd6eae102@codeaurora.org>
 <2a8057f7-0704-5e8f-423e-e56a91a9b448@codeaurora.org>
 <20190329212755.GB4102@linux.ibm.com>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <10b7ba19-9184-a4aa-d609-a644fcbe0503@codeaurora.org>
Date:   Sat, 30 Mar 2019 09:14:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190329212755.GB4102@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/19 2:57 AM, Paul E. McKenney wrote:
> On Fri, Mar 29, 2019 at 07:52:15PM +0530, Neeraj Upadhyay wrote:
>>
>>
>> On 3/29/19 6:58 PM, Mukesh Ojha wrote:
>>>
>>> On 3/29/2019 4:57 PM, Neeraj Upadhyay wrote:
>>>> Only unlock the root node, if current node (rnp) is not
>>>> root node.
>>>>
>>>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>>>
>>>
>>>
>>>> ---
>>>>    kernel/rcu/tree_stall.h | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>>>> index f65a73a..0651833 100644
>>>> --- a/kernel/rcu/tree_stall.h
>>>> +++ b/kernel/rcu/tree_stall.h
>>>
>>>
>>> why this is showing as under tree_stall.h while it is under
>>> "kernel/rcu/tree.c"
>>
>> It's moved in https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=10462d6f58fb6dbde7563e9343505d98d5bfba3d
>>
>> Please see linux-rcu dev tree for other changes, which moves code to
>> this file.
>>
>>
>> Thanks
>> Neeraj
>>
>>>
>>>> @@ -630,7 +630,9 @@ static void rcu_check_gp_start_stall(struct
>>>> rcu_node *rnp, struct rcu_data *rdp,
>>>>            time_before(j, rcu_state.gp_req_activity + gpssdelay) ||
>>>>            time_before(j, rcu_state.gp_activity + gpssdelay) ||
>>>>            atomic_xchg(&warned, 1)) {
>>>> -        raw_spin_unlock_rcu_node(rnp_root); /* irqs remain disabled. */
>>>> +        if (rnp_root != rnp)
>>>> +            /* irqs remain disabled. */
>>>> +            raw_spin_unlock_rcu_node(rnp_root);
>>>
>>> Looks good as it will balance the lock .if it is the root_node,
>>> which was not there earlier, and unlock was happening without any
>>> lock on root.
>>>
>>> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> 
> Applied, again thank you both!
> 
> In both cases, I updated the commit log, so please check to make sure
> that I didn't mess anything up.
> 
> 							Thanx, Paul
> 

Thanks Paul. One minor comment on 
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=ec6530e763046b6bb1f4c2c2aed49ebc68aae2a0 


"it clearly does not make sense to release
both rnp->lock and rnp->lock"

should be rnp->lock and rnp_root->lock



Thanks
Neeraj

>>> Cheers,
>>> -Mukesh
>>>
>>>>            raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>>>>            return;
>>>>        }
>>
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>> member of the Code Aurora Forum, hosted by The Linux Foundation
>>
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
