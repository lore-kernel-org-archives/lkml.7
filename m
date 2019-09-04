Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EA2C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825902087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoWlN9yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbfIDTAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 15:00:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38901 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730410AbfIDTAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:00:39 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so46678213iog.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YS/oRA+KV/UBzoz/WnnIu9hGtCWMQgkzh1fKr4+obk0=;
        b=WoWlN9yxWDFjkBERDEvSZtnHj2s/6B92wbrXvUeunbJWmcdnO2QqghZnXrW2DQrZ8D
         7Be9aVcLZ0OVYxDnq7dBhIilw+oR4PZCWFiXsKbwzXhj+G40DVmH3FQnMzJlYzzJHOc2
         ypFG3yTMilx5701aG1DxMYXRLMtBm2B3JybVTcpdxkXTnzgRA+T8KbEz5PqCi5zLA3aH
         vf8ta/AqS9n82mA0LdCNxoC82m8LNekvY/1RW01VUxir3YvJJH8ePd5NfKQCELrqdj3t
         g3aycJU6W3VqBGFVrRSXjaaJtsNNRCN8kNYKuYqmS2wbWMwXaf+cQ98ySSnFYaXxCdYg
         wJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YS/oRA+KV/UBzoz/WnnIu9hGtCWMQgkzh1fKr4+obk0=;
        b=FMMKakyl6X8PjpmfkeGDwDVktxy5ejpcTf8/8hNyDkFPS+BTCHcUNGxiK31ozGFhLL
         Kt3EFMCxcYSEXf+kMk4jRMS3WQYwlInQJczp8z849HfdV6ULXBfWwccjLXhz6RHeQlee
         6/uJYymYXWQStwalsQo8P4cL4RLLG2UmrY9eCkN79oZ8JUG/h3GFGKggU9xKoKH+VkQI
         OLJcnm4lBFYpzX5JAdIrIocJb9IhJs4uXfM0kMAPgnJfIblHDJltKo00zuhxwVLKTnBL
         3m0M9O8hHjgm27Hj+FsCm/FM1m0+3LyN1o+w7pU9Ybfegvrx39uYYDb95DmgVVSMjuVd
         l2Zw==
X-Gm-Message-State: APjAAAWdDghkduBOi7oeL7YQ/hnEA0oCHN8PjtQtizDeOjaqEmxk2Mql
        3muyyZ9S9PfHfwqctMSE7g==
X-Google-Smtp-Source: APXvYqwl47gvKXOASt4UpIqyuvgLMoKmPU1FeoteayOagm8oZNzs66COHn0Cui2b9+jrt1WRbJrYmw==
X-Received: by 2002:a5d:8196:: with SMTP id u22mr9364546ion.280.1567623636995;
        Wed, 04 Sep 2019 12:00:36 -0700 (PDT)
Received: from [192.168.1.99] ([92.117.176.185])
        by smtp.googlemail.com with ESMTPSA id 80sm32670032iou.13.2019.09.04.12.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 12:00:36 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] ftrace: Implement fs notification for
 tracing_max_latency
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
 <20190903132602.3440-2-viktor.rosendahl@gmail.com>
 <20190904073915.4a145a91@oasis.local.home>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Message-ID: <d8377cbd-8c3c-d699-153d-8af7b44d6b87@gmail.com>
Date:   Wed, 4 Sep 2019 21:00:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904073915.4a145a91@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 1:39 PM, Steven Rostedt wrote:
> On Tue,  3 Sep 2019 15:25:59 +0200
> Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:
> 
>> +void latency_fsnotify_stop(void)
>> +{
>> +	/* Make sure all CPUs see caller's previous actions to stop tracer */
>> +	smp_wmb();
> 
> These memory barriers just look wrong. What exactly are you trying to protect here?
> 
> Where's the matching rmbs?
> 

Thanks for reviewing.

However, since these functions will disappear when I take the irq_work
facility into use, we should perhaps not spend too much time discussing
what would have been.

There are no matching rmbs, I was thinking that the smp_wmb() would
merely enforce the order of the memory writes, as seen by other CPUs, so 
that the tracer would be stopped, before the latency fsnotify is disabled.

E.g. in case of the preemptirqsoff tracer the idea was that it doesn't
matter exactly when a CPU sees the "tracer_enabled = 0;" in
stop_irqsoff_tracer() but that it needs to be seen before the writes in
latency_fsnotify_stop() are seen.

best regards,

Viktor
