Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D42C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A58E20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="lz75J0c+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDJTrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:47:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35335 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJTro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:47:44 -0400
Received: by mail-lf1-f67.google.com with SMTP id u21so2769722lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=tU3vJekCKusblL9JvPKb8fGI54ySYcXX423SgGxmtnE=;
        b=lz75J0c+2+/nYWDgDrkTzfoFBgpjpYZiolonjWgHpsrBRWEYbYSOrFcTy+PZ37H2gi
         Wn/WqxG9i1/0kM/DaiquP+UtmAow5xxYT0vyjMjcE5GwOgxuZ4VItzfPQB3/Rcalw2dF
         rpVrUmDlKpMeMHzx42nHlNtSCnd84+uioCq80fQFzI1xHZPuJsrzbDeSMnuKfHtqx0ck
         cl+7AmLYMN0trIxbPMxN3vG8hljqQqQVzA0mufFs2BG7HkEE6hnxtbrmloMKmoxIVOG+
         kIdvJJpCFS/6S6BNhHOOyEFpgKG/hcpsGJgjVCyB/ucBqgyP8FCSCpxdHcbhewG1wGDn
         +gTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=tU3vJekCKusblL9JvPKb8fGI54ySYcXX423SgGxmtnE=;
        b=RzVlkgv2/SC0mhdwMmHu3cwz/jf6Vso/bL3bWoUc3GQTWtYwmfcEPGCk+/DqIi9tI3
         nuEX4l9OZb1eyVtvlYYsxFM8vw332QN3ijyTDwTRIK0Pp6xP4+xtYPU9DwkROx0AzdVb
         S5I6ZdRsqSnfTQzRwfbd61K7MGAy6WbSnxJl+VGCcN09ofmzlrG0r2KlmRVAX3wV0D6V
         HRooM9ufo/gFOtRMfxyEZaF5ZsUZNNuApJ5pISPn94zpxE0RvMoOwyrQmPbpzXX4ounY
         YWRWaitIhABjOb6g0iqK1wpu17vQ4+s/AcHlO3XUJx+4Hvxx5ssC7Y0SD5tWsBQPI5S+
         i3ag==
X-Gm-Message-State: APjAAAVGAeKewcZUa5MdIQ+M8AwwnRn7NgmQS30HEmE1m0iZHYRF9PKm
        Ax49zT01Ky6jdTfUOuxMK3I9zA==
X-Google-Smtp-Source: APXvYqxy1tAbFCAhSJaDaJvkxDCt1s1TyA1VNuMNzdbY34ExcBXiEIStlGNJvGhzLOdQLI0+th8VnA==
X-Received: by 2002:ac2:41d8:: with SMTP id d24mr9780382lfi.56.1554925662134;
        Wed, 10 Apr 2019 12:47:42 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.84.172])
        by smtp.gmail.com with ESMTPSA id t21sm3471081lfb.65.2019.04.10.12.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:47:41 -0700 (PDT)
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <231f7423-bf13-99f8-427b-530f5446348b@cogentembedded.com>
 <OF7F1B534F.B934A9FE-ON482583D0.001DC618-482583D0.001FE84B@mxic.com.tw>
 <6d60bbef-a8ef-849e-33f3-3db35cefc09f@cogentembedded.com>
 <OFAEA16021.C7F7B095-ON482583D1.0031A13D-482583D1.00335085@mxic.com.tw>
 <869a1c6d-cfa6-35e9-592b-4e0937530e31@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <9cf8bd62-10d2-fb8d-a001-261cf9166c59@cogentembedded.com>
Date:   Wed, 10 Apr 2019 22:47:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <869a1c6d-cfa6-35e9-592b-4e0937530e31@cogentembedded.com>
Content-Type: multipart/mixed;
 boundary="------------854A01743A26F124AB02C562"
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------854A01743A26F124AB02C562
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 04/09/2019 02:20 PM, Sergei Shtylyov wrote:

