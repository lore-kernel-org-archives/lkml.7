Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBA3C433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 10:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF6F2085B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 10:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfHDKAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 06:00:37 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44980 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfHDKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 06:00:36 -0400
Received: by mail-ed1-f54.google.com with SMTP id k8so76068417edr.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 03:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=g8BNhH388Zl1p3dVfMhGaT2LfsXGUWfNYbaxd1kMPnI=;
        b=DyRcswS/IdN4drQhFzBgtOvQqb7wmuS0ufKDpq3xhzQzMQmp1s7tWy+aFXYywo7Pff
         zEqtULgwzvOqqCkIQ1PllR5+NBB/MBORIi51r+85DFaGu4NP/bNx7BKSloC+LXLG6rlX
         qMxOwoY3493BblyP7iYfMkDs66aLJLLGe/exjK9Earali5wRkNwjcKz2cAwhx6vMTO/B
         f3eA1SRMZt2MY7eEuj7caltZXu9Su6jVp8BMF+28/h2QKLM35Q4w7jJv0hU3ZbKFcXqL
         w8sWH6snRmCCJbF/6NRpZyueqmIs2O8ewDbzQWYxbVwKUBsXdVOG09q2eA3BUf1Hy7Oo
         7cYg==
X-Gm-Message-State: APjAAAWLvet0fUt0Br6wDWd7PMartfrg/seL2oc1ZjR2siRnFlpp5Csb
        gTRnO542QaFhWeASZgpWAoE9Qw==
X-Google-Smtp-Source: APXvYqxcdHXaH1ybwLvBcHI1ZrUwq0G3kPIENozSUqwM6NF7eNBaHwAsijTgHh2cbiC4dVp3SDWkpA==
X-Received: by 2002:a17:906:5399:: with SMTP id g25mr111945424ejo.247.1564912835174;
        Sun, 04 Aug 2019 03:00:35 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k51sm19583123edb.7.2019.08.04.03.00.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 03:00:34 -0700 (PDT)
To:     Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org
From:   Hans de Goede <hdegoede@redhat.com>
Subject: 5.3 boot regression caused by 5.3 TPM changes
Message-ID: <b20dd437-790a-aad9-0515-061751d46e53@redhat.com>
Date:   Sun, 4 Aug 2019 12:00:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

While testing 5.3-rc2 on an Irbis TW90 Intel Cherry Trail based
tablet I noticed that it does not boot on this device.

A git bisect points to commit 166a2809d65b ("tpm: Don't duplicate
events from the final event log in the TCG2 log")

And I can confirm that reverting just that single commit makes
the TW90 boot again.

This machine uses AptIO firmware with base component versions
of: UEFI 2.4 PI 1.3. I've tried to reproduce the problem on
a Teclast X80 Pro which is also CHT based and also uses AptIO
firmware with the same base components. But it does not reproduce
there. Neither does the problem reproduce on a CHT tablet using
InsideH20 based firmware.

Note that these devices have a software/firmware TPM-2.0
implementation, they do not have an actual TPM chip.

Comparing TPM firmware setting between the 2 AptIO based
tablets the settings are identical, but the troublesome
TW90 does have some more setting then the X80, it has
the following settings which are not shown on the X80:

Active PCR banks:           SHA-1         (read only)
Available PCR banks:        SHA-1,SHA256  (read only)
TPM2.0 UEFI SPEC version:   TCG_2         (other possible setting: TCG_1_2
Physical Presence SPEC ver: 1.2           (other possible setting: 1.3)

I have the feeling that at least the first 2 indicate that
the previous win10 installation has actually used the
TPM, where as on the X80 the TPM is uninitialized.
Note this is just a hunch I could be completely wrong.

I would be happy to run any commands to try and debug this
or to build a kernel with some patches to gather more info.

Note any kernel patches to printk some debug stuff need
to be based on 5.3 with 166a2809d65b reverted, without that
reverted the device will not boot, and thus I cannot collect
logs without it reverted.

Regards,

Hans
