Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1C4C74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E49C2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE858to2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfGKQyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 12:54:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35218 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbfGKQyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 12:54:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so7092363wrm.2;
        Thu, 11 Jul 2019 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NesWXuGbkASvqkB3OfHXJkarfZRKXQiML61VfYbpfEw=;
        b=VE858to2y7ZF+Yho6XDdzelgR7kQDjL4jiugFGdBeGx66hyP15ePL8ltL11wvW7IMw
         rjuLr3ip9sXleNjnR0pKFBQTRbGImm6L7qCJy0z81Jn6sHSFCJjgzGrP67Ul5n3CPtwD
         CzIHOI3K61AHNyNoUAOZ0pzNxQmgTDbJW+FBiNPlxPOb7DiqxgrReUbfigk5dPI8cPp/
         irSBolZvC3tkywfQncRHDp2IenZ1VnlIHTNqvGN8hfLzWISdPsF9E6oGjTYQ7203Cai2
         YbIlgvUDy9/2zLTYRKwKV5789L/Qx+uEu7ItJmpUNCen4ZX464uMO0qbRzOKdAja2I2A
         fWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NesWXuGbkASvqkB3OfHXJkarfZRKXQiML61VfYbpfEw=;
        b=n4ksfA/Aq6UtGxPWsIwV/O8yYL5LhDv4sjzFhs03iMF9t5RB+Xt60wWKTqoUzVpemT
         nxTuo/8gW0rOeZdGL/L2MyQotc/lZzAtLpmD7ZSoh6sSsPPltBQS+vEsLufBW25sOTRc
         vO4q0W7ipTz77fz2YKbDsCB4dBx6NXsOp717k8GU/VWq63v+TcnMFqnQme4mVhIvt8Ig
         jkn74Lf5A29gZmpQBfBpkzlP9CN+8Ppp/4e1ZavlNQK8ZbCLs8woxj0XKtblljaSlX4S
         ZDmE+9edpCMDUGBABOcTdbnSD5HjPwsjnogeZVTqdKu3dox66IQNCk32whdypV7zh31S
         WCKA==
X-Gm-Message-State: APjAAAV9yOPuUnXGFxLhiavrvYOxENCZWEIPEIc7OqgVGBLgDaA5jXEm
        V/HcwD5+BMNLvC4kSxl+E2Y=
X-Google-Smtp-Source: APXvYqxvQMOsPbq3fIdc8FXV42JE16f8lykhebXezEpi2QhaD/xtj/HV+Ano6Jw7WoDgSdzUkOiTFw==
X-Received: by 2002:adf:e941:: with SMTP id m1mr6267917wrn.279.1562864054220;
        Thu, 11 Jul 2019 09:54:14 -0700 (PDT)
Received: from [10.67.49.31] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d16sm4577249wrv.55.2019.07.11.09.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 09:54:13 -0700 (PDT)
Subject: Re: [PATCH v6 2/6] ARM: Disable instrumentation for some code
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>, christoffer.dall@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>, jinb.park7@gmail.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Landley <rob@landley.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>, thgarnie@google.com,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andre Przywara <andre.przywara@arm.com>,
        julien.thierry@arm.com, drjones@redhat.com, philip@cog.systems,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        kasan-dev@googlegroups.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvmarm@lists.cs.columbia.edu,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
References: <20190617221134.9930-1-f.fainelli@gmail.com>
 <20190617221134.9930-3-f.fainelli@gmail.com>
 <CACRpkdb3P6oQTK9FGUkMj4kax8us3rKH6c36pX=HD1_wMqcoJQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <aa45795c-7fa1-ebb8-5d26-cce4c8a60e1a@gmail.com>
Date:   Thu, 11 Jul 2019 09:53:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACRpkdb3P6oQTK9FGUkMj4kax8us3rKH6c36pX=HD1_wMqcoJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/19 2:56 PM, Linus Walleij wrote:
> On Tue, Jun 18, 2019 at 12:11 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> @@ -236,7 +236,8 @@ static int unwind_pop_register(struct unwind_ctrl_block *ctrl,
>>                 if (*vsp >= (unsigned long *)ctrl->sp_high)
>>                         return -URC_FAILURE;
>>
>> -       ctrl->vrs[reg] = *(*vsp)++;
>> +       ctrl->vrs[reg] = READ_ONCE_NOCHECK(*(*vsp));
>> +       (*vsp)++;
> 
> I would probably even put in a comment here so it is clear why we
> do this. Passers-by may not know that READ_ONCE_NOCHECK() is
> even related to KASan.

Makes sense, I will add that, thanks!

> 
> Other than that,
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij
> 


-- 
Florian
