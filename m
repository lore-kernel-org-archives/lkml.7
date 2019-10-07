Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972CBC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5D9206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z32D50Xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfJGKKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:10:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34256 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJGKKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:10:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so8363896pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 03:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XO1tUWwVg3ldpvvlr197QyBHXOPBJs+Oz3B5tCIDh7E=;
        b=z32D50XwrbQhoMs5ZlCwo6nkE3o2ABiqql4DpVNn93SVGIxKiBRu2bX3xhk6VLxzj0
         0L2ofFTziab40NeP8sLgVezl0TJJ+PW9E8mJcJsKRWZjippsF+DSNYmQ5xs20yRWAbcE
         mCRkN31mP6Xk5ZsB3SQL2k82fS+NRAnLw1dbjXYWHR2VpzTWCyMeaj75tGi8HPB9wE6z
         eOjzScJt1omj1BhxBAfCbXwCY4HTpcn2z6ImgJPTB/g0VTqlTdLnJnbYVlWfSj2jjYQg
         klO9JOZBDAQeybsbSeI+0t5mS74wXVrtJsmlJZcQVRe9yA1ywDwItK9rx0FrEkoauhbH
         gtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XO1tUWwVg3ldpvvlr197QyBHXOPBJs+Oz3B5tCIDh7E=;
        b=EWqlb/bgMiykgFP0M2lpY9S4v1Tk3sBhR1hEX6+/F+y0TYo1aVzxiX2YYSrPSgpRtO
         J5cuPlp48xurns+nMQzcxZPZk32ZAZ+iM9+tvHA1fmj22rl/l66lEpP6GK4f+a9oZ4/w
         7Bh+xc6bVXYXufXcyvp5M7bQnhsGgzPgu5fJkcnvSDmAOyuGOxNfVraWV8Ce5kG21FCy
         qMPqPclCXDWVLFutM2et5Vtfq7pUWsSxMqPJOZjEhdIUXD/4rTRwA2jQHKiNmWtJltCI
         OauWhkpUbThoXHyKU+ogiFKdvAnYCcdgA5ABaGaJH2R/vpjoqcwwoDXDM0ZixpRa9fjG
         Aa+Q==
X-Gm-Message-State: APjAAAVv+6PNPtYxXK2dQv2J1Bi0hqsySiNuMrzU0/JClV/tehc5XLlg
        Hx/6ePPl6JF9Ywo2e7W3B6vFA5ugkQ==
X-Google-Smtp-Source: APXvYqwnDB36e9vSf5ng1nGbWTuo/pYuBppzVrHRrTabh7OcBrr9kil8al08FbBTpHhuKA6wPFzfPA==
X-Received: by 2002:aa7:96c1:: with SMTP id h1mr33214998pfq.111.1570443053002;
        Mon, 07 Oct 2019 03:10:53 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:801:5b45:54fa:fc3f:2c55:c2df])
        by smtp.gmail.com with ESMTPSA id z4sm17465132pfn.45.2019.10.07.03.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 03:10:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Add support for ADUX1020 sensor
Date:   Mon,  7 Oct 2019 15:40:25 +0530
Message-Id: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds initial IIO driver support for ADUX1020 Photometric
sensor from Analog Devices. This sensor is usable for multiple optical
measurement applications, including gesture control and proximity sensing.

This initial driver includes support for only proximity mode with event
based interrupt. The driver validation has been performed using Shiratech
LTE mezzanine [1] connected to 96Boards Dragonboard410c [2].

Thanks,
Mani

[1] https://www.96boards.org/product/shiratech-lte/
[2] https://www.96boards.org/product/dragonboard410c/

Manivannan Sadhasivam (2):
  dt-bindings: iio: light: Add binding for ADUX1020
  iio: light: Add support for ADUX1020 sensor

 .../bindings/iio/light/adux1020.txt           |  22 +
 drivers/iio/light/Kconfig                     |  11 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/adux1020.c                  | 783 ++++++++++++++++++
 4 files changed, 817 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/adux1020.txt
 create mode 100644 drivers/iio/light/adux1020.c

-- 
2.17.1

