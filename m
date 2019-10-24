Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327FECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0085320684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFpNo7lC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438037AbfJXIJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:09:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37796 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725977AbfJXIJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571904588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BeX4D8O9z+tVBCKqcGZcr5ign6JXERCJLYcp/HFmwQY=;
        b=MFpNo7lCPKb5Aelw1esoIagJycn7Strxg/cg+0MqFNo/V9uW5FKGekXdylE3I7ZvBy56J+
        E8C4jDAMVxz4Pkw/4RHfwHmm0N1kHZ25QbBfuXgugBq/Xcq19Fcv0Sp8jcvVyH9t/gvUW9
        Jb+D54kgEpvm/Dgk2qGL0aPOYs5hZcU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-cr7EmkoTMfCbqea0fLtTPw-1; Thu, 24 Oct 2019 04:09:44 -0400
Received: by mail-wm1-f69.google.com with SMTP id q22so805228wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 01:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F8182UJbr670CLsPagPoudZb9pdwLWvpPAyPH6nj5ZE=;
        b=miurvVlDdmN0YaL7DgQPFbc3oK8uND38fUmAIKyWfr22cVV1OBfCglni+/jj9L8dTo
         1Q1RLbMN6ZMRJawcnMrudb1FpuUNTwANGEPqfjZ2X2NKi6Rqn66TfvVV+NCTEA4vA4Zq
         DL/UxGzSQZioPbxXJxG3oGt2HzOvEJK79qAGJxGnf27U0hmtisD2oLUk8cutaC8xwgrV
         9Uz1Td6xBJh+tzmQ9Bc79hw654d4lJzfPlAYkvRjg4kYTQHNGtdGjlp+3AQbj5qUjk7y
         qDGQjINBOzNQ41QOCJBH31sZlqA61rhZEJl8nX7TcMf0MAe5rF8cThE99xCpTFBSx+GI
         iygg==
X-Gm-Message-State: APjAAAVco7b0knyKUr/FFTJNjjun+Narp5CwzosmQ7jmqHMqstcSIXyi
        NLDmJW0WmvKFqKQml1DIamLxiaWxVUXxBAzBSILw4jnG5zgYuD6jKuza+F0TfEIb1wc1PbSSd6A
        YM/LWIvlyvqdOwMonb8DTTW/h
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr2392139wrv.99.1571904583094;
        Thu, 24 Oct 2019 01:09:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyKZOyZYyIUZdVQo/tZ2TZK5072qWStDiP0lwOfbyMiILgwgIpJZBlmoNkgpPMnERM/NoB8nQ==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr2392118wrv.99.1571904582820;
        Thu, 24 Oct 2019 01:09:42 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id w22sm1557244wmc.16.2019.10.24.01.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 01:09:42 -0700 (PDT)
Subject: Re: [PATCH resend] Add touchscreen platform data for the Schneider
 SCT101CTM tablet
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Gorbea Ainz <danielgorbea@hotmail.com>
References: <20191023185323.13552-1-hdegoede@redhat.com>
 <CAHp75VfhKzXfJEwHLdkwJHPXmL6bCRMtvo-0aCSQxdiHQyXHHQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1274f8b7-234b-1af4-0715-b47018d96946@redhat.com>
Date:   Thu, 24 Oct 2019 10:09:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfhKzXfJEwHLdkwJHPXmL6bCRMtvo-0aCSQxdiHQyXHHQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: cr7EmkoTMfCbqea0fLtTPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23-10-2019 21:08, Andy Shevchenko wrote:
> On Wed, Oct 23, 2019 at 9:53 PM Hans de Goede <hdegoede@redhat.com> wrote=
:
>>
>> From: Daniel Gorbea Ainz <danielgorbea@hotmail.com>
>>
>> Add touchscreen platform data for the Schneider SCT101CTM tablet
>=20
> Thanks, now patchwork sees it.
>=20
>> Signed-off-by: Daniel Gorbea <danielgorbea@hotmail.com>
>=20
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> I'm not sure you need to put Rb when you have your SoB.
> Do you think it's fine if I remove Rb when applying?

I believe having a r-b here is fine, but if you want to remove
it that is fine with me too.

Regards,

Hans




>=20
>> ---
>> hdegoede: Resend from my email address as vger.kernel.org does not like
>> Daniel's emails
>> ---
>>   drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x=
86/touchscreen_dmi.c
>> index 8bfef880e216..ba494ace83d4 100644
>> --- a/drivers/platform/x86/touchscreen_dmi.c
>> +++ b/drivers/platform/x86/touchscreen_dmi.c
>> @@ -549,6 +549,24 @@ static const struct ts_dmi_data pov_mobii_wintab_p1=
006w_v10_data =3D {
>>          .properties     =3D pov_mobii_wintab_p1006w_v10_props,
>>   };
>>
>> +static const struct property_entry schneider_sct101ctm_props[] =3D {
>> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1715),
>> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
>> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
>> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
>> +       PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>> +       PROPERTY_ENTRY_STRING("firmware-name",
>> +                             "gsl1680-schneider-sct101ctm.fw"),
>> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
>> +       { }
>> +};
>> +
>> +static const struct ts_dmi_data schneider_sct101ctm_data =3D {
>> +       .acpi_name      =3D "MSSL1680:00",
>> +       .properties     =3D schneider_sct101ctm_props,
>> +};
>> +
>>   static const struct property_entry teclast_x3_plus_props[] =3D {
>>          PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
>>          PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
>> @@ -968,6 +986,14 @@ const struct dmi_system_id touchscreen_dmi_table[] =
=3D {
>>                          DMI_EXACT_MATCH(DMI_BOARD_NAME, "0E57"),
>>                  },
>>          },
>> +       {
>> +               /* Schneider SCT101CTM */
>> +               .driver_data =3D (void *)&schneider_sct101ctm_data,
>> +               .matches =3D {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "Default string"),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "SCT101CTM"),
>> +               },
>> +       },
>>          {
>>                  /* Teclast X3 Plus */
>>                  .driver_data =3D (void *)&teclast_x3_plus_data,
>> --
>> 2.23.0
>>
>=20
>=20

