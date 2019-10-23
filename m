Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED66CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2BD2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389858AbfJWHMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:12:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:51184 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732481AbfJWHMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:12:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E5F8B3F9;
        Wed, 23 Oct 2019 07:12:02 +0000 (UTC)
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Qian Cai <cai@lca.pw>, catalin.marinas@arm.com
Cc:     f.fainelli@gmail.com, marc.zyngier@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        Robin Murphy <Robin.Murphy@arm.com>, phill@raspberrypi.org,
        will@kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
References: <6703f8dab4a21fe4e1049f8f224502e1733bf72c.camel@suse.de>
 <A1A8EEF0-2273-4338-B4D8-D9B1328484B4@lca.pw>
 <9208de061fe2b9ee7b74206b3cd52cc116e43ac0.camel@suse.de>
 <AA6D37F1-A1B3-4EC4-8620-007095168BC7@lca.pw>
 <1956a2c8f4911b2a7e2ba3c53506c0f06efb93f8.camel@suse.de>
From:   Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; prefer-encrypt=mutual; keydata=
 mQINBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABtCRNYXR0aGlhcyBC
 cnVnZ2VyIDxtYnJ1Z2dlckBzdXNlLmNvbT6JAjgEEwECACIFAlV6iM0CGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJENkUC7JWEwLx6isQAIMGBgJnFWovDS7ClZtjz1LgoY8skcMU
 ghUZY4Z/rwwPqmMPbY8KYDdOFA+kMTEiAHOR+IyOVe2+HlMrXv/qYH4pRoxQKm8H9FbdZXgL
 bG8IPlBu80ZSOwWjVH+tG62KHW4RzssVrgXEFR1ZPTdbfN+9Gtf7kKxcGxWnurRJFzBEZi4s
 RfTSulQKqTxJ/sewOb/0kfGOJYPAt/QN5SUaWa6ILa5QFg8bLAj6bZ81CDStswDt/zJmAWp0
 08NOnhrZaTQdRU7mTMddUph5YVNXEXd3ThOl8PetTyoSCt04PPTDDmyeMgB5C3INLo1AXhEp
 NTdu+okvD56MqCxgMfexXiqYOkEWs/wv4LWC8V8EI3Z+DQ0YuoymI5MFPsW39aPmmBhSiacx
 diC+7cQVQRwBR6Oz/k9oLc+0/15mc+XlbvyYfscGWs6CEeidDQyNKE/yX75KjLUSvOXYV4d4
 UdaNrSoEcK/5XlW5IJNM9yae6ZOL8vZrs5u1+/w7pAlCDAAokz/As0vZ7xWiePrI+kTzuOt5
 psfJOdEoMKQWWFGd/9olX5ZAyh9iXk9TQprGUOaX6sFjDrsTRycmmD9i4PdQTawObEEiAfzx
 1m2MwiDs2nppsRr7qwAjyRhCq2TOAh0EDRNgYaSlbIXX/zp38FpK/9DMbtH14vVvG6FXog75
 HBoOuQINBFP2BfcBEACwvZTDK9ItC4zE5bYZEu8KJm7G0gShS6FoFZ0L9irdzqtalO7r3aWE
 t3htGkomQTicTexppNXEgcUXe23cgdJrdB/zfVKVbf0SRwXGvsNs7XuRFOE7JTWTsoOFRCqF
 FpShPU3OevKS+lOU2zOFg2MDQIxhYfbj0wleBySIo57NIdtDZtla0Ube5OWhZIqWgWyOyZGx
 vtWfYWXJ4/7TQ9ULqPsJGpzPGmTJige6ohLTDXMCrwc/kMNIfv5quKO0+4mFW/25qIPpgUuB
 IhDLhkJm4xx3MonPaPooLDaRRct6GTgFTfbo7Qav34CiNlPwneq9lgGm8KYiEaWIqFnulgMp
 lZWx5HDuslLlQWey3k4G6QEiM5pJV2nokyl732hxouPKjDYHLoMIRiAsKuq7O5TExDymUQx8
 8PXJcGjTRss9q2S7EiJszQbgiy0ovmFIAqJoUJzZ/vemmnt5vLdlx7IXi4IjE3cAGNb1kIQB
 wTALjRLeueHbBmGxwEVn7uw7v4WCx3TDrvOOm35gcU2/9yFEmI+cMYZG3SM9avJpqwOdC0AB
 /n0tjep3gZUe7xEDUbRHPiFXDbvKywcbJxzj79llfuw+mA0qWmxOgxoHk1aBzfz0d2o4bzQh
 r6waQ2P3KWnvgw9t3S3d/NCcpfMFIc4I25LruxyVQDDscH7BrcGqCwARAQABiQQ+BBgBAgAJ
 BQJT9gX3AhsCAikJENkUC7JWEwLxwV0gBBkBAgAGBQJT9gX3AAoJELQ5Ylss8dNDXjEP/1ys
 Qpk7CEhZffZRe8H+dZuETHr49Aba5aydqHuhzkPtX5pjszWPLlp/zKGWFV1rEvnFSh6l84/T
 yWQIS5J2thtLnAFxCPg0TVBSh4CMkpurgnDFSRcFqrYu73VRml0rERUV9KQTOZ4xpW8KUaMY
 600JQqXyXAu62FTt0ZNbviYlpbmOOVeV2DN/MV0GRLd+xd9yZ4OEeHlOkDh7cxhUEgmurpF6
 m/XnWD/PF0DTaCMmAa8mVdNvo6ARkY0WvwsYkOEs/sxKSwHDojEIAlKJwwRK7mRewl9w4OWb
 jMVpXxAMF68j+z9OA5D0pD8QlCwb5cEC6HR2qm4iaYJ2GUfH5hoabAo7X/KF9a+DWHXFtWf3
 yLN6i2arX7QnWO322AzXswa+AeOa+qVpj6hRd+M6QeRwIY69qjm4Cx11CFlxIuYuGtKi3xYk
 jTPc0gzfTKI3H+vo4y7juXNOht1gJTz/ybtGGyp/JbrwP5dHT3w0iVTahjLXNR63Dn1Ykt/a
 Pm7oPpr2nXR2hjmVhQR5OPL0SOz9wv61BsbCBaFbApVqXWUC1lVqu7QYxtJBDYHJxmxn4f6x
 tXCkM0Q7FBpA8yYTPCC/ZKTaG9Hd1OeFShRpWhGFATf/59VFtYcQSuiH/69dXqfg+zlsN37v
 k0JD+V89k3MbGDGpt3+t3bBK1VmlBeSGh8wP/iRnwiK8dlhpMD651STeJGbSXSqe5fYzl5Rv
 IdbSxlU+cvs5rg4peg6KvURbDPOrQY1mMcKHoLO8s5vX6mWWcyQGTLQb/63G2C+PlP/froSt
 QX6VB+A20Q0pjoify3DTqE8lu7WxRNAiznQmD2FE2QNIhDnjhpyTR/M66xI8z6+jo6S8ge3y
 1XR9M7Wa5yXAJf/mNvvNAgOAaJQiBLzLQziEiQ8q92aC6s/LCLvicShBCsoXouk9hgewO15Z
 H+TabYE6PRyJkMgjFVHT1j2ahAiMEsko3QnbVcl4CBqbi4tXanWREN3D9JPm4wKoPhCLnOtn
 JaKUJyLqMXVNHZUS33ToTb4BncESF5HKfzJvYo75wkPeQHhHM7IEL8Kr8IYC6N8ORGLLXKkU
 XdORl3JrQ2cyCRr0tfAFXb2wDD2++vEfEZr6075GmApHLCvgCXtAaLDu1E9vGRxq2TGDrs5x
 HKe19PSVsqVJMRBTEzTqq/AU3uehtz1iIklN4u6B9rh8KqFALKq5ZVWhU/4ycuqTO7UXqVIH
 p0YimJbSzcvDIT9ZsIBUGto+gQ2W3r2MjRZNe8fi/vXMR99hoZaq2tKLN7bTH3Fl/lz8C6Sn
 HRSayqF4p6hKmsrJEP9aP8uCy5MTZSh3zlTfpeR4Vh63BBjWHeWiTZlv/e4WFavQ2qZPXgQv
 uQINBFP2CRIBEACnG1DjNQwLnXaRn6AKLJIVwgX+YB/v6Xjnrz1OfssjXGY9CsBgkOipBVdz
 KHe62C28G8MualD7UF8Q40NZzwpE/oBujflioHHe50CQtmCv9GYSDf5OKh/57U8nbNGHnOZ1
 6LkxPxuITbNV30NhIkdnyW0RYgAsL2UCy/2hr7YvqdoL4oUXeLSbmbGSWAWhK2GzBSeieq9y
 WyNhqJU+hKV0Out4I/OZEJR3zOd//9ngHG2VPDdK6UXzB4osn4eWnDyXBvexSXrI9LqkvpRX
 jmDJYx7rvttVS3Etg676SK/YH/6es1EOzsHfnL8ni3x20rRLcz/vG2Kc+JhGaycl2T6x0B7x
 OAaQRqigXnuTVpzNwmVRMFC+VgASDY0mepoqDdIInh8S5PysuPO5mYuSgc26aEf+YRvIpxrz
 Ye8A27kL1yXJC6wl1T4w1FAtGY4B3/DEYsnTGYDJ7s7ONrzoAjNsSa42E0f3E2PBvBIk1l59
 XZKhlS/T5X0R8RXFPOtoE1RmJ+q/qF6ucxBcbGz6UGOfKXrbhTyedBacDw/AnaEjcN5Ci7Uf
 KksU95j0N9a/jFh2TJ460am554GWqG0yhnSQPDYLe/OPvudbAGCmCfVWl/iEb+xb8JFHq24h
 BZZO9QzcAJrWmASwG8gQGJW8/HIC0v4v4uHVKeLvDccGTUQm9QARAQABiQIfBBgBAgAJBQJT
 9gkSAhsMAAoJENkUC7JWEwLxCd0QAK43Xqa+K+dbAsN3Km9yjk8XzD3Kt9kMpbiCB/1MVUH2
 yTMw0K5Bz61z5Az6eLZziQoh3PaOZyDpDK2CpW6bpXU6w2amMANpCRWnmMvS2aDr8oD1O+vT
 sq6/5Sji1KtL/h2MOMmdccSn+0H4XDsICs21S0uVzxK4AMKYwP6QE5VaS1nLOQGQN8FeVNaX
 jpP/zb3WUSykNZ7lhbVkAf8d0JHWtA1laM0KkHYKJznwJgwPWtKicKdt9R7Jlg02E0dmiyXh
 2Xt/5qbztDbHekrQMtKglHFZvu9kHS6j0LMJKbcj75pijMXbnFChP7vMLHZxCLfePC+ckArW
 jhWU3HfpF+vHMGpzW5kbMkEJC7jxSOZRKxPBYLcekT8P2wz7EAKzzTeUVQhkLkfrYbTn1wI8
 BcqCwWk0wqYEBbB4GRUkCKyhB5fnQ4/7/XUCtXRy/585N8mPT8rAVclppiHctRA0gssE3GRK
 uEIuXx1SDnchsfHg18gCCrEtYZ9czwNjVoV1Tv2lpzTTk+6HEJaQpMnPeAKbOeehq3gYKcvm
 DL+bRCTjmXg8WrBZdUuj0BCDYqneaUgVnp+wQogA3mHGVs281v1XZmjlsVmM9Y8VPE614zSi
 ZQBL5CinBTTI8ssYlV/aIKYi0dxRcj6vYnAfUImOsdZ5AQja5xIqw1rwWWUOYb99
