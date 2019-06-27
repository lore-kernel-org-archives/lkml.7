Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9C0C5B576
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23A4214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561673515;
	bh=aHxcNfVljSqhRSlSegAcEzeXkVCC440RZzzHWoNXqYc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=o4aMFl0GN9leW+zJ1sEhR6PE0U0JxJNAIQFo+hR8KzgrQze5RUhYTCqeW0AGZbAr6
	 KiNJEtXSDQ6bONuC7WJ/8V/0XmNMnqukbJ8hMZu+jHN1CawnIjInHjYQZiqhzSAkqt
	 nahTGVhXL9wsLm4LQWJC9rPUO9cKArGZYVx++CqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfF0WLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:11:54 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39680 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfF0WLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:11:54 -0400
Received: by mail-oi1-f193.google.com with SMTP id m202so2771956oig.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 15:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OZ6b83d+h7uhjaIJlMKgIz6a0WqRwOVzCwxFhVUs1N0=;
        b=iTH5fCD9fSTOY/FWC1ufpkj3M1LoGuojGSBbWyHQc0hhr0HqQa0DC6SmlNZQ0bdWCX
         d3mxXSQjKp3FSt9Vv9r5McKSyFKCWrEB4NKNvqcnhtdOYP13hPaTYnzOX14zezlZVEkW
         JRnGvcDfWh7faEiwZSPN1ArG9qllGtJC5+klU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OZ6b83d+h7uhjaIJlMKgIz6a0WqRwOVzCwxFhVUs1N0=;
        b=hM6fz5kuplmYjaxSqvN+Ok07kQjgGAAM7BkJ+GgLxnrQ+1Iav4dpS1a+W+ZzYaCO7b
         b9wfoEc7ZH+RsEkOKisEL1b+UkXZriXUWkG0hs1R1cy6JJxlaTdl4qiSCMPsYUdiXG4r
         9xltbPhn8gFMiY0KnrqKPFxeEk7wV9mVLcrKwBldfm2kzc/cBkkDtPkrlH1pTpiGtBQq
         hzsMPKJYSGoU9X9KsCQgTEDsz//wdFHC1Yr93j5GM8OxmVq6p5D0f+Zq3w4bh6rVubG2
         mqDuIQngQiaIN8EhlKKdeSz1wfvo4/ZhPDHp/fuB9dS5BYxdHLn/nBVMLTIBgwMLdnkQ
         6Axg==
X-Gm-Message-State: APjAAAUdZlxBED/PIoTJQtzgx63EOvfHK86Dab/HurVOfXBIBvSR38Xn
        rVd2wCJ7+U0MQr/re8o/V3NeYg==
X-Google-Smtp-Source: APXvYqzRW1nmq0bYaFgUIDdjRmvSjBZRTXH+ea+k66uHzjXrx9oy7m36SPgAT1+TuzDAlLHInjEd2g==
X-Received: by 2002:aca:aa87:: with SMTP id t129mr3559087oie.12.1561673513598;
        Thu, 27 Jun 2019 15:11:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u17sm98666oif.11.2019.06.27.15.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 15:11:53 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees][PATCH] doc: RCU callback locks need only
 _bh, not necessarily _irq
To:     paulmck@linux.ibm.com
Cc:     Jiunn Chang <c0d1n61at3@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20190627210147.19510-1-c0d1n61at3@gmail.com>
 <bc2ce605-56ab-33aa-c94d-d7774e6ce8cd@linuxfoundation.org>
 <20190627221045.GH26519@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <feb2e1b3-f88e-3022-207f-2862f49a501d@linuxfoundation.org>
Date:   Thu, 27 Jun 2019 16:11:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627221045.GH26519@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/19 4:10 PM, Paul E. McKenney wrote:
> On Thu, Jun 27, 2019 at 04:01:35PM -0600, Shuah Khan wrote:
>> On 6/27/19 3:01 PM, Jiunn Chang wrote:
>>> The UP.rst file calls for locks acquired within RCU callback functions
>>> to use _irq variants (spin_lock_irqsave() or similar), which does work,
>>> but can be overkill.  This commit therefore instead calls for _bh variants
>>> (spin_lock_bh() or similar), while noting that _irq does work.
>>>
>>> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>>
>> Should this by Suggested-by?
> 
> I wrote it and Jiunn converted my change to .rst, so I believe that
> this is correct as is.
> 

Great.

thanks,
-- Shuah
