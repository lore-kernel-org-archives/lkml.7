Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F63C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915F22070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCsQffW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCDI7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:59:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33385 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCDI7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:59:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id h11so2626083pgl.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 00:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lddv2BvAmg/3+JQ4vKHXyk6c9KK8aWBcC10kuHFotIE=;
        b=aCsQffW9bHgFsHEjyiL0WYr+qXXa/X/A0zFv6nyDl6WLSyHUkwWwobzZNHzZoYWX4K
         RMmuEa+FCiwSIRTXVNJ0cFXAHQZi8S4IbZYwQHplr/XIKVR7k8fY5krxrFlTBIFtbwqF
         gAtLM07nVyhBuSQ+A01nfWrmp/KAeGDzo3o4T/tJlxlpXTyzIVEIgO5jSGaAUQC5Qq+T
         0INyYKt/MC7Y99aACAKBK90db/5+I2CXTwHBObRqQD2zwma1tEoHnXSDyB0lagrXUsnT
         UbEQ2hZGj5QN1Y4ylRsMdXM4g85gBOJS7VW2saOf7GPI6H8xCUq1OBYyLCAQCy0cS9VV
         IO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lddv2BvAmg/3+JQ4vKHXyk6c9KK8aWBcC10kuHFotIE=;
        b=L+OebBsjm+DG8wlCdUEIFZkFj4SwkysK4ceTYxAix0K6XW2+rmJ6FcmbxDTxhxQSfk
         cfywO1lxPqbGklCCSicpt0ViYDt2syKZ7N6chCkJwF5pjmSVWHH/nuCHQasgf7NXbltg
         VSfKvawHfQQadxAb+IohApU/xGKHF+NE68klyikQd/7R1YKwM3aGMYkPWKlqg/l7dD0j
         O8UVTVcb+R62AB4JrNwk4z/J+8zdU4eywPaoLJ5/EHTAhMxZXmxOSjfntS9gKJXVCX5z
         zCU19wULELMwHpsznii/z60KfkwT7JCKemcJBnp1n5jVMUT+wmoZFZr1B05DlblDeGXs
         wMAA==
X-Gm-Message-State: APjAAAWZ8s9Af0hhyozVBHEEQ9ulWCufiYBpzB5jBn2LEKsMLtBU3lo/
        Yl0IRJ/gGHZp1X/jVPVnSOkNwA==
X-Google-Smtp-Source: APXvYqx29GhlVQ8RsybKS3HusLQT3Z8LHVCra3jqbS/ewyVOOv7hsDoDqrkrqAulnuQGRR1J1M1o7Q==
X-Received: by 2002:a17:902:2dc3:: with SMTP id p61mr19031099plb.166.1551689950721;
        Mon, 04 Mar 2019 00:59:10 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k8sm7395523pgg.75.2019.03.04.00.59.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 00:59:09 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/4] Add new features for the Spreadtrum serial controller
Date:   Mon,  4 Mar 2019 16:58:20 +0800
Message-Id: <cover.1551689518.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes the baud rate calculation formula issue, as well as
adding power management support and DMA mode support for the Spreadtrum
serial controller.

Changes from v1:
 - The patch 1 of V1 was applied, so remove the baud rate fix from this patch set.
 - Add reviewed tag from Rob for patch 1.
 - Fix the incorrect names' order in patch 3.

Lanqing Liu (4):
  dt-bindings: serial: sprd: Add clocks and clocks-names properties
  serial: sprd: Add power management for the Spreadtrum serial
    controller
  dt-bindings: serial: sprd: Add dma properties to support DMA mode
  serial: sprd: Add DMA mode support

 .../devicetree/bindings/serial/sprd-uart.txt       |   17 +-
 drivers/tty/serial/sprd_serial.c                   |  501 +++++++++++++++++++-
 2 files changed, 498 insertions(+), 20 deletions(-)

-- 
1.7.9.5

