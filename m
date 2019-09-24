Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B089C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60BA21655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nBKxnDnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440701AbfIXKJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 06:09:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35261 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbfIXKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:09:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id a24so1060517pgj.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6aBTeAng15psj7LmOvIH7gwUXqR6k6y6/iJImtS8wA4=;
        b=nBKxnDnAfqWRyeTJ1aQPcrNh3m9oAltJTJq33mvRP8cXRUElf8b4lvIRULzYb/mgR8
         vU91du01glpQu9KAjq/ur0Qci2aHRVma1CLw5ruYynZdhTC7E8Qy/frpLjrHK3PIe2Sw
         sSSkgXw5HaaD+r5nI9z76S6N8UFPOA7NNxS0T1Tk/EBoBcQTj57JOopO32xPle7aGxIo
         GNzQK892wHXKRB6gjduXHfN96J7KvlRtPPnsIW3jU3nRloztTNqYhlqhra6L7OU8Ady3
         bR6RhnEl/9/O/meU5t3YsWYY4AZI0qid5sKumAJX45HmxV2Qg5PAVgzsm0PRlxtuobHE
         ASeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6aBTeAng15psj7LmOvIH7gwUXqR6k6y6/iJImtS8wA4=;
        b=QAp7sSFwdPOQzUUwltK6lOvaioioO7h8g7/YMMNNrvDlZXbJVQKPy+Gxj8FLoxQ1kh
         QJ2RM2xM/rtopE1EEX4h6mD8T5LxYxlFIMdomykz9J5fCu1AiKfilOU7kl8B4gGeqomY
         Nr7Na9a2C0FkiM+x8Dum/PoDsM7FrMyHXuF8j6stmMEOXI6MqgI6JFWgS3/kqhV2J0ha
         eq87WOdnDDXwWTMk6WHaSbX14BQjINSDzo5e4P79ebHOntBYAgvpaQk1CbMDHbUnxvHE
         xfx+eZ6iQuQxLm+asRhURgPhSmvG+wXI6rwRtnOcrhYdrG4Y2dTUKbxzeT3akfuE4kOu
         WQTg==
X-Gm-Message-State: APjAAAUSAoAbU7R9ig0LEGhjTHXqDClI2081a9lCEWu5ZIWlCozXuKh0
        7obMoUJo0I1SJmTGCYGhpAUzrQNOSTMRuMkI
X-Google-Smtp-Source: APXvYqyNa3ZegWwa3/Q8pg0c9BKjW1n2gRV2iIScEPEf18JpC2+UU5Bye1/7kFcjxpSIyQxwyaHtEQ==
X-Received: by 2002:a17:90a:ba93:: with SMTP id t19mr1968110pjr.141.1569319778255;
        Tue, 24 Sep 2019 03:09:38 -0700 (PDT)
Received: from ?IPv6:2600:380:8419:743e:6023:99b1:fa9f:a39c? ([2600:380:8419:743e:6023:99b1:fa9f:a39c])
        by smtp.gmail.com with ESMTPSA id k5sm1363200pgo.45.2019.09.24.03.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 03:09:37 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <38ea2681-dbf0-457a-dcc0-406d10e2572b@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <65a1f01e-e8f5-0da8-eb3c-48c5749c9568@kernel.dk>
Date:   Tue, 24 Sep 2019 12:09:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <38ea2681-dbf0-457a-dcc0-406d10e2572b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/19 3:21 AM, Pavel Begunkov wrote:
> On 24/09/2019 11:02, Jens Axboe wrote:
>> On 9/24/19 1:06 AM, Pavel Begunkov wrote:
>>> On 24/09/2019 02:00, Jens Axboe wrote:
>>>>> I think we can do the same thing, just wrapping the waitqueue in a
>>>>> structure with a count in it, on the stack. Got some flight time
>>>>> coming up later today, let me try and cook up a patch.
>>>>
>>>> Totally untested, and sent out 5 min before departure... But something
>>>> like this.
>>> Hmm, reminds me my first version. Basically that's the same thing but
>>> with macroses inlined. I wanted to make it reusable and self-contained,
>>> though.
>>>
>>> If you don't think it could be useful in other places, sure, we could do
>>> something like that. Is that so?
>>
>> I totally agree it could be useful in other places. Maybe formalized and
>> used with wake_up_nr() instead of adding a new primitive? Haven't looked
>> into that, I may be talking nonsense.
> 
> @nr there is about number of tasks to wake up. AFAIK doesn't solve the
> problem.

Ah right, embarassingly I'm actually the one that added that
functionality ages ago...

-- 
Jens Axboe

