Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6312FECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3544C21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eo44T3ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfJGPjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:39:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39769 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfJGPje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:39:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id e1so8443831pgj.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aqxBeTv+Uaor0p8Sdaehy27crOZap/vMuOdocajh3K8=;
        b=Eo44T3ue9PTyK90zuRJpURaKwjZEippo0XCcpL1sQTu3b1SYC11r0oG760/AMone7/
         oxxU5fvuJmJkaGMzctM59CMsVLzNd4+bj0Mzrbk2Od7v8bD70h+Oh+6hiipr411VftEC
         otDSZD7sKX3dtf9n1t2MFjO5mgkWp6Sy5roRv0+oJkJ3eYFZFqeCQYRpCW1ik6E60ERo
         3If7rHRQ9V6/H4YVOofEu5Tm/4LA1NSZ3SbzL3XeS8RBAkVf5y1fejGv52F2Z9Dkvf3C
         mNGExhBVcDTxPQxsS+49oK+vxFenxEAOGJX476kAHo6Gu1PoesP+rukD6pXkstRuzzy2
         u3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aqxBeTv+Uaor0p8Sdaehy27crOZap/vMuOdocajh3K8=;
        b=R1vsidcpRA/at8oorf83CaJPswIdSzLbxNlWaXkwKKQWti6cR0d03PqtKFEjarlygi
         AGfHhgJGYzbxXl0ovWK1ldN/maSH81v9ZzZqE1RX+NAjxr6zNzLyxBraqdQ/pKehrE31
         lXs+HhP5GsyCzv3zku/dEO/95kTm/LLz5PBw1Al+zo9oufpi4x/Homk3QisEP3KN0JCP
         UKGBR4/5uqnpmYsTPNkTCDY4pgw8pNMjmZdVmRipilCCV0dFBQGb92IpBHb5pwkJq4SF
         Zg5IhrtYudfNc1bSwyTUrNslY+oPqRcMyxu0qSHlF8uIGnS9q6wU9OG/FJekaInzyb9h
         k4xQ==
X-Gm-Message-State: APjAAAX+zGytb2Q8WsdAjbd8nJvquLkUcUjRHkaX77ZfdlaPgkApLdoj
        o/KFuT5EDcr4BbKu4mIhy/Ya
X-Google-Smtp-Source: APXvYqxp9EVNuIxWAF4JhI63OtaIYOBD0UTnkXJOxhywvLLiF23kdWSzZs3AK8N9xrT/wgs6bfQNFw==
X-Received: by 2002:a63:350f:: with SMTP id c15mr31560380pga.225.1570462773734;
        Mon, 07 Oct 2019 08:39:33 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7088:cb7f:1889:38a3:2d:5880])
        by smtp.gmail.com with ESMTPSA id d69sm15945077pfd.175.2019.10.07.08.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:39:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org
Cc:     alexandru.Ardelean@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/2] Add support for ADUX1020 sensor
Date:   Mon,  7 Oct 2019 21:09:15 +0530
Message-Id: <20191007153917.13611-1-manivannan.sadhasivam@linaro.org>
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

Changes in v2:

* Converted the devicetree binding to YAML

Manivannan Sadhasivam (2):
  dt-bindings: iio: light: Add binding for ADUX1020
  iio: light: Add support for ADUX1020 sensor

 .../bindings/iio/light/adux1020.yaml          |  47 ++
 drivers/iio/light/Kconfig                     |  11 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/adux1020.c                  | 783 ++++++++++++++++++
 4 files changed, 842 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/adux1020.yaml
 create mode 100644 drivers/iio/light/adux1020.c

-- 
2.17.1

