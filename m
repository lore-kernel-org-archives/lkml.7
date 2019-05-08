Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86894C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDC021019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEHHJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:09:16 -0400
Received: from ivanoab6.miniserver.com ([5.153.251.140]:51094 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfEHHJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:09:15 -0400
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1hOGhU-0004P0-0x; Wed, 08 May 2019 07:09:12 +0000
Received: from erebus.kot-begemot.co.uk ([192.168.3.72])
        by jain.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1hOGhM-00080l-AJ; Wed, 08 May 2019 08:09:09 +0100
Subject: Re: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
References: <20190411094944.12245-1-brgl@bgdev.pl>
 <20190411094944.12245-5-brgl@bgdev.pl>
 <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com>
Date:   Wed, 8 May 2019 08:09:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2019 22:26, Richard Weinberger wrote:
> On Thu, Apr 11, 2019 at 11:50 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Setting a chip for an interrupt marks it as allocated. Since UM doesn't
>> support dynamic interrupt numbers (yet), it means we cannot simply
>> increase NR_IRQS and then use the free irqs between LAST_IRQ and NR_IRQS
>> with gpio-mockup or iio testing drivers as irq_alloc_descs() will fail
>> after not being able to neither find an unallocated range of interrupts
>> nor expand the range.
>>
>> Only call irq_set_chip_and_handler() for irqs until LAST_IRQ.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Just noticed that this triggers the following errors while bootup:
> Trying to reregister IRQ 11 FD 8 TYPE 0 ID           (null)
> write_sigio_irq : um_request_irq failed, err = -16
> Trying to reregister IRQ 11 FD 8 TYPE 0 ID           (null)
> write_sigio_irq : um_request_irq failed, err = -16
> VFS: Mounted root (hostfs filesystem) readonly on
> 
> Can you please check?
> This patch is already queued in -next. So we need to decide whether to
> revert or fix it now.
> 
I am looking at it. It passed tests in my case (I did the usual round).

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
