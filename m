Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2592BC32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AEF20818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfHFT1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:27:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37103 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfHFT1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:27:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so83418404eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 12:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1LHxYcL996sKOby6eEjWVTx69NkSzcDYDpH2jDk93e8=;
        b=FbpTwkK+1aaNQGsBgKzggxWlpZSMIZX6GAoAh35kWDuoByRzfW/+uwrru1Hxw+uCKp
         qcOnUQA7uBI9k9mP9Cr5H0vCnpQ/p7WI4Sq5RVDkylefeBhcVK7mV327XM5aZJ2MhkhS
         R50kOesydOxxqk45pEYi8MbX9gzeP+u7LCtUsQKAlLc57H/eqkW4+omgCjOEuVS1e+RD
         YmAOB9Yf5Ntam6RBILywT2grDJjUMERAcBS0MifYNWPUrtMpdYQjK8WduONE5iVTJ16C
         75JuvW1hGe5Z47WGumnJgLjY3VLeY8hlzan50M6hIjv5O6S3u+4s0RT6lSCT+4ZcV9ud
         vLYA==
X-Gm-Message-State: APjAAAUhF3ZAwqVEQbXPNDSU4OQqbIfGF1dsYxUMgzYpfy55h/W2rGII
        rD5qkRh8tQYfGAmjEIIAJ7K5LQ==
X-Google-Smtp-Source: APXvYqz/Tszk0I/Ku+EjS80ijEzX6q7wYNUEgtRBwizetzwIBl+06H1dvevfmqcRDGWBdASl7Q6VeQ==
X-Received: by 2002:a50:b875:: with SMTP id k50mr5715639ede.232.1565119640579;
        Tue, 06 Aug 2019 12:27:20 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w27sm21228102edw.63.2019.08.06.12.27.19
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 12:27:19 -0700 (PDT)
Subject: Re: 5.3 boot regression caused by 5.3 TPM changes
To:     Chris Coulson <chris.coulson@canonical.com>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org
References: <b20dd437-790a-aad9-0515-061751d46e53@redhat.com>
 <0d5bbfe6-a95e-987e-b436-83f754d044ac@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4df2fd32-4b64-4cba-4211-d1008ec01da4@redhat.com>
Date:   Tue, 6 Aug 2019 21:27:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0d5bbfe6-a95e-987e-b436-83f754d044ac@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-08-19 17:53, Chris Coulson wrote:
> Hi,
> 
> On 04/08/2019 11:00, Hans de Goede wrote:
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
>> Active PCR banks:           SHA-1         (read only)
>> Available PCR banks:        SHA-1,SHA256  (read only)
>> TPM2.0 UEFI SPEC version:   TCG_2         (other possible setting: TCG_1_2
>> Physical Presence SPEC ver: 1.2           (other possible setting: 1.3)
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
>> Regards,
>>
>> Hans
> Do you think this might be the same issue as https://marc.info/?l=linux-integrity&m=155968949020639 <https://marc.info/?l=linux-integrity&m=155968949020639&w=2>?

I was hoping it would be the same issue, so I tested a 5.3 kernel
with that patch added, but unfortunately it still crashes on
the Irbis TW90.

Regards,

Hans

