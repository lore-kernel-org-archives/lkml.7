Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6A8C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEFE2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M03Tw5RA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfLTQYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:24:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38743 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfLTQYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:24:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so9821568wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 08:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Z5ieuru/1XCttEcOMbv48Hm1AcXx6usyE65v2BBik/A=;
        b=M03Tw5RAHCudsOqV8mUhnNRSBKZRIgkeAq1dWW0/gYOYQHMGSVeID0wI7TI6VeMemH
         6ejiB2Hn6310HvtWRIhQttM0Ntn4ApRS9MYFj3QB8uGjtEm2lvnmZscbHQXwbN2wzoug
         unE6Z6mhkxEy7Y6nnGGvIcG4QFTvuhRoG296s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Z5ieuru/1XCttEcOMbv48Hm1AcXx6usyE65v2BBik/A=;
        b=opoihhwHShJU12uHgaI8iBwoAxA6xLflOQ1b7XHOkMCpyf7trZQcznjvU9LeEHS+VV
         ELBx/E6tya+AmcJNgdWSc69T0162u/4/1XMPLt2VJ4QW+WRyZTCmP1PR3GXwhTSCINiG
         JdXHPtmK/y1PA500ZKNLorAXjEfqgAyeG1DQ7On3d6Z7f03Oq4/cFkGLzY7fW2hSfu+d
         Bpr1WlbxhE/CpX50nWU565yVXLVlEuUY5zOyk0SJuy7Vd9rucm69MwCNlyEWxtXs3f16
         sfHVGVDXLTfyq30BFZrYM9UQO7DVRH9HLdw7oyjPHrv7kMeWhZjYCb9WaiF+Zkt/4GZ5
         bL8A==
X-Gm-Message-State: APjAAAXSLL2DoN++VD8KjDzRrzydW1OjMg4Y2qgjMx1Q0NweWMD0QP7M
        97EailYrTjMTPvpG73P0C82Pb6E7e4A=
X-Google-Smtp-Source: APXvYqyTajBN2WQIHvjdGlTRAezy+p1IeM23FPlngflIZP1Tpc2EBSh8MuAXiEmaa3oXwIU4ZD26qA==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr17166001wmj.105.1576859046593;
        Fri, 20 Dec 2019 08:24:06 -0800 (PST)
Received: from [10.28.17.247] ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id d14sm10896103wru.9.2019.12.20.08.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 08:24:05 -0800 (PST)
Subject: Re: [PATCH 1/2] include: trace: Add SCMI header with trace events
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rostedt@goodmis.org
References: <20191216161650.21844-1-lukasz.luba@arm.com>
 <20191218120900.GA28599@bogus>
 <7b59a2f1-0786-d24f-a653-76a60c15a8ae@broadcom.com>
 <CA+-6iNxn29WpUrbc9gL4EMTJfZj7FRCeO-_QaUqbjJYd1JAEKA@mail.gmail.com>
 <7fe599d3-1ce2-1fde-2911-9516a26090b6@arm.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Openpgp: preference=signencrypt
