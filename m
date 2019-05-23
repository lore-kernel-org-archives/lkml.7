Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A4FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAA02175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owHVPK/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfEWJaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:30:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41859 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730283AbfEWJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:30:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id u16so1564250wrn.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 02:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qQG/Dz+q3JTMTmvRPhKGrhtgC1e/05CWbdwWmbSbs0U=;
        b=owHVPK/SPHvRkGKDqN3ABV7GCe7eUovnMPq4gnajGKoTxPDnmsFy1LVzD8WAHKYYJb
         xWtGG9H4ZaC+xpYDyDOTNqhGNyyUt1KaaIwjhTKkM8kiqSW+5IZhYw58TwkvQJqurEO2
         bjEhU1ozg6hBHexysrUznVzhEA4LUcwxnIIu6KlGhrBlDl6FDis2Axz8147S1/OQo6Jg
         /mxkkJWPAxiiLsiCHyiInQ3CssPCcV2/lLMHb2zA/zyv1eBCCynAClfMhWP7uH/5LAao
         W3Kr2F0b0PqBnbD9DQqjRp6jAnRmCdDiw5Ayk14QB6BmgEWARBa891iBqxudeWxMzCGe
         BiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qQG/Dz+q3JTMTmvRPhKGrhtgC1e/05CWbdwWmbSbs0U=;
        b=UqBDI7RQqRf4V4t/veYDwHcwYDVlh1Wmy1gurM/YeO7c6nT/EnfnaNs0i5fcnh93OT
         LKvfP0Ar3IjQpwO0alUw2MwFVCtZw0+VLFMtXliEzJY9YG0rzYr+4mc3PnZH3GXKIcNq
         Ibc+YliJ9U56Rn/oyoDnemf6+lRne9J20yBI4hVQyScuC0BJTtP2scPyLqgmKvpQDKBm
         Gkc0vMsPTjmW1I2wBJd6ZwvHsGudk0MhsYWAv1WFxhYiRF9G0mq43QEpcBbS45oFZqKe
         7/f9Y+pRnnc5ODxJ87kldbe9JYiHeDbcuizf/ixmkJYXqogWOTpgYoYGst5GYtlY+37L
         Aa3w==
X-Gm-Message-State: APjAAAX3EphEp77P6WcuHgGnOtKgd6CamEajTJgPvwS+vcWEIAT0ep1B
        78UWS6HXcVOKI8kmxW9sSSYEBn2wU37/6A==
X-Google-Smtp-Source: APXvYqybkROd+8FV7xvzYRHzx5I6P8yHjU/b56D5mpl52Evdz6IbV5IvY5L/X78qMtD8vo3ZK0UNVw==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr2427438wrm.291.1558603821998;
        Thu, 23 May 2019 02:30:21 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id o8sm48848496wra.4.2019.05.23.02.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 02:30:21 -0700 (PDT)
Subject: Re: [PATCH] soundwire: stream: fix bad unlock balance
To:     Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190522162528.5892-1-srinivas.kandagatla@linaro.org>
 <4744834c-36b1-dd8d-45fa-76c75eb3d5cb@linux.intel.com>
 <2dc66f9d-e508-d457-a7d6-c06c4336e7b8@linaro.org>
 <20190523092034.GA23777@buildpc-HP-Z230>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b85e54e8-5ba8-38ff-3538-f54526c67b31@linaro.org>
