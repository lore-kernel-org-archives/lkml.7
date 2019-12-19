Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049BBC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C6D2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lQ/Xfr7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLSRG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:06:58 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:60646 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfLSRG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:06:56 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 47dywG5XPnz9vcwr
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 17:06:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ROdMlLSnYCvu for <linux-kernel@vger.kernel.org>;
        Thu, 19 Dec 2019 11:06:54 -0600 (CST)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 47dywG4S2rz9vcwf
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 11:06:54 -0600 (CST)
Received: by mail-yb1-f197.google.com with SMTP id b194so4496634yba.21
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=subject:to:cc:references:from:in-reply-to:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=khlYaPbWIWU3Yw95Dv5xQPpS+EL00uRq9R+bfqtQfGE=;
        b=lQ/Xfr7LFusZOGaK6IzuJQXJfpzY5VP4sHGkSbgquKqc5U9vVmLPvuMpuHFe0rmkHd
         410E0V22Aq8PUHS+gMcuU5IrhzAhsrzskBv0ZFGzYbLczWUp6pwNza4sFn8/39wiGCAf
         W+KPjBv+hZJA8Xn0dGn7sjElyzzPcorZn6ej2l9UP/LNUGvryzSy0+p3ENL2NIoTKSk3
         r7wfXVYwL/TTG8Co+Xq2bykhRbdlc2wVgHOPL1YxAHYWY+MQSwK1Pn7u3VDOXZw2+3Jv
         G0JiALuby9+UBdQ3FZesNPTJrhU7A02RVwnX/XeyaRbV8BU74U5NYn7flFV+hrrrsx1K
         m2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:in-reply-to
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=khlYaPbWIWU3Yw95Dv5xQPpS+EL00uRq9R+bfqtQfGE=;
        b=ta8S6JefU7EA7+6m9gwFlqzBCoLX0queEzjB/XX6/6XaIJZvXQG7us3KZQmzFJB6yH
         f8E3TqxIHobrM6A0L5JryJUykY/IuRDpcGFwXjGq3GzPXPYFa77eD2/Y5t9YDzTjFHBC
         DqfCEAeUU6Vm6BJu5uIuElP233XP2mhse/ZWSOsDYUKhBfzIljB3VARsiW3cronFgZjh
         fbkc8ySEP0peU50sYwLmTGXA7O3IX5Dbj6vG+a/GWsfsB5cLNQwZHWUK1gkVUERXO1Lz
         h+bRD4DUxR9xgOHdiK+BOnyunt+FJwZrpzvP6WAYqBkL9b70SnZmlramqNb+c+QDjHAl
         hslA==
X-Gm-Message-State: APjAAAVDIRhQxJUMJCTWNCJV0K0IcwfUd6BVpYsACqDQP6E9MRoHrh5g
        glAIrSVtmZU3m1zrBBt8HFA/XjYvVtOXJqMAkoW4cqo4rF+D6M9ocRsSr7fJaNB6qQqqaKuaz69
        r37MCb78mchezhbpWafM9pb9+sCgJ
X-Received: by 2002:a25:5984:: with SMTP id n126mr2353405ybb.347.1576775213889;
        Thu, 19 Dec 2019 09:06:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqzd996EJBbEY6a2F54855tl8zzwzeowj+d2Jd91rW95pAhUsAcgUXSwRnIh8w0xA9uNbZGCjw==
X-Received: by 2002:a25:5984:: with SMTP id n126mr2353355ybb.347.1576775213425;
        Thu, 19 Dec 2019 09:06:53 -0800 (PST)
Received: from [128.101.106.66] (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id h23sm2569757ywc.105.2019.12.19.09.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 09:06:52 -0800 (PST)
Subject: Re: [PATCH] drm/amd/display: replace BUG_ON with WARN_ON
To:     Mikita Lipski <mlipski@amd.com>
Cc:     "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Leo Li <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Francis <David.Francis@amd.com>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20191218161505.13416-1-pakki001@umn.edu>
 <d963ed6f-4ced-cc9d-6612-8720ed9d2c41@amd.com>
From:   Aditya Pakki <pakki001@umn.edu>
In-Reply-To: <d963ed6f-4ced-cc9d-6612-8720ed9d2c41@amd.com>
Message-ID: <cb5b4d65-4a56-8fa4-5be4-c9ff5a2bf4e3@umn.edu>
Date:   Thu, 19 Dec 2019 11:06:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/19 10:29 AM, Mikita Lipski wrote:
> 
> 
> On 12/18/19 11:15 AM, Aditya Pakki wrote:
>> In skip_modeset label within dm_update_crtc_state(), the dc stream
>> cannot be NULL. Using BUG_ON as an assertion is not required and
>> can be removed. The patch replaces the check with a WARN_ON in case
>> dm_new_crtc_state->stream is NULL.
>>
>> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 7aac9568d3be..03cb30913c20 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -7012,7 +7012,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>>        * 3. Is currently active and enabled.
>>        * => The dc stream state currently exists.
>>        */
>> -    BUG_ON(dm_new_crtc_state->stream == NULL);
>> +    WARN_ON(!dm_new_crtc_state->stream);
>>   
> 
> Thanks for the patch, but this is NAK from me since it doesn't really do anything to prevent it or fix it.
> 
> If the stream is NULL and it passed this far in the function then something really wrong has happened and the process should be stopped.
> 
> I'm currently dealing with an issue where dm_new_crtc_state->stream is NULL. One of the scenarios could be that driver creates stream for a fake sink instead of failing, that is connected over MST, and calls dm_update_crtc_state to enable CRTC.
> 
>>       /* Scaling or underscan settings */
>>       if (is_scaling_state_different(dm_old_conn_state, dm_new_conn_state))
>>
> 

Thanks Mikita for your advice regarding the patch. However, would a better error handling 
in this scenario be helpful ? Clearly, the stream variable is dereferenced in 
update_stream_scaling_settings would have the same impact as a crash ?
