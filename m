Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57121ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5E820659
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2StEBJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390455AbfJPCu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:50:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36822 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389882AbfJPCu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:50:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id o12so33939599qtf.3;
        Tue, 15 Oct 2019 19:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=U0Z5HisauZe2iHOuTduiI3CoVYv9qoYMP5yXHXCMrRg=;
        b=n2StEBJNe1dRBdmxo24SeBjCmeM4di4xNbXfvXZ04I9znQb9QoIXnqpEnj6Sz7S5WV
         dOPjUBwJSaiwmLd6tLRXCTMeg3FaCazuZHEdDBLfp2ZN2SHo70/zKeo8b8N+F7fqtfcd
         UepRpWDcSAd7pKsJfv0PkAEmSliArI556HJEdhOMCj2lK3/+SQk6bpIlVW/TjqwEdIvt
         6H6sIuyVCognBOgZC4zrVU/j6KRYm6/UsU5mV6SkDKT/v4rMLyZ+HzfATtZjU/AUsRlQ
         ElldLEiHji2SjGJMqDjBAPRbwyBo/0llZ2LxbtvCE68AlwUVUym/cVKrg+IeF5E+pIf7
         gvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=U0Z5HisauZe2iHOuTduiI3CoVYv9qoYMP5yXHXCMrRg=;
        b=jY3IvEXAa5k75wTvL4lGMSqQ5ou5/muxzkdLZo5Z1fjrNwZJjt1/lioazuAqyTH3Aw
         9CqQH/0B/ZfcYE0q2YOn7wPA2uRELA4XS9OvCQXIylxAfvk8PaeHdegUIS8up4/lDfxq
         cmrjbTmKTuVwWC+cVILzleMxqK09vhxAmzioGKCnVQ1C3SpI5uMk8e4YeywJBKbyyU/I
         l8wPFVUH2bkjNE2SHIgj1xcYGjfxNyPVkvGoqLBQlaMQapKMJCCQM/YyX07VdmcRn2M4
         Of66yonU8eA1ouEWks/91B0tXk6wNOjjHXbOqD4CGWeQ7u8gNfIqrjnOh93mF6xYMnCd
         Z4vQ==
X-Gm-Message-State: APjAAAXsPT32hw7d9Fi2hE3ry9VqZN0xJw1kYqvfIUC2yjOJcOLbDbUX
        bCypbUZN+DOSanoQYsPuLecRBYaZxD0=
X-Google-Smtp-Source: APXvYqwk+xVnrHVs7bZQjb6igqAhc+cdO5izE8uSLDp9QI9dv1kUdkzhUOlX78ecxuiT6Wk4pAbytw==
X-Received: by 2002:aed:24e9:: with SMTP id u38mr41851049qtc.30.1571194258669;
        Tue, 15 Oct 2019 19:50:58 -0700 (PDT)
Received: from smtp.gmail.com ([2804:d43:421:ecd6:45ed:dc65:8f65:8e1])
        by smtp.gmail.com with ESMTPSA id c8sm10409249qko.102.2019.10.15.19.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 19:50:58 -0700 (PDT)
Date:   Tue, 15 Oct 2019 23:50:54 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v2 0/2] iio: adc: Add driver support for AD7292
Message-ID: <20191016025051.bstkghi4ug4upxvr@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a basic driver for the AD7292 ADC/DAC system along
with device tree binding documentation.

Changelog V2:
- made SPI rx/tx buffers separated fields in the state struct
- adjusted spi_transfer tx_buf pointer
- at probe, stored vref supply for later reference 
- removed regulator_get_voltage() from read_raw() INFO_SCALE
- added a comment to make clear when internal voltage reference will be used
- use standard channel definition to specify the ADC channels in dt-binding doc

Marcelo Schmitt (2):
  iio: adc: Add driver support for AD7292
  dt-bindings: iio: adc: Add DT docs for AD7292

 .../bindings/iio/adc/adi,ad7292.yaml          | 107 ++++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad7292.c                      | 350 ++++++++++++++++++
 5 files changed, 476 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
 create mode 100644 drivers/iio/adc/ad7292.c

-- 
2.23.0

