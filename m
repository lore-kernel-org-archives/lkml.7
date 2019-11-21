Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FC0C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AF420708
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plexistor-com.20150623.gappssmtp.com header.i=@plexistor-com.20150623.gappssmtp.com header.b="NJJ7sFm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKUPCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:02:48 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:45012 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:02:47 -0500
Received: by mail-ed1-f44.google.com with SMTP id a67so3019806edf.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 07:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E392Bey6gyqrThPXx8YcFlOe0YHcNWFPSVbftT0swoA=;
        b=NJJ7sFm/XhnCvz3aQIsC8DV3UH1stbe9RQHbzgpl5sHNyXkOsGrQVGp+Qs6j8qo5zj
         fg9/oaME/zYfyRDk17NyDNMWP9yJe2lqstRCyUdcUkpysCuHhCYYbVzooMPmvFArvyUO
         G4yExiKQS8gB+rnJw26mfMfAUFVidpcp/Rczl8pzrWaSkJmVU+BM7Di4dbXb5MjW5hzY
         1uMQRlDaEFKAjrijZfq4e6YthfzIdWro930ACoCpJb/lPL4kt2/UfOO1HCujzb2nOg4y
         POCRUYTWxs5amOzBkMhhN1eSh45LoPHrmo/hM7ojgkivTGLuPUCBIGA8PACefyRTsYTF
         P54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E392Bey6gyqrThPXx8YcFlOe0YHcNWFPSVbftT0swoA=;
        b=hqJV56gMwwcRN39Tf5mYBUIUPDS8GSUT/0DnLvMcNoGhdBOWxM3sJn7jJDxieYvkod
         S0DQGFJ3wrKYjoas6tuX36G7FmXJF2CdRCL944MAt/kXDfuVFz7OrukkSNvwEIat4b3g
         5WeLcJXsb0U/q+8Toq/sHrNatHljK6vqUkT0eQsKOEisvdYdwuVjS7aVX+kxEPO7q+BY
         I70z/scZoyO7i2KldeIk6gsV83Mq8UTknyi2alVSf8RjN5NHdii7Vr4A2ZMEILd8+txV
         AJiXWWoXmWeFmMrmz+53vusBBdWg6F2/wJZOKx/JOn7orEspxkUQucQr3EaW7ukU1zt5
         U+5w==
X-Gm-Message-State: APjAAAUv+nEvuLTlnkhFIvwYhuEHDDJSoM9cXsXqqT6ngzx0rftjWTec
        yesEE9rMDbsHLG09CYaY07oB8g==
X-Google-Smtp-Source: APXvYqxyVsfWB8PAdeR3T5PNAaNZIDSuV0GxjDC7qwGEKfB7nsdRVF4BkBx3a/r6kSrG+4kav45Mtg==
X-Received: by 2002:a17:906:1da1:: with SMTP id u1mr14708052ejh.275.1574348566101;
        Thu, 21 Nov 2019 07:02:46 -0800 (PST)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id br8sm20496ejb.80.2019.11.21.07.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:02:45 -0800 (PST)
Subject: Re: single aio thread is migrated crazily by scheduler
To:     Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb> <20191121041218.GK24548@ming.t460p>
 <20191121141207.GA18443@pauld.bos.csb>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <93de0f75-3664-c71e-9947-5b37ae935ddc@plexistor.com>
Date:   Thu, 21 Nov 2019 17:02:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121141207.GA18443@pauld.bos.csb>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2019 16:12, Phil Auld wrote:
<>
> 
> The scheduler doesn't know if the queued_work submitter is going to go to sleep.
> That's why I was singling out AIO. My understanding of it is that you submit the IO
> and then keep going. So in that case it might be better to pick a node-local nearby
> cpu instead. But this is a user of work queue issue not a scheduler issue. 
> 

We have a very similar long standing problem in our system (zufs), that we had to do
hacks to fix.

We have seen these CPU bouncing exacly as above in fio and more benchmarks, Our final
analysis was: 
 One thread is in wait_event() if the wake_up() is on the same CPU as the
waiter, on some systems usually real HW and not VMs, would bounce to a different CPU.
Now our system has an array of worker-threads bound to each CPU. an incoming thread chooses
a corresponding cpu worker-thread, let it run, waiting for a reply, then when the
worker-thread is done it will do a wake_up(). Usually its fine and the wait_event() stays
on the same CPU. But on some systems it will wakeup in a different CPU.

Now this is a great pity because in our case and the work_queue case and high % of places 
the thread calling wake_up() will then immediately go to sleep on something.
(Work done lets wait for new work)

I wish there was a flag to wake_up() or to the event object that says to relinquish
the remaning of the time-slice to the waiter on same CPU, since I will be soon sleeping.

Then scheduler need not guess if the wake_up() caller is going to soon sleep or if its
going to continue. Let the coder give an hint about that?

(The hack was to set the waiter CPU mask to the incoming CPU and restore afer wakeup)

> Interestingly in our fio case the 4k one does not sleep and we get the active balance
> case where it moves the actually running thread.  The 512 byte case seems to be 
> sleeping since the migrations are all at wakeup time I believe. 
> 

Yes this is the same thing we saw in our system. (And it happens only sometimes)

> Cheers,
> Phil
> 
> 
>> Thanks,
>> Ming
> 

Very thanks
Boaz
