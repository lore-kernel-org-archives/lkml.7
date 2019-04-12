Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7412BC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2D72083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDLLIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:08:16 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59483 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:08:16 -0400
Received: from [192.168.178.52] ([109.104.50.142]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MCKSA-1h6cYe1kA6-009ROX; Fri, 12 Apr 2019 13:07:42 +0200
Subject: Re: [PATCH V5 3/3] hwmon: pwm-fan: Add RPM support via external
 interrupt
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1554989411-23666-1-git-send-email-stefan.wahren@i2se.com>
 <1554989411-23666-4-git-send-email-stefan.wahren@i2se.com>
 <20190411165742.GA29395@roeck-us.net>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <019733e8-6b12-f5c1-e251-fd7eabe2891b@i2se.com>
Date:   Fri, 12 Apr 2019 13:07:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411165742.GA29395@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:o0QXvLSdqXxmNy4CXgonbNSrTq6A3Sb13dDV4/PC6Q0OiIpX7by
 0mupAL1ECnulfZgJWZxC0Rz93jdnKUcIzoSOSeghywiNIBXlcS6m+Qr7LOJvhfm6bsMUVuW
 D+5a/euBkDlIxLx4K/fVPhqGhSsNZm7FRyWWcbv/8otk2ju2HBe41jju/sgdjBk5Z3DZP99
 xd7NCA2j/cOlXJ3DtmdBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0NyLlMniSkk=:dh39u8LoxPVa1laAJRMxKR
 w96x4AE3MfuH8b71fee0PMjQ0h2q58ZrK05Qvtk0ywm2opcO8/99PCjMoNN4DjII+0iBIJP1L
 ZVgHe2cTFQStAjcAfs/PsEiltn5BvCl4PpWsIb1lP+TyXW6M6b9t3x4iP8RAsdEXJQKbVJVlo
 lO8MeXtlmLZtieW3QeVR2WmP4H9qKfVGBGuKwVTzvN2uFnrx6ZUZzJf36mXgSv3QxRv3/Ohs/
 Zp7XlsS5vIOv7Q6b0xIAi5OcrxPSKRvQOEOlf5YXwXO0tw9F1r3zM0COWlr2yJdGB0t7j5YUe
 OwIBbdq5HGkEg78VO5LD/vJ7LwM2W1Uk2vq2ORvoEqqQh8LC8eP4B8xDFJoGJ5MRzGk/IoQ2Y
 m6UP/0fXYEkDqBaozj3G7rIz/r7/mXE2XW5d3sryAc7RhLktmspimKwfzRYIZoA7AFnK3Pd85
 BSjNsh06uRgm4RngJqaFZyFIMWXbOd0kLIKSGs662Qog+1iRYeZU6Lwa4/wRgodJeekxDByZt
 +iZjvCaVA4ZACsg6s8s0tD/5g3qgweFeo1d3BJ0d79YUfe4busXvrSjzDCbWHWu5GcRgdMBtq
 3qINp1pgHqPobg1YHy46XSfcZp4njWL3rJ4H89xz5nMqXI1wmXDyMeGq/pg5FIsYErwMZKhZd
 FMXZkObL9+hKbyAJM5HGhVL5WE79EdxmnjkawnqTHxXeLg2hpUdD0e8QFPp2xCgd0V9ZIopIa
 SBNuhTSRKjG0dyVRetMrZapJcXGt/GXzgUS+aKy6lk3GGoLLZq2RiZnZvFk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.04.19 18:57, Guenter Roeck wrote:
> On Thu, Apr 11, 2019 at 03:30:11PM +0200, Stefan Wahren wrote:
>>  
>> -ATTRIBUTE_GROUPS(pwm_fan);
>> +static umode_t pwm_fan_attrs_visible(struct kobject *kobj, struct attribute *a,
>> +				     int n)
>> +{
>> +	struct device *dev = container_of(kobj, struct device, kobj);
>> +	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
>> +	struct device_attribute *devattr;
>> +
>> +	/* Hide fan_input in case no interrupt is available  */
>> +	devattr = container_of(a, struct device_attribute, attr);
> Field day for static analyzers - devattr is no longer used.
> No need to resend. I'll let the series rest for a couple of days
> and then apply to hwmon-next (after removing devattr) unless there are
> additional comments.
>
Thank you

Stefan

