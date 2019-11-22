Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ABCC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B8E20708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKVJFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:05:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36044 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfKVJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:05:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id n188so4744056wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 01:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Nf3kSA3hvbFKpVNXqMsfEdpGB5UW14apon950jWNL9E=;
        b=TbxIAmMxNABfZYJt/RJFw60qI+pWyDY8DiH3dOIz3vdMuY6ZNYCYIl+QFNcCBFFBAR
         7qL6J02c092o7pGx0DHlGzU0oyH/GjBVgwdnCCNaojB5Fstju3IkIrfSs4tC91Hgpd5Z
         KlLmc4sJWFk3W8BZ2lQbVr5lZpazhiwyhPQgStUXYxnPV7ToCMapJPXH+/F7cLDgAK+b
         7UDo21U2IbixBlCL3xrSoXZpeoKrbdDQoP54XC2MkDVX33KjzmWGA+lEntCSwfkK2GtZ
         wFAZAYChPunt8iPgJkMi9L8D6MCCqHDmJSzdwEaQN2I8O4owTxc5ZcLFcBkSm0rBjXYc
         RNfw==
X-Gm-Message-State: APjAAAUKhwdAU18ff3hXn4m/F81742QZDbXSTKRqYM/b83lyrITqf2NB
        EOcu+DbWCMqKrdrAKbL20+OWasdvu3c=
X-Google-Smtp-Source: APXvYqzfmhjOn5tQSGCZ28SkG/4MgLgo4SPB6D+iR8+jHIWwEpQrCcNGpdbbNkpWU6UG5HoGADuVUA==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr14406639wmd.171.1574413511454;
        Fri, 22 Nov 2019 01:05:11 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id y8sm2731141wmi.9.2019.11.22.01.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2019 01:05:10 -0800 (PST)
Subject: Re: [PATCH v2 2/2] tty: use tty_init_dev_retry() to workaround a race
 condition
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20191121152239.28405-1-sudipm.mukherjee@gmail.com>
 <20191121152239.28405-2-sudipm.mukherjee@gmail.com>
 <20191121164138.GD651886@kroah.com> <20191121210155.limd7v6cpd5yz2e7@debian>
