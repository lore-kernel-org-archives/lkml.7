Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC90C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8B22071B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaTaagEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfKTPqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:46:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35236 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731502AbfKTPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:46:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id s10so14015016plp.2;
        Wed, 20 Nov 2019 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CCZSSj9vAJJYiFWorYOzuwdjbF9yMuxXR2Fthqq1xrI=;
        b=IaTaagEkblmJrOTAmh0JyQ42Z2ntr8s4rhLHX50JnHDakyzIsKAj/wwZae+Oe1+UJk
         HesRq3+LmiXxCK+UxofswC8iqp3v6eJNQt6h6L0Pw+BWFEaKCXMYEKW6t8UM6DDes+1P
         raw61TDX8wB4JurFAB99l80/307RGQ27p+8H43A4WLwRnJV+myIzhsHGwnS/QKPIj7rc
         zFU2DM7GdyMAq5LBkx/R32A9twwWbVJ3Ma4WIcvwk97tzQPSYoeZlVDcJue6bRSgIPTv
         acblET/725t/nJIEThqRWMlsYw1NbGIpIkHek2TTAGjhjRZzGhOv6TG9Frlmussb+wUl
         yQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CCZSSj9vAJJYiFWorYOzuwdjbF9yMuxXR2Fthqq1xrI=;
        b=c1tkfTdEBMG8XbZ95YF9QAZE23CwGy1yhcjvzYgy+P/w8qK0wX24U5PDbznsRKxEZQ
         J7H4aK+7Q8FvomGtNzEArCsTMJuVCKoR59QVzxOQ6FIfwX8ePGP753YvmbjMqCPIoVZe
         BSr7JriYDT7rtZ96E1BuVI+5vW682rWqH3KpQIpONSW9sioTcBPN2EQcRkyNjnmbgMty
         Hl50IzqC57rwlHtGLqWmkChRllG7Q+CANBngOI78CrN3iXsfIH9JgxEzAMGVuXHexK/f
         waUcjdvG5kNeLC9GE4nsiVIgc8q29WtTxbwoaqdWuAeibTADrzTef9SHZvLPbBA2JQTf
         i/5A==
X-Gm-Message-State: APjAAAXjJHjLbEn9rAodTOQaCxlHjLZotdg42zZATeMI8SztBOeObmt3
        m0ST6JVsvXEoM+FskHtOfqc=
X-Google-Smtp-Source: APXvYqx7zqeX0hdDwBGBK7B8mAqD9/zGSofyjerfqIiGiDe2bDaJrHPYOklZ/M+J1QYkNBldGIK8IA==
X-Received: by 2002:a17:90b:46cf:: with SMTP id jx15mr5030787pjb.19.1574264809306;
        Wed, 20 Nov 2019 07:46:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s18sm31211229pfc.120.2019.11.20.07.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 07:46:48 -0800 (PST)
Subject: Re: [PATCH 3.16 00/83] 3.16.78-rc1 review
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Denis Kirjanov <kda@linux-powerpc.org>
References: <lsq.1574264230.280218497@decadent.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7f0b50eb-8d42-bbcc-6291-0297f168ff55@roeck-us.net>
Date:   Wed, 20 Nov 2019 07:46:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <lsq.1574264230.280218497@decadent.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/19 7:37 AM, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.78 release.
> There are 83 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Nov 22 15:37:10 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 229 pass: 229 fail: 0

Guenter
