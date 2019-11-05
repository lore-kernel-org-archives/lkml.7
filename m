Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7831C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654C82087E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYo/5KBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfKEVxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:53:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41657 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfKEVxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:53:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id p26so16982713pfq.8;
        Tue, 05 Nov 2019 13:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4CXYo/cgnoTsCjAMMynzYTPUIwRzWVFEV0CA8Ua58Rw=;
        b=pYo/5KBRtiZGkS9XOGtjyGi+PMmOAuB114Bqxn0MWScWhMaw+OhvDkiP13vVvPf4Lo
         3NqKu7qhA9gYtLAJxsiIFxb94+ENYwN2awt+kv1aJ5aRfS92zbZdpo1HttOoQIVH+OkQ
         Ik0avMKoSNfN+iq5tMbl/fOjYTUNl8eLcHHXUt+9OqcvyJMBt7Lf5T5/heA7wr/gDfSs
         pgN/M+O3NjOBYwbEP3RByettcMZkmXQv8hpuRVncZ11LLJPxzMrLvDcBnv4Lq+OP3d5D
         m1iNQstaoyzBG8BqpJu7Ox6rEy/NeE0XcC+RysDNBIX/T88eBAaSeUI7Au4UoZH9CTtb
         1kCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4CXYo/cgnoTsCjAMMynzYTPUIwRzWVFEV0CA8Ua58Rw=;
        b=TLIrI61D+9yqqGdiwHskKYSQDwetTWDHRegkJM8WZAFfYfjAHGzXwyi/5L3ODGyMQj
         O2Se2QHQmnl0ljHEXwX9wtZ7+ZMuhlGhRzaic3ZTR7tbuRonG6Ah7m6LBPU+hdQhBp5J
         iyzeI8xvS2O1TfFFgdj9QnPpcmcNjoNBavHW56ejV4W/nF9TG5xbw9R2xN2FfRsxs1v/
         YWtElONSoVQpBzR8SP7QuYJniVIHzAOmLjCqor1qOmZsSM8beOj0fqAPffx0j1zMsC2P
         4TmlKw1AHP6dJXexi/FOP3/K3cf0PoTxz5DeXSLn9cM00SdyzwzRR8X7i/6ucGNcHEiP
         r34A==
X-Gm-Message-State: APjAAAVNOlrGryoKgUEyEz2m2vYrulWal+hEpOEzsqAEk7AWUDhwyZK2
        iDF2703omjRXY4TUBDcL/9U=
X-Google-Smtp-Source: APXvYqwO87q9uzOmJnztEtcJaqvZdxcCGQp4Nl/xpHUxsvGf6y9yLfWIWFVIDmQU67zH05Ip1BIgQA==
X-Received: by 2002:a65:55c3:: with SMTP id k3mr37746623pgs.155.1572990790523;
        Tue, 05 Nov 2019 13:53:10 -0800 (PST)
Received: from ?IPv6:2405:4800:58f7:3f8f:27cb:abb4:d0bd:49cb? ([2405:4800:58f7:3f8f:27cb:abb4:d0bd:49cb])
        by smtp.gmail.com with ESMTPSA id o191sm24793150pfg.64.2019.11.05.13.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 13:53:09 -0800 (PST)
Cc:     tranmanphong@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net,
        madhuparnabhowmik04@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH] Doc: Improve format for
 whatisRCU.rst
To:     Amol Grover <frextrite@gmail.com>, paulmck@kernel.org
References: <20191102115517.6378-1-tranmanphong@gmail.com>
 <20191105165938.GA10903@workstation>
From:   Phong Tran <tranmanphong@gmail.com>
Message-ID: <2e218986-1dd1-42d8-94dc-cce098533af0@gmail.com>
Date:   Wed, 6 Nov 2019 04:53:05 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105165938.GA10903@workstation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/19 11:59 PM, Amol Grover wrote:
> On Sat, Nov 02, 2019 at 06:55:17PM +0700, Phong Tran wrote:
>> Adding crossreference target for some headers, answer of quizzes
>>
>> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
>> ---
>>   Documentation/RCU/whatisRCU.rst | 73 +++++++++++++++++++++++----------
>>   1 file changed, 52 insertions(+), 21 deletions(-)
>>
>> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
>> index 70d0e4c21917..ae40c8bcc56c 100644
>> --- a/Documentation/RCU/whatisRCU.rst
>> +++ b/Documentation/RCU/whatisRCU.rst
>> @@ -1,4 +1,4 @@
>> -.. _rcu_doc:
>> +.. _whatisrcu_doc:
>>   
>>   What is RCU?  --  "Read, Copy, Update"
>>   ======================================
>> @@ -27,14 +27,21 @@ the experience has been that different people must take different paths
>>   to arrive at an understanding of RCU.  This document provides several
>>   different paths, as follows:
>>   
>> -1.	RCU OVERVIEW
>> -2.	WHAT IS RCU'S CORE API?
>> -3.	WHAT ARE SOME EXAMPLE USES OF CORE RCU API?
>> -4.	WHAT IF MY UPDATING THREAD CANNOT BLOCK?
>> -5.	WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU?
>> -6.	ANALOGY WITH READER-WRITER LOCKING
>> -7.	FULL LIST OF RCU APIs
>> -8.	ANSWERS TO QUICK QUIZZES
>> +:ref:`1.	RCU OVERVIEW <1_whatisRCU>`
>> +
>> +:ref:`2.	WHAT IS RCU'S CORE API? <2_whatisRCU>`
>> +
>> +:ref:`3.	WHAT ARE SOME EXAMPLE USES OF CORE RCU API? <3_whatisRCU>`
>> +
>> +:ref:`4.	WHAT IF MY UPDATING THREAD CANNOT BLOCK? <4_whatisRCU>`
>> +
>> +:ref:`5.	WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU? <5_whatisRCU>`
>> +
>> +:ref:`6.	ANALOGY WITH READER-WRITER LOCKING <6_whatisRCU>`
>> +
>> +:ref:`7.	FULL LIST OF RCU APIs <7_whatisRCU>`
>> +
>> +:ref:`8.	ANSWERS TO QUICK QUIZZES <8_whatisRCU>`
>>   
>>   People who prefer starting with a conceptual overview should focus on
>>   Section 1, though most readers will profit by reading this section at
>> @@ -52,6 +59,7 @@ everything, feel free to read the whole thing -- but if you are really
>>   that type of person, you have perused the source code and will therefore
>>   never need this document anyway.  ;-)
>>   
>> +.. _1_whatisRCU:
>>   
>>   1.  RCU OVERVIEW
>>   ----------------
>> @@ -120,6 +128,7 @@ So how the heck can a reclaimer tell when a reader is done, given
>>   that readers are not doing any sort of synchronization operations???
>>   Read on to learn about how RCU's API makes this easy.
>>   
>> +.. _2_whatisRCU:
>>   
>>   2.  WHAT IS RCU'S CORE API?
>>   ---------------------------
>> @@ -381,13 +390,15 @@ c.	RCU applied to scheduler and interrupt/NMI-handler tasks.
>>   Again, most uses will be of (a).  The (b) and (c) cases are important
>>   for specialized uses, but are relatively uncommon.
> 
> Hey,
> 
> The changes looks good overall, however a few areas would
> look even better after a bit of formatting.
> 
> The API methods text under this section could be converted
> to sub-headings (^^^) for improved readability.
> 
> rcu_dereference() sub-section under `Section 2` has 2
> footnotes which could be linked using
> http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#footnotes
> 

Okay, sent out the patch with the suggestions.

https://lkml.org/lkml/2019/11/5/996

Regards,
Phong.
