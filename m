Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE7C5B54D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08352075E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561672899;
	bh=xuNaRVxvFrwYpNNaax5D6Dx243448WQqfhCw7Koc188=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=dZ+S6p2HIjo43DkuY76izq/tLdM58pGNj8j9d/eqn8DPeCnHlugJv1QmKAyph7dhL
	 etGx3Hg89a7NRtGMaD6se+G3NgEduKBjEEjMtKWPlQgV/JzgmRrFSoSo9eff9PPTvA
	 3+PZ61kbrX6sBCRoicq1qVOgU4wckh+3FvfEN/1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfF0WBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:01:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37177 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfF0WBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:01:38 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so8188641iok.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 15:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wdf1nBH0PL7WyynZAhKLoekJmYEyf1wAOf9OL+xS3ps=;
        b=EZHy57R286JnmS4RonvV6TgNEpBo7e4UR6VUQq5Li7wTrWYpHwlkn/4WQUkF2lQ6Id
         Rv3dpR5L2/bLYYSOZX6qLqoRJ06fSz1sXieusMNnGTlqu43X9nUNHFZCEqWM7ABauNp4
         G56OIJb6sANOtjquvzu+W7fjjNna3Qti3oceA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wdf1nBH0PL7WyynZAhKLoekJmYEyf1wAOf9OL+xS3ps=;
        b=Y/JKeO+FUB9sdDPYb2Kj/jtbxNf7nJNz2kXSUenw/L+Il4Fz9omvxub+/QB/8gA1+W
         huyvKE+lO0+V02lDFNOTLB+cMbFljU9hhwncuZNCmJGHjRC4XgUmhrYwlAJKnTpPVxe4
         ozzEc7ar7fGyKlXuq3uydBOViXpLN0qj7jHTa5S6pJvAd/wZ+nupRUCiAQHSP+RNVaJ6
         nd8M3qzIfgohdntrVXkCRkFB2g7hchhYzB7gBwIFLcAJgiSPQ0Oz7oCaY3hSzs3V5i//
         YxTj/dBeBar+/+EyCW6Yng1IXiOTltxYHv9LvVYLURnHMOIDz9YT9G202xUFq6u72phE
         LLAQ==
X-Gm-Message-State: APjAAAVlIbV6aT/afu0hFEOCGXdyhwzCHLCcto4Y2RQ52y335KfOr7v+
        meqzY5v8E4MkeR7Jg/rY4VZzrQ==
X-Google-Smtp-Source: APXvYqwIakKTlYV+0olJ7RCZ68AsDHHJsD4oFuVMJEN85upKVc7g8czSyY8b7jU772BU5N/q4HZWgw==
X-Received: by 2002:a6b:7606:: with SMTP id g6mr7245403iom.288.1561672897612;
        Thu, 27 Jun 2019 15:01:37 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p25sm319707iol.48.2019.06.27.15.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 15:01:36 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees][PATCH] doc: RCU callback locks need only
 _bh, not necessarily _irq
To:     Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20190627210147.19510-1-c0d1n61at3@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bc2ce605-56ab-33aa-c94d-d7774e6ce8cd@linuxfoundation.org>
Date:   Thu, 27 Jun 2019 16:01:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627210147.19510-1-c0d1n61at3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/19 3:01 PM, Jiunn Chang wrote:
> The UP.rst file calls for locks acquired within RCU callback functions
> to use _irq variants (spin_lock_irqsave() or similar), which does work,
> but can be overkill.  This commit therefore instead calls for _bh variants
> (spin_lock_bh() or similar), while noting that _irq does work.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

Should this by Suggested-by?

> Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> ---
>   Documentation/RCU/UP.rst | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/RCU/UP.rst b/Documentation/RCU/UP.rst
> index 67715a47ae89..e26dda27430c 100644
> --- a/Documentation/RCU/UP.rst
> +++ b/Documentation/RCU/UP.rst
> @@ -113,12 +113,13 @@ Answer to Quick Quiz #1:
>   Answer to Quick Quiz #2:
>   	What locking restriction must RCU callbacks respect?
>   
> -	Any lock that is acquired within an RCU callback must be
> -	acquired elsewhere using an _irq variant of the spinlock
> -	primitive.  For example, if "mylock" is acquired by an
> -	RCU callback, then a process-context acquisition of this
> -	lock must use something like spin_lock_irqsave() to
> -	acquire the lock.
> +	Any lock that is acquired within an RCU callback must be acquired
> +	elsewhere using an _bh variant of the spinlock primitive.
> +	For example, if "mylock" is acquired by an RCU callback, then
> +	a process-context acquisition of this lock must use something
> +	like spin_lock_bh() to acquire the lock.  Please note that
> +	it is also OK to use _irq variants of spinlocks, for example,
> +	spin_lock_irqsave().
>   
>   	If the process-context code were to simply use spin_lock(),
>   	then, since RCU callbacks can be invoked from softirq context,
> 

thanks,
-- Shuah
