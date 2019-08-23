Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B5CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA98922CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQJ1Cr4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395298AbfHWO3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:29:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32960 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390586AbfHWO3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:29:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so5897908pgn.0;
        Fri, 23 Aug 2019 07:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wOEo7GpB66pr1gOpedbJlaqSXnJAzhriTnRt2Kpk940=;
        b=HQJ1Cr4P5FHyQFc+I3XTFXEF8WF0n4W3S/hPoKkAFyY7dPn9wGhoUbE0V4IKfyWsq5
         G3rsE7VgHtn/MdvoKvPpah0uc+/56A2K9FBXtb9kNIcjvNe8BYxu8N9YFUnxDRXi+R6S
         x+fKRZHYVx8WBgntpvUH8LiA9PCi66NzZ6qM1gweCFAv23Nxto7TS8eprwn9zc7x+bnS
         AboX8b+IGtnP47YhBxsi2Zqewdk/orcAVgx7ZqoEFpFX6sc8cc0F0hbj7pt0pAToLAVz
         4aQwq+xEwDxfZSojEO8VmKQWnUJqtCFsedNcXooh9wOG4Mkid8Cu62bRCYJPtM8hAEEw
         6ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wOEo7GpB66pr1gOpedbJlaqSXnJAzhriTnRt2Kpk940=;
        b=tdtCk9HezNJX8RuQTTa4YC7u2xf1sQT2IVRJWY7hyUlucLIof48OHqvfTZWmBQt9At
         Vkn3zojp1f1cpeP6GFkQUEEPxvcqQFMrKt5cIQm+ssdNcFDDHBAcf2Mjqn29bVphWi2B
         4UyvaK9cZN98AMVinqrq28it2/flE4HvAbLVceb4x+58jBB+/G0/52hhVZGI6yRSqFdH
         YYTjPgPucoL9YirmgJ1GFZQsGUCj9cICX9pFziDESbr3FOk+nNBhDSyHISStCOE0z/Pd
         uHPAyP4lr4lH4CkXpPTH9mTQZsK7II0EVtrRbgaupFUvGBY0CKbQWMK1Y+eTXcNvfOUf
         p27Q==
X-Gm-Message-State: APjAAAWB7ul7Dc9O8sCRLfATlWcD+GNqvFmdT/NNNhvGuBVq+AYw1Wzz
        1aIT+SpmbEhNQdrcX2Hl1eGN2DIk
X-Google-Smtp-Source: APXvYqwilXYcUdF+1XluUgSBN88DYZBZ+lGmQCurA3WoV2mbz3mu88hS7DqeQekqGXajxMRJdgLfJg==
X-Received: by 2002:a63:b102:: with SMTP id r2mr4181299pgf.370.1566570539614;
        Fri, 23 Aug 2019 07:28:59 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a189sm2999147pfa.60.2019.08.23.07.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 07:28:59 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/85] 4.19.68-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190822171731.012687054@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <52746cb4-5e63-05a4-5329-f39bfaa0e38b@roeck-us.net>
Date:   Fri, 23 Aug 2019 07:28:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/19 10:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.68 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 24 Aug 2019 05:15:49 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 390 pass: 390 fail: 0

Guenter
