Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F564C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E63207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HKWT5bPJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SKi1epJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfCIDm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 22:42:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48028 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfCIDm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 22:42:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 617C76087D; Sat,  9 Mar 2019 03:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552102975;
        bh=BEQnw82ugnELq9g2PIfNnuVifTIhO2fIcKljsI9jDGQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HKWT5bPJYiBxarhi7c2ZwbwLWA7azH3lMT3q/cDQPkky4LHiQGz8euJP0uysuuY3p
         nYPcbQBFmk/J5GjL9mxO6c1Bpfb8P/iD74qkMAbAC7doXCyYfuMEn9+lwk/r34SxCa
         uzEJ8OqdjJLSsJGUkUDHCcIjdaJQxVWQdfIx7D+o=
Received: from [10.204.78.89] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A12D8602F8;
        Sat,  9 Mar 2019 03:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552102974;
        bh=BEQnw82ugnELq9g2PIfNnuVifTIhO2fIcKljsI9jDGQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SKi1epJRAhl6M093BlT0brK65uufPd0WUNz4LQba7sju2WyRXm+9gB7rlf1/rkcKg
         SNOFboZvYTwaTuOkriJt5V7GPguSajgssxkCSGXeE0zyrwEDw2K6HefoorJ6yw6tEA
         Tm2KBxsLAqSd3fE79212Dt9WM6oc1KXe1oaysa2k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A12D8602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu/tree_plugin: Fix nohz status in stall warning
To:     paulmck@linux.ibm.com
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
References: <1552069309-24392-1-git-send-email-neeraju@codeaurora.org>
 <20190308211840.GW13351@linux.ibm.com>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <99ea3a0a-31b1-be28-418e-a3a80b02260b@codeaurora.org>
Date:   Sat, 9 Mar 2019 09:12:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190308211840.GW13351@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/19 2:48 AM, Paul E. McKenney wrote:
> On Fri, Mar 08, 2019 at 11:51:49PM +0530, Neeraj Upadhyay wrote:
>> Fix stall warning, to show correct nohz marker.
>>
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> 
> Good eyes, thank you!
> 
> I applied and pushed all three with modified commit logs.  Please check
> to make sure that I didn't mess anything up.  If testing and reviews
> are OK, I expect to submit them for the v5.2 merge window.
> 
> I had to hand-apply this one, so in future patches could you please
> generate them against -rcu?  It may be found here:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> 
> 							Thanx, Paul
> 

Thanks Paul, I reviewed the patches on -rcu; they look good. Thanks for 
applying them! I will move my codebase to  -rcu, for all future work.

Thanks
Neeraj

>> ---
>>   kernel/rcu/tree_plugin.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index 97dba50..93da32c 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -1659,7 +1659,7 @@ static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
>>   		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
>>   		".l"[rdp->all_lazy],
>>   		".L"[!rcu_segcblist_n_nonlazy_cbs(&rdp->cblist)],
>> -		".D"[!rdp->tick_nohz_enabled_snap]);
>> +		".D"[!!rdp->tick_nohz_enabled_snap]);
>>   }
>>
>>   #else /* #ifdef CONFIG_RCU_FAST_NO_HZ */
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>> member of the Code Aurora Forum, hosted by The Linux Foundation
>>
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
