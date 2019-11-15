Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EC9C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B987F2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWY22g1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfKOOqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:46:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42799 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfKOOqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:46:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id j12so4802885plt.9;
        Fri, 15 Nov 2019 06:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A5DbVcBWyWNT0Bf+TBIj4rpDMpIX275oycgq4m/LPKE=;
        b=NWY22g1b9U1t3GuzHDFJY7ddGjKEIAPOGLr4be7jbF+/vAqjVu5HkklrQyA3YfU6wG
         /QMZG+lgH1gpIk2s2UB4p8mzV2FNkXKMvN398xcIC+D340JXLHxMinhmnVBsKj3EJEY7
         BPSzTCzC5ms2FqcwCTSZDJKDMv4tWSQr81UkNQdy4inyrtkh/JqZX5to5Y9gV6UmQ1N9
         hhNaQ/b/b0/nvMxhE5TsaVlX4NnGi5hQZp6BXiRvSZLj+/OCIERR0Hf7VXphzBhVccwu
         pWlyCsmGqFBRyQ2kLZ/tPnW5lQ3zbzZAvTifZyNIGIhZxRk09Xw5ctb2Z4WAa2g8WHlm
         +6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A5DbVcBWyWNT0Bf+TBIj4rpDMpIX275oycgq4m/LPKE=;
        b=foDa/fWcQHe253wOtRPSIFYBneFBEkR8vnfgJSVo0q8eSe0IY4+kbO8a5rsMRSVOlo
         s9ANmcGRwiLBOgHgKGWKk79c6yEFx9HT9ffzs4lkFYTGFw4VPHr3Ua6Mz6Z6kz23Htvt
         c7f/VLUoZlY81iDu87rTcIOWT0z0iJecH+aWnLgCnQEDDcLWdEcnFNEO+WbDK+2T1nIS
         /ZtGqYbUGukxsushDcioVSeqmby5ezQob/cOMfxACZ7T2ow7QKBYF9TlhtSMSxAWINU4
         bk6AJFeZpHZYhZ/gDIwyznoXDbileGUwhNI+uiaQQcOFEXX/rhwtr05U2n3VWyCNJb+n
         fVqw==
X-Gm-Message-State: APjAAAVlFLGrYfIPzdyRyePeXGrqqlcrtEj0/ECARmlD+DjmbyU+/aPQ
        EF/j7IHn3ohbSXrWFHxH0VNq4d4G
X-Google-Smtp-Source: APXvYqx63eLmkyL1L5ScgKFrNI0nbrIy7y25gRFi0Y7MecNmCCdTl5M2Pd+cy5czBjYGx7zrvv4ilQ==
X-Received: by 2002:a17:90a:a4e:: with SMTP id o72mr19982526pjo.66.1573829183239;
        Fri, 15 Nov 2019 06:46:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w5sm11742001pfd.31.2019.11.15.06.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:46:21 -0800 (PST)
Subject: Re: [PATCH] hwmon: (dell-smm-hwmon) Disable BIOS fan control on
 SET_FAN
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Giovanni Mascellani <gio@debian.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191114211408.22123-1-gio@debian.org>
 <20191114213901.GA28532@roeck-us.net> <20191114215154.hze2avicv7pwiksp@pali>
 <7ea74678-59e4-2c23-6744-6d0b2eff0a67@debian.org>
 <20191115112902.yfaoqttsafmilijh@pali>
 <97d17b37-0267-ae32-803c-ce8f7a871ab4@debian.org>
 <20191115143654.xxpxd4xrrapvv5xu@pali>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <afdf3d85-1950-2eec-a826-718a1c28f460@roeck-us.net>
Date:   Fri, 15 Nov 2019 06:46:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115143654.xxpxd4xrrapvv5xu@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 6:36 AM, Pali Rohár wrote:
> On Friday 15 November 2019 14:44:59 Giovanni Mascellani wrote:
>> Hi,
>>
>> Il 15/11/19 12:29, Pali Rohár ha scritto:
>>> No. I have not tested that my patch on other models. You can look at
>>> that my patch link, some people already reported that on some models it
>>> does not work...
>>
>> Yes, I saw that. But they are also using other laptops, which could be
>> excluded by the whitelist until we have a working command for them.
>>
>>> What is incompatible with Secure Boot? sys_iopl nor sys_ioperm has
>>> nothing to do with UEFI Secure Boot. They are just ordinary syscalls
>>> like any other and are executed on kernel side. And IIRC it is up to the
>>> kernel how it set privileges for I/O ports. Maybe bootloaders under
>>> Secure Boot can set some other default values, but kernel can overwrite
>>> them. I really do not see reason why it could be incompatible with UEFI
>>> Secure Boot nor why it should not work. It just looks like improper
>>> setup from userspace.
>>
>> Ah, my fault here: there is a patch to lock down the kernel when it is
>> started with Secure Boot[1], and I believed that was already in
>> mainline, but apparently it is not.
> 
> Ok, so, this is not a problem.
> 
> I hope that such patch is not going to be part of mainline kernel as it
> would break lot of things. UEFI Secure Boot and kernel lock down are two
> different things. It would be really suspicious that for "workarounding"
> broken functionality would be needed to turn of totally unrelated option
> in firmware SETUP.
> 
>>   [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit?id=160a99536afc317b337212dd40eaba341702343e
>>
>>> It makes sense to have implemented in kernel switching between automatic
>>> and manual mode as kernel has API for it. But it depends on the fact
>>> that we know which SMM API to call. And currently it is just some random
>>> call which we somehow observed that is working on 2 machines and on some
>>> more other does not. Until we have fully working implementation we
>>> cannot put it into kernel.
>>
>> Mmh, but then what is a plausible way forward to have this? Can't we
>> start populating a whitelist for the machines we already have a solution
>> for, and add more entries when they are discovered? This would already
>> give a benefit to the users of supported laptops, without impacting
>> users of unsupported laptops. My feeling is that if we pretend to have
>> information for all possible models supported by dell-smm-hwmon, we will
>> never benefit any user. Or can you suggest a plan?
> 
> The following question is up to the hwmon maintainers. Guenter, should
> we start creating whilelist of machines which support those SMM calls
> for enabling / disabling BIOS auto mode? And maintaining this whilelist
> in kernel dell-smm-hwmon driver?
> 
Ok with me.

>>> What does not make sense for me is to have that "protection" in kernel.
>>
>> I am not really sure which "protection" you mean. I didn't mean to
>> introduce any protection from userspace in my patch, I just wanted to
>> make SET_FAN working. I think that the kernel module cannot (and should
>> not) reliably protect itself from userspace sending random IO port
>> reads/writes.
> 
> I mean protection to disallow calling SET_FAN operation when auto mode
> is enabled.
> 
I don't have a problem with that, as long as it only applies in conjunction
with the whitelist. The whitelist would determine if the pwmX_enable attribute
is supported. If it is, pwmX can only be written if pwm1_enable is set to 1
(manual fan speed control). This is pretty common for other drivers.

Guenter
