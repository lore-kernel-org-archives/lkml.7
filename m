Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C99C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B1C20874
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dahcgIre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfHMPJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:09:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46139 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbfHMPJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:09:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id f9so3357636ljc.13;
        Tue, 13 Aug 2019 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7U8/4UyoTUA6NLa9a1ZrNdP8XteABe+RpH2j97wuTYQ=;
        b=dahcgIredi4r+Sk8PCHI08aELfUnNckW6FZzoqTilNr0dAejWvX1qlPTUPZ0H2o6H7
         PK0n+cJkt7ZVF00f8N8k2itwK6wHXKTKZQXCk3YLIRAE35QfHDim+ivXFI+EJ2Fd+NYB
         sDKlcG2h0qxExjR35e2fsCAfudutcx0Mp7o4pyIGRH+YMRyFVQRJhCB0SPqbzdxpXHia
         Icira3PcwFi5WXXCLxqNr0qHGjxUOgcTT+akJR/OwJtbybNDl7xIzXU9OAOMDoSoMKKs
         nRrKOAROVBm4O5Xnn97rMuSnxSku0BJawawAgu2F4WrqGcFO1/Klkav+cUDVu4zq8+05
         q5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7U8/4UyoTUA6NLa9a1ZrNdP8XteABe+RpH2j97wuTYQ=;
        b=d4NYkWcYcx0ojN8suZSkvRUZr2LYN1CAaBNUns+q/EuZgMCNJX8PYDZZtSKYoLjf+c
         rIFXhbviaLfc856aHEJI53+9P/13GUBNPDFng9WWc1LqwutAz4vqErbK5FvN2KgZVxMP
         UF6uKkSRIWbn02efjnhtBlKj8+gCzfDaRv9iPhR//hpJf5Qt6V4GYmeigryX6LUKVLSO
         WmrVpnqBcJvIdVyAm9VTBxs4WnBWpaqIv9zTudjQOoBZdmcQIDEHvv5/9QZIJTdAwu2s
         pw4j5C+ecWgZLV376gTENj5RCPLbaHCKaFE8QdDMajnpiCrC2OhNPTNMbeErtRrjAAAI
         MbSg==
X-Gm-Message-State: APjAAAUDux+R9RxoN+deCrRGYl2TVyv28XC3R+rD4+xOBHlHIekW0Ek5
        GwzXZn8NPjssd2wY6K3b6pE8dkJg
X-Google-Smtp-Source: APXvYqzvyfy3C9D9LIOl5jzh+aLNClcIvQHFzEQMR0+MA+CnMjyeTweS51dZtrWs63fIAyxuZ9BQ4w==
X-Received: by 2002:a2e:9acf:: with SMTP id p15mr1620452ljj.13.1565708980339;
        Tue, 13 Aug 2019 08:09:40 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id d16sm3570367lfi.31.2019.08.13.08.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 08:09:39 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] irqchip/tegra: Remove everything related to COP
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190811183044.13925-1-digetx@gmail.com>
 <86blwtnnwd.wl-maz@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7005ba67-3815-94cc-c524-ec39023e5164@gmail.com>
Date:   Tue, 13 Aug 2019 18:09:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <86blwtnnwd.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

13.08.2019 17:25, Marc Zyngier пишет:
> On Sun, 11 Aug 2019 19:30:43 +0100,
> Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> There is no point in touching of the COP (ARM7TDMI auxiliary boot/firmware
>> CPU) because COP's interrupts should be related only to an old multimedia
>> firmware that is not applicable to the upstream kernel. Hence let's remove
>> everything related to the COP, for consistency.
> 
> We've had that exact discussion a few weeks ago, and I objected to
> this change as there is no possible way you can know for sure people
> don't use mainline with an old firmware. The whole point of the
> firmware is to be an abstraction for the kernel, for better or worse.

I think you're misunderstanding what kind of firmware it is. It absolutely can't be used
with upstream kernel without of porting the whole downstream driver stack (which is a very
old crusty v3.1 kernel, a typical non-upstreamable downstream hackery). In upstream we now
have a proper DRM graphics driver, video decoder driver and etc. Few years ago those
downstream drivers were obsoleted and not supported by the NVIDIA anymore.

> If you really want to do something useful here, consider detecting
> such firmware (even better, detect the new ones that don't require
> this stuff) and document the various requirements. At least we'll know
> where we stand, because the changes you're making are just as random
> as what we have so far.

As I just said in the above, that old firmware is not usable with the upstream in any shape
or form. Hence there is nothing to detect, it is safe to assume that only newer hardware has
something running in background. Peter De Schrijver suggested that kernel shouldn't touch
the COP's interrupts for the newer firmware, so this patch should be fine if Peter or
somebody else from NVIDIA will give an ACK.
