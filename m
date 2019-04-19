Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF626C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8454E21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gEoeke4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfDST3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:29:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52928 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDST3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555702175; x=1587238175;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=A+7h5WbTxEYTGjfoEubh+u73kHoj9ynkG6MnblQmpP4=;
  b=gEoeke4vkV19ClMO4xu5LH1wrQZZGhrIVMZVEKBuBHXPTfiyiMEyFOv1
   GEcYEsmj/R0AvPsKls/oEgfhy4P2S3uQ1jgm7zF+6X68DLlYIXiTA/epx
   R/3+UoJ99rlc3mHiQh29EFrAZqpLLlklE1IX6LupFP2m+sjktk4xIVfPF
   H9g8hrqeAl7qOKroda0VoYDz94vq2G/3jT9JjKEi/8jjx3rXPPE1U7lTY
   iReMlnGdmZvt2zGk3DAm0QXg0ARukyKoExg8hJbHJre6I3eRhTa7Idt6M
   ctJZidQrjsos8mzyFxsTrJAOTEQ+fguDLrFHlXnkg8BjXZbJMrKJMUhjB
   w==;
X-IronPort-AV: E=Sophos;i="5.60,371,1549900800"; 
   d="scan'208";a="212156732"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 03:29:34 +0800
IronPort-SDR: Vw2xOaMWS6rdR443v/0aHCPO6ZQ3aU9eYNIIVe9Gvg3uC4FiPD3zfCfpHahQpMwTOGLK6Xnc1o
 2eXoZ39tAlJIgcztgRZh5L4vyHVkirBVIv8iqy3imRYK9yrYnPAiiRDTG8ecCdE1BkubpZyLpQ
 +aWDENj8YElKEjYarSRAu5Nbq8WD0lvQyZTwPhVJWOBgqh1HDbcbisKqtCLWXJhfbbW7MtOZo1
 ICKM9EnMiWMyGLxPAHLAofYjkaRXhZS0pHWjs28oluyHesqMxbI15FU2izf6E7cyvl5ekVBclQ
 DXDafeY5+bX2clqZnQELUz+z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Apr 2019 12:06:14 -0700
IronPort-SDR: 6LU24F7zEw6o0ER6ll9wtyVM/KuKY0PPYLt5iD21lXXc0Dl+j+QK2O7Jz9xWQmSm6iGRqrgHHL
 tgl9C8yU/ML2cD/Cg44+Cxzl+Ut113gQx079gemju7YbfAv7wiG5hVa7lZxH3l5HwFUTkWg/4i
 6MWUDnpnwby0vJTjyZudP/58raJb5RsxerpiqzUq1KJWbYIHqocwMOlcK6BHEIkY+jmdRwCY3o
 Hkin8yYUux70pH8lCYFZZlxNUCEJr4O1sk0EaWsSoQkHxKfIWrTY2cMNV9hUmuVxaS29tgFNj0
 yrQ=
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.167]) ([10.111.66.167])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Apr 2019 12:29:35 -0700
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver for
 the SiFive FU540 UART
To:     Kevin Hilman <khilman@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <20190413020111.23400-1-paul.walmsley@sifive.com>
 <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com>
 <7h5zr9dcsi.fsf@baylibre.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <f2bb876c-2b44-663b-ea06-d849f721fb6c@wdc.com>
Date:   Fri, 19 Apr 2019 12:29:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7h5zr9dcsi.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/19 12:18 PM, Kevin Hilman wrote:
> Atish Patra <atish.patra@wdc.com> writes:
> 
>> On 4/18/19 4:22 PM, Kevin Hilman wrote:
>>> Hi Paul,
>>>
>>> Paul Walmsley <paul.walmsley@sifive.com> writes:
>>>
>>>> This series adds a serial driver, with console support, for the
>>>> UART IP block present on the SiFive FU540 SoC.  The programming
>>>> model is straightforward, but unique.
>>>>
>>>> Boot-tested on a SiFive FU540 HiFive-U board, using BBL and the
>>>> open-source FSBL (with appropriate patches to the DT data).
>>>>
>>>> This fifth version fixes a bug in the set_termios handler,
>>>> found by Andreas Schwab <schwab@suse.de>.
>>>>
>>>> The patches in this series can also be found, with the PRCI patches,
>>>> DT patches, and DT prerequisite patch, at:
>>>>
>>>> https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v5.1-rc4
>>>
>>> I tried this branch, and it doesn't boot on my unleashed board.
>>>
>>> Here's the boot log when I pass the DT built from your branch via
>>> u-boot: https://termbin.com/rfp3.
>>>
>>
>> Unfortunately, that won't work. The current DT modifications by OpenSBI.
>>
>> 1. Change hart status to "masked" from "okay".
>> 2. M-mode interrupt masking in PLIC node.
>> 3. Add a chosen node for serial access in U-Boot.
>>
>> You can ignore 3 for your use case. However, if you pass a dtb built
>> from source code, that will have hart0 enabled and M-mode interrupts
>> enabled in DT.
> 
> Hmm, so what you're saying is there not currently any way to pass a DT
> built from source using OpenSBI + mainline u-boot?
> 

OpenSBI can accept DT built from source with following build option.

FW_PAYLOAD_FDT="<unleashed>.dtb"

More documentation:
https://github.com/riscv/opensbi/blob/master/docs/firmware/fw_payload.md

> As a short-term workaround, is there a way to make these changes from
> the u-boot command-line after loading a DTB built from source into
> memory?  If so, I could at least script that part.
> 
> 
>> Not sure if we should do these DT modifications in U-Boot as well.
> 
> I guess so (and I'd be happy to test the patch.)
> 
> Either that, or the upstream DTs (or code) should have those features to
> the right settings.
> 
> Speaking of which, I tried to patch the DT from Paul's recent series[1]
> to make the necessary changes.  I can see where to change cpu0 from
> "okay" to "masked", but I'm not so sure how to make the PLIC change.
> 

Here is the code snippet of how OpenSBI modifies the DT.

https://github.com/riscv/opensbi/blob/master/platform/sifive/fu540/platform.c#L53

If you just want to use custom built DTB, you can use OpenSBI build 
option instead of scripting these.

We don't want OpenSBI to keep modifying the DT forever. But we have to 
do it until there is a better solution available.

> I was hoping to be able to review/test Paul's DT patches, but now I'm a
> bit confused as to how to do that.
> 
>> I also noticed that your kernel is booting only 1 hart.
>> Just FYI: RISC-V SMP for U-Boot patches are merged in master. So you
>> should be able to boot all cpus. You can ingore FU540_ENABLED_HART_MASK
>> in OpenSBI build as well.
> 
> Ah, nice.
> 
> I've just updated to u-boot master branch with SMP enabled, and build a
> new openSBI (also from master branch) with u-boot payload. Using your
> v5.1-rc4_unleashed branch, I see 4 CPUs booting:
> https://termbin.com/kg13
> 

Great.

Regards,
Atish
> Thanks,
> 
> Kevin
> 
> [1] https://lore.kernel.org/lkml/20190413020111.23400-1-paul.walmsley@sifive.com/T/#m77daa2857b76ec7cbca0672ad03ae286f61ca0e6
> 

