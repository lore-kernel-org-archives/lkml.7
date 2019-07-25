Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077D7C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4362190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfGYOss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:48:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46968 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfGYOss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:48:48 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hqf30-0005yd-JK
        for linux-kernel@vger.kernel.org; Thu, 25 Jul 2019 14:48:46 +0000
Received: by mail-pf1-f200.google.com with SMTP id i2so31031868pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L8TSu/J/AdGKl6bLer7RllEWvDobiC6YHiBN2E8KIEk=;
        b=oT/c7QLbZgB2qlbp/vID6L6ICH/x/8d361x/D/TQCxUwFQCPJDOzr3/jPx+VRoqStR
         TWdzzB6OymbA0aFI6XtKCOAK/YrkL/brTtUinG8wD/etL/yr7lvq9upDv6GzRjZBpuba
         qNkB1EfyoeiJA9dSka93m3UIGERrH7eNpXTaBsPhpdzCd38UairyOSfeo4y+3bLSjsbo
         jo9YTnI2uzpAdU2eUJkdGBqTps4hlb9JtdPU8anJnwDBYOyuKcfmWCDgS6EPGAAVYpAa
         3zkW1depI36iGn5SknEAlbNUaZ3CgC+wBJdbK57qkUg9j/8Z+/BtnlMWfgcRBVTjTFc+
         08jg==
X-Gm-Message-State: APjAAAUM2Dt7aO6ppJ3dri49KYGjEbwxxC/lP39UbE1R9eY5I1VRyk2d
        R14XXi3kxRdj1Rml2+J9RDhfJ+b0234/5j9C6kOAZbAR9L5xXekEugOyfnVqXcqz0mysEfMhUEx
        zM5/obdXGTaFG7mbjNxAezahh+2oCntgnXJcmJ9vGyg==
X-Received: by 2002:a17:90a:fa18:: with SMTP id cm24mr90826099pjb.120.1564066124979;
        Thu, 25 Jul 2019 07:48:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+RocIAB96bC6X+oFDDNSsZzVfifLEi0IB/t8xIP+CytFrvp+42/dz87PH2bFD6ICwoSl9Wg==
X-Received: by 2002:a17:90a:fa18:: with SMTP id cm24mr90826077pjb.120.1564066124658;
        Thu, 25 Jul 2019 07:48:44 -0700 (PDT)
Received: from 2001-b011-380f-3c20-0160-ac1c-9209-b8ff.dynamic-ip6.hinet.net (2001-b011-380f-3c20-0160-ac1c-9209-b8ff.dynamic-ip6.hinet.net. [2001:b011:380f:3c20:160:ac1c:9209:b8ff])
        by smtp.gmail.com with ESMTPSA id w4sm67258918pfn.144.2019.07.25.07.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 07:48:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] staging: rtl8723bs: Disable procfs debugging by default
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190725075503.GA16693@kroah.com>
Date:   Thu, 25 Jul 2019 22:48:42 +0800
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <83A2CB3F-B0C4-43C6-A3A6-B6E8B440BECC@canonical.com>
References: <20190718092522.17748-1-kai.heng.feng@canonical.com>
 <20190725075503.GA16693@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 15:55, Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 18, 2019 at 05:25:22PM +0800, Kai-Heng Feng wrote:
>> The procfs provides many useful information for debugging, but it may be
>> too much for normal usage, routines like proc_get_sec_info() reports
>> various security related information.
>>
>> So disable it by defaultl.
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/staging/rtl8723bs/include/autoconf.h | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/include/autoconf.h  
>> b/drivers/staging/rtl8723bs/include/autoconf.h
>> index 196aca3aed7b..8f4c1e734473 100644
>> --- a/drivers/staging/rtl8723bs/include/autoconf.h
>> +++ b/drivers/staging/rtl8723bs/include/autoconf.h
>> @@ -57,9 +57,5 @@
>>  #define DBG	0	/*  for ODM & BTCOEX debug */
>>  #endif /*  !DEBUG */
>>
>> -#ifdef CONFIG_PROC_FS
>> -#define PROC_DEBUG
>> -#endif
>
> What?  Why?  If you are going to do this, then rip out all of the code
> as well.

Or make it a Kconfig option? Which one do you think is better?

>
> And are you _sure_ you want to do this?

Yes. The procfs of rtl8723bs is useful to Realtek to decode but not to  
others.

Kai-Heng

>
> thanks,
>
> greg k-h


