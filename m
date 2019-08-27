Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796EDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D03721881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfH0Rcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:32:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38748 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbfH0Rcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:32:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so32399255edo.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 10:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pFiMHAzqxLC1id6tXwjbkyZFOQ1lOnoUzRqly8BR0gs=;
        b=re2eUokzGAqglXQ+yn5TJ7vm1JEEx+50dTs1GFNHn5VCG8z2dsCHBXU/4kkKPZZXb3
         0YqmLVBd34aVTEWNbvjr5HMOhlek90AnQGUxP1ZusF9kwIAVC3y6rhtbbUdsrwJ53mjB
         9kO96hWWNOd3R0LDnyj2osnkZ5f2G9U1rMPp92MkRdQqxGLV8mARFYHg0xZPFC/rHRj0
         mmmMh7SR0zFQNaDEBGp3jInP/UvFGx8aE5filL3uNlgEQVfkDH7x7nXJbOMwmralP8F+
         DoRhT8ZE4fangTYqr+GrvOUlqxmzqMnNnh4132a/CKcHsBRbvT4PjJMKYojWY6b3Z4S2
         nYbg==
X-Gm-Message-State: APjAAAXfnJrEBIyi4tuj/eCmMOGH+CWOpmBMVNnrY1KxToLT7Jh6x87Y
        uIhnpyOn8Q7C0LF7GL52ow4=
X-Google-Smtp-Source: APXvYqwwOj3nyuIPcIKGvaK9Hw1s6w1fz0q6SqkUQj+1/IzRX3orqcq+QGyXOnBP9xQUM8L9WazVXQ==
X-Received: by 2002:a17:906:6792:: with SMTP id q18mr22571133ejp.80.1566927164812;
        Tue, 27 Aug 2019 10:32:44 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id j57sm2108923eda.61.2019.08.27.10.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 10:32:44 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH] checkpatch: check for nested (un)?likely calls
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190827165515.21668-1-efremov@linux.com>
 <94f293d3d31e9f686e601e2e3c972ae371a40585.camel@perches.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <c93541d7-9e0f-75e6-56c4-597ba440fb88@linux.com>
Date:   Tue, 27 Aug 2019 20:32:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <94f293d3d31e9f686e601e2e3c972ae371a40585.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 8:21 PM, Joe Perches wrote:
> On Tue, 2019-08-27 at 19:55 +0300, Denis Efremov wrote:
>> IS_ERR, IS_ERR_OR_NULL, IS_ERR_VALUE already contain unlikely optimization
>> internally. Thus, there is no point in calling these functions under
>> likely/unlikely.
>>
>> This check is based on the coccinelle rule developed by Enrico Weigelt
>> https://lore.kernel.org/lkml/1559767582-11081-1-git-send-email-info@metux.net/
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -6480,6 +6480,13 @@ sub process {
>>  			     "Using $1 should generally have parentheses around the comparison\n" . $herecurr);
>>  		}
>>  
>> +# nested likely/unlikely calls
>> +		if ($perl_version_ok &&
>> +		    $line =~ /\b(?:(?:un)?likely)\s*\(!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?)\s*${balanced_parens}\s*\)/) {
>> +			WARN("LIKELY_MISUSE",
>> +			     "nested (un)?likely calls, unlikely already used in $1 internally\n" . $herecurr);
>> +		}
>> +
> 
> Couple things:
> 
> 1:
> 
> Are you going to submit patches for the just 10 instances that exist?
> 
> $ git grep -P -n '\b(?:(?:un)?likely)\s*\(!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?)\s*\([^\)]+\)\s*\)'
> arch/x86/kernel/irq.c:246:      if (likely(!IS_ERR_OR_NULL(desc))) {
> drivers/infiniband/hw/hfi1/verbs.c:1044:        if (unlikely(IS_ERR_OR_NULL(pbuf))) {
> drivers/input/mouse/alps.c:1479:        } else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
> fs/ntfs/mft.c:74:       if (likely(!IS_ERR(page))) {
> fs/ntfs/mft.c:157:      if (likely(!IS_ERR(m)))
> fs/ntfs/mft.c:274:              if (likely(!IS_ERR(m))) {
> fs/ntfs/mft.c:1779:             if (likely(!IS_ERR(rl2)))
> fs/ntfs/namei.c:118:            if (likely(!IS_ERR(dent_inode))) {
> fs/ntfs/runlist.c:954:  if (likely(!IS_ERR(old_rl)))
> include/net/udp.h:483:  if (unlikely(IS_ERR_OR_NULL(segs))) {

Yes, I will do it in days.

> 
> 2:
> 
> This will not warn about code like:
> 
> fs/ntfs/mft.c:  if (unlikely(IS_ERR(rl) || !rl->length || rl->lcn < 0)) {
> 
> that could probably be better written as:
> 
> 		if (IS_ERR(rl) || unlikely(!rl->length || rl->lcn < 0)) {
> 
> 

Ok, I will change the regex in v2 to:
$line =~ /\b(?:(?:un)?likely)\s*\(!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?)/

Should I skip $perl_version_ok check then?

If there are no other suggestions about, for example, warn message or commit
description I will send v2.

Thanks,
Denis
