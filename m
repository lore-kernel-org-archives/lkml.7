Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBB1C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7802067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfDYS3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:29:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49271 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfDYS3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:29:19 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hJj7V-0004FM-0u
        for linux-kernel@vger.kernel.org; Thu, 25 Apr 2019 18:29:17 +0000
Received: by mail-pl1-f198.google.com with SMTP id s22so293863plq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jrt+trXrJhr7fLR86aQx6vvMRFfaqHQu3rE7dA4mLUQ=;
        b=riTYz0AQ3oq43TWaYarhyox37qSr9zL5n8J3hDyOb4WEpCIO271AvKUzu5NVl2JZVJ
         HB/1NF4Lyt4FINXA8JfOTM8vXwtPFYe1hPgNZR5dluYMUe3RC/SW2RPkNcRFV6m4rC2m
         Ka9cV/rlFar64Rpz4IB9D4G2qyO3/VpP5waN17DoiEVIZ+/qwq23vVN282/lC8eXj1Cp
         bnHLhXhTCMt5fkfZ6LbE97XtXIlR3f2LKh2kqte/ZpsMB+kL165CJ6Ke49CAKCq8PAc/
         LPHj0TvAPZpagb+cSCI1BrkHxPcynYGtZfCOwm3rCTAnSC0tkGJcOEfYciQ2b/vSYDlI
         Y9ew==
X-Gm-Message-State: APjAAAWA2voZHVa42QK4peQFTGZi2Ncj0sqovnbzf4w/ceoFOgWv8mFj
        n49XKUPCY+RGhC60nyVUCizvLKayXseXpgGv8Vt4FVcpBAnk3PbastDqotU6Yb0jRXhS3e9QfPO
        049Ufrjbd/b4U6CE9jlYqcZ/U6cOhy8qksm2ZeZIoSA==
X-Received: by 2002:a17:902:2927:: with SMTP id g36mr39037807plb.6.1556216955706;
        Thu, 25 Apr 2019 11:29:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxn4zIp2v9w/b4br5bx9kX1bPPMwxol6I/8qBNWMGkguzRhYUeD3zb6fcNe8aXiw89Y6S1mGw==
X-Received: by 2002:a17:902:2927:: with SMTP id g36mr39037763plb.6.1556216955147;
        Thu, 25 Apr 2019 11:29:15 -0700 (PDT)
Received: from 2001-b011-380f-14b9-485f-68f1-af5a-cffb.dynamic-ip6.hinet.net (2001-b011-380f-14b9-485f-68f1-af5a-cffb.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:485f:68f1:af5a:cffb])
        by smtp.gmail.com with ESMTPSA id d129sm44188018pfa.142.2019.04.25.11.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 11:29:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] HID: Increase maximum report size allowed by
 hid_field_extract()
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJLDuMZuqKiawnkq3YxL6T9SqNGqQ1Q_Vs=kMKmsx6SD0w@mail.gmail.com>
Date:   Fri, 26 Apr 2019 02:29:11 +0800
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>
Content-Transfer-Encoding: 8bit
Message-Id: <08CA35F5-1ADC-4C55-ACF5-04B19CC77A25@canonical.com>
References: <20190308051117.21899-1-kai.heng.feng@canonical.com>
 <CAO-hwJLDuMZuqKiawnkq3YxL6T9SqNGqQ1Q_Vs=kMKmsx6SD0w@mail.gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 17:42, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:

> Hi,
>
>
> On Fri, Mar 8, 2019 at 6:11 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> Commit 71f6fa90a353 ("HID: increase maximum global item tag report size
>> to 256") increases the max report size from 128 to 256.
>>
>> We also need to update the report size in hid_field_extract() otherwise
>> it complains and truncates now valid report size:
>> [ 406.165461] hid-sensor-hub 001F:8086:22D8.0002: hid_field_extract()  
>> called with n (192) > 32! (kworker/5:1)
>>
>> BugLink: https://bugs.launchpad.net/bugs/1818547
>> Fixes: 71f6fa90a353 ("HID: increase maximum global item tag report size  
>> to 256")
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/hid/hid-core.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 9993b692598f..860e21ec6a49 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1301,10 +1301,10 @@ static u32 __extract(u8 *report, unsigned  
>> offset, int n)
>>  u32 hid_field_extract(const struct hid_device *hid, u8 *report,
>>                         unsigned offset, unsigned n)
>
> Ronald (Cc-ed) raised quite a good point:
> what's the benefit of removing the error message if this function (and
> __extract) can only report an unsigned 32 bits value?

I didn’t spot this, sorry.

>
> My take is we should revert 94a9992f7dbdfb28976b upstream and think at
> a better solution.

I think using a new fix to replace it will be a better approach, as it at  
least partially solves the issue.

Kai-Heng

>
> Cheers,
> Benjamin
>
>> {
>> -       if (n > 32) {
>> -               hid_warn(hid, "hid_field_extract() called with n (%d) >  
>> 32! (%s)\n",
>> +       if (n > 256) {
>> +               hid_warn(hid, "hid_field_extract() called with n (%d) >  
>> 256! (%s)\n",
>>                          n, current->comm);
>> -               n = 32;
>> +               n = 256;
>>         }
>>
>>         return __extract(report, offset, n);
>> —

>> 2.17.1

