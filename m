Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81C0CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC59421835
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0xhsRa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfJ2Lnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:43:33 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:40530 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfJ2Lnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:43:33 -0400
Received: by mail-wr1-f49.google.com with SMTP id o28so13272088wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9twwSC3KKkX5NFClf9qDXmGQTEsyZtLZnuYbLSSEf4=;
        b=b0xhsRa4PgyoD/ivXLDHLynLZKDNsDv8stCFmPfrCWBct1zqVjx0KAv0WKvo1SM3AS
         luPu6Ys0V+MxMYEYBm5SKmBDLVUsleflRREBAb43y9ZnzCXcwM5PeNmGytxyrSDDAp65
         VgP+1xWBJu44cu+xDU4ECkTiKNzpMAJcqro+LpM3u6/j9YZ8nNMXwlwV1pgIupLbGVji
         cbyHSKsEarveG2p7vbysdXaO6/F/pEIgRBJd2Wvh0ks+Yz23qVFilC+Eyb1VBcnr5pGS
         jJSNjIRaJIVckoqIJgR0bf0nOMQXNF9yI/y3k6ZBffBkXk/F7SZsFzSJJCrMifM67YBT
         fnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9twwSC3KKkX5NFClf9qDXmGQTEsyZtLZnuYbLSSEf4=;
        b=EWtCFrNvjuXOY/eyVFotMVIrcw2+QTIMHxExSQffo5TsHCVeW6wqVCofv9cbf7KCim
         e/Aege613JYXZSqL45dYDnJgo6nqVAF3ifAoN5+6RkQsi5+PqVNCxpmXoV2dMw0EUA4N
         SPcqcN5dqq0NhxNNncrVhaTGuI9xCfhxHzeqtlgK+ehMvMQjhcPzg+c98pxZwXpDWeCC
         9kS1AoHxf9v7FR+76EHict6do8C/Gu0UZyavNrJ94+lilEI1sSGOAA8h4xhwP90DO+TP
         Q+M+6MgV+R2L/xNSBtG7Z7kdQ7xdxfEmZ7RyEHSI9czA9FfxvZT8MPrKLOgPSGwatSfy
         0l+A==
X-Gm-Message-State: APjAAAWKI9KQzsafnF+bFY5tHXBAZ+1z1PEOoTvKG874EcGpT69DlWIz
        xvUnG4GkqtBkE5IovwTakv5WAw==
X-Google-Smtp-Source: APXvYqw9eq/aeSJ7zg4mRQRc49zW6dvlZNmR9bTpdIDTMMnJX/vFxp1dccUkocf1RCYpXl047Lsyew==
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr19929451wrp.296.1572349411116;
        Tue, 29 Oct 2019 04:43:31 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q25sm26559864wra.3.2019.10.29.04.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:43:30 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/10] nvmem: patches(set 1) for 5.5
Date:   Tue, 29 Oct 2019 11:42:30 +0000
Message-Id: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.5 which includes:
- New provider for Rockchip OTP and Spreadtrum eFuse.
- Hole region support in imx scu driver.
- few trivial fixes.

Can you please queue them up for 5.5.

thanks,
srini

Baolin Wang (1):
  nvmem: sc27xx: Change to use devm_hwspin_lock_request_specific() to
    request one hwlock

Finley Xiao (1):
  nvmem: add Rockchip OTP driver

Freeman Liu (2):
  dt-bindings: nvmem: Add Spreadtrum eFuse controller documentation
  nvmem: sprd: Add Spreadtrum SoCs eFuse support

Heiko Stuebner (1):
  dt-bindings: nvmem: add binding for Rockchip OTP controller

Lucas Stach (1):
  nvmem: imx-ocotp: reset error status on probe

Peng Fan (2):
  nvmem: imx: scu: support hole region check
  nvmem: imx: scu: support write

Sebastian Reichel (1):
  nvmem: core: fix nvmem_cell_write inline function

Srinivas Kandagatla (1):
  nvmem: imx: scu: fix dependency in Kconfig

 .../bindings/nvmem/rockchip-otp.txt           |  25 ++
 .../devicetree/bindings/nvmem/sprd-efuse.txt  |  39 ++
 drivers/nvmem/Kconfig                         |  23 +
 drivers/nvmem/Makefile                        |   4 +
 drivers/nvmem/imx-ocotp-scu.c                 | 120 ++++-
 drivers/nvmem/imx-ocotp.c                     |   4 +
 drivers/nvmem/rockchip-otp.c                  | 268 +++++++++++
 drivers/nvmem/sc27xx-efuse.c                  |  13 +-
 drivers/nvmem/sprd-efuse.c                    | 424 ++++++++++++++++++
 include/linux/nvmem-consumer.h                |   2 +-
 10 files changed, 903 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
 create mode 100644 drivers/nvmem/rockchip-otp.c
 create mode 100644 drivers/nvmem/sprd-efuse.c

-- 
2.21.0

