Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE791C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E59A2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Ew+e7GQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfFUTwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 15:52:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42830 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfFUTwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:52:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id y13so5870939lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wso9AT0PLE8YSVz4mFagGPGoqkgjnJ4hhl/knflL07M=;
        b=Ew+e7GQyGGn3VMUMvlmlNk529darBgRUJ/dcJFSuTVhcptTW0Osp8jReJotYp3YmKA
         f6eeGrLRGAbz3L8Of3mQVbcQDLORcn3KXYXhPmuLEmtkhvEZh+lMjKapiefa6/uiNl2W
         sMOLt5EglU5sNbD9GTGtO5A5tcs2ho6YQ53d4IWO8ykmDYB7C1u0OYGN4kKeIMmQbB8t
         sCsUfdPPmodLtBotaF1sfyp3QcvscC+eoN6kkXc3skMo0VaCzrVmg+NLHLSyIaA9tmok
         kdq69iSb8NJ1pNNEYW3c7xUwEyznK+nW7o7MOGRmdKVvN+I8ayYLDei7JYMyJxs3C0XZ
         O92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wso9AT0PLE8YSVz4mFagGPGoqkgjnJ4hhl/knflL07M=;
        b=Jku6nR1XGndjCunXsTZCChv5lF9AA0TF9y41AM8ch7T9c/P9XNy1/+TiriuN8ENeEp
         ie7bYnBwQlNI3ZLct2iP69omkwkAX2/dkA/HIOHLZB3fzze7t5KSZsJNWLuuWJ3+vrX2
         Fg5wSdhV7k6pzrYZGU/tvV8Kaerp+fQlfeOkAVvCNZi0LjDGRgdD6rVCBaG6GJsTeQnq
         Ba0MDNUGQjppvJkNvTIM0s+cZxOnCwpAF046Nn63Y8UKSvhnIlWuUusLskZDb8QmwSPm
         RSOCOrz89ElwZ73YBrv1fhwYWX4rXBftx4C+8xH8Edt7iAU7MrR4y6TxkYIaiNLz7rcU
         X7vQ==
X-Gm-Message-State: APjAAAX1Rk4tL+NvBYO747g0AT5qkYwt3RLck0GLmo6fHuEibpVtq8Km
        jQ6QCorj31C+kracTVFjq2MVF8d4SYg=
X-Google-Smtp-Source: APXvYqx3uKDLsq5HSFMYR5JCV7tpvJVm6zODfloD79xoOac4SxateHkoi4zxVApNcx1Fez+sYLEylg==
X-Received: by 2002:a19:ca1e:: with SMTP id a30mr3669450lfg.163.1561146725828;
        Fri, 21 Jun 2019 12:52:05 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.87.14])
        by smtp.gmail.com with ESMTPSA id n3sm513817lfh.3.2019.06.21.12.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 12:52:05 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v7 3/5] mtd: Add support for HyperBus memory devices
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190620172250.9102-1-vigneshr@ti.com>
 <20190620172250.9102-4-vigneshr@ti.com>
Organization: Cogent Embedded
Message-ID: <4d17e914-cd1f-c6fe-b70a-6aae02e0cf4e@cogentembedded.com>
Date:   Fri, 21 Jun 2019 22:52:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190620172250.9102-4-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 06/20/2019 08:22 PM, Vignesh Raghavendra wrote:

> Cypress' HyperBus is Low Signal Count, High Performance Double Data Rate
> Bus interface between a host system master and one or more slave
> interfaces. HyperBus is used to connect microprocessor, microcontroller,
> or ASIC devices with random access NOR flash memory (called HyperFlash)
> or self refresh DRAM (called HyperRAM).
> 
> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
> signal and either Single-ended clock(3.0V parts) or Differential clock
> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
> At bus level, it follows a separate protocol described in HyperBus
> specification[1].
> 
> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
> to that of existing parallel NORs. Since HyperBus is x8 DDR bus,
> its equivalent to x16 parallel NOR flash wrt bits per clock cycle. But
> HyperBus operates at >166MHz frequencies.

   s/wrt/WRT/.

> HyperRAM provides direct random read/write access to flash memory
> array.
> 
> But, HyperBus memory controllers seem to abstract implementation details
> and expose a simple MMIO interface to access connected flash.
> 
> Add support for registering HyperFlash devices with MTD framework. MTD
> maps framework along with CFI chip support framework are used to support
> communicating with flash.
> 
> Framework is modelled along the lines of spi-nor framework. HyperBus
> memory controller (HBMC) drivers calls hyperbus_register_device() to
> register a single HyperFlash device. HyperFlash core parses MMIO access
> information from DT, sets up the map_info struct, probes CFI flash and
> registers it with MTD framework.
> 
> Some HBMC masters need calibration/training sequence[3] to be carried
> out, in order for DLL inside the controller to lock, by reading a known
> string/pattern. This is done by repeatedly reading CFI Query
> Identification String. Calibration needs to be done before trying to detect
> flash as part of CFI flash probe.
> 
> HyperRAM is not supported at the moment.
> 
> HyperBus specification can be found at[1]
> HyperFlash datasheet can be found at[2]
> 
> [1] https://www.cypress.com/file/213356/download
> [2] https://www.cypress.com/file/213346/download
> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>     Table 12-5741. HyperFlash Access Sequence
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[...]
> diff --git a/include/linux/mtd/hyperbus.h b/include/linux/mtd/hyperbus.h
> new file mode 100644
> index 000000000000..ead969aad35b
> --- /dev/null
> +++ b/include/linux/mtd/hyperbus.h
> @@ -0,0 +1,86 @@
[...]
> +/**
> + * struct hyperbus_ops - struct representing custom HyperBus operations
> + * @read16: read 16 bit of data to flash in a single burst. Used to read

   s/to flash/from flash/.

[...]
> +#endif /* __LINUX_MTD_HYPERBUS_H__ */

   I thought you agreed to add the #defines for the HF commands. Well, I can add them
as well...

MBR, Sergei
