Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C1C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17706205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+56grgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgAHNF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:05:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37891 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726672AbgAHNF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578488756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZyNWhxAqEND9gNENO394kM2pqYdc/AHJLcS0vI9DMM=;
        b=Q+56grgFxCcfU+cRkVdjqvNf1BNphlwyAeui8zD0TACff6GaHVhA11MQBEwCThWkwAVEio
        +W6RlLmEB3mt73uD9FHWKyxLPlFBnGgaFXN2rJhoCJjstZYe/3kI3FFhwLyp4dqPHzvPRs
        NjJgK+ggNgH0lBuLnJPG+qwRhGfQ9ko=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-QJvIkcA7NJyajWcTdVOBAA-1; Wed, 08 Jan 2020 08:05:53 -0500
X-MC-Unique: QJvIkcA7NJyajWcTdVOBAA-1
Received: by mail-wm1-f70.google.com with SMTP id o24so387470wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 05:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ZyNWhxAqEND9gNENO394kM2pqYdc/AHJLcS0vI9DMM=;
        b=DLE1stTuldlUcpjzA4LpRMyyjUwnx/ZOCKMdP7q+R226Rdy5wwgfe8r7tte5w8dJnD
         X3WHxgZH9bThhhM/oi2h8KyvRxJCbICWiacYfF4u+qe5bdvebHxwK4tkBMmxsBxVn1WW
         UmPC1JXxY1xG4w8sLo/2LUYTv+vWTtd/CKfpCQW1Ggq01NG/KiDoln9XRbDxKPKvuJ9f
         HoX6a1ODwjyKM9mm6U2MpgEnMINn3IfWo9PTLv/7T13m2gBTNoCM2a7NyPTWvaj87HnR
         FBGZ1WWJn+GioTlHV+LWyRF3VeEXYfhkLs6OnvLN/reG/sVaZM+tKlBiOJu+MWwOfTbq
         cqqA==
X-Gm-Message-State: APjAAAVO9A46NsJ+kTu4zP3t99708gggzP+2nIVDif1EDjYEDRhSdkf+
        5Cktkdw/Wxv2gfmXnHtN7odsdXJeFsuoh4g4Not21wBI6dm0zDmQj+Gzq5D783vsPj87cJus0Yd
        hDrfiK8J82UTrSUYLj+KKGuP1
X-Received: by 2002:adf:9104:: with SMTP id j4mr4487912wrj.221.1578488752746;
        Wed, 08 Jan 2020 05:05:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwt6raJ7XXDO0y1F3AZXYQAKrwGE7wlqeRaiMVFND1I9TfQEzmcWJEIWeRKIEM6yMULuh+dcQ==
X-Received: by 2002:adf:9104:: with SMTP id j4mr4487891wrj.221.1578488752529;
        Wed, 08 Jan 2020 05:05:52 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id g9sm4245246wro.67.2020.01.08.05.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 05:05:50 -0800 (PST)
Subject: Re: [PATCH 2/2] platform/x86: GPD pocket fan: Allow somewhat
 lower/higher temperature limits
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Anderson <jasona.594@gmail.com>
References: <20200106144219.525215-1-hdegoede@redhat.com>
 <20200106144219.525215-2-hdegoede@redhat.com>
 <CAHp75Ve5XF-UZw6D-OUCkgOPMYH0DgT1L5uVNGRuLmZ6Cjd1KA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2df70a79-10e1-ea9e-0425-dcc46c1e28bc@redhat.com>
Date:   Wed, 8 Jan 2020 14:05:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve5XF-UZw6D-OUCkgOPMYH0DgT1L5uVNGRuLmZ6Cjd1KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08-01-2020 13:23, Andy Shevchenko wrote:
> On Mon, Jan 6, 2020 at 4:42 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Allow the user to configure the fan to turn on / speed-up at lower
>> thresholds then before (20 degrees Celcius as minimum instead of 40) and
>> likewise also allow the user to delay the fan speeding-up till the
>> temperature hits 90 degrees Celcius (was 70).
>>
>> Cc: Jason Anderson <jasona.594@gmail.com>
> 
>> Reported-by: Jason Anderson <jasona.594@gmail.com>
> 
> My understanding of this tag that the report assumes a bug to fix
> followed up with a corresponding Fixes tag.

Well in a way the old min/max for the limits being to strict a bug
and Jason pointed this out so I want to give him credit for that.

OTHO Fixes: feels a little bit to strong, even without a Cc: stable
tag, commits with Fixes: in there are almost guaranteed to be picked
up for the stable series and in this case that seems unnecessary to me.

If you do want to add a Fixes: tag then adding the one from patch 1/2
makes the most sense.

Regards,

Hans



> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/platform/x86/gpd-pocket-fan.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/gpd-pocket-fan.c b/drivers/platform/x86/gpd-pocket-fan.c
>> index 1e6a42f2ea8a..0ffcbf9bc18e 100644
>> --- a/drivers/platform/x86/gpd-pocket-fan.c
>> +++ b/drivers/platform/x86/gpd-pocket-fan.c
>> @@ -126,7 +126,7 @@ static int gpd_pocket_fan_probe(struct platform_device *pdev)
>>          int i;
>>
>>          for (i = 0; i < ARRAY_SIZE(temp_limits); i++) {
>> -               if (temp_limits[i] < 40000 || temp_limits[i] > 70000) {
>> +               if (temp_limits[i] < 20000 || temp_limits[i] > 90000) {
>>                          dev_err(&pdev->dev, "Invalid temp-limit %d (must be between 40000 and 70000)\n",
>>                                  temp_limits[i]);
>>                          temp_limits[0] = TEMP_LIMIT0_DEFAULT;
>> --
>> 2.24.1
>>
> 
> 

