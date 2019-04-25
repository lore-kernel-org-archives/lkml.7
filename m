Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8CBC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BA520717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf+Bkb9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfDYSwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:52:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41203 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDYSwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:52:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so796056wrt.8;
        Thu, 25 Apr 2019 11:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7iwea6UpuDboaEVy8ociq8XRsqFyNOF/vHgsyWf4dgA=;
        b=hf+Bkb9m8NLLL5hDqFic7RZEANH+j98J5H9UgtXBds6WNIi+3sv+i5a1DfD5hSePIZ
         RBeFDoguz1UB8ufC1Vo7jdxoWKmyWKx8+8ocv5lsn5Kbz93rInJM4ICVRzDkdBGnigLz
         86DhRkl3Fp0MZydkTnkJwr6pp2v5I2AMIzJbRq4Wilo44ypjb8pAvUJ6j37Fml1UK0mi
         g+PwdRFNCdgC0bnBxuK+H6LGrx2xdBB2GKvnHZSUPSUO5QKesxIaRDz5lbMMT1a8IOlH
         zwPY+IVZG1hab7QNqpsOasSR4Ik5TabJPYpVkDZgEo8fw2eNRfzWeS7vcpbfYQEMLu4g
         SW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7iwea6UpuDboaEVy8ociq8XRsqFyNOF/vHgsyWf4dgA=;
        b=Y4iV+Ah+vIhoPKzuynX/lox0nUGaIQUrlrQnXKpfFWQfyuc5P+9db0tMCDcpOwMCIw
         34utTDUc+t/AO5WcH4xCx348DGc/3D9gflmuS/XV4ZqsA4Syyzin9FIqzBLoGgUf4vfX
         gBdXrOkf3Vh7t8hZyMQvGfqayTVUdwdWFHEkd8p8Hn2+uNsePJAc/LPBuFgscuToqt8W
         2aNhUlnWwCimmdeR4N5rgQaLP2rDn3XoDjJMKBFsZM2tj8S6s30tTczCA9i70dLhyfwG
         3DG+cl7ypi0+k/gsQ0GJe0KkVQxMh8DLnhzSozq+GsWyGRROy8awSvShe2aRXfuJRpT4
         9sJg==
X-Gm-Message-State: APjAAAVyCkOoiNL89h+sT2LvjfvfWtRoWyVD4qAJnI/C/jHSy2xwXGlS
        DemXhPO3I62nD0khw7hPgz2nOA9zpG0=
X-Google-Smtp-Source: APXvYqwl8aW+j/Xkj+Gx8Ipsa3ilMij5r6HrE5jIYGEt99797Zu3dLk4pCcbW/s4Pg8n8gaY2Kvqlg==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr27774863wrv.126.1556218318295;
        Thu, 25 Apr 2019 11:51:58 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id c2sm21286136wrr.13.2019.04.25.11.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 11:51:57 -0700 (PDT)
Subject: Re: [PATCH v3 08/11] platform/x86: asus-wmi: Enhance detection of
 thermal data
To:     "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        "acpi4asus-user@lists.sourceforge.net" 
        <acpi4asus-user@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <7595c4f0-3dbb-2fe5-4daf-4b9a266f67d7@gmail.com>
 <3C3E65E75D9910479323816378A812E7414CDE12@BGSMSX104.gar.corp.intel.com>
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Message-ID: <a5d5f899-d218-b581-b187-f783759b6afa@gmail.com>
Date:   Thu, 25 Apr 2019 20:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3C3E65E75D9910479323816378A812E7414CDE12@BGSMSX104.gar.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.19 20:25, Pawnikar, Sumeet R wrote:
>> +	/*
>> +	 * If the temperature value in deci-Kelvin is near the absolute
>> +	 * zero temperature, something is clearly wrong.
>> +	 */
>> +	if (!value || value == 1)
>> +		return 0;
> Do you still need to return 0 in case of wrong/failure case ? 
> Shouldn't you return error here ? 

Yes, I think 0 is right there, it's not an error condition in the check
itself (such as IO or memory error). The function returns two values: check
result in asus->asus_hwmon_thermal_available and error code.

This is still a successful negative result. The 0 or 1 (as added in this
patch) there merely indicates that the temperature measurement is not
available this way. It is safe to assume that no device that does provide
temperature will return 0.1 K. The temperature measurement is not critical
for driver operation so the driver proceeds without it.

One could return ENODEV when the check result is negative, but that would
just move the actual check and assignment further to asus_wmi_fan_init.

This is how it might look like in DSDT in this case:
Method (TMPR, 0, NotSerialized)
{
    Return (One)
}
..
If ((IIA0 == 0x00110011))
{
    Return ((TMPR () & 0xFFFF))
}

This is indeed the right method ID but it's nothing there.

Regards,
Yurii
