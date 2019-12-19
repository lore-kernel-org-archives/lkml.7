Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8F1C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C184B2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srWIczF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLSJ3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:29:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53192 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLSJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:29:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so4680924wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 01:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AwcynCAB8dmhDVrPZzNhCAtkvCBJgVaLCigdZVhu4dI=;
        b=srWIczF+g/KZIcwnNxAcr05vmE5y1j1isQTSU8xSC0bnypoPSXtRS5nYWyD/w1tGnH
         sgWwM5VXdGF+v0DetE0l0Awa46q562zigMi1bsFlEsbfpXjw6qx81NaVj7fqnCmM8JGS
         Ge1O2FAchSvZcTvMp4HTB3eX5zRex92sJQrgoZI+O2PfPDG6+8/W+7eKoXRbGD7JRwdl
         fepNQvdjsFMwX9vQEtKOCQD6ZyEthF4p/E1ZZnbyEngW80Hl9bDfz6XCmE8twr05Ixbw
         Gco9hufwR4t28tIrxVoL/gvqpLZcm3vHtjg3pJgAwWm5pNqZqCYwesgkudFUBuAljeG/
         gRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AwcynCAB8dmhDVrPZzNhCAtkvCBJgVaLCigdZVhu4dI=;
        b=LTDnx5BUQlageOI3n60h5TRsHFq9UUUUwlclWpfBctQaI4j0/LwarUB1u5/eWa7PSG
         6oKzcrrZHpouTpCLp9WEgI2rKfcNb473cKtzAZ5SW9jhrD/TGuY0Tu5pWEcCBONUxEyi
         0WeFOk6uFOcjKD1kZwVfhT8RzbuLnnbia2euMDDctSpHnFRGNDafJmI96iLgoYCGlesB
         JO3s7SRBJ7IBorcK89PCBLieMqNf0dHcifBN9vm7nH/49YlmzQKa390Du1zAnv+kNeuf
         ZEy9Dtp7BFQjKgidgi3JMhu+/A3fJb8MFzLrt4WS33CILEEeuALTqfFFg4+kxC9tZ9ax
         +RXg==
X-Gm-Message-State: APjAAAXyt/Ic4Ht+rL25dy/UhHIIFNzcRL7WQA1vGwx4MrJmC3SI8V+R
        8dGY2M/o5nrLKzt0vyFayfApNw==
X-Google-Smtp-Source: APXvYqyZvNDj+IC2Bkj9K9Nk41cpwvkkMxBfTULUwaN7stMhyACDzuUZKubB++Qm1tIFf+FaSdxq6g==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr8492440wma.72.1576747741029;
        Thu, 19 Dec 2019 01:29:01 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s1sm5627356wmc.23.2019.12.19.01.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 01:29:00 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     robh@kernel.org, bgoswami@codeaurora.org, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 0/2] soundwire: Add support to Qualcomm SoundWire master
Date:   Thu, 19 Dec 2019 09:28:40 +0000
Message-Id: <20191219092842.10885-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the v4 patchset.
Here is new patchset addressing all the comments from v3

This patchset adds support for Qualcomm SoundWire Master Controller
found in most of Qualcomm SoCs and WCD audio codecs.

This driver along with WCD934x codec and WSA881x Class-D Smart Speaker
Amplifier drivers is tested on on DragonBoard DB845c based of SDM845
SoC and Lenovo YOGA C630 Laptop based on SDM850.

SoundWire controller on SDM845 is integrated in WCD934x audio codec via
SlimBus interface.

Currently this driver is very minimal and only supports PDM.

Most of the code in this driver is rework of Qualcomm downstream drivers
used in Andriod. Credits to Banajit Goswami and Patrick Lai's Team.

TODO:
	Test and add PCM support.

Thanks,
srini

Changes since v4:
	- moved stream handling to codec as there is a strong hw requirements
	 on port and PA enable sequence on codec side
	- removed dummy runtime pm 
	- cleaned up code as suggested by Pierre


Srinivas Kandagatla (2):
  dt-bindings: soundwire: add bindings for Qcom controller
  soundwire: qcom: add support for SoundWire controller

 .../bindings/soundwire/qcom,sdw.txt           | 167 ++++
 drivers/soundwire/Kconfig                     |   9 +
 drivers/soundwire/Makefile                    |   4 +
 drivers/soundwire/qcom.c                      | 856 ++++++++++++++++++
 4 files changed, 1036 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
 create mode 100644 drivers/soundwire/qcom.c

-- 
2.21.0

