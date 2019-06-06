Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E587C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 23:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AC520717
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 23:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CQ2czUJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfFFXPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 19:15:46 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:36369 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFFXPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 19:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559862945; x=1591398945;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=aM8dRNNhCuRSED8C8Oc74ThBFAMLPPJJcz08vPpy1+I=;
  b=CQ2czUJOVLMn7qWm2TiKGrHpHNaO4Uu7cVL3wENYJxz4T7G4+af3dRWX
   bQPTSUeUNIUuIPbWA6BM3vNXxOzv7YTALRpgks04i9vL0Kum6Nws/obYO
   ZsNc48Hdm2MVeIPOUX/cff1s4WVc98SLLCcjRszaIKEgfdJaKwz2rC8me
   yVXfQXzIEl8moSISyd0TDDRFK6Tvn0BzjSx09ZilWTs4/zF1YC6yn0Kd7
   t+JOtmV55n/40e+pCY5rZ/W+epgHhrf6wvNpX9nhWN5VUqB/KBXFWf3Y6
   aGRG4skAXPJcKr4D0Ng3B7Icq3rSAEhIxUf7QTHMEVrSGa4kqxCkHoUMz
   A==;
X-IronPort-AV: E=Sophos;i="5.63,561,1557158400"; 
   d="scan'208";a="111270892"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 07:15:45 +0800
IronPort-SDR: kEO1784+QzgnuqkNf70d1plcSSs6uGI73eVQs8qoaPvix+NH3DEec8alJxZbxZ5AWPumrWGGRu
 bb9HlGfH6sNhGo6Vj8RjQxtsFRzZd44OQkKaf5poqlJv/qKpa8hucNGiBEUhSlIS3/LmZiSkiO
 b9ykXE69subHL9btlPQT2/xCRsQc/x2S/y07CLWdZN+R/8na0WBkQWAvBQzZoFWwEOclw1mtYO
 XNPiO/pIrWOw0YwlqPJYLe76VPRvqzy6kTSqDHx9SY6B8OEybn4D3ugFRg0FfjpKjf2amloMJs
 s893fAs1hcWiW2Wuy8CCinyp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 06 Jun 2019 15:50:38 -0700
IronPort-SDR: 0uzpy0OABTK631+vt4PZaTzOPuv2jsT7PoBTW3gy3XUetZx0y2iO3qy3RNG4yzWbP+iflJwaiu
 SqLPpZQtX8WBzIM8av0SjkTox/5maoWyh+useQzNBzpojpFn7NecUrxchJO4Tfc7aXFmzHKFAe
 ++84UCZ34X5TH4mYA0hcISQgbwDDWOlTIvDliZH1XE9djkNlVysBDi8lIMmzu1B/ImnXEjVyM+
 4fQH8bF5LKrEx20xECan36vYzuoi/y5wFfAnXcTNGTfCs5VExDPXOm3Wx33efC57J9mhaUobdi
 6c8=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Jun 2019 16:15:45 -0700
Subject: Re: [PATCH v3 0/5] arch: riscv: add board and SoC DT file support
To:     Kevin Hilman <khilman@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20190602080500.31700-1-paul.walmsley@sifive.com>
 <7h36kogchx.fsf@baylibre.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <05010310-baa2-c711-cb54-96a9138f582a@wdc.com>
Date:   Thu, 6 Jun 2019 16:15:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7h36kogchx.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/19 10:37 AM, Kevin Hilman wrote:
> Hi Paul,
> 
> Paul Walmsley <paul.walmsley@sifive.com> writes:
> 
>> Add support for building flattened DT files from DT source files under
>> arch/riscv/boot/dts.  Follow existing kernel precedent from other SoC
>> architectures.  Start our board support by adding initial support for
>> the SiFive FU540 SoC and the first development board that uses it, the
>> SiFive HiFive Unleashed A00.
>>
>> This third version of the patch set adds I2C data for the chip,
>> incorporates all remaining changes that riscv-pk was making
>> automatically, and addresses a comment from Rob Herring
>> <robh@kernel.org>.
>>
>> Boot-tested on v5.2-rc1 on a HiFive Unleashed A00 board, using the
>> BBL and open-source FSBL, with modifications to pass in the DTB
>> file generated by these patches.
> 
> Tested this series on top of v5.2-rc3 on HiFive Unleashed board using
> OpenSBI + mainline u-boot (master branch as of today).
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> 
>> This patch series can be found, along with the PRCI patch set
>> and the DT macro prerequisite patch, at:
>>
>> https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1
> 
> nit: I only see this series in that branch, not any of the prerequisite
> patches you mentioned, which made me assume I could this series alone on
> top of v5.2-rc3, which worked just fine.
> 

I tried only this series on top of v5.2-rc3. Kernel boots file with DT 
updated via U-Boot. But networking didn't come up.

Do you have networking up after the boot? If yes, can you please share 
the config.

> Kevin
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


-- 
Regards,
Atish
