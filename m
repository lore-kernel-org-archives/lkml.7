Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEF4C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDE424650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tTxlGfcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLSK4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:56:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37363 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfLSK4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:56:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so5522555wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NFjdDRBGKQSP78ncYCRWkusaN/fJO8tWC9Wf0q8cNrE=;
        b=tTxlGfcI9uQ7TaCT/WwexWp4Y2jwgo6CfGXE1WeFBkXPMbottwq90HX5uVFSzNo68J
         Qo4Id6rQdijASoPQxhh4ptwUB6rruGjJ946O2dP5olZx2Dh9BNbFrhpUIif79c/8QO0L
         SAxWMWRjRHpm+llgcQFTieGMUaeU6W+CR+dRtD3hZ5atsgOle7TkSxPBQZcSYQkbY/Id
         tPpeOKkOfmnRdxTCIKhJ3rAYxQHxz8Yu3gMQiTCzjZ6SFLCWBWV+b9MM7vx2u7OrMQrd
         P9Lg8Jr0ltAGyBGnfrJgcwGz8VcsRUrwn/vpATq3o4nLwE4A5zw6i44GHFdXKUEO9X3A
         szHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NFjdDRBGKQSP78ncYCRWkusaN/fJO8tWC9Wf0q8cNrE=;
        b=szhYUGZ0eDJdDn9lwToLgdzxR5jjXzgkoeaBh15Qo3g487d3YzBG3eBKoI+M97V596
         VitPUFGvwjX4oLcPegAMUyvcA1DyqwzRCOg64yYgWbfN9vJgq0GJeOEYYB9q8RknXhhB
         KZU3CySxoQUJif4BULV/QjoKnNrSo9n/fVbsiYagqXwAV5ZVpctLsXuLco97D+VLj18Q
         iNAbL7IEmY/vzR6SI8nyXR07DALKy9/rV5HABB1ufTJURb/UdCoNyiLMAUWBrk1nCiRo
         RwpAL2Qt1xE25oArJr6zZGzPyO6FcBS0dtwfe7uzZTxvzZJnu1Wu2lTnGX4SLFOM5QA2
         tfVA==
X-Gm-Message-State: APjAAAWUSRhP9hwAFZt6GnGB2e9peWSAXNiutt/jGX/LpX18Aco+5rII
        kJtPVgO2OejR0K1yVfx7+F/lHA==
X-Google-Smtp-Source: APXvYqysDZtstl/Fxp9EMdSVODWATfvcs4eJE1n3yx5iwUHY15xnvv7JJRXZwRoKkklPyrNYMYrVIw==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr9105000wrv.0.1576753001006;
        Thu, 19 Dec 2019 02:56:41 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id v83sm5908775wmg.16.2019.12.19.02.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 02:56:40 -0800 (PST)
Subject: Re: [PATCH v2 0/4] at24: move write-protect pin handling to nvmem
 core
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Khouloud Touil <ktouil@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        baylibre-upstreaming@groups.io,
        LKML <linux-kernel@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20191210154157.21930-1-ktouil@baylibre.com>
 <cd9f342c-5576-57f5-c62d-a78c5876a7fd@linaro.org>
 <CAMpxmJUM2WWyJyU0MuOu9qObPFr2ghH5LHs8DXo_poMwtZqPNA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b56813c2-d29e-c461-ca1d-80a131c9341a@linaro.org>
Date:   Thu, 19 Dec 2019 10:56:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMpxmJUM2WWyJyU0MuOu9qObPFr2ghH5LHs8DXo_poMwtZqPNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/2019 10:53, Bartosz Golaszewski wrote:
> czw., 19 gru 2019 o 11:51 Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> napisał(a):
>>
>>
>>
>> On 10/12/2019 15:41, Khouloud Touil wrote:
>>> The write-protect pin handling looks like a standard property that
>>> could benefit other users if available in the core nvmem framework.
>>>
>>> Instead of modifying all the drivers to check this pin, make the
>>> nvmem subsystem check if the write-protect GPIO being passed
>>> through the nvmem_config or defined in the device tree and pull it
>>> low whenever writing to the memory.
>>>
>>> This patchset:
>>>
>>> - adds support for the write-protect pin split into two parts.
>>> The first patch modifies modifies the relevant binding document,
>>> while the second modifies the nvmem code to pull the write-protect
>>> GPIO low (if present) during write operations.
>>>
>>> - removes support for the write-protect pin split into two parts.
>>> The first patch modifies the relevant binding document to remove
>>> the wp-gpio, while the second removes the relevant code in the
>>> at24 driver.
>>>
>>> Changes since v1:
>>> -Add an explenation on how the wp-gpios works
>>> -keep reference to the wp-gpios in the at24 binding
>>>
>>> Khouloud Touil (4):
>>>     dt-bindings: nvmem: new optional property write-protect-gpios
>>>     nvmem: add support for the write-protect pin
>>>     dt-bindings: at24: remove the optional property write-protect-gpios
>>>     eeprom: at24: remove the write-protect pin support
>>>
>>
>> Thanks Khouloud for this patchset,
>>
>> I can take this via nvmem tree once we get an ack on dt bindings from DT
>> maintainers.
>>
> 
> Hi Srinivas,
> 
> this will conflict with my at24 tree for this release - can you put
> those patches (once they're fine) into an immutable branch for me to
> merge in?

I can ack nvmem core patch so that you can take it directly via at24 
tree if thats okay.


-srini
> 
> Bart
> 
>>
>> --srini
>>>    .../devicetree/bindings/eeprom/at24.yaml      |  6 +-----
>>>    .../devicetree/bindings/nvmem/nvmem.yaml      |  9 +++++++++
>>>    drivers/misc/eeprom/at24.c                    |  9 ---------
>>>    drivers/nvmem/core.c                          | 19 +++++++++++++++++--
>>>    drivers/nvmem/nvmem.h                         |  2 ++
>>>    include/linux/nvmem-provider.h                |  3 +++
>>>    6 files changed, 32 insertions(+), 16 deletions(-)
>>>
