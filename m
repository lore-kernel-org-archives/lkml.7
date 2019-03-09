Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A856C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650C420657
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 22:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekulswfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfCIWgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 17:36:20 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:46336 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfCIWgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 17:36:19 -0500
Received: by mail-pg1-f177.google.com with SMTP id a22so1004789pgg.13;
        Sat, 09 Mar 2019 14:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R8EdCKxHV2rbrpAAtPC0Sd4QAK79+GUDFis/pST1pgs=;
        b=ekulswfnSKDx4fO7qdRol7c8pxMvSpqsoGFjtYFWNGU57zrRvVkP5V/ygYLtr4zA97
         rEONF7roO8ON4ZEzf9itmZVF1rGzND49SDCtrftGzlN6+yNulmRc9Puki3w/LyUcCz7p
         22Knnpj34ADRPetlBnF8G/LBOwPPsO19P45OvXzmbCaFldAVvxzsgarLShsnHf05EXrm
         eruxH9KZAb6FeK5flXA0Z87+cN48tjjuwJvGnFzGV30XAAOOz132w6LCPJPOYbIZ0k3e
         KcXxzWB4bo+csZo7YoMuDaTj0/2lM7KSQU1GgqWZHR8lI/NirLFvVKoRhG4ybuAAq89d
         dJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R8EdCKxHV2rbrpAAtPC0Sd4QAK79+GUDFis/pST1pgs=;
        b=LIQtjvN4tt7kreKXsaGqXc/qogDRuwSST/5nx1ace6iFE6yaZTqKWiTfUi/QzdngBY
         wzbQUs09Uh69xnTwBIL6XEW9p2rOouO00+HsmnlCJ++/B11qNgEVmGKD7YVlpvgvrbrG
         1LfeTsWh3ack6dpqoDGwNu7/ZVL3g6CzVwkGrMmHYGFUmgybCKbu6COsH1bzCKaDWNyj
         Oodi88sZZSvYxKZdbFE4JOotQ9zIfWcOwvsQglCuEHdrxW9qSNH+tV2TYd2jbToxXqGm
         Oex+CzRWKMVy3jsLhywMmwg6JX7rarxd8hjUqfX5+jKVaZPnpKJge/V5F5jhphwexx0K
         eCyw==
X-Gm-Message-State: APjAAAVR/VRz0sh0y85E0R+i6BD4zDvetz2qD8Kv94Z7OkhFnABssduu
        z1JFEc0AGXEKRCKtzA4mJnvi8wvH
X-Google-Smtp-Source: APXvYqxQMV7HRUTqoFpi7ZwrWmdbqboC11tAr5MfNp29bOn9R4MGUsclyJ8f2+wr9P5t06HKJD5ejA==
X-Received: by 2002:a62:1b03:: with SMTP id b3mr25994604pfb.218.1552170978848;
        Sat, 09 Mar 2019 14:36:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m24sm2342504pgv.1.2019.03.09.14.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 14:36:18 -0800 (PST)
Subject: Re: [PATCH 5.0 00/46] 5.0.1-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190308124902.257040783@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <db623c17-a448-47c6-0132-3ee3d05d3c65@roeck-us.net>
Date:   Sat, 9 Mar 2019 14:36:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/19 4:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.1 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 10 12:48:36 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
