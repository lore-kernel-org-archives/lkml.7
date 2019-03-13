Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42BFC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF50213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bbadu+Q3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfCMUfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:35:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42619 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCMUfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:35:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id b2so2320345pgl.9;
        Wed, 13 Mar 2019 13:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QT+XHlb7R9PkN0kbGWlSurg93LJPDLkVjSk+/M9+1Ss=;
        b=Bbadu+Q3mnX6WLUGc6DkDNqyBBBvyEV0tTVOmcAvLv/G3FMTm+tEF7vdi36i+0d+a/
         pc62lP/F4JBjIFriC9nqQULUef/RiXmotTl6wJXgR5LTCjixnJRY0qd2GoCYqNmSS+NH
         9kKGMYY1h5aa9w/8yDU247MpoHRSWHZ+fO/IIp3ePEVegOO6kr/lzRBB4NnWujpk+sce
         C20zthm5BnvXs2ranY4O+Fc6qWykavgh3q/XYnIuw5boQ/aZjY5r2UDbo+bPZd9NkqQ1
         zgKnK93rjU1Zu0ZGXlzZEfIiSEq+5kUdQ6nvb4hVwt9vFRi1OkbNpv9f6u+sZacqsX8K
         3feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QT+XHlb7R9PkN0kbGWlSurg93LJPDLkVjSk+/M9+1Ss=;
        b=Gue3G2Yqg6SWGiZzu1+WPTW2VTWsjTo1VwnGPM9iAgJeIgPTvJ5j0kIf3W4kiIb2bT
         Tg+d8YI0IfqwYpV4Z/WeucX+fs3fK4Y5/Ek68PrxefqutHbJS6mAh8UUJqzSyVIGARnj
         lX48vryjUbQLwzjCV78gLAX7Jq7pQyj+ATCenmd+QPx91XWB3IV13lDzxPxRXX7xJ+51
         g1YKFkErbQKmRXnupKw2vkykYu5kEswEnvN3g6V/rFhhAE0mCPMvLDAbbqzZe15T2jsQ
         CIV6TdYVBgracxx8CYCRmcr7nR4z7HbFIBHda9tk72GuRREqEBNqWAWdqlxdVvucId6n
         3/ug==
X-Gm-Message-State: APjAAAUUsCc5ymMov5Q+rvXbbmWOssabcXaqdS1vLHn3kVPyJpwpQ+EZ
        zbTNOYBsri+gaY/E5VKva3UgU4zd
X-Google-Smtp-Source: APXvYqydqKfqdHpDkzt6RoAvmGjLX95Xo22/MjI+xS3EOdiZIp/la73+KbmiDmGXOsTlCtSM5aFDZA==
X-Received: by 2002:a63:f843:: with SMTP id v3mr13934530pgj.25.1552509313602;
        Wed, 13 Mar 2019 13:35:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f16sm3250702pga.71.2019.03.13.13.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:35:12 -0700 (PDT)
Date:   Wed, 13 Mar 2019 13:35:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/135] 4.14.106-stable review
Message-ID: <20190313203512.GB26634@roeck-us.net>
References: <20190312170341.127810985@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:07:27AM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.106 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 14 17:02:27 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 329 pass: 329 fail: 0

Guenter
