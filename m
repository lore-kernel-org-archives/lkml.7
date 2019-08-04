Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C2CC19759
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 16:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FDA2070D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 16:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfHDQMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 12:12:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37189 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfHDQMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 12:12:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so70779888wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 09:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VanA4arzx1pKLCBPTthhxDPqngslBUn68r1ZMhO+zus=;
        b=nBYRCb07v2g8r5lJYp713hYfnDzaZ/bjXBzbDx1MnscfQHbATsmhOEkaDfskJcuD0w
         Vo/ukUZwMVC9bQA3oCgW7pobFGIsy5iFlaYRcCkN3T63yWBmtei36mMAmIcwZayEvajZ
         7hP4ghVoQecc6czdZSKpJFaAY9aaJcFSNRUTFZJNVV65+qGc9vhJm+iEMNo5Thk0Dpxi
         AjTVEyrteQ170taMKKevdzNJlF0K42UKUxP574V9ZKVUlDdHPDS9t1rWqaG+YnuA1RCC
         afIpAYod+qXszIVCRoTxDzxO/ikFpQvM0elFQc8rzm0wVL1FHQp5MRKL8MISA43+HEus
         vVoQ==
X-Gm-Message-State: APjAAAXEp7xRxDc5FFBjlRVb9z9+Iiz3eta+UavkV4IosOzqGWGoMDJs
        2tvYHnCXHEoK55yeDmVf8XfWgA==
X-Google-Smtp-Source: APXvYqyui6X2NxaOd0H8eIaOJhvyabkDxZbqr3kyLDs9QTwtaV3BSwC3mF1xdmSMEORCyA02T/5PyA==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr14240302wma.120.1564935154008;
        Sun, 04 Aug 2019 09:12:34 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c7sm74215923wro.70.2019.08.04.09.12.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 09:12:33 -0700 (PDT)
Subject: Re: 5.3 boot regression caused by 5.3 TPM changes
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <b20dd437-790a-aad9-0515-061751d46e53@redhat.com>
 <CAKv+Gu8p47SHEtTHQu_3agQJDH2yYjQJ5xUvE+oTiLaY=sZdUA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ff73efc3-1951-2982-3ddf-e77005c5fddb@redhat.com>
Date:   Sun, 4 Aug 2019 18:12:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8p47SHEtTHQu_3agQJDH2yYjQJ5xUvE+oTiLaY=sZdUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04-08-19 17:33, Ard Biesheuvel wrote:
> Hi Hans,
> 
> On Sun, 4 Aug 2019 at 13:00, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> While testing 5.3-rc2 on an Irbis TW90 Intel Cherry Trail based
>> tablet I noticed that it does not boot on this device.
>>
>> A git bisect points to commit 166a2809d65b ("tpm: Don't duplicate
>> events from the final event log in the TCG2 log")
>>
>> And I can confirm that reverting just that single commit makes
>> the TW90 boot again.
>>
>> This machine uses AptIO firmware with base component versions
>> of: UEFI 2.4 PI 1.3. I've tried to reproduce the problem on
>> a Teclast X80 Pro which is also CHT based and also uses AptIO
>> firmware with the same base components. But it does not reproduce
>> there. Neither does the problem reproduce on a CHT tablet using
>> InsideH20 based firmware.
>>
>> Note that these devices have a software/firmware TPM-2.0
>> implementation, they do not have an actual TPM chip.
>>
>> Comparing TPM firmware setting between the 2 AptIO based
>> tablets the settings are identical, but the troublesome
>> TW90 does have some more setting then the X80, it has
>> the following settings which are not shown on the X80:
>>
>> Active PCR banks:           SHA-1         (read only)
>> Available PCR banks:        SHA-1,SHA256  (read only)
>> TPM2.0 UEFI SPEC version:   TCG_2         (other possible setting: TCG_1_2
>> Physical Presence SPEC ver: 1.2           (other possible setting: 1.3)
>>
>> I have the feeling that at least the first 2 indicate that
>> the previous win10 installation has actually used the
>> TPM, where as on the X80 the TPM is uninitialized.
>> Note this is just a hunch I could be completely wrong.
>>
>> I would be happy to run any commands to try and debug this
>> or to build a kernel with some patches to gather more info.
>>
>> Note any kernel patches to printk some debug stuff need
>> to be based on 5.3 with 166a2809d65b reverted, without that
>> reverted the device will not boot, and thus I cannot collect
>> logs without it reverted.
>>
> 
> Are you booting a 64-bit kernel on 32-bit firmware?

Yes you are right, I must say that this is somewhat surprising
most Cherry Trail devices do use 64 bit firmware (where as Bay Trail
typically uses 32 bit). But I just checked efibootmgr output and it
says it is booting: \EFI\FEDORA\SHIMIA32.EFI so yeah 32 bit firmware.

Recent Fedora releases take care of this so seamlessly I did not
even realize...

Regards,

Hans
