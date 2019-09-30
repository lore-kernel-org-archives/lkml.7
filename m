Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D433C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA53E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cixpPgmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfI3IWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:22:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53292 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726425AbfI3IWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569831755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OB4a4DU8FxkQuyLNjFZrUcXOBJkZw3SxcwXDPI6uKnI=;
        b=cixpPgmflyzsrT+vQ4lDcMsFj8mq/MKt+0YQnkoWMvGNMLqXE5AIe2Fl1NxNMNfBu1oQqc
        k4TtYhChMpW/19uNadP2rFcVg2//M39fNf9+zsdGUhJQpEhhcwpeqWZJi+ECvsSOxH6kCW
        gAaUbULUZ7OtjnWTOT5jKoK/QecXV2g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-VrHjIw2LPDak5taYXsPcmg-1; Mon, 30 Sep 2019 04:22:33 -0400
Received: by mail-ed1-f69.google.com with SMTP id 34so5800322edf.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 01:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FtSsOprUbHxPPZB9JS+/sPQLDrAgamZY39moikk7rIY=;
        b=qmO1649CNjVuH/zXgdILYKoi/5Wi3/qoqfL1TZFY8DIFXv5zG2Vdp+IjF0asFwiqak
         xYmP0QJe2T4+94ZlAU2bdNCtFFunoY+f98AXIrXGiZR9JtRcT2TaejZoSlHUYmIh/T2q
         eg1Z+VwzG3m4sgCM1QUS1T0lLBXDCbz6kmB1qaoMem9NjW45ddSNIkhyeMBuaRDDXepQ
         68NWHmEfnimDGBo5EkMDI1byGawkAoFODkMKcxJCEATr2+3WkXvCRFzu/bPQQYOcS5ZR
         QYsOzxxa9ERSioDgfR2qCSLqOnNsAbZv8C+jGC1mt/md1w/Zu7DywakD9KzfSoVFvrpC
         M8nQ==
X-Gm-Message-State: APjAAAUukk/DUaCbgf+vajBSTwljAOyD7NFWkMfu3ShbJwG+VM/bWPyb
        P90TmNzjpv+UK+RXeCZgqPqkYrSFYyCX4Qsz8ytbPSKvEx1gEpyWiAnnwqpDM1/VhoS5uvyW5Xf
        Hufup2aVGQPY9h4VhNyg0oJlU
X-Received: by 2002:aa7:c897:: with SMTP id p23mr18325397eds.199.1569831752191;
        Mon, 30 Sep 2019 01:22:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw86cFPiizinkZHr+F9ZnGV7u8wkgCwOhKZOul1R40hK3W0O5KlN39caDguQJGY8rFqL1h5yQ==
X-Received: by 2002:aa7:c897:: with SMTP id p23mr18325382eds.199.1569831752020;
        Mon, 30 Sep 2019 01:22:32 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id gs24sm1380129ejb.5.2019.09.30.01.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 01:22:31 -0700 (PDT)
Subject: Re: [PATCH] virt: vbox: fix memory leak in
 hgcm_call_preprocess_linaddr
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>, kjlu@umn.edu,
        Stephen McCamant <smccaman@umn.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190927230421.20837-1-navid.emamdoost@gmail.com>
 <3b5913e3-856a-db81-7708-929e62ee53d4@redhat.com>
 <CAEkB2ER7xVU3vzK4ohj7f9=b=ZpNx++dyNrtLhOieeDgyeVBDg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <664aab6a-37c9-7239-a817-25dfbab00c7f@redhat.com>
Date:   Mon, 30 Sep 2019 10:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAEkB2ER7xVU3vzK4ohj7f9=b=ZpNx++dyNrtLhOieeDgyeVBDg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: VrHjIw2LPDak5taYXsPcmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-09-2019 04:22, Navid Emamdoost wrote:
> It is a neat fix now, thank you.

Can you submit a new version of your patch with the fix I proposed please ?