> [...]
>>>>>> +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>>>>>> +   if (ret)
>>>>>> +      return ret;
>>>>>> +
>>>>>> +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>>>>>> +                &desc->info.op_tmpl, &offs, &len);
>>>>>> +
>>>>>> +   regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, 0);
>>>>>> +   regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RBURST(32) |
>>>>>> +           RPC_DRCR_RBE);
>>>>>> +
>>>>>> +   regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
>>>>>> +   regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
>>>>>
>>>>>    So you're not even trying to support flashes larger than the
>>> read dirmap?
>>>>> Now I don't think it's acceptable (and I have rewritten this code
>>> internally).
>>>>
>>>> what about the size comes form mtd->size ?
>>>
>>>    I'm not talking about size here; we should use the full address.
>>> I'm attaching
>>> my patch...
>>
>> okay,got it!
>> what about just
>> -      regmap_write(rpc->mfd->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
>> +      regmap_write(rpc->mfd->regmap, RPC_DREAR,
>> +                   RPC_DREAR_EAV(offs >> 25) | RPC_DREAR_EAC(1));
>>
>> because only > 64MByte size make RPC_DREAR_EAV() work.
> 
>    Seems OK now, after Boris' reply.

   Well, actually not. The 'len' check in the beginning is oversimplified.
Attached is the patch fixing up the dirmap read path (and making it handle
flashes > 64 MiB as well)...

>> thanks & best regards,
>> Mason
> 
> [...]

MBR, Sergei

--------------854A01743A26F124AB02C562
Content-Type: text/x-patch;
 name="spi-renesas-rpc-fix-dirmap-read.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="spi-renesas-rpc-fix-dirmap-read.patch"

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: spi: renesas-rpc: fix dirmap read

allow reading from large flashes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/spi/spi-renesas-rpc.c   |   11 +++++++----
 include/linux/mfd/renesas-rpc.h |    2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)

Index: renesas/drivers/spi/spi-renesas-rpc.c
===================================================================
--- renesas.orig/drivers/spi/spi-renesas-rpc.c
+++ renesas/drivers/spi/spi-renesas-rpc.c
@@ -264,13 +264,15 @@ static ssize_t rpc_spi_mem_dirmap_read(s
 {
 	struct rpc_spi *rpc =
 			spi_controller_get_devdata(desc->mem->spi->controller);
+	loff_t from = offs & (RPC_DIRMAP_SIZE - 1);
+	size_t size = RPC_DIRMAP_SIZE - from;
 	int ret;
 
 	if (offs + desc->info.offset + len > U32_MAX)
 		return -EINVAL;
 
-	if (len > 0x4000000)
-		len = 0x4000000;
+	if (len > size)
+		len = size;
 
 	ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
 	if (ret)
@@ -284,13 +286,14 @@ static ssize_t rpc_spi_mem_dirmap_read(s
 		     RPC_DRCR_RBE);
 
 	regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
-	regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
+	regmap_write(rpc->regmap, RPC_DREAR,
+		     RPC_DREAR_EAV(offs >> 25) | RPC_DREAR_EAC(1));
 	regmap_write(rpc->regmap, RPC_DROPR, 0);
 	regmap_write(rpc->regmap, RPC_DRENR, rpc->smenr);
 	regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
 	regmap_write(rpc->regmap, RPC_DRDRENR, 0);
 
-	memcpy_fromio(buf, rpc->dirmap + desc->info.offset + offs, len);
+	memcpy_fromio(buf, rpc->dirmap + desc->info.offset + from, len);
 
 	return len;
 }
Index: renesas/include/linux/mfd/renesas-rpc.h
===================================================================
--- renesas.orig/include/linux/mfd/renesas-rpc.h
+++ renesas/include/linux/mfd/renesas-rpc.h
@@ -57,6 +57,7 @@
 #define RPC_DRCMR_OCMD(c)	(((c) & 0xFF) << 0)
 
 #define RPC_DREAR		0x0014	// R/W
+#define RPC_DREAR_EAV(v)	(((v) & 0xff) << 16)
 #define RPC_DREAR_EAC(c)	(((c) & 0x7) << 0)
 
 #define RPC_DROPR		0x0018	// R/W
@@ -140,6 +141,7 @@
 #define RPC_PHYOFFSET2		0x0084	// R/W
 #define RPC_PHYOFFSET2_OCTTMG(v) (((v) & 0x7) << 8)
 
+#define RPC_DIRMAP_SIZE		0x4000000
 #define RPC_WBUF_SIZE		256	// Write Buffer size
 
 struct rpc {

--------------854A01743A26F124AB02C562--
