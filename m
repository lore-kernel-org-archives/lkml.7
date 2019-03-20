Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E63AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2531C2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfCTTxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:53:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36560 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTTxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:53:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so4174179wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FjmXI3kqtrk6lZK1MyhOQEA1PPTngSnN9tCHDw4gYiw=;
        b=C0eXzQk3zpcMaJRxvEuyHT/KDKRGz+qK9htlAKhCGznuXxmOU0ne3kda2cxfieaJfo
         l2lTnWxVTPf3LlsMPvxdCcSHhTl+o+9rZTzcUSRQLiYqyz258Dj6P79UX8DxBsU5oeTl
         ZuzncnNMHNtz/1wn6UvnmyVjCBi50n5lP7VD7qXESbeeqO+e6LhILC+EEdY95gvlnR/T
         gFtWMt4+7Xa+8bZLeilJEEJw8uKmB9lXtXTXCzBD8N4cCrb+8rEfaSO/bfHp8Tu+l+PK
         BpddssSvG/qFpFp1fWCIrw0zwORswFmacBjUHRU7jRtuMFUxWHSfVf7zzq3Hsen9kdCY
         tFtQ==
X-Gm-Message-State: APjAAAWV73oCTCQ1Tb6n9dSDMlM67ywFsckPi0Z9aVgV/i2Zw6ZW0E0q
        d4R9DGaTi5/z1aCUi+O7WROeig==
X-Google-Smtp-Source: APXvYqw/RpT0tv3uh0oW87rpgmk1MdKi3/cL4EPPYl8e4QRjXip6Eysfdv9+FiCS5Zm00qgadc7fOg==
X-Received: by 2002:a5d:638d:: with SMTP id p13mr6501wru.202.1553111578813;
        Wed, 20 Mar 2019 12:52:58 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a204sm3773553wmf.12.2019.03.20.12.52.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:52:58 -0700 (PDT)
Subject: Re: [PATCH] virt: vbox: Implement passing requestor info to the host
 for VirtualBox 6.0.x
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Thayer <michael.thayer@oracle.com>,
        "Knut St . Osmundsen" <knut.osmundsen@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20190320093519.26029-1-hdegoede@redhat.com>
 <20190320094601.GA30735@kroah.com>
 <29c6e212-6233-364f-5a90-564f91bca989@redhat.com>
 <20190320181934.GA3907@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <20db92db-7a6f-756d-4b31-a764d192d265@redhat.com>
Date:   Wed, 20 Mar 2019 20:52:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320181934.GA3907@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-03-19 19:19, Greg Kroah-Hartman wrote:
> On Wed, Mar 20, 2019 at 10:52:05AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 20-03-19 10:46, Greg Kroah-Hartman wrote:
>>> On Wed, Mar 20, 2019 at 10:35:19AM +0100, Hans de Goede wrote:
>>>> VirtualBox 6.0.x has a new feature where the guest kernel driver passes
>>>> info about the origin of the request (e.g. userspace or kernelspace) to
>>>> the hypervisor.
>>>>
>>>> If we do not pass this information then when running the 6.0.x userspace
>>>> guest-additions tools on a 6.0.x host, some requests will get denied
>>>> with a VERR_VERSION_MISMATCH error, breaking vboxservice.service and
>>>> the mounting of shared folders marked to be auto-mounted.
>>>>
>>>> This commit implements passing the requestor info to the host, fixing this.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>
>>> This feels like support for a "new feature", so why would this need to
>>> go to older kernels?
>>>
>>> It's not our fault that vb implemented a non-backwards-compatible change
>>> for their new release, right?  So why should we be forced to add new
>>> features to stable kernels?
>>
>>  From a technical point of view I completely agree with you and I'm unhappy
>> with this breakage after vb agreed with me to keep ABI compatibility so
>> that we could add a version of the vboxguest driver to the mainline kernel.
> 
> So they broke that agreement, ugh.  That implies they will do it again?

Well they did not really broke the ABI, they started using a reserved
field and a 6.0.x host will happily work with 5.2.x guest-extensions
(with the mainline vboxguest driver) the same way around, 5.2.x host
als works with 6.0.x guest-extensions user-space bits + mainline kernel
module.

Things break when using a 6.0.x host + 6.0.x guest-extensions userspace
parts combined with the mainline kernel module. The 6.0.x + 6.0.x combi
seems to assume that there is a 6.0.x vboxguest driver which fills in
the reserved field. I believe this is an oversight and not a deliberate
breakage. Perhaps this is even something which the VirtualBox devs can
fix in a future 6.0.x update...  Michael ?

>> OTOH this is going to bite users out there, which is why I added the Cc:
>> stable. But this is entirely your call.
> 
> Let me think about it...
> 
>>> I have no problem to add this for 5.2, but not for older stuff.
>>
>> Can we at least at it as a fix to 5.1 ? It is not very adventurous.
> 
> Sure, let me go review it now.

Thank you for the review, I will reply to it tomorrow (and prep a v2).

Regards,

Hans

