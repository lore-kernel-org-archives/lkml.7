Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFF8FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DC82084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhDzQyPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbfKHUH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:07:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38588 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387874AbfKHUH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:07:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so7452501wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 12:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gwf03HQCJcAeKeVV6CDOtpVEM+58xqWFoXIO9s1VR2c=;
        b=NhDzQyPS3minpgWDPizoGqVOo5LUY7O8ofGjJhFjcBBc0tuZyxmovgfXtvEDtqm6kt
         mAbUOvYMvXf6r2wubPDvUB5Yy3AuG+0bILmDhgKGK5M2SBO6rwpXTQ7ANTanZxpnp9lY
         shWw618Egw0M0qmXLUzqP+VotL72Rbxwo6IsH2N98Kyn3NkwIvaMArjnlkWRPdhIxNzn
         5oSRjKXnIf9Y/nBgd1/K/sQHSg84VlklYgJ8zAs0ELzIRHZ4z1bHMUutqq9VixeCCrKU
         jlUpsfARXvnewUQy2MH2twYVu5srqi8+rErn3h1EFc/y6nouyas0WjWayb5/VMAHwpDi
         gLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=gwf03HQCJcAeKeVV6CDOtpVEM+58xqWFoXIO9s1VR2c=;
        b=GfaKpGGVteTLgnyk9I3u9VT5yJudWQdSWd6KhuUoIEHED8aHfg7cBW68ktxli7a+Vy
         xz2oLkTdSvjyOB/G4KLsaqQ0FldoYrGitDmKRoeNIcggh+tvzcQOj63EW2I4XpVle+wX
         UOI1GUCs0PUjIb62dgo6Rb1QxyWFM/5Tygk6UTG7P8BJkkmsvjjC/Tr2NRGJMUFAtTQI
         pln47Via90IO6iQrlnQWjD3Wn64vNUQELolqKWkh9INObfST3bBylLfohBfILldSg0ed
         F9jIj9lvQ7iciJPtN69hcB7MaEOV9sB8ePwWl9KsivRjPfn0mzXW5cKdOmIUnTCoJmXK
         yzXw==
X-Gm-Message-State: APjAAAVNj6sw3tRUViszjlDcWYcJgznFgGCGXtuEFWMqKhe7FfHPDK43
        1a4GAoqhqty7f55RiXTKWJs=
X-Google-Smtp-Source: APXvYqwl9KXzZZqdsQGTX5vggm4+Gvse6h9VoWpyn33lsaQWOqOG4teXB3ND+xZvvQYUQa2fmHTr9A==
X-Received: by 2002:a1c:b1c3:: with SMTP id a186mr10052449wmf.10.1573243675924;
        Fri, 08 Nov 2019 12:07:55 -0800 (PST)
Received: from wambui.local ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id f13sm6612474wrq.96.2019.11.08.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:07:55 -0800 (PST)
From:   Wambui Karuga <wambui@karuga.xyz>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Fri, 8 Nov 2019 23:07:44 +0300 (EAT)
To:     Sean Paul <sean@poorly.run>
cc:     =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
        Wambui Karuga <wambui.karugax@gmail.com>, hjc@rock-chips.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: use DRM_DEV_ERROR for log output
In-Reply-To: <20191108160602.GG63329@art_vandelay>
Message-ID: <alpine.LNX.2.21.99999.375.1911082306460.13123@wambui>
References: <20191107092945.15513-1-wambui.karugax@gmail.com> <20191107133851.GF63329@art_vandelay> <20191108124630.GA10207@wambui> <4996186.DxzAFJqeGu@diego> <20191108160602.GG63329@art_vandelay>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1284482943-1573243675=:13123"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1284482943-1573243675=:13123
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 8 Nov 2019, Sean Paul wrote:

> On Fri, Nov 08, 2019 at 03:06:44PM +0100, Heiko Stübner wrote:
>> Hi,
>>
>> [it seems your Reply-To mail header is set strangely as
>> Reply-To: 20191107133851.GF63329@art_vandelay
>> which confuses my MTA]
>>
>> Am Freitag, 8. November 2019, 13:46:30 CET schrieb Wambui Karuga:
>>> On Thu, Nov 07, 2019 at 08:38:51AM -0500, Sean Paul wrote:
>>>> On Thu, Nov 07, 2019 at 01:54:22AM -0800, Joe Perches wrote:
>>>>> On Thu, 2019-11-07 at 12:29 +0300, Wambui Karuga wrote:
>>>>>> Replace the use of the dev_err macro with the DRM_DEV_ERROR
>>>>>> DRM helper macro.
>>>>>
>>>>> The commit message should show the reason _why_ you are doing
>>>>> this instead of just stating that you are doing this.
>>>>>
>>>>> It's not that dev_err is uncommon in drivers/gpu/drm.
>>>>>
>>>>
>>>> It is uncommon (this is the sole instance) in rockchip, however. So it makes
>>>> sense to convert the dev_* prints in rockchip to DRM_DEV for consistency.
>>>>
>>>> Wambui, could you also please convert the dev_warn instance as well?
>>>>
>>> Hey, Sean.
>>> Trying to convert this dev_warn instance, but the corresponding DRM_WARN
>>> macro does not take the dev parameter which seems to be useful in the
>>> original output.
>>> Should I still convert it to DRM_WARN without the hdmi->dev parameter?
>>
>> There exists DRM_DEV_ERROR, DRM_DEV_INFO and DRM_DEV_DEBUG to
>> handle actual devices. Interestingly there is no DRM_DEV_WARN though.
>>
>> So depending on what Sean suggest another option would be to add the
>> missing DRM_DEV_WARN and then use it to replace the dev_warn.
>
> Yep, this sounds good to me me.
>
> Sean
>
Okay, I can add DRM_DEV_WARN and replace it there.

wambui
>>
>>
>> Heiko
>>
>>
>>
>>>
>>> Thanks,
>>> wambui
>>>> I'll apply this to drm-misc-next and expand on the commit message a bit.
>>>>
>>>> Thanks,
>>>>
>>>> Sean
>>>>
>>>>> $ git grep -w dev_err drivers/gpu/drm | wc -l
>>>>> 1950
>>>>> $ git grep -w DRM_DEV_ERROR drivers/gpu/drm | wc -l
>>>>> 756
>>>>>
>>>>>> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>>>>> []
>>>>>> @@ -916,7 +916,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
>>>>>>  	}
>>>>>>
>>>>>>  	if (!dsi->cdata) {
>>>>>> -		dev_err(dev, "no dsi-config for %s node\n", np->name);
>>>>>> +		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
>>>>>>  		return -EINVAL;
>>>>>>  	}
>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> dri-devel mailing list
>>>>> dri-devel@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>>
>>>
>>
>>
>>
>>
>
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS
>
--8323329-1284482943-1573243675=:13123--
