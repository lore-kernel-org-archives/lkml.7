Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23053C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E126920657
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g5Y9GHKn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TD+kkHx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfCLLzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:55:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35132 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfCLLze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:55:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 32A94608A5; Tue, 12 Mar 2019 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552391734;
        bh=dpLLuNeAQXMZnAv2XwzRoUUnLTx1Bgo49pZ/7KpaUjI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=g5Y9GHKngBcP1rNqw9sn50jaP6/wQ7hvIC9npAGrCQcDiqv4t6BgZXO89ruOnaPw5
         0TrHXxJ2nvpn8r+t3/zuxyKFquLn26kMTm5foA+mGxGJ8bcuni1cX3zzaq5EEkcvvs
         DIUuB7EI1xFjKo3iqeBt/5aqpeBzlGLWXhv7/CFw=
Received: from [10.204.78.89] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 033206028C;
        Tue, 12 Mar 2019 11:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552391732;
        bh=dpLLuNeAQXMZnAv2XwzRoUUnLTx1Bgo49pZ/7KpaUjI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TD+kkHx+bN6dxMakh1/Y4Gbcf4xEiwR7bnLe3LkeADLUCddBZxoX5i00IcBNA2tiJ
         bjCShcjx9DVWWXaH+EblrWfDy7iSMeJ2exhUzXmSxP4rcfbsBQrepkKPkRNtJKYVji
         mQz1fI5isWgL4wldCISxqhCVAfcrRT13QV6L/xpA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 033206028C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu/tree: Fix self wakeups for grace period kthread
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
References: <1552038378-11166-1-git-send-email-neeraju@codeaurora.org>
 <20190311215027.2f3458a1@oasis.local.home>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <579cd03a-17a7-5729-46b3-ffcc4afee0e5@codeaurora.org>
Date:   Tue, 12 Mar 2019 17:25:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190311215027.2f3458a1@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/19 7:20 AM, Steven Rostedt wrote:
> On Fri,  8 Mar 2019 15:16:18 +0530
> Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
> 
>> Update the code to match the comment that self wakeup of
>> grace period kthread is allowed from interrupt handler, and
>> softirq handler, running in the grace period kthread's
>> context. Present code allows self wakeups from all
>> interrupt contexts - nmi, softirq and hardirq contexts.
> 
> That's not actually the issue. But it appears that we return if we
> simply have BH disabled, which I don't think we want, and we don't care
> about NMI as NMI should never call this code.
> 
> I think your patch is correct, but the change log is not.
> 
> -- Steve
> 

Hi Steve, sorry, I don't understand fully, why we want to not return in 
BH disabled case. From the commit logs and lkml discussion, there is a 
case where GP kthread is interrupted in the wait event path and 
rcu_gp_kthread_wake() is called in softirq handler (I am not sure about 
interrupt handler case; how rcu_gp_kthread_wake() is called from that path).

https://github.com/torvalds/linux/commit/1d1f898df6586c5ea9aeaf349f13089c6fa37903

Thanks
Neeraj
> 
>>
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>> ---
>>   kernel/rcu/tree.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index acd6ccf..57cac6d 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -1585,7 +1585,7 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
>>   static void rcu_gp_kthread_wake(void)
>>   {
>>   	if ((current == rcu_state.gp_kthread &&
>> -	     !in_interrupt() && !in_serving_softirq()) ||
>> +	     !in_irq() && !in_serving_softirq()) ||
>>   	    !READ_ONCE(rcu_state.gp_flags) ||
>>   	    !rcu_state.gp_kthread)
>>   		return;
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