Regards,

Hans


>=20
>=20
> On Sat, Sep 28, 2019 at 4:54 AM Hans de Goede <hdegoede@redhat.com> wrote=
:
>>
>> Hi,
>>
>> On 28-09-2019 01:04, Navid Emamdoost wrote:
>>> In hgcm_call_preprocess_linaddr memory is allocated for bounce_buf but
>>> is not released if copy_form_user fails. The release is added.
>>>
>>> Fixes: 579db9d45cb4 ("virt: Add vboxguest VMMDEV communication code")
>>>
>>> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>>
>> Thank you for catching this, I agree this is a bug, but I think we
>> can fix it in a cleaner way (see below).
>>
>>> ---
>>>    drivers/virt/vboxguest/vboxguest_utils.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vb=
oxguest/vboxguest_utils.c
>>> index 75fd140b02ff..7965885a50fa 100644
>>> --- a/drivers/virt/vboxguest/vboxguest_utils.c
>>> +++ b/drivers/virt/vboxguest/vboxguest_utils.c
>>> @@ -222,8 +222,10 @@ static int hgcm_call_preprocess_linaddr(
>>>
>>>        if (copy_in) {
>>>                ret =3D copy_from_user(bounce_buf, (void __user *)buf, l=
en);
>>> -             if (ret)
>>> +             if (ret) {
>>> +                     kvfree(bounce_buf);
>>>                        return -EFAULT;
>>> +             }
>>>        } else {
>>>                memset(bounce_buf, 0, len);
>>>        }
>>>
>>
>> First let me quote some more of the function, pre leak fix, for context:
>>
>>          bounce_buf =3D kvmalloc(len, GFP_KERNEL);
>>          if (!bounce_buf)
>>                  return -ENOMEM;
>>
>>          if (copy_in) {
>>                  ret =3D copy_from_user(bounce_buf, (void __user *)buf, =
len);
>>                  if (ret)
>>                          return -EFAULT;
>>          } else {
>>                  memset(bounce_buf, 0, len);
>>          }
>>
>>          *bounce_buf_ret =3D bounce_buf;
>>
>> This function gets called repeatedly by hgcm_call_preprocess(), and the
>> caller of hgcm_call_preprocess() already takes care of freeing the
>> bounce bufs both on a (later) error and on success:
>>
>>          ret =3D hgcm_call_preprocess(parms, parm_count, &bounce_bufs, &=
size);
>>          if (ret) {
>>                  /* Even on error bounce bufs may still have been alloca=
ted */
>>                  goto free_bounce_bufs;
>>          }
>>
>>          ...
>>
>> free_bounce_bufs:
>>          if (bounce_bufs) {
>>                  for (i =3D 0; i < parm_count; i++)
>>                          kvfree(bounce_bufs[i]);
>>                  kfree(bounce_bufs);
>>          }
>>
>> So we are already taking care of freeing bounce-bufs allocated for previ=
ous
>> parameters to the call (which me must do anyways), so a cleaner fix woul=
d
>> be to store the allocated bounce_buf in the bounce_bufs array before
>> doing the copy_from_user, then if copy_from_user fails it will be cleane=
d
>> up by the code at the free_bounce_bufs label.
>>
>> IOW I believe it is better to fix this by changing the part of
>> hgcm_call_preprocess_linaddr I quoted to:
>>
>>          bounce_buf =3D kvmalloc(len, GFP_KERNEL);
>>          if (!bounce_buf)
>>                  return -ENOMEM;
>>
>>          *bounce_buf_ret =3D bounce_buf;
>>
>>          if (copy_in) {
>>                  ret =3D copy_from_user(bounce_buf, (void __user *)buf, =
len);
>>                  if (ret)
>>                          return -EFAULT;
>>          } else {
>>                  memset(bounce_buf, 0, len);
>>          }
>>
>> This should also fix the leak in IMHO is a clear way of doing so.
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>
>=20
>=20

