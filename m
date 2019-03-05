Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9753FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6610020684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqQ34ccQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfCEDiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:38:13 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:46060 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfCEDiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:38:12 -0500
Received: by mail-pf1-f174.google.com with SMTP id v21so4563439pfm.12;
        Mon, 04 Mar 2019 19:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y4Fhc4lhJQRR7GIpSSKdSfLVSVeo6OwxPbp2QdnV18s=;
        b=hqQ34ccQFhMKCS+PZHPV/kmgPyZ0KVrjxShveAL84piPfqYuDx8SdkBrikVJeZw6Vc
         coyNk23qD1dNjRPLh2radC5SKMMwppaR1ebWGy5LdxlfygODpHXium5YszYjo+kf5dKm
         5oEDJuQCg5GoVp8re6ApSXAdE4yj1Q3D9DZtYv2htgD4OUlTv8PmK5nxMPBfrZWxYAzm
         K/JRsHEzXKT8xWCnGO6AYPRBiIS43AVNPIz7BK13/6Gzt8GBlKVhUAeK6iR9uILGmkjy
         BzK6wkoFbCNpEgs0hrKH0zj8rij5xwpYR+2KJO/F9QtfTEvAYDgSJHuFKJE2dWAqblff
         RtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y4Fhc4lhJQRR7GIpSSKdSfLVSVeo6OwxPbp2QdnV18s=;
        b=gcwS/XL92lDCLfZjqo/oeP9ggBVE52XZ4TcB42+T8HZkd2pTxewSbY05OV1nmq+jkd
         XA0mT3RxEIq+2tfJiFhXxaHN2GJjWelPkBYeoGfvtdoqGY/x5iGVVy4ZwlVpmOxZrWSB
         gk19RJ1fWpVbsOuuWX9JpAtsKjBHTstskjrM4wzxwDULDqpo9dPsIT/UAm6psgf3mtUO
         N1snxuawSzM2gBc5jZIgwvv7awRwsiMRlCtZqtH/VN2cf4ysEfFlJxiAvtRwO9EdvgCm
         qiFScEomCITgkEO7XE20n69iZBFRpPqUyqr+xaK9F5vVQuEmMqbaPMORNTqFGXRO1BQf
         zXxQ==
X-Gm-Message-State: APjAAAXpBEu4v44yEbp5hyimNN6r04mC3WUiwn2yR5d70sFrxLUP9EnG
        55F85tOVasv8G8ygagwIC35yh+b0
X-Google-Smtp-Source: APXvYqyz7o0RniZMYci228X6ZgNZCinuxmpcIIfz0ps1bqPdyC7FOBGjiQmFmUC2UEaOJBBbb9HORw==
X-Received: by 2002:a17:902:5066:: with SMTP id f35mr24579652plh.184.1551757091334;
        Mon, 04 Mar 2019 19:38:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q7sm15892947pfa.119.2019.03.04.19.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 19:38:10 -0800 (PST)
Subject: Re: [PATCH 4.9 00/32] 4.9.162-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190304081602.307094059@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <831a6231-11bf-b098-540e-0f38f21b4aa4@roeck-us.net>
Date:   Mon, 4 Mar 2019 19:38:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 12:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.162 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  6 08:15:49 UTC 2019.
> Anything received after that time might be too late.
> 


Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 315 pass: 315 fail: 0

Guenter
