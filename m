Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A969C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D2621556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="fPX7dQwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfLKVnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:43:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44194 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLKVnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:43:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so11371156pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 13:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U8lNG5OFR5VV956oP54GBQ7RPKQcfjRRY5jdcJewOVU=;
        b=fPX7dQwaKWadTbKKNrJCN7AUKYF9Jk+mpQourMVjSrbXpZRTSmRrutVF7pHcv/rXtY
         luysV+zW/mWSkKGqiSa1FPj3NFFyoyYtQhupjrhzBGLx0o43aerMIURFNcRvrbwsIhGA
         SVHo27Pj3v72AlLB/2RCO07iB/i7uCDe9K/g7UXZwFN7XWb06pb5P08HaXAuScZVwe+1
         tKmoduzLLi6WCGikyOmcILv5vs3MaBW0g4woS2c7MD/kEAQ9vTVI7gRMsJ7bODVhZ+gY
         NCzd4eEPtrjoyIP8HCtU8HMbAzEjVYrJv6fQCjT9Wy8u3DhV9pXpbyrFskNZSYWx3LBy
         fkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U8lNG5OFR5VV956oP54GBQ7RPKQcfjRRY5jdcJewOVU=;
        b=fDx8TQdnGPiN03oh7B4cuFsCQkxvZHxKIplAKBpWTmCfszBdrPAvLT9/fFtB50ZGcv
         T8TeFDWx00ZMwh81DZVLOH/PKXIdbo87O2Lek7TE7Sdp5H4MgRupt0fzghDgCIy7Ysmo
         cVZ24YzAPRNGU6KdpyrEX4jAk/aXHZbmEcQhLfuKwK1VJLYe0nLDJjQW1LJKbrGILyg5
         XC+OttuRoQs90CEoKkuf4VjnDzIW/4C9k+5woHgxX6MFaQ3gtQAfZejf7qkWXC56ZXBk
         gEgDzB4JUOQCpzU8p4Ri71HujzC1a1VBsz97NVSp7Afwl3GVBZJbssBxr9ltr9um/Vez
         STKw==
X-Gm-Message-State: APjAAAXDUZ7P3/4o6+lEWiwzszlJTnvHnjR541wM/7oa2pYek8UGxZo7
        S8pIx0W+lGCUIugi+QVIQWKWaA==
X-Google-Smtp-Source: APXvYqyaGe3avt8YTLsrM2z506vUriJQSCARJ23p4OXFZQfzMvjFPI6uaAL8wgTCwvHgarIjUT/6vg==
X-Received: by 2002:a63:1346:: with SMTP id 6mr6703192pgt.111.1576100629376;
        Wed, 11 Dec 2019 13:43:49 -0800 (PST)
Received: from debian ([122.164.82.31])
        by smtp.gmail.com with ESMTPSA id a12sm3731412pga.11.2019.12.11.13.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 13:43:48 -0800 (PST)
Date:   Thu, 12 Dec 2019 03:13:37 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.3 000/105] 5.3.16-stable review [warning related]
Message-ID: <20191211214337.GB2676@debian>
References: <20191211150221.153659747@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 04:04:49PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.3.16 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Dec 2019 14:56:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.3.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.3.y
> and the diffstat can be found below.
> 

the following is from "dmesg -l warn"

-------------------x------------x------------------------
================================================
WARNING: lock held when returning to user space!
5.3.16-rc1+ #1 Tainted: G            E    
------------------------------------------------
tpm2-abrmd/679 is leaving the kernel with locks still held!
2 locks held by tpm2-abrmd/679:
 #0: 00000000d3bc394f (&chip->ops_sem){.+.+}, at: tpm_try_get_ops+0x2b/0xb0 [tpm]
 #1: 000000004a4d7099 (&chip->tpm_mutex){+.+.}, at: tpm_try_get_ops+0x4b/0xb0 [tpm]

------------x----------------------x---------------------

the fix for the above to a typical kernel is here ...

https://patchwork.kernel.org/patch/11283317/

--
software engineer
rajagiri school of engineering and technology

