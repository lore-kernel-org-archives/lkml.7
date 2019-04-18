Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B383C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44BB20821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Me8xyGum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389574AbfDRQjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:39:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42524 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:39:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id w23so2105338lfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q9SN4l7UyWsDjFX3sHxki8ZWqrL4mJS7jSv1YjPxhPE=;
        b=Me8xyGum4KaZOfgILRJHXLzuCzKg954py9giPTofkNRlG1aJJ1K8v78Z2A7GUd2ZiN
         yCHcDalaxKOz4HpvP0h+ywTg/oJbRT9ECLORzI/S6krIuLiDVCU34w4jh3XJEatoGsIS
         kw3GBYhagFQkY0L+5MEox6/dYPRIo2L1FS9tmSm5JleRPL7EkqoOZAoOQhaO9N4WR3n1
         noy2GuGI4HlIOAXdnyKq4S+TpSMWXTlFg6+ZtSPCRqLO1mRpWQBM3dnT3UjNIn5fm2HK
         HNo3e45JEZ4xiAzbJmDjbRzboRIw47PgnS7dSzktgKw1XuS+tpyF+g6sw+x8a0+eWCRG
         xUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=q9SN4l7UyWsDjFX3sHxki8ZWqrL4mJS7jSv1YjPxhPE=;
        b=qSC5Du7EkTdNWyPjejl8BttR/sLfXQnrFWSQFAGsCrz90mKHR7Lm8S0b6XhmyqZBTF
         9e4vZ5ZMhoq3k+fZlPwEM9wnSpFH4pHx9vhc/XLG1InHZ/QCAfkTlUN1YTIXHBhmjfTG
         qgrYqO0zY7HDPcAYQCCFJbCsAz0LRGK+bp9fucb4285uZbd30n3eK6M9MYXXfjcjd4cq
         hm+t7dPQ/+CeCYwaVMWAIqDIe8SvL3s8jmb5XqZ0N9WrracosGT3HPA8Xa09Qho9RGTx
         DnQwBGnqeVvoQvILNtYjVKclwHfVMC15ghyoIKO7a4hMps5vKNhiCmbCAr/kufirWT/y
         38pg==
X-Gm-Message-State: APjAAAWHFEDSSqR1y0DaOzSjwfr69cq8uTu+qd3bMfpwiUhndit1YJgo
        nBSh+BhdtujGw1IkIOVQRUy0oYleXZw=
X-Google-Smtp-Source: APXvYqxwAf436imAJJPPOENJrclK50l31qpMeHpQ4YFeNfcZCi0+lIRAxk6GJaGeOGn7q7oh/wzCCw==
X-Received: by 2002:a19:f203:: with SMTP id q3mr2614113lfh.78.1555605544768;
        Thu, 18 Apr 2019 09:39:04 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.82.67])
        by smtp.gmail.com with ESMTPSA id 5sm541595lfy.73.2019.04.18.09.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 09:39:03 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] MTD: Add Initial Hyperbus support
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        devicetree@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org
References: <20190412092923.24919-1-vigneshr@ti.com>
 <9e8575e2-b8de-341d-7ab5-08055b84c805@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <9ec33aa3-91aa-15f1-bd25-f94eccc65fcb@cogentembedded.com>
Date:   Thu, 18 Apr 2019 19:39:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <9e8575e2-b8de-341d-7ab5-08055b84c805@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 04/17/2019 08:24 PM, Vignesh Raghavendra wrote:

>> Vignesh Raghavendra (5):
>>    mtd: cfi_cmdset_0002: Add support for polling status register
>>    dt-bindings: mtd: Add binding documentation for HyperFlash
>>    mtd: Add support for HyperBus memory devices
>>    dt-bindings: mtd: Add bindings for TI's AM654 HyperBus memory
>>      controller
>>    mtd: hyperbus: Add driver for TI's HyperBus memory controller
>>
> 
> Thanks for all the reviews!
> Were you able to test this series with your hardware? Would like to get this into v5.2-rc1 if possible

   Not yet, and I still haven't ported my driver to use your HyperBus code.

> Regards
> Vignesh

MBR, Sergei