Message-ID: <796c6b37-67a0-9598-a146-5f298e0cd0c1@suse.com>
Date:   Wed, 23 Oct 2019 09:11:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1956a2c8f4911b2a7e2ba3c53506c0f06efb93f8.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/10/2019 13:23, Nicolas Saenz Julienne wrote:
> On Mon, 2019-10-21 at 16:36 -0400, Qian Cai wrote:
>> I managed to get more information here,
>>
>> [    0.000000] cma: dma_contiguous_reserve(limit c0000000)
>> [    0.000000] cma: dma_contiguous_reserve: reserving 64 MiB for global area
>> [    0.000000] cma: cma_declare_contiguous(size 0x0000000004000000, base
>> 0x0000000000000000, limit 0x00000000c0000000 alignment 0x0000000000000000)
>> [    0.000000] cma: Failed to reserve 512 MiB
>>
>> Full dmesg:
>>
>> https://cailca.github.io/files/dmesg.txt
> 
> OK I got it, reproduced it too.
> 
> Here are the relevant logs:
> 
> 	[    0.000000]   DMA      [mem 0x00000000802f0000-0x00000000bfffffff]
> 	[    0.000000]   DMA32    [mem 0x00000000c0000000-0x00000000ffffffff]
> 	[    0.000000]   Normal   [mem 0x0000000100000000-0x00000097fcffffff]
> 
> As you can see ZONE_DMA spans from 0x00000000802f0000-0x00000000bfffffff which
> is slightly smaller than 1GB.
> 
> 	[    0.000000] crashkernel reserved: 0x000000009fe00000 - 0x00000000bfe00000 (512 MB)
> 
> Here crashkernel reserved 512M in ZONE_DMA.
> 
> 	[    0.000000] cma: Failed to reserve 512 MiB
> 
> CMA tried to allocate 512M in ZONE_DMA which fails as there is no enough space.
> Makes sense.
> 
> A fix could be moving crashkernel reservations after CMA and then if unable to
> fit in ZONE_DMA try ZONE_DMA32 before bailing out. Maybe it's a little over the
> top, yet although most devices will be fine with ZONE_DMA32, the RPi4 needs
> crashkernel to be reserved in ZONE_DMA.
> 
> My knowledge of Kdump is limited, so I'd love to see what Catalin has to say.
> Here's a tested patch of what I'm proposing:
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 120c26af916b..49f3c3a34ae2 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -76,6 +76,7 @@ phys_addr_t arm64_dma32_phys_limit __ro_after_init;
>  static void __init reserve_crashkernel(void)
>  {
>         unsigned long long crash_base, crash_size;
> +       phys_addr_t limit = arm64_dma_phys_limit;
>         int ret;
> 
>         ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> @@ -86,11 +87,14 @@ static void __init reserve_crashkernel(void)
> 
>         crash_size = PAGE_ALIGN(crash_size);
> 
> +again:
>         if (crash_base == 0) {
>                 /* Current arm64 boot protocol requires 2MB alignment */
> -               crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
> -                               crash_size, SZ_2M);
> -               if (crash_base == 0) {
> +               crash_base = memblock_find_in_range(0, limit, crash_size,
> SZ_2M);
> +               if (!crash_base && limit == arm64_dma_phys_limit) {
> +                       limit = arm64_dma32_phys_limit;
> +                       goto again;

I'd try to avoid the goto.
Apart from that we should write some information message that the crashkernel
got reserved in arm64_dma_phys_limit. Otherwise RPi4 might break silently and
this will give the user at least a hint what happened.

Regards,
Matthias

> +               } else if (!crash_base && limit == arm64_dma32_phys_limit) {
>                         pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>                                 crash_size);
>                         return;
> @@ -448,13 +452,13 @@ void __init arm64_memblock_init(void)
>         else
>                 arm64_dma32_phys_limit = PHYS_MASK + 1;
> 
> -       reserve_crashkernel();
> -
>         reserve_elfcorehdr();
> 
>         high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> 
>         dma_contiguous_reserve(arm64_dma_phys_limit ? : arm64_dma32_phys_limit);
> +
> +       reserve_crashkernel();
>  }
> 
>  void __init bootmem_init(void)
> 
> 
> Regards,
> Nicolas
> 
