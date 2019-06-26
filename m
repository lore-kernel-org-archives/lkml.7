Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B34C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2839320663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkpiqxEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfFZMOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:14:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41408 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZMON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:14:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id y72so1139149pgd.8;
        Wed, 26 Jun 2019 05:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nE8JZHrKvZIjpzwoCOV4W+kZMdzp32CH3OhSv9DzAQA=;
        b=FkpiqxEmc1WKkr3sirer29jM7xKhdHyKj0fJ2SNPATI1XoRrgSCqtqr9u1BKAC5cXW
         YFlgxc/7PYtwZNZTxfldcM14QmtYCm5V+lOlEqpU9Hb19P2FtbAt3wmSsrs4kBJ6AZQF
         xNcQZqQR1b7/EuDIIVJO/0cj0Z7SHlyBVQdwSv7gbLf6RapeCmFI0xnvOW49BJh5bLeI
         RS4umvJZCdtSFtR5EIM67n/KRpXkwZYMwHaqEykhtlh1F41v969pTFQAuq90Bf8RkXxB
         sI6z8boSKMD/WDlvoH0rirK0/QKtqFKmzHexh6m20aylIOt7MKN0jHGhTlGHhSuKk+Hl
         h75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nE8JZHrKvZIjpzwoCOV4W+kZMdzp32CH3OhSv9DzAQA=;
        b=fkQ7mRk02oW7Dw/gcQBl0xzjsLXvJP0HCyuJw8jnr1cxW7mUFHBQlG6bFMk0ept/po
         GwkdsEKMXw2JBvdi6Qm/u7VTi305fhxw9POmYzOtsIvAhfY0Xm6jymAfZzZDjq2X0kPD
         G7nR7mqlo2gky1uqkM4new+8NDYis7B5Nux0XCrQPYboHD1YbxAtpiQItDadw38bxOAN
         LjDMp/TY2Qhi4K0nhedK/8MBlQofsA36nZpRSxb3vKO5alGZmfLwfmhsPDO2qyeEisla
         k0F+lsDNdcbVL8vxaP+MTXwrEh8Fv3bsEteOA1T3W/ew85KtFjEQbFTGKWbTgnH3AtfI
         41zw==
X-Gm-Message-State: APjAAAVBrNBeU8Zn297k0IpDc0PINKkGH07q0nXXdvjYiIXkMfFaz6R3
        RhijJQZRp5IWkorkFrEXEWTT4eIjp+U=
X-Google-Smtp-Source: APXvYqyl/rcV1NaUbh6KN9ZCyayU/jSJPecs/2fph6Nkb+9gPHbGA+Bn5bVK4tmxcfI91FmEViay7g==
X-Received: by 2002:a17:90a:214f:: with SMTP id a73mr4338153pje.21.1561551252708;
        Wed, 26 Jun 2019 05:14:12 -0700 (PDT)
Received: from [10.44.0.192] ([103.48.210.53])
        by smtp.gmail.com with ESMTPSA id x128sm30778516pfd.17.2019.06.26.05.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 05:14:12 -0700 (PDT)
From:   Greg Ungerer <gregungerer00@gmail.com>
X-Google-Original-From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH 08/17] binfmt_flat: consolidate two version of
 flat_v2_reloc_t
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Michal Simek <monstr@monstr.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190613070903.17214-1-hch@lst.de>
 <20190613070903.17214-9-hch@lst.de>
 <20190625222941.GA1343@ZenIV.linux.org.uk>
 <f8a61a8e-0469-a9d6-e0a1-01a4619d7363@linux-m68k.org>
 <CAMuHMdXkMh+pOqPNavmYAhKXTVT12nC5gKc10CJj_CXME+uhWQ@mail.gmail.com>
Message-ID: <a2567a04-ac83-408f-51a2-53d23fcc0c36@linux-m68k.org>
Date:   Wed, 26 Jun 2019 22:14:06 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXkMh+pOqPNavmYAhKXTVT12nC5gKc10CJj_CXME+uhWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 26/6/19 6:18 pm, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Wed, Jun 26, 2019 at 9:23 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 26/6/19 8:29 am, Al Viro wrote:
>>> On Thu, Jun 13, 2019 at 09:08:54AM +0200, Christoph Hellwig wrote:
>>>> Two branches of the ifdef maze actually have the same content, so merge
>>>> them.
>>>>
>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>> ---
>>>>    include/linux/flat.h | 6 ++----
>>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/include/linux/flat.h b/include/linux/flat.h
>>>> index 2b7cda6e9c1b..19c586b74b99 100644
>>>> --- a/include/linux/flat.h
>>>> +++ b/include/linux/flat.h
>>>> @@ -69,15 +69,13 @@ struct flat_hdr {
>>>>    typedef union {
>>>>       unsigned long   value;
>>>>       struct {
>>>> -# if defined(mc68000) && !defined(CONFIG_COLDFIRE)
>>>> +#if defined(__LITTLE_ENDIAN_BITFIELD) || \
>>>> +    (defined(mc68000) && !defined(CONFIG_COLDFIRE))
>>>>               signed long offset : 30;
>>>>               unsigned long type : 2;
>>>>    # elif defined(__BIG_ENDIAN_BITFIELD)
>>>>               unsigned long type : 2;
>>>>               signed long offset : 30;
>>>> -# elif defined(__LITTLE_ENDIAN_BITFIELD)
>>>> -            signed long offset : 30;
>>>> -            unsigned long type : 2;
>>>>    # else
>>>>    #          error "Unknown bitfield order for flat files."
>>>>    # endif
>>>> --
>>>> 2.20.1
>>>>
>>>
>>> FWIW, I wonder if keeping that type is worth bothering.
>>> Something like
>>> old_reloc(__be32 reloc)
>>> {
>>>        u32 v = be32_to_cpu(reloc);
>>>        int offset, type;
>>>
>>> #if (defined(mc68000) && !defined(CONFIG_COLDFIRE))
>>>        /* old m68k uses unusual format - type is in lower bits of octet 3 */
>>>        type = v % 4;
>>>        offset = (int)v / 4;
>>> #else
>>>        /* everything else (including coldfire) has it in upper bits of octet 0 */
>>>        type = v >> 30;
>>>        offset = (int)(v << 2) >> 2; /* or (v & 0x1fffffff) - (v & 0x20000000) * 4 */
>>> #endif
>>>        ...
>>>
>>> and to hell with bitfields, aliasing unions, etc.  Unless I'm misreading
>>> the whole thing, that is...  Greg?
>>
>> I think you are right. This is much better.
>> The old mc6800 is the odd one out, the rest have it in network order,
>> and this makes that much clearer.
> 
> Is that correct for Microblaze, which can be big or little endian?

It is true for all architectures that use flat. All fields inside a
flat format binary are store in network order.

The final processing of the relocation entries in the elf2flt
converter tool:

    for (i=0; i<reloc_len; i++) reloc[i] = htonl(reloc[i]);

Regards
Greg


