Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E89C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9956206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDwhVNeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgAIN56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:57:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32776 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbgAIN55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:57:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so7391180lji.0;
        Thu, 09 Jan 2020 05:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vUi7NLIocyRS0PK7xQpa9ihsunHfDM+yNh2KLJqObqI=;
        b=nDwhVNeP3UOSw+2v0nu7GGg4CgMANqRgm6uiVpxHe4YFpSL/D3u/953I1H3RPvqWFo
         50x3r+OnyLiqAjJ5UVqdgMckc5qZiEOKt2EXCYUgLbNWIuJ3TEtyxizHaW07msb0GNkv
         kU4JRew7hMG4sC1YcM+dfAgSpoRKe0FnA8/4uiDS5mJ0bSspJ6GLbl4/HRMmCkn7NCg0
         pvZQxvJkLgSVqM+R3gTh7NX41xxe8Gj1kSdwgw+3b9LzOe4XHfOTDKckv8/jJAmZebh8
         fHNLMsQp+cW/OBbwyn+5AHfkzSTng//2yA9MawCrhAQ8jtLUswy3O9mJE6jZspGfJX//
         TEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vUi7NLIocyRS0PK7xQpa9ihsunHfDM+yNh2KLJqObqI=;
        b=bsdME4YxQj6uP6XH+21wxnP7BjoKzGp5jc44oHPU3s4EXslw6SpmEbE37QxV2BLEQS
         Vw3P0LNBVT7jTCKPifBW5vlEtmeHc/NrcXQl7pqMLWh9oNPuAhbLi5X6Hki5iMUiEuY8
         jdlNOhbX16pU1WWva314KTrP8ibN8WGrYzHfLKY1iGxe1F+I30ZOZv4qzN9CSajupuUe
         03eCoerboWHL+pMdFNxek607W5BHza3In9O+BfRrQDd6vtllSGC+rAo2AFTGhOILj9uL
         xygW59livIjUIDCVeZtlLwH52x7gqQ1uOffLKeAIp+mqFTpBJjmlQVRDutsbTDgClYXH
         6CfQ==
X-Gm-Message-State: APjAAAVVuUeIl2EpH205FvqHK0P31xhTHQiFLZlE5i39oFwaSVbgubhz
        gYIDUhru7PgJ40sPj7VLRevk5Irp
X-Google-Smtp-Source: APXvYqzlVZbz1si16O7Y7h85FVXIU0zIUSUw5yUm6olaMrPcn3zAWbIAR4fBxs8iyr0jOMUPL7LPxg==
X-Received: by 2002:a2e:8916:: with SMTP id d22mr6713631lji.19.1578578275109;
        Thu, 09 Jan 2020 05:57:55 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id m189sm3148058lfd.92.2020.01.09.05.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 05:57:54 -0800 (PST)
Subject: Re: [PATCH v3] regmap: add iopoll-like atomic polling macro
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1578546590-24737-1-git-send-email-spujar@nvidia.com>
 <fa5198bf-0001-3a57-017f-1b40e0188606@gmail.com>
 <b9f5459f-007e-3139-a3cf-c7dfd3fc335a@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e1ab2304-2ef8-c50d-d9c7-21569b397c23@gmail.com>
Date:   Thu, 9 Jan 2020 16:57:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <b9f5459f-007e-3139-a3cf-c7dfd3fc335a@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.01.2020 10:24, Sameer Pujar пишет:
> 
> On 1/9/2020 11:30 AM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 09.01.2020 08:09, Sameer Pujar пишет:
>>> This patch adds a macro 'regmap_read_poll_timeout_atomic' that works
>>> similar to 'readx_poll_timeout_atomic' defined in linux/iopoll.h; This
>>> is atomic version of already available 'regmap_read_poll_timeout' macro.
>>>
>>> It should be noted that above atomic macro cannot be used by all
>>> regmaps.
>>> If the regmap is set up for atomic use (flat or no cache and MMIO) then
>>> only it can use.
>>>
>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>> ---
>> Could you please explain what is the targeted use-case here?
> 
> I was trying to use regmap_read_poll_timeout() to poll for status change
> of a register. This resulted in "BUG: scheduling while atomic". The
> callback function, in which I was trying to use the macro, runs in
> atomic context. Hence new atomic macro is added. I was checking ALSA
> playback/capture and trigger() callback had to monitor some register
> status.
> 
> In general, the new macro can be used in atomic callbacks where regmap
> interface is used and polling is required.
> 

You should send a full patchset because it may turn out that the patch
which makes use of the new feature isn't correct or maybe the new
feature isn't really needed.

If there was a previous discussion about the need for this change, then
you should provide a link to that discussion.

Please note that usually changes without a real use-case in kernel are
not getting picked up or they are getting removed later on if nobody
makes use of them, so I assume this is a kind of an RFC patch for now.
