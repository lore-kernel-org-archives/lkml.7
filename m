Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D68C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 08:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDCA20866
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 08:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfCIIhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 03:37:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:32851 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfCIIhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 03:37:45 -0500
Received: from [114.245.43.129] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1h2XUC-00053i-KW; Sat, 09 Mar 2019 08:37:41 +0000
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
To:     Christopher Heiny <Cheiny@synaptics.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Duggan <aduggan@synaptics.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
 <17cd420ea32a9787c56ba25e36e7661541c2f65f.camel@synaptics.com>
From:   Aaron Ma <aaron.ma@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=aaron.ma@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFffeLkBCACi4eE4dPsgWN6B9UDOVcAvb5QgU/hRG6yS0I1lGKQv4KA+bke0c5g8clbO
 9gIlIl2bityfA9NzBsDik4Iei3AxMbFyxv9keMwcOFQBIOZF0P3f05qjxftF8P+yp9QTV4hp
 BkFzsXzWRgXN3r8hU8wqZybepF4B1C83sm2kQ5A5N0AUGbZli9i2G+/VscG9sWfLy8T7f4YW
 MjmlijCjoV6k29vsmTWQPZ7EApNpvR5BnZQPmQWzkkr0lNXlsKcyLgefQtlwg6drK4fe4wz0
 ouBIHJEiXE1LWK1hUzkCUASra4WRwKk1Mv/NLLE/aJRqEvF2ukt3uVuM77RWfl7/H/v5ABEB
 AAG0IUFhcm9uIE1hIDxhYXJvbi5tYUBjYW5vbmljYWwuY29tPokBNwQTAQgAIQUCV994uQIb
 AwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDNxCzQfVU6ntJ9B/9aVy0+RkLqF9QpLmw+
 LAf1m3Fd+4ZarPTerqDqkLla3ekYhbrEtlI1mYuB5f+gtrIjmcW27gacHdslKB9YwaL8B4ZB
 GJKhcrntLg4YPzYUnXZkHHTv1hMw7fBYw82cBT+EbG0Djh6Po6Ihqyr3auHhfFcp1PZH4Mtq
 6hN5KaDZzF/go+tRF5e4bn61Nhdue7mrhFSlfkzLG2ehHWmRV+S91ksH81YDFnazK0sRINBx
 V1S8ts3WJ2f1AbgmnDlbK3c/AfI5YxnIHn/x2ZdXj1P/wn7DgZHmpMy5DMuk0gN34NLUPLA/
 cHeKoBAF8emugljiKecKBpMTLe8FrVOxbkrauQENBFffeLkBCACweKP3Wx+gK81+rOUpuQ00
 sCyKzdtMuXXJ7oL4GzYHbLfJq+F+UHpQbytVGTn3R5+Y61v41g2zTYZooaC+Hs1+ixf+buG2
 +2LZjPSELWPNzH9lsKNlCcEvu1XhyyHkBDbnFFHWlUlql3nSXMo//dOTG/XGKaEaZUxjCLUC
 8ehLc16DJDvdXsPwWhHrCH/4k92F6qQ14QigBMsl75jDTDJMEYgRYEBT1D/bwxdIeoN1BfIG
 mYgf059RrWax4SMiJtVDSUuDOpdwoEcZ0FWesRfbFrM+k/XKiIbjMZSvLunA4FIsOdWYOob4
 Hh0rsm1G+fBLYtT+bE26OWpQ/lSn4TdhABEBAAGJAR8EGAEIAAkFAlffeLkCGwwACgkQzcQs
 0H1VOp6p5Af/ap5EVuP1AhFdPD3pXLNrUUt72W3cuAOjXyss43qFC2YRjGfktrizsDjQU46g
 VKoD6EW9XUPgvYM+k8BJEoXDLhHWnCnMKlbHP3OImxzLRhF4kdlnLicz1zKRcessQatRpJgG
 NIiD+eFyh0CZcWBO1BB5rWikjO/idicHao2stFdaBmIeXvhT9Xp6XNFEmzOmfHps+kKpWshY
 9LDAU0ERBNsW4bekOCa/QxfqcbZYRjrVQvya0EhrPhq0bBpzkIL/7QSBMcdv6IajTlHnLARF
 nAIofCEKeEl7+ksiRapL5Nykcbt4dldE3sQWxIybC94SZ4inENKw6I8RNpigWm0R5w==
Message-ID: <a0f21198-5715-8858-8368-51e43092181e@canonical.com>
Date:   Sat, 9 Mar 2019 16:37:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <17cd420ea32a9787c56ba25e36e7661541c2f65f.camel@synaptics.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/9/19 7:13 AM, Christopher Heiny wrote:
> I'm not sure this is a safe action, due to a race condition with the
> actual IRQ handler (rmi_process_interrupt_requests from rmi_driver.c). 
> Remember that reading the IRQ status register clears all the IRQ bits. 
> So you're faced with this possible scenario:
>     - ATTN asserted, indicating new data in IRQ status register
>     - rmi_driver_set_irq_bits called
>     - rmi_driver_set_irq_bits reads IRQ status, clearing bits
>     - rmi_process_interrupt_requests called
>     - rmi_process_interrupt_request reads IRQ status, sees no
>       bits set, nested IRQs are not handled
> This could lead to loss of data or inconsistent system state
> information.  For example, a button up or down event may be lost, with
> consequent weird behavior by the user interface.

rmi_driver_set_irq_bits is only called to config and enable specific
functions of RMI.
Reading IRQ status before set irqs is supposed to clear spam data/irq
status.
spam data make probe/detect touchpad/trackpoint fail.

rmi_smb_resume -> rmi_driver_reset_handler -> fn-config ->
clear_irq_bits -> set_irq_bits -> enable_irq -> irq_handler  ->
rmi_process_interrupt_requests

set_irq_bits will not be in interrupt context, it enables IRQ bits of RMI.

Regards,
Aaron
