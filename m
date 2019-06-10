Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA33C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3636820859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbfFJKxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:53:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40579 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbfFJKxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:53:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so4842922pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 03:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IrBElB7Dvt+ekOLqOELcuBpGs5ztYGEVdrqPLh5WW7s=;
        b=QT4rHmFbwB1C1/6hJxmu0iaRi5v7maTfPw6ylsIocA7Mxjai1gIRLioOsbOvMVw1Da
         OiLY0ZOtQgcFmsC/nLo9tDthW/hN3IGAH49PTq4zmXJZ0mnxfQH8NVa4HGSoZoan77Gd
         pAkY96SAzcM9Sf1rW0VP4yMhrcwTYYYs0GfPxEH+qQol94NXy37A5/nsdePU2Nn5hck8
         9LFXXb8cRMW/YOwL0tXE+z+59Qr3dmbWIo3PgD0PAebU6YlvTkDKcr/KaHi2C3FWH9/s
         RmKCdcbqNNYJlBgltvsrg+o4B9+HhhTX36Xs8LMNnmibDlGSydQ4H+ed+vd8yTckUERU
         o6Uw==
X-Gm-Message-State: APjAAAWzNlv2d6K0DYtN0r9KZut5XRpz/Yz/mqtBFBEAx4h7Lw5osnlv
        BoJXFJxtWfcp2w1jiY8VIbi1nB6sxg0=
X-Google-Smtp-Source: APXvYqxPGMw3+1D+l5TB5e4THCbfQTkpsGSeU+iebeT0+u8S9YvnaAd7W1WrJYym+gmERVkL4+w6IQ==
X-Received: by 2002:aa7:808d:: with SMTP id v13mr73501435pff.198.1560163982899;
        Mon, 10 Jun 2019 03:53:02 -0700 (PDT)
Received: from localhost.localdomain ([122.177.221.32])
        by smtp.gmail.com with ESMTPSA id p43sm10611287pjp.4.2019.06.10.03.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:53:01 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to
 vmcoreinfo
To:     James Morse <james.morse@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Steve Capper <Steve.Capper@arm.com>, kexec@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Dave Anderson <anderson@redhat.com>,
        bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
 <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
 <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
 <58c6cda9-9fd4-3b3e-740a-7b9b80b1f634@redhat.com>
 <a48bb02c-8f93-4e3b-085d-a6f0e5a1f3a0@arm.com>
 <66da4098-b221-408b-50ca-f3790b943965@redhat.com>
 <380b137b-a611-5c8d-3890-8021084f87fe@redhat.com>
 <2a4af3a0-1342-fdd2-1cfd-e37abb99d8bd@arm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <3ab2ca1a-95de-cecf-f590-1e2d00bb644b@redhat.com>
Date:   Mon, 10 Jun 2019 16:22:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2a4af3a0-1342-fdd2-1cfd-e37abb99d8bd@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 06/07/2019 08:41 PM, James Morse wrote:
> Hi Bhupesh,
> 
> (sorry for the delay on this)

No problem.

> On 04/05/2019 13:53, Bhupesh Sharma wrote:
>> On 04/03/2019 11:24 PM, Bhupesh Sharma wrote:
>>> On 04/02/2019 10:56 PM, James Morse wrote:
>>>> Yes the kernel code is going to move around, this is why the information we expose via
>>>> vmcoreinfo needs to be thought through: something we would always need, regardless of how
>>>> the kernel implements it.
>>>>
> 
>>>> Pointer-auth changes all this again, as we may prefer to use the bits for pointer-auth in
>>>> one TTB or the other. PTRS_PER_PGD may show the 52bit value in this case, but neither TTBR
>>>> is mapping 52bits of VA.
>>>>
>>>>
>>>>> So far, I have generally come across discussions where the following variations of the
>>>>> address spaces have been proposed/requested:
>>>>> - 48bit kernel VA + 48-bit User VA,
>>>>> - 48-bit kernel VA + 52-bit User VA,
>>>>
>>>> + 52bit kernel, because there is excessive quantities of memory, and the kernel maps it
>>>> all, but 48-bit user, because it never maps all the memory, and we prefer the bits for
>>>> pointer-auth.
>>>>
>>>>> - 52-bit kernel VA + 52-bit User VA.
>>>>
>>>> And...  all four may happen with the same built image. I don't see how you can tell these
>>>> cases apart with the one (build-time-constant!) PTRS_PER_PGD value.
>>>>
>>>> I'm sure some of these cases are hypothetical, but by considering it all now, we can avoid
>>>> three more kernel:vmcoreinfo updates, and three more fix-user-space-to-use-the-new-value.
>>>
>>> Agree.
>>>
>>>> I think you probably do need PTRS_PER_PGD, as this is the one value the mm is using to
>>>> generate page tables. I'm pretty sure you also need T0SZ and T1SZ to know if that's
>>>> actually in use, or the kernel is bodging round it with an offset.
>>>
>>> Sure, I am open to suggestions (as I realize that we need an additional VA_BITS_ACTUAL
>>> variable export'ed for 52-bit kernel VA changes).
> 
> (stepping back a bit:)
> 
> I'm against exposing arch-specific #ifdefs that correspond to how we've configured the
> arch code's interactions with mm. These are all moving targets, we can't have any of it
> become ABI.

Sure, I understand your concerns.

> I have a straw-man for this: What is the value of PTE_FILE_MAX_BITS on your system?
> I have no idea what this value is or means, an afternoon's archaeology would be needed(!).
> This is something that made sense for one kernel version, a better idea came along, and it
> was replaced. If we'd exposed this to user-space, we'd have to generate a value, even if
> it doesn't mean anything. Exposing VA_BITS_ACTUAL is the same.
> 
> (Keep an eye out for when we change the kernel memory map, and any second-guessing based
> on VA_BITS turns out to be wrong)
> 
> 
> What we do have are the hardware properties. The kernel can't change these.
> 
> 
>>> Also how do we standardize reading T0SZ and T1SZ in user-space. Do you propose I make an
>>> enhancement in the cpu-feature-registers interface (see [1]) or the HWCAPS interface
>>> (see [2]) for the same?
> 
> cpufeature won't help you if you've already panic()d and only have the vmcore file. This
> stuff needs to go in vmcoreinfo.
> 
> As long as there is a description of how userspace uses these values, I think adding
> key/values for TCR_EL1.TxSZ to the vmcoreinfo is a sensible way out of this. You probably
> need TTBR1_EL1.BADDR too. (it should be specific fields, to prevent 'new uses' becoming ABI)
> 
> This tells you how the hardware was configured, and covers any combination of TxSZ tricks
> we play, and whether those address bits are used for VA, or ptrauth for TTBR0 or TTRB1.

Fair enough. Let me try and experiment with this suggestion a bit and I 
will come back with a RFC patch/patchset by this weekend. Hopefully, it 
will cover all the weird PA/VA bit combinations we are handling in arm64 
distros these days :)

Thanks,
Bhupesh


>> Any comments on the above points? At the moment we have to carry these fixes in the
>> distribution kernels and I would like to have these fixed in upstream kernel itself.
> 
> 
> Thanks,
> 
> James
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

