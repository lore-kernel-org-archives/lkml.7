Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A632C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 02:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E2E24656
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 02:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mvV048o5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbfLMC7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 21:59:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41646 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731465AbfLMC7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 21:59:16 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2DA5820B7187;
        Thu, 12 Dec 2019 18:59:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DA5820B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576205955;
        bh=qv+NmmnZ+/n9eF3FzeCcHEgZTGuVHBDcefUGSa3G2Ug=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mvV048o53KZrnKUqBWi40AGMeYEPwiiAx3txKH0je5V8BQHmIW8UQ03ad8Z3hPAAf
         bUr4X2ZCRYkT0HLu0Ljs7y9O14mIukU7XyaxUCh9MiWMy6feKWF3KGqHWHRevCUYUM
         IyS/6OHbMg6T3Tsm9ESbrhWes2lpClPsNMtTkyxY=
Subject: Re: [PATCH v3 1/2] IMA: Define workqueue for early boot "key"
 measurements
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191213004250.21132-1-nramas@linux.microsoft.com>
 <20191213004250.21132-2-nramas@linux.microsoft.com>
 <1576202134.4579.189.camel@linux.ibm.com>
 <6e0dad33-66f9-4807-d08d-ff30396cec5e@linux.microsoft.com>
 <1576204377.4579.206.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c60341a3-2329-cd92-c76c-6f8249a57b43@linux.microsoft.com>
Date:   Thu, 12 Dec 2019 18:59:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576204377.4579.206.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2019 6:32 PM, Mimi Zohar wrote:

>>>
>>> Don't you need a test here, before setting ima_process_keys?
>>>
>>> 	if (ima_process_keys)
>>> 		return;
>>>
>>> Mimi
>>
>> That check is done before the comment - at the start of
>> ima_process_queued_keys().
> 
> The first test prevents taking the mutex unnecessarily.
> 
> Mimi

I am trying to understand your concern here. Could you please clarify?

  => If ima_process_keys is false
       -> With the mutex held, should check ima_process_keys again 
before setting?

Let's say 2 or more threads are racing in calling ima_process_queued_keys():

The 1st one will set ima_process_keys and process queued keys.

The 2nd and subsequent ones - even if they have gone past the initial 
check, will find an empty list of keys (the list "ima_keys") when they 
take the mutex. So they'll not process any keys.

thanks,
  -lakshmi



