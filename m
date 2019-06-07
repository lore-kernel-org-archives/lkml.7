Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B929C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D856E208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iLG359sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbfFGR6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:58:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13841 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730728AbfFGR6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559930310; x=1591466310;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=woJa8oDcFeR2tkr19R+p4o+CE4xnVzjrKnTOpvLa3lc=;
  b=iLG359spsbqDp8PNBStrYGVZ2p52J1kZEzgW2guetPV/9cKsRUwour6K
   SFgcwm0gnoSY8lDs4tIO4SiuO6cluHmciJWe05jukiJ48TrsDfusty/wW
   JdTMl64S4emL0zLWj6RNPQNTRFve/sFKnqjNMPIN/9XyA9tbRgmCHf49T
   1wnzpcaOxp8H0t1HeEChC85U+kB6AaS5+y2OsItt2NL4bq1cVmcw2JFrn
   fbEtYPSM7+kGmZA98TT0UC240+EGjeZztr7A13g+cFaFV/+O1zK6EQe/0
   c90ZqCXCF6XgAPnx2/Msr/eN6TkNvqLBmi9TRasiesahAM5PbKxAr9Z04
   A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; 
   d="scan'208";a="216362527"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 01:58:21 +0800
IronPort-SDR: f8wvUdVXwSlqKxwDD7dky98ZdU263/ZX5OfIpqsiYhk2I11u+0VGHKgi8PyQt5iASPUBIwHS8J
 UFDtqx8ROB8Ov2ZO+wEzOD9Jf8K/6Mi4Y5+RuRT9AEHquJbeCB29EWjPxCs45+lpX85DWknkG4
 BQ0l+WnUXvgEcJL+jfhiA9tNXqabNgjDKp98qP5zGif2WWpye/uVSTNFv4vzOYEgAshy3+QzL4
 NJCsfedi35wvyA6tyOx1BwT9rMCPdR0Vksww5G9gcXn2TXvKOir67jOVD1sfyIWdDLkFVb1cug
 35P5lDRDBQ+LwFJuh3Ueof5o
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2019 10:33:14 -0700
IronPort-SDR: 9ydF7SBc0h/lVUEWTPyG2EwzSjQ/jM1gCbTbXoA60RiLQCcxrzXErJ3WXlF+ZONWg+5rX5e7zB
 2jKYHy/M1YI3WdoP/Yj1FZp6yGKx48Q9q9CLvLGiHnQ4v9ntFLRIgNn3eE2mfqKXjeyqvavs4P
 PkgTdA8XtjGhNocg7a4X8ko1qvKFzqtzSrXWH9ZNuOlb3+7h2U/GotkRh9LQRPvb0fjwEuCytb
 HtrvWmelq9kOyNw58zByYcXORpFFRWa3ndhpKfx/36IBTsGkFap81gndsuHyQfsiLMrwxuy2QB
 HGU=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 10:58:21 -0700
Subject: Re: [PATCH v3 0/5] arch: riscv: add board and SoC DT file support
To:     Kevin Hilman <khilman@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20190602080500.31700-1-paul.walmsley@sifive.com>
 <7h36kogchx.fsf@baylibre.com> <05010310-baa2-c711-cb54-96a9138f582a@wdc.com>
 <7hftolcp90.fsf@baylibre.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <cf846786-10ed-f0ee-8664-b831a72386da@wdc.com>
Date:   Fri, 7 Jun 2019 10:58:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7hftolcp90.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/19 9:52 AM, Kevin Hilman wrote:
> Atish Patra <atish.patra@wdc.com> writes:
> 
>> On 6/5/19 10:37 AM, Kevin Hilman wrote:
>>> Hi Paul,
>>>
>>> Paul Walmsley <paul.walmsley@sifive.com> writes:
>>>
>>>> Add support for building flattened DT files from DT source files under
>>>> arch/riscv/boot/dts.  Follow existing kernel precedent from other SoC
>>>> architectures.  Start our board support by adding initial support for
>>>> the SiFive FU540 SoC and the first development board that uses it, the
>>>> SiFive HiFive Unleashed A00.
>>>>
>>>> This third version of the patch set adds I2C data for the chip,
>>>> incorporates all remaining changes that riscv-pk was making
>>>> automatically, and addresses a comment from Rob Herring
>>>> <robh@kernel.org>.
>>>>
>>>> Boot-tested on v5.2-rc1 on a HiFive Unleashed A00 board, using the
>>>> BBL and open-source FSBL, with modifications to pass in the DTB
>>>> file generated by these patches.
>>>
>>> Tested this series on top of v5.2-rc3 on HiFive Unleashed board using
>>> OpenSBI + mainline u-boot (master branch as of today).
>>>
>>> Tested-by: Kevin Hilman <khilman@baylibre.com>
>>>
>>>> This patch series can be found, along with the PRCI patch set
>>>> and the DT macro prerequisite patch, at:
>>>>
>>>> https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1
>>>
>>> nit: I only see this series in that branch, not any of the prerequisite
>>> patches you mentioned, which made me assume I could this series alone on
>>> top of v5.2-rc3, which worked just fine.
>>>
>>
>> I tried only this series on top of v5.2-rc3. Kernel boots file with DT
>> updated via U-Boot. But networking didn't come up.
>>
>> Do you have networking up after the boot? If yes, can you please share
>> the config.
> 
> I didn't test networking from the kernel initially, but looking now, I
> do not have networking come up in the kernel either.
>

ok. I am not alone then :).

@Paul: Do you get networking up in your FSBL + BBL + Linux boot flow 
with the DT patch series ?

> Kevin
> 



-- 
Regards,
Atish
