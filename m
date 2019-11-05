Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D36C17488
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3077D21D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPYSp2Nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbfKEOCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:02:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40564 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388428AbfKEOCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:02:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id e3so7353491plt.7;
        Tue, 05 Nov 2019 06:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YQL6SU2a3KKoxlnyLuTfZyxJaKZQZOJt+fGwiLwFJ9U=;
        b=pPYSp2NbeXLKWAE9KkeK2vm7vB0gKz42Hn9YwazC1o3qnOC94f4orQrSZIShFbN7sK
         68v1nDDjgBVBgqTAG0A1KG+y0ZI0d82qmwb/n538ktvyL5qs58ckPeAPJF8pOi3wm0pf
         Pvv9RgbyMbDr5+/+xX5QTcblS2FfzYtnDB95acI88zTExYefcIeiBsOzMpbP3qU6GSf2
         GuosVwY307GC7Owz/fwcJV9ybRADP6HN19es9Re8uljIhTacybA2nSXmoKAQ7FyqxuWs
         fa8F2uy2dAJDp3xAUY/FL3VI9KT/qpWg9uHfDJhWGmQUis8iNI/ArhXTI2368BG6U7Mz
         4b9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YQL6SU2a3KKoxlnyLuTfZyxJaKZQZOJt+fGwiLwFJ9U=;
        b=C20Lo+qcUxHI8XW/w53ZosmyZVGIP2CZatB5pcuiPj9t4ynb4DuLEzsAGnOkGqu+OC
         M4mUYpUO/YC0SqSg9o7863GKCSyz2dwR0AUFpU5z8uTanyjC1DONF1JKRIfjzAXCPr5g
         8oYEFYy5keh67o9TG6IAb1ZFLsaA0klH7uJc6K5XBl1yOZKt867LUi4qta13nVxqrxE2
         W0JKHPNg/1ZnTR5GX/AGd9BkRAKWAyMFf0KBIJhMybZfamy2CQM4iz8KKI06xPP9PRm0
         ghkve1fsi6HPrqdUtc31SzXcQS4suPpjiVJlOFvvsYbRoAvhV/uiwk1fu/G/yLwiIgxk
         vgjQ==
X-Gm-Message-State: APjAAAUq1AYvL+gncae8n735BvSerYTFqWO8oJGxUyTC0qYR4YWs4EDj
        WFSzjFPWhYaZJYuxDtbvOt7Yjhxn5+8=
X-Google-Smtp-Source: APXvYqzWvTeN5jzIYdnusiSIYJblVUpaFWxzfXQyB0OKxJ/r//EY/3c+H7crSzSveOLdOGuPma9KQA==
X-Received: by 2002:a17:902:9343:: with SMTP id g3mr13093886plp.278.1572962570199;
        Tue, 05 Nov 2019 06:02:50 -0800 (PST)
Received: from ?IPv6:2405:4800:58f7:3f8f:27cb:abb4:d0bd:49cb? ([2405:4800:58f7:3f8f:27cb:abb4:d0bd:49cb])
        by smtp.gmail.com with ESMTPSA id v17sm25646727pfc.41.2019.11.05.06.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 06:02:49 -0800 (PST)
Cc:     tranmanphong@gmail.com, madhuparnabhowmik04@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: RCU: NMI-RCU:
 Converted NMI-RCU.txt to NMI-RCU.rst.
To:     paulmck@kernel.org
References: <20191028214252.17580-1-madhuparnabhowmik04@gmail.com>
 <5bab8828-76e4-c67f-5855-ea4e4f43eaa5@gmail.com>
 <20191105135524.GN20975@paulmck-ThinkPad-P72>
