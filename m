Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC10C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952E020C01
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dms87Qg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfITNo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 09:44:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40100 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfITNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:44:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so3854649pgj.7;
        Fri, 20 Sep 2019 06:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GsxmCKzeG74g0A2Tyb3QHj/7yLDLR/UckrSAwd43T38=;
        b=dms87Qg1h+9cMV/MxT3GpnTtd9dVVEUbK6VX/Bd+cd+rDWbXshndpskwOXBUnQqo0l
         4Qs6bFSdY+MF2AZkd+bvKo03psH3mJpKGR1AeUVUiFYVSD1ILlnXsIa5mI1s1UqXigR6
         lkASWye75UnjyZF3dmqyakeurRvtlzQqdwWRITKHtg9YkP8jM6SE+cLVE4DZ3SE+8OSZ
         Eq9NmsenZIZS5dIwzU8capYnCKfZQpHuYr/TCBjYCG3SzhJvQ676MpRmuAUq/+5fe/XX
         gTdzWjv9CyD9sF7OceLrUO83/NXK0Lc5nOWTqz2s7R9yCUEs4MvpVDFHI1XfcCJ29utq
         PA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GsxmCKzeG74g0A2Tyb3QHj/7yLDLR/UckrSAwd43T38=;
        b=kqjI1nZQR25ou/rPJoNUmmryhebRIIVCz75HSQJjmE3YOnTVcgHMH3gNcXbID+7uD8
         SO1+Sky2weAnE2OIkYrpkdSAVpRP1JMZyJtRwrZjunz0b4IxZKgMMzyCqdQNx5kOSDKs
         3Elj4ynrHVr4pPPjvZKULRjnRhtBGBsvTTvbW2ePmHoaxLLPucNPPhyGn5kGwdztgu/n
         AthqEHXnaucxYjM7T0Jju7nru+jV3cGCiYoCTLQY0/MKCQ3/LdLlSTv0685+1DIcK/a9
         JFKO6pJRQoaRslKhb4N9t/rjC3L8xLazvSpz7vLJ/pvDRNVhYpHtSLtg39y2ahh//1XD
         aPqw==
X-Gm-Message-State: APjAAAWsOykfP0bed1k6Fgb9wT3qvyrb4Fx8SWrP49hqkPtwPVP68g+k
        sowLfQV9Uv2LyouR5/Jsjp0gkrrx
X-Google-Smtp-Source: APXvYqzVmpB0+7pj50kGtKlG4adOR5KXZRJ1o1mPJtk6UhuoKCkuDazjefq8k5ZEuskyELKk6GYanw==
X-Received: by 2002:a63:741c:: with SMTP id p28mr15116854pgc.147.1568987067678;
        Fri, 20 Sep 2019 06:44:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y80sm2558599pfc.30.2019.09.20.06.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 06:44:27 -0700 (PDT)
Subject: Re: [PATCH 5.2 000/124] 5.2.17-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190919214819.198419517@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6389eaa0-1f36-0ef8-0a53-c2fad611ab5f@roeck-us.net>
Date:   Fri, 20 Sep 2019 06:44:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/19 3:01 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.2.17 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 21 Sep 2019 09:44:25 PM UTC.
> Anything received after that time might be too late.
> 

My buildes didn't catch this release for some reason. No report this time.

Guenter