From:   Jiri Slaby <jslaby@suse.com>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 mQINBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABtBxKaXJpIFNsYWJ5
 IDxqc2xhYnlAc3VzZS5jb20+iQI4BBMBAgAiBQJOkujrAhsDBgsJCAcDAgYVCAIJCgsEFgID
 AQIeAQIXgAAKCRC9JbEEBrRwSc1VD/9CxnyCYkBrzTfbi/F3/tTstr3cYOuQlpmufoEjCIXx
 PNnBVzP7XWPaHIUpp5tcweG6HNmHgnaJScMHHyG83nNAoCEPihyZC2ANQjgyOcnzDOnW2Gzf
 8v34FDQqj8CgHulD5noYBrzYRAss6K42yUxUGHOFI1Ky1602OCBRtyJrMihio0gNuC1lE4YZ
 juGZEU6MYO1jKn8QwGNpNKz/oBs7YboU7bxNTgKrxX61cSJuknhB+7rHOQJSXdY02Tt31R8G
 diot+1lO/SoB47Y0Bex7WGTXe13gZvSyJkhZa5llWI/2d/s1aq5pgrpMDpTisIpmxFx2OEkb
 jM95kLOs/J8bzostEoEJGDL4u8XxoLnOEjWyT82eKkAe4j7IGQlA9QQR2hCMsBdvZ/EoqTcd
 SqZSOto9eLQkjZLz0BmeYIL8SPkgnVAJ/FEK44NrHUGzjzdkE7a0jNvHt8ztw6S+gACVpysi
 QYo2OH8hZGaajtJ8mrgN2Lxg7CpQ0F6t/N1aa/+A2FwdRw5sHBqA4PH8s0Apqu66Q94YFzzu
 8OWkSPLgTjtyZcez79EQt02u8xH8dikk7API/PYOY+462qqbahpRGaYdvloaw7tOQJ224pWJ
 4xePwtGyj4raAeczOcBQbKKW6hSH9iz7E5XUdpJqO3iZ9psILk5XoyO53wwhsLgGcrkCDQRO
 kueGARAAz5wNYsv5a9z1wuEDY5dn+Aya7s1tgqN+2HVTI64F3l6Yg753hF8UzTZcVMi3gzHC
 ECvKGwpBBwDiJA2V2RvJ6+Jis8paMtONFdPlwPaWlbOv4nHuZfsidXkk7PVCr4/6clZggGNQ
 qEjTe7Hz2nnwJiKXbhmnKfYXlxftT6KdjyUkgHAs8Gdz1nQCf8NWdQ4P7TAhxhWdkAoOIhc4
 OQapODd+FnBtuL4oCG0c8UzZ8bDZVNR/rYgfNX54FKdqbM84FzVewlgpGjcUc14u5Lx/jBR7
 ttZv07ro88Ur9GR6o1fpqSQUF/1V+tnWtMQoDIna6p/UQjWiVicQ2Tj7TQgFr4Fq8ZDxRb10
 Zbeds+t+45XlRS9uexJDCPrulJ2sFCqKWvk3/kf3PtUINDR2G4k228NKVN/aJQUGqCTeyaWf
 fU9RiJU+sw/RXiNrSL2q079MHTWtN9PJdNG2rPneo7l0axiKWIk7lpSaHyzBWmi2Arj/nuHf
 Maxpc708aCecB2p4pUhNoVMtjUhKD4+1vgqiWKI6OsEyZBRIlW2RRcysIwJ648MYejvf1dzv
 mVweUa4zfIQH/+G0qPKmtst4t/XLjE/JN54XnOD/TO1Fk0pmJyASbHJQ0EcecEodDHPWP6bM
 fQeNlm1eMa7YosnXwbTurR+nPZk+TYPndbDf1U0j8n0AEQEAAYkCHwQYAQIACQUCTpLnhgIb
 DAAKCRC9JbEEBrRwSTe1EACA74MWlvIhrhGWd+lxbXsB+elmL1VHn7Ovj3qfaMf/WV3BE79L
 5A1IDyp0AGoxv1YjgE1qgA2ByDQBLjb0yrS1ppYqQCOSQYBPuYPVDk+IuvTpj/4rN2v3R5RW
 d6ozZNRBBsr4qHsnCYZWtEY2pCsOT6BE28qcbAU15ORMq0nQ/yNh3s/WBlv0XCP1gvGOGf+x
 UiE2YQEsGgjs8v719sguok8eADBbfmumerh/8RhPKRuTWxrXdNq/pu0n7hA6Btx7NYjBnnD8
 lV8Qlb0lencEUBXNFDmdWussMAlnxjmKhZyb30m1IgjFfG30UloZzUGCyLkr/53JMovAswmC
 IHNtXHwb58Ikn1i2U049aFso+WtDz4BjnYBqCL1Y2F7pd8l2HmDqm2I4gubffSaRHiBbqcSB
 lXIjJOrd6Q66u5+1Yv32qk/nOL542syYtFDH2J5wM2AWvfjZH1tMOVvVMu5Fv7+0n3x/9shY
 ivRypCapDfcWBGGsbX5eaXpRfInaMTGaU7wmWO44Z5diHpmQgTLOrN9/MEtdkK6OVhAMVenI
 w1UnZnA+ZfaZYShi5oFTQk3vAz7/NaA5/bNHCES4PcDZw7Y/GiIh/JQR8H1JKZ99or9LjFeg
 HrC8YQ1nzkeDfsLtYM11oC3peHa5AiXLmCuSC9ammQ3LhkfET6N42xTu2A==
Message-ID: <eef58b47-f208-2ac5-6e02-a87f9568c70f@suse.com>
Date:   Fri, 22 Nov 2019 10:05:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191121210155.limd7v6cpd5yz2e7@debian>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 11. 19, 22:01, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Thu, Nov 21, 2019 at 05:41:38PM +0100, Greg Kroah-Hartman wrote:
>> On Thu, Nov 21, 2019 at 03:22:39PM +0000, Sudip Mukherjee wrote:
>>> There seems to be a race condition in tty drivers and I could see on
>>> many boot cycles a NULL pointer dereference as tty_init_dev() tries to
>>> do 'tty->port->itty = tty' even though tty->port is NULL.
>>> 'tty->port' will be set by the driver and if the driver has not yet done
>>> it before we open the tty device we can get to this situation. By adding
>>> some extra debug prints, I noticed that:
>>>
>>> 6.650130: uart_add_one_port
>>> 6.663849: register_console
>>> 6.664846: tty_open
>>> 6.674391: tty_init_dev
>>> 6.675456: tty_port_link_device
>>>
>>> uart_add_one_port() registers the console, as soon as it registers, the
>>> userspace tries to use it and that leads to tty_open() but
>>> uart_add_one_port() has not yet done tty_port_link_device() and so
>>> tty->port is not yet configured when control reaches tty_init_dev().
>>
>> Shouldn't we do tty_port_link_device() before uart_add_one_port() to
>> remove that race?  Once you register the console, yes, tty_open() can
>> happen, so the driver had better be ready to go at that point in time.
>>
> 
> But tty_port_link_device() is done by uart_add_one_port() itself.
> After registering the console uart_add_one_port() will call
> tty_port_register_device_attr_serdev() and tty_port_link_device() is
> called from this. Thats still tty core.

Interferences of console vs tty code are ugly. Does it help to simply
put tty_port_link_device to uart_add_one_port before uart_configure_port?

thanks,
-- 
js
suse labs