From:   Phong Tran <tranmanphong@gmail.com>
Message-ID: <7b9f5499-bd03-8405-52f5-1fb94e9d85dc@gmail.com>
Date:   Tue, 5 Nov 2019 21:02:46 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105135524.GN20975@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/19 8:55 PM, Paul E. McKenney wrote:
> On Tue, Nov 05, 2019 at 08:40:05PM +0700, Phong Tran wrote:
>> On 10/29/19 4:42 AM, madhuparnabhowmik04@gmail.com wrote:
>>> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>>>
>>> This patch converts NMI-RCU from txt to rst format.
>>> Also adds NMI-RCU in the index.rst file.
>>>
>>> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>>> -- >   .../RCU/{NMI-RCU.txt => NMI-RCU.rst}          | 53 ++++++++++---------
>>>    Documentation/RCU/index.rst                   |  1 +
>>>    2 files changed, 29 insertions(+), 25 deletions(-)
>>>    rename Documentation/RCU/{NMI-RCU.txt => NMI-RCU.rst} (73%)
>>>
>>> diff --git a/Documentation/RCU/NMI-RCU.txt b/Documentation/RCU/NMI-RCU.rst
>>> similarity index 73%
>>> rename from Documentation/RCU/NMI-RCU.txt
>>> rename to Documentation/RCU/NMI-RCU.rst
>>> index 881353fd5bff..da5861f6a433 100644
>>> --- a/Documentation/RCU/NMI-RCU.txt
>>> +++ b/Documentation/RCU/NMI-RCU.rst
>>> @@ -1,4 +1,7 @@
>>> +.. _NMI_rcu_doc:
>>> +
>>>    Using RCU to Protect Dynamic NMI Handlers
>>> +=========================================
>>>    Although RCU is usually used to protect read-mostly data structures,
>>> @@ -9,7 +12,7 @@ work in "arch/x86/oprofile/nmi_timer_int.c" and in
>>>    "arch/x86/kernel/traps.c".
>>>    The relevant pieces of code are listed below, each followed by a
>>> -brief explanation.
>>> +brief explanation.::
>> there is just a minor ":" redundant in html page.There are some same in this
>> patch.
>> eg:
>>   brief explanation.:
>>
>> Other things look good to me.
>>
>> Tested-by: Phong Tran <tranmanphong@gmail.com>
> 
> Thank you, Phong!
> 
> I queued a commit to be squashed into Madhuparna's original as shown below
> which adds your Tested-by and attempts a fix.  Does this work for you?
> 

Yes, Paul.

Regards,
Phong.

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 2c29f1c481f74f5e5aaaab195042f4df6a0b8119
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Nov 5 05:51:12 2019 -0800
> 
>      squash! Documentation: RCU: NMI-RCU: Converted NMI-RCU.txt to NMI-RCU.rst.
>      
>      [ paulmck: Apply feedback from Phong Tran. ]
>      Tested-by: Phong Tran <tranmanphong@gmail.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/Documentation/RCU/NMI-RCU.rst b/Documentation/RCU/NMI-RCU.rst
> index da5861f..1809583 100644
> --- a/Documentation/RCU/NMI-RCU.rst
> +++ b/Documentation/RCU/NMI-RCU.rst
> @@ -12,7 +12,7 @@ work in "arch/x86/oprofile/nmi_timer_int.c" and in
>   "arch/x86/kernel/traps.c".
>   
>   The relevant pieces of code are listed below, each followed by a
> -brief explanation.::
> +brief explanation::
>   
>   	static int dummy_nmi_callback(struct pt_regs *regs, int cpu)
>   	{
> @@ -21,12 +21,12 @@ brief explanation.::
>   
>   The dummy_nmi_callback() function is a "dummy" NMI handler that does
>   nothing, but returns zero, thus saying that it did nothing, allowing
> -the NMI handler to take the default machine-specific action.::
> +the NMI handler to take the default machine-specific action::
>   
>   	static nmi_callback_t nmi_callback = dummy_nmi_callback;
>   
>   This nmi_callback variable is a global function pointer to the current
> -NMI handler.::
> +NMI handler::
>   
>   	void do_nmi(struct pt_regs * regs, long error_code)
>   	{
> @@ -61,7 +61,7 @@ Quick Quiz:
>   
>   :ref:`Answer to Quick Quiz <answer_quick_quiz_NMI>`
>   
> -Back to the discussion of NMI and RCU...::
> +Back to the discussion of NMI and RCU::
>   
>   	void set_nmi_callback(nmi_callback_t callback)
>   	{
> 
