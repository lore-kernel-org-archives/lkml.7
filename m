Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F20C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509782133F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfE1Ov1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:51:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53822 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfE1OvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:51:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id d17so3282933wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 07:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gJ89d8jYJUtYpuU3LsHEgG546l6uJgQ8GYRu1lYlx78=;
        b=BSUcHnqiH9P7KL/nQ6Tx1c5o9wHM239Q9R9FCwJdkLJPQKTPJAIi4FtSvDyyOCOftW
         jssU3ClMXDusjEkW8osp7yxOMskJISvD0M1VENRiBKsw4/IZe04aBUQUNKHFjOLTUKyN
         5pcPvUDfoS98jACj6P5ho1yCAIqwdAZvl3NFXiJmEkBdbVZSq+93iyZFyZdaDjGP3W/3
         5ogeWyKI6gXbVd0pQjWVxExIOcyyKs2YrPI8r9FO89GZulfc1WL2Mr4fxcNqcnWbUF1X
         DTLLGHQfz4FauCYUDOB3+xtT23srdALpfjYCYgImHS58WXaMoM5Qis/hPRYmmdmDH/Ri
         SZjQ==
X-Gm-Message-State: APjAAAVQKxYBFNsVyC0T0M+5c62NWtQr93PRwhURmHpl7RV9zCOauOxg
        AT2HiNfZJnTSBxPBGKSnjsEqE3Epn70=
X-Google-Smtp-Source: APXvYqzyz88Pw81oABGHZfhRZDQAk3eHLckbg5GBfUrvmrPEFUftrDcjuKbgYtb0+WcicblriWBWeg==
X-Received: by 2002:a1c:5f02:: with SMTP id t2mr3486436wmb.19.1559055083656;
        Tue, 28 May 2019 07:51:23 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a14sm155834wrs.22.2019.05.28.07.51.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 07:51:22 -0700 (PDT)
Subject: Re: [PATCH] vboxguest: check for private_data before trying to close
 it.
To:     Yang Xiao <92siuyang@gmail.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <1559047634-24397-1-git-send-email-92siuyang@gmail.com>
 <9c6d3fe3-4d7b-f105-62b5-f9d4221543fb@redhat.com>
 <CAKgHYH0kSkirQDTQh7iP0kJRUShTW4Q6b-+gPr-K2GcZFM6SgQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2d318813-3a0d-4866-3982-3d03c37480a7@redhat.com>
Date:   Tue, 28 May 2019 16:51:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKgHYH0kSkirQDTQh7iP0kJRUShTW4Q6b-+gPr-K2GcZFM6SgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28-05-19 16:49, Yang Xiao wrote:
> Based on your explanation, file->private_data can not be NULL before
> call vbg_core_close_session method all the time, since
> file->private_data is always set.
> Am I right?

Yes.

Regards,

Hans



> 
> On Tue, May 28, 2019 at 9:19 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 28-05-19 14:47, Young Xiao wrote:
>>> vbg_misc_device_close doesn't check that filp->private_data is non-NULL
>>> before trying to close_session, where vbg_core_close_session uses pointer
>>> session whithout checking, too. That can cause an oops in certain error
>>> conditions that can occur on open or lookup before the private_data is set.
>>>
>>> This vulnerability is similar to CVE-2011-1771.
>>
>> How is this in anyway related to CVE-2011-1771 ????
>>
>> That CVE is about a filesystems lookup method including a direct open
>> of the file for performance reasons and if that direct open fails, doing
>> a fput, which is how it ends up with a file with private_date being NULL,
>> see:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=703016
>>
>> "the problem is that CIFS doesn't do O_DIRECT at all, so when you try to open a file with it you get back -EINVAL. CIFS can also do open on lookup in some cases. In that case, fput will be called on the filp, which has not yet had its private_data set."
>>
>> The vboxguest code on the other hand is not a filessystem and as such
>> does not have a dentry lookup method at all!
>>
>> It's close method is part of the file_operations struct for a character
>> device using the misc_device framework which guarantees that private_data
>> is always set.
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>
>>>
>>> Signed-off-by: Young Xiao <92siuyang@gmail.com>
>>> ---
>>>    drivers/virt/vboxguest/vboxguest_linux.c | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
>>> index 6e8c0f1..b03c16f 100644
>>> --- a/drivers/virt/vboxguest/vboxguest_linux.c
>>> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
>>> @@ -88,8 +88,10 @@ static int vbg_misc_device_user_open(struct inode *inode, struct file *filp)
>>>     */
>>>    static int vbg_misc_device_close(struct inode *inode, struct file *filp)
>>>    {
>>> -     vbg_core_close_session(filp->private_data);
>>> -     filp->private_data = NULL;
>>> +     if (file->private_data != NULL) {
>>> +             vbg_core_close_session(filp->private_data);
>>> +             filp->private_data = NULL;
>>> +     }
>>>        return 0;
>>>    }
>>>
>>>
> 
> 
> 
