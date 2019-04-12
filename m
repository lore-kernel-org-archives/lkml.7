Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E678C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673332084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s9hXBuAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfDLKGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:06:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39633 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfDLKGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:06:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so11175434wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZJfIU5gkl1Vb0G63ZXfxI+zDLp2o966pseSwL3myPN8=;
        b=s9hXBuAMW9ljkuOVwZcZWqDtxaqsyeePb+oNncEYVJFI9HghxgeYCxMZ00NVTH68wh
         r/r76z20GhLGZ0Rj5YDcBwrLY81fQCgwpN0U95RZ851LX7eDGVUTjmVhHFc8ZJE+1axm
         Lb5aSGlq9Gv4t3OxQPykJytA6Npw3N/TdzaBTnJaqhg/F7OsKfFzi0/kBpevNqcu4RJF
         xFeMkJ4c5/4Y2gVDwXWwat9rH/tRK60I8VMPgoBKSTh9obn2sj7hWQi5INTE9Ur3m59S
         k5nLC4AgV0j/dTpyyxJcU5VSOl/MM2DaO6t/2q1EhaS2mzrNWabOytrlr4SfxJNNCV+Q
         PD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZJfIU5gkl1Vb0G63ZXfxI+zDLp2o966pseSwL3myPN8=;
        b=DqfcehYTLgZRpFAhP5B86004H7c7PO0DE0CC/yEA7/Ar3SRGTFk5Qg7Iqg5icY6vXx
         qUmoQZ+bkq/qIH8I+QHPQ71KZHzZM4Z9les4tzc68zmzZlWg7wt/Y6pcE8Mf/bHWIlGV
         n1ZsP9QVBzGMBhwqzA7Yx0RayXPEC4smlNFw6yeJqMyytp8tnDRq9o00tdNzuBZgOukT
         xAzHL+NC0EOBj1194ja7AxFJQQb/hzkf95+R+NKIGX4UB5y6DB9RHxSO0AvoQeJ5p5zs
         EU0b6SiV49QfXPpM4Tmo33s/mNZJciCcEQztV8urHHpoWYA5HdgIdMvIgudTa64kXiq9
         M5dw==
X-Gm-Message-State: APjAAAUgb6YZM8IsxjVsmzRdQ39Y2DS0ct3m8yzjAke4LLPZY7/3J54s
        aKD3iWuaBTOhBGJ3j0rddZiDBg==
X-Google-Smtp-Source: APXvYqzlrUvWqzUPEDQKBXnmJFyh09RPCuIzvrKlFKqXhWoK/2JGjnyhDmcBU5qN4Kw2aiyjFdRqug==
X-Received: by 2002:adf:c10e:: with SMTP id r14mr34107737wre.168.1555063571818;
        Fri, 12 Apr 2019 03:06:11 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id c2sm30957459wrr.13.2019.04.12.03.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:06:11 -0700 (PDT)
Subject: Re: [PATCH 0/2] soundwire: fix Kconfig select/depend issues
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <189ee558-766c-0e94-9570-3bf283681795@linaro.org>
Date:   Fri, 12 Apr 2019 11:06:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/2019 20:28, Pierre-Louis Bossart wrote:
> 0-day/Kbuild starts complaining about missed module dependencies and
> compilation issues. Since codecs and soc drivers need to be compilable
> independently, let's fix this using the following model:
> 
> SOUNDWIRE_INTEL ---- select -----------
>                                        |
> 				      v
> REGMAP_SOUNDWIRE --- select ---> SOUNDWIRE_BUS
> 

Last time when I looked at this, Kconfig symbols SOUNDWIRE_BUS and 
SOUNDWIRE looked totally redundant and bit over done.

Removing SOUNDWIRE_BUS Kconfig did clean it up and made it bit more 
align with others.
regarding REGMAP_SOUNDWIRE, It should be selected by the codec/soundwire 
slave drivers isn't it?


------------------------------><-----------------------------------
diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 6ad5ef48b61e..8cd2ac650b50 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -44,7 +44,7 @@ config REGMAP_IRQ

  config REGMAP_SOUNDWIRE
  	tristate
-	depends on SOUNDWIRE_BUS
+	depends on SOUNDWIRE

  config REGMAP_SCCB
  	tristate
diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 5c8677e20b49..bcee4b101c8a 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -3,7 +3,7 @@
  #

  menuconfig SOUNDWIRE
-	bool "SoundWire support"
+	tristate "SoundWire support"
  	---help---
  	  SoundWire is a 2-Pin interface with data and clock line ratified
  	  by the MIPI Alliance. SoundWire is used for transporting data
@@ -16,17 +16,12 @@ if SOUNDWIRE

  comment "SoundWire Devices"

-config SOUNDWIRE_BUS
-	tristate
-	select REGMAP_SOUNDWIRE
-
  config SOUNDWIRE_CADENCE
  	tristate

  config SOUNDWIRE_INTEL
  	tristate "Intel SoundWire Master driver"
  	select SOUNDWIRE_CADENCE
-	select SOUNDWIRE_BUS
  	depends on X86 && ACPI && SND_SOC
  	---help---
  	  SoundWire Intel Master driver.
diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index f6fbb21d4e84..9d70d20ca3ce 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -1,10 +1,11 @@
  #
  # Makefile for soundwire core
  #

  #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
-obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
+soundwire-objs= bus_type.o bus.o slave.o mipi_disco.o stream.o
+obj-$(CONFIG_SOUNDWIRE) += soundwire.o

  #Cadence Objs
  soundwire-cadence-objs := cadence_master.o
------------------------------><-----------------------------------

--srini
> 
> Pierre-Louis Bossart (2):
>    regmap: soundwire: fix Kconfig select/depend issue
>    soundwire: fix SOUNDWIRE_BUS option
> 
>   drivers/base/regmap/Kconfig | 3 ++-
>   drivers/soundwire/Kconfig   | 1 -
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