Autocrypt: addr=james.quinlan@broadcom.com; prefer-encrypt=mutual; keydata=
 mQENBFOXa3ABCADHz9QNP8upEMOGzf0RJ1lhBRnacq5Gz9fcbmcxK2y4PXtT1JR2WJWT3roY
 oHUXKL42zA74Iv6ODOjvO/VcvmJTllbz5zhuj5hDHBTNdSdspHWJMS3VdRtB5YQ4+4SNfi4O
 +ucstwf5U8HHLtsFes1udLWgujK4CD2mHBpR1tIc7dXP7jsCcxvkwA/jMN8D8w80kE1RY1eM
 3Chfft2oJOMK54n8f9x+iWdDsXV2e5vk0TLAJPB8ErGbAWj+HF+SQ/QdI6hdn/KbEQgJyZCV
 t8mB2uDfjvp14PIY02OSu9vgEWVYMMPoNLazromChJBtflewbp/Uim7BWYvcYRCPwx7VABEB
 AAG0KEppbSBRdWlubGFuIDxqYW1lcy5xdWlubGFuQGJyb2FkY29tLmNvbT6JATgEEwECACIF
 AlazUjUCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJENnFxA/a7tJZiMwH/RHLgTPx
 BzrlFPQbEDfh05FXthTM0r1wC8AwHGmXhaxMT352Ju4jqCPvhF4YbczqEmuSFqOHZ6hQhBah
 L/O4QYRtBUCYhGg/cQ5WzklE48A2iNEoSsA8rP6Cy4wzXKrO0yPHQPyDtQ/o/Fa6T6r2EBAT
 mVtQBizeiDkUKDgfYU+o0iTW+205myQ9tTe3R0BJmq+F6dYdusKHRn9QXkm5oUC/tea3bq6N
 jnExBVz8LFaZRxe5uVs5Hwa+ZZqqsj3xJ6CmPQIktjcX8cHUSdrd/B7BC/kBwhhUeKT5HfQl
 KNk75rbMY8vJy8emev72Tyi3zq3tNy7DZvZoAmX5NGua8625AQ0EU5drcAEIAKmzln4+BvCz
 CfrbQqCd/EUhmVesujmNO2lTUFL20Wv1Kq27ZFXPaWfe9+lxg9R+p1Ry4ChRk7xZ34r56t0i
 lGZKH2CIETGChBedfOoDTcgt7K9lMlIxl9QIVEt5yxaqUExN38TIeEayBdeZSbPtmWzGQGl1
 kaUHY8l8GWSVB6mJrJaEnfpxt8xTbHdCbPzRM2nf5w76IFFvIP6ojnW06fWYTSYisPuidZs/
 7r1s8GpucrveKXNpzw3li9ChzI90zTBpMl3jWtqOQE5Nn0UHpPvN2SiAJ/Gm18LRP8TCTmOU
 bpLN2UoJhUGdscyYen+ECxVEZXsQCyASJvGzcWHjQL8AEQEAAYkBHwQYAQIACQUCU5drcAIb
 DAAKCRDZxcQP2u7SWUnTCAC8GirJT3daWnIgc23Qw0caHxP9dHLNKf4Fo1bxss5n6JoZgQWt
 kvqWRBBGqHTBbVBrScH5jI7kYRXaP37Q6J4bOxi68L/NC9qY7y41M6O+EaRZ4xYR5PjXY7yu
 eEeLGk0U8L6lgOtCH53lhk0i4E5BRKvg71T0UvmJPpSmtYUo/JH0sCinJADCQx+C961yPerJ
 xOO2mNvMpvXjMSqeWzYmZ9uhvRGVfo5O9i4MdFXpSm/3a3i/bZLaxPt3tjxJu+aPKHHadKcr
 8EmSDiRrCGBbnhED/fvI/titv3qxtMBLAY++03FOh6XC93NjsRC3yCogAY7iIuWoWBmisCQ6 Kcyg
Message-ID: <9befbc13-ba00-094d-0064-0d97c1ccbb63@broadcom.com>
Date:   Fri, 20 Dec 2019 11:24:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7fe599d3-1ce2-1fde-2911-9516a26090b6@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Thank you for sharing your experiments and thoughts. I have probably
> similar setup for stressing the communication channel, but I do also
> some wired things in the firmware. That's why I need to measure these
> delays. I am happy that it is useful for you also.
>
> I don't know if your firmware supports 'fast channel', but please keep
> in mind that it is not tracked in this 'transfer_id'.
> This transfer_id in v2 version does not show the real transfers
> to the firmware since there is another path called 'fast channel' or
> 'fast_switch' in the CPUfreq. It is in drivers/firmware/arm_scmi/perf.c=

> and the atomic variable is not incremented in that path. Adding it also=

> there just for atomic_inc() probably would add delays in the fast_switc=
h
> and also brings little value.
> For the normal channel, where we have spinlocks and other stuff, this
> atomic_inc() could stay in my opinion.
>
> Regards,
> Lukasz
Hi Lukasz,

We currently do not use "fast channels" - although it is possible we migh=
t someday.
I find the transfer_id useful per your v2 even if it doesn't cover FC.=C2=
=A0 Thanks for
submitting and discussing this!

Regards,
Jim Quinlan