Date:   Thu, 23 May 2019 10:30:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523092034.GA23777@buildpc-HP-Z230>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/05/2019 10:20, Sanyog Kale wrote:
> On Thu, May 23, 2019 at 09:43:14AM +0100, Srinivas Kandagatla wrote:
>>
>>
>> On 22/05/2019 17:41, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 5/22/19 11:25 AM, Srinivas Kandagatla wrote:
>>>> This patch fixes below warning due to unlocking without locking.
>>>>
>>>> ?? =====================================
>>>> ?? WARNING: bad unlock balance detected!
>>>> ?? 5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G?????????????? W
>>>> ?? -------------------------------------
>>>> ?? aplay/2954 is trying to release lock (&bus->msg_lock) at:
>>>> ?? do_bank_switch+0x21c/0x480
>>>> ?? but there are no more locks to release!
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>> ?? drivers/soundwire/stream.c | 3 ++-
>>>> ?? 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>>>> index 544925ff0b40..d16268f30e4f 100644
>>>> --- a/drivers/soundwire/stream.c
>>>> +++ b/drivers/soundwire/stream.c
>>>> @@ -814,7 +814,8 @@ static int do_bank_switch(struct
>>>> sdw_stream_runtime *stream)
>>>> ?????????????????????????? goto error;
>>>> ?????????????????? }
>>>> -?????????????? mutex_unlock(&bus->msg_lock);
>>>> +?????????????? if (mutex_is_locked(&bus->msg_lock))
>>>> +?????????????????????? utex_unlock(&bus->msg_lock);
>>>
>>> Does this even compile? should be mutex_unlock, no?
>>>
>>> We also may want to identify the issue in more details without pushing
>>> it under the rug. The locking mechanism is far from simple and it's
>>> likely there are a number of problems with it.
>>>
>> msg_lock is taken conditionally during multi link bank switch cases, however
>> the unlock is done unconditionally leading to this warning.
>>
>> Having a closer look show that there could be a dead lock in this path while
>> executing sdw_transfer(). And infact there is no need to take msg_lock in
>> multi link switch cases as sdw_transfer should take care of this.
>>
>> Vinod/Sanyog any reason why msg_lock is really required in this path?
>>
> 
> In case of multi link we use sdw_transfer_defer instead of sdw_transfer
> where lock is not acquired, hence lock is acquired in do_bank_switch for
> multi link. we should add same check of multi link to release lock in
> do_bank_switch.

probably we should just add the lock around the sdw_transfer_defer call 
in sdw_bank_switch()?
This should cleanup the code a bit too.

something like:

------------------------------------>cut<-----------------------------
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index d01060dbee96..f455af5b8151 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -676,10 +676,13 @@ static int sdw_bank_switch(struct sdw_bus *bus, 
int m_rt_count)
          */
         multi_link = bus->multi_link && (m_rt_count > 1);

-       if (multi_link)
+       if (multi_link) {
+               mutex_lock(&bus->msg_lock);
                 ret = sdw_transfer_defer(bus, wr_msg, &bus->defer_msg);
-       else
+               mutex_unlock(&bus->msg_lock);
+       } else {
                 ret = sdw_transfer(bus, wr_msg);
+       }

         if (ret < 0) {
                 dev_err(bus->dev, "Slave frame_ctrl reg write failed\n");
@@ -742,25 +745,19 @@ static int do_bank_switch(struct 
sdw_stream_runtime *stream)
         struct sdw_master_runtime *m_rt = NULL;
         const struct sdw_master_ops *ops;
         struct sdw_bus *bus = NULL;
-       bool multi_link = false;
         int ret = 0;

         list_for_each_entry(m_rt, &stream->master_list, stream_node) {
                 bus = m_rt->bus;
                 ops = bus->ops;

-               if (bus->multi_link) {
-                       multi_link = true;
-                       mutex_lock(&bus->msg_lock);
-               }
-
                 /* Pre-bank switch */
                 if (ops->pre_bank_switch) {
                         ret = ops->pre_bank_switch(bus);
                         if (ret < 0) {
                                 dev_err(bus->dev,
                                         "Pre bank switch op failed: 
%d\n", ret);
-                               goto msg_unlock;
+                               return ret;
                         }
                 }

@@ -814,7 +811,6 @@ static int do_bank_switch(struct sdw_stream_runtime 
*stream)
                         goto error;
                 }

-               mutex_unlock(&bus->msg_lock);
         }

         return ret;
@@ -827,16 +823,6 @@ static int do_bank_switch(struct sdw_stream_runtime 
*stream)
                 kfree(bus->defer_msg.msg);
         }

-msg_unlock:
-
-       if (multi_link) {
-               list_for_each_entry(m_rt, &stream->master_list, 
stream_node) {
-                       bus = m_rt->bus;
-                       if (mutex_is_locked(&bus->msg_lock))
-                               mutex_unlock(&bus->msg_lock);
-               }
-       }
-
         return ret;
  }

------------------------------------>cut<-----------------------------
> 
>> --srini
>>
>>>> ?????????? }
>>>> ?????????? return ret;
>>>>
> 
