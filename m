Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36AFC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B679520859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Qdfu7lKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfE0QMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:12:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39236 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfE0QMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:12:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so20167wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5mEyxNiTxG7QHCldnzuLItg2WJUiLZE71Nb5mEMikHM=;
        b=Qdfu7lKbLkMVRKD6Gk7EDaRAOh0aHQeWqxjDWZvknbEkiHbKsi7MUieqe1q8sGforH
         it5X5CBTkk6qo5HNbES2BPpxyemCI6jyrLk3xnUgbwWjJoh/Ow0M4+2IUTCZAGqEAbQg
         D0qw0M8yy/tOMTfXLx4t+bVdXWkasDV0e1OK68nTpcw+pdg9fQzg8WsSX9LDU1q4YbYp
         XGdy2qR8AMJSV8pK7CtZCuNJ4/EuRlo04Ka/dr8MNMdo1w/xpqZtNZjyObGnL/bJnBku
         wRBWl2UF2uz7+wSaRjYdJPxBfPcfgsTQ1KJJ5tL5gE/AyiKI7Ifo582sH7jV988+ie2c
         xTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=5mEyxNiTxG7QHCldnzuLItg2WJUiLZE71Nb5mEMikHM=;
        b=L8iy4eAKzZipoPnkirBT8cgsZYg1IN2uL97dSPd8pmWWRhKxBduSPE7NQWDq/B3S8p
         e2SXQeXk/ILVE18igzDudCz1MzvSsyCmSBxFmud/N5+MDeEzK9iicuYbBtPXWxxFqgwe
         vHsWYPVwF1ltDQ4r3Rb/AMjYU5AiQrCUTajCrn6ASPwyZBaZcryoMSu46Cg30h0WiHQA
         dahVFerWviI69kJ1QLvhcXayDQlAO9+gLQrn0+e0KzrDovmHu/Gm9ImWTfGB9D/wROzA
         iMHKnfHnMSQ5qJ9fj/yvsjI9G7Ogh7kPAMyOcZyYTDNXrwQPr2WrSYs/m5MIpcqpELUl
         1DnQ==
X-Gm-Message-State: APjAAAWtRtC1PAQ4yAyq0/5V1bY3W42MslEVjgyDdbK5VsFhcFY9ANFR
        at8/xsLLizJ9AB6m91iXtAMxFw==
X-Google-Smtp-Source: APXvYqxdhEw7utvMO4VRArF33KJ19jG5BwvZVlrj9QcVk6+kzn3PBObGHvAKrpcEoNeAF24NJ1LU5g==
X-Received: by 2002:a05:600c:228c:: with SMTP id 12mr14844150wmf.91.1558973565870;
        Mon, 27 May 2019 09:12:45 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j123sm21766217wmb.32.2019.05.27.09.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 09:12:45 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial\@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
References: <20190413020111.23400-1-paul.walmsley@sifive.com>
        <7hmukmew5j.fsf@baylibre.com>
        <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com>
Date:   Mon, 27 May 2019 18:12:43 +0200
In-Reply-To: <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com> (Atish Patra's
        message of "Thu, 18 Apr 2019 18:04:34 -0700")
Message-ID: <86sgszq3k4.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18 Apr 2019 at 18:04, Atish Patra <atish.patra@wdc.com> wrote:

> On 4/18/19 4:22 PM, Kevin Hilman wrote:
>> Hi Paul,
>>
>> Paul Walmsley <paul.walmsley@sifive.com> writes:
>>
>>> This series adds a serial driver, with console support, for the
>>> UART IP block present on the SiFive FU540 SoC.  The programming
>>> model is straightforward, but unique.
>>>
>>> Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
>>> open-source FSBL (with appropriate patches to the DT data).
>>>
>>> This fifth version fixes a bug in the set_termios handler,
>>> found by Andreas Schwab <schwab@suse.de>.
>>>
>>> The patches in this series can also be found, with the PRCI patches,
>>> DT patches, and DT prerequisite patch, at:
>>>
>>> https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4
>>
>> I tried this branch, and it doesn't boot on my unleashed board.
>>
>> Here's the boot log when I pass the DT built from your branch via
>> u-boot: https://termbin.com/rfp3.
>>
>
> Unfortunately, that won't work. The current DT modifications by OpenSBI.
>
> 1. Change hart status to "masked" from "okay".
> 2. M-mode interrupt masking in PLIC node.
> 3. Add a chosen node for serial access in U-Boot.
>
> You can ignore 3 for your use case. However, if you pass a dtb built from source
> code, that will have hart0 enabled and M-mode interrupts enabled in DT.

Atish,
I'm trying to get the kernel boot with the current linux kernel DT from
Paul's patch series [0].

Could you point me to some documentation on 2. ?
Or do you know of a way to disable M-mode interrupts from U-boot ?

[0]: https://lore.kernel.org/patchwork/project/lkml/list/?series=390077

Thanks,
Loys

>
> Not sure if we should do these DT modifications in U-Boot as well.
>
