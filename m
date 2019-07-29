Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E49C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1594C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbfG2Ptr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:49:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36536 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387461AbfG2Ptr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:49:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so62485105wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r1zF/Xvf5xstuaSmuvOpiw5SBlzxXv+2sIQrb0XvTxI=;
        b=Y8WlkZYe0pMA5IRA3skWWFgS1MQW84PUyx3WbRJ1wvO9h9pSF/76PJ8QLsKSjPE5s5
         ig5wBotqnh3aSnU2+bs4YPTwAFJ8mLrqjHyDi4vAM+NDqrc19GTH8vIv6ykkR4CBZAPZ
         j0z0LyjlwomHeEc5d+ML21ibbs5rcx/wshr7wwwGwXEchyDkUX0sLO3YwQ2bCj/Y6A4C
         ui3Dl0KtBD7ZC63udXh+YYibIfB9qGbNzRbjaJhbDUdeAhMRmlPUvYh+BpX/mAdJvwrf
         Axd1d+qfkr3tjiV5CFXXIqYdcNtH7BVKo8FsPC1uUr/dzkQII98Aronoa3OhHBZYGEBg
         2WZw==
X-Gm-Message-State: APjAAAVuO/0NtLu1XZDoJl6aiMpRivmr8dB8Pyf60lXZPThyAAfHeY+y
        sr5ENZrsj89r6eP2P9+XioUOKA==
X-Google-Smtp-Source: APXvYqwG1kkdqyheJ5L/2tF9vxiXysI2Qf0EqMWIGET334y6sf3M1167NNNxYUgurF+LYlcv+lW2ng==
X-Received: by 2002:a5d:428b:: with SMTP id k11mr87739246wrq.174.1564415385095;
        Mon, 29 Jul 2019 08:49:45 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id r14sm54428995wrx.57.2019.07.29.08.49.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 08:49:44 -0700 (PDT)
Subject: Re: [Regression] 5.3-rc1: hid_llogitech_dj does not work
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
References: <CAHk-=wjm7FQxdF=RKa8Xe23CLNNpbGDOACewgo8e-hwDJ8TyQg@mail.gmail.com>
 <2480108.bWkXKoXas6@kreacher>
 <1dddedba-ca02-1014-36e0-ba4e3631f28b@redhat.com>
Message-ID: <5036172e-1fa9-d038-4473-b4f257764b78@redhat.com>
Date:   Mon, 29 Jul 2019 17:49:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1dddedba-ca02-1014-36e0-ba4e3631f28b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 25-07-19 17:50, Hans de Goede wrote:
> Hi Rafael,
> 
> On 25-07-19 12:07, Rafael J. Wysocki wrote:
>> Hi Hans,
>>
>> This is similar to a problem I reported some time ago:
>>
>> https://lore.kernel.org/lkml/2268131.Lc39eCoc3j@kreacher/
>>
>> and the device affected by it is the same.
>>
>> The symptom is simply that the mouse just doesn't work (no reaction).  If I do
>> "rmmod hid_llogitech_dj", it says "Killed", but the module does go away and
>> the mouse starts to work (through the generic code I suppose), but then
>> the machine hangs on attempts to suspend (nasty).
>>
>> Reverting all of the hid_llogitech_dj changes between 5.2 and 5.3-rc1:
>>
>> dbcbabf7da92 HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices
>> 39d21e7e0043 HID: logitech-dj: make const array template static
>> 423dfbc362b7 HID: logitech-dj: Add usb-id for the 27MHz MX3000 receiver
>>
>> helps here, but the first two don't really look like they can make any difference,
>> so I guess I'm an unlucky owner of a MX3000 that doesn't quite work as expected.
>>
>> Any help will be appreciated. :-)
> 
> Actually we received another bug report about this and the reporter there
> has come up with a patch with points to
> 
> dbcbabf7da92 HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices
> 
> Being the culprit, can you try just reverting that one?
> 
> I will take a closer look at this soonish.

Thank you for reporting this.

After upgrading to 5.3-rc2 I can reproduce this myself and the dbcbabf7da92 commit
indeed is the culprit. I've prepared a fix for this which I'm about to submit upstream.

I've put you in the Cc of the fix.

Regards,

Hans
