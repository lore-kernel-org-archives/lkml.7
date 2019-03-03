Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69944C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387A020830
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moldevP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfCCSdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 13:33:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54853 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfCCSdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 13:33:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id f3so130284wmj.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 10:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r/cHonZCPoYXelMKZoT8nIReTxwyDIcG4H3P7TUyC6U=;
        b=moldevP2HRj/uIHH10p6rcZcPL77kyceDMNM7Gr1qkhV5mqm618BUP7G7fdIYnUwjQ
         0A1A4a5AXWlgHf86XtDtBzTqy3t2FIeRbm50mnn2uzO6l29av+dcOlvChHvh0dPWk/fS
         T4BcnjyS3GcklvN+frBZlvBud7alj2kctZ5VDSOTloidNEaPTb0pGVv/jSq2cYXSeXAa
         VgfIRkL5xqboDPKwwtTHmBqo7JNMqBK24FmzsWzc0SKUBIBTXjrfVxzucLQIprRt68NV
         84UwBohzEfzauaE235Xkl1Hz+tDmBjksThhyttyxdnAUMylBXFvligBYlNIapKzm1Nok
         mdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r/cHonZCPoYXelMKZoT8nIReTxwyDIcG4H3P7TUyC6U=;
        b=HbtU6dWh9uA7UhfOmyQWKgcpZXXjr9tGHJgoEYmoGQoJlY4qKKpEVAawz4/Nr0j8sj
         3lmsZ/oFMYhZSwlXONnH80Pms2dyPP7yXzg9CyVjjXInPXw/tt5nVqJ0U37OirI0sZV8
         C3TzIDa5zuFJJ8v66JR95mtKOoLsuUXhxKsSdFFWrhsjahBsf9vuwU3zm+kNYVP7SdUg
         VwNitlwaQntbf3TVEpY9dDsxwhSrHNqWcquDm/f/wdFPSfROeT35i4SI6HwiCANxGlPj
         9GjPnIDVHojen21m0j5g7I2ilVMvRIjqY3tnKQs/mIEPQTdMWr/0K3FlDk8dfoA1I3tV
         A3KA==
X-Gm-Message-State: AHQUAua88K4hpzLJa/MVSIG0YAY3iYnw5wlKwjqdwrfQljMgEJDz2Arq
        WvMOxO8zM+L7Ey457libANDq2zJH
X-Google-Smtp-Source: AHgI3IagNjX7L4H6ab9F7d7id9tRwDd1bIXEDdIBSBzt9TzgAKiOFyGM6Pn5lx9TNJ1/xdhfrUPYeQ==
X-Received: by 2002:a1c:3d84:: with SMTP id k126mr9051239wma.60.1551637978880;
        Sun, 03 Mar 2019 10:32:58 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:35a8:f48d:4b19:96c9? (p200300EA8BF1E20035A8F48D4B1996C9.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:35a8:f48d:4b19:96c9])
        by smtp.googlemail.com with ESMTPSA id c186sm6026978wmf.34.2019.03.03.10.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 10:32:58 -0800 (PST)
Subject: Re: Fwd: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <981d965e-b25b-be2b-2067-07aec5eafc7a@gmail.com>
 <43eb3aad-0e0b-9019-dfe3-47f205607df0@gmail.com>
 <20190303175514.GA16636@kroah.com>
 <e55de1df-b70a-93b5-9f18-072392fa0657@gmail.com>
 <20190303181509.GE16636@kroah.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a833dcdd-6473-3426-cc80-405b3d100750@gmail.com>
Date:   Sun, 3 Mar 2019 19:32:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190303181509.GE16636@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.2019 19:15, Greg Kroah-Hartman wrote:
> On Sun, Mar 03, 2019 at 07:04:21PM +0100, Heiner Kallweit wrote:
>> On 03.03.2019 18:55, Greg Kroah-Hartman wrote:
>>> On Sun, Mar 03, 2019 at 06:47:32PM +0100, Heiner Kallweit wrote:
>>>> I submitted this through the netdev tree, maybe relevant for you as well.
>>>> See also here: https://marc.info/?t=155103900100003&r=1&w=2
>>>>
>>>> -------- Forwarded Message --------
>>>> Subject: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
>>>> Date: Sun, 3 Mar 2019 18:20:50 +0100
>>>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>>> To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>
>>>> CC: netdev@vger.kernel.org <netdev@vger.kernel.org>
>>>>
>>>> Add a new function strreplace_nonalnum that replaces all
>>>> non-alphanumeric characters. Such functionality is needed e.g. when a
>>>> string is supposed to be used in a sysfs file name. If '\0' is given
>>>> as new character then non-alphanumeric characters are cut. 
>>>
>>> sysfs doesn't have any such requirements, it can use whatever you want
>>> to give it for a filename.
>>>
>> Even a slash?
> 
> Is a slash an illegal character for a file to have?  It's up to the vfs
> to care about this, don't force random parts of the kernel to care :)
> 
>> HWMON drivers is an example where such functionality occurs open-coded.
> 
> Is that data coming from userspace or from a kernel driver?
> 
Usually from a kernel driver. That's what
Documentation/hwmon/hwmon-kernel-api.txt says:

All supported hwmon device registration functions only accept valid device
names. Device names including invalid characters (whitespace, '*', or '-')
will be rejected. The 'name' parameter is mandatory.

The hwmon subsystem has an own function to check for such characters:
hwmon_is_bad_char()


> thanks,
> 
> greg k-h
> 
Heiner
