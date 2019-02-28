Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1084C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FB4218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ8pPUKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbfB1USU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:18:20 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51538 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfB1UST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:18:19 -0500
Received: by mail-it1-f193.google.com with SMTP id e24so16715126itl.1;
        Thu, 28 Feb 2019 12:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2tfQCi3mTzbLNmI6d9X28QaSAPM3bQ2GVcTgZG9SmSs=;
        b=GQ8pPUKHKxSHH1l++MLaNKNIq73FxKR+fchgpz788bEBj7w7Tg/GPpD0ijZ7fI0Gqz
         eOoc5eKrZxbcAA0eG6lC2HxGeS1/jdtLVncreLPBRiUhW91n2OCMAaBvTc/ijXM1pxve
         W+8Y1MrdjeK+GBn3NByDHr4Uu2fNTK7YfyoqhuNslM1kAJUSczWALhYlbKLqM0S2wNR1
         Awhbnu1V3rhXjhgwPIcCfKS59V9pkH59EdP+hTWxSNnB56qLNseYTCtZiEyT1noRUcto
         Bn5kZuPZ7lpDYfVKM0BbafyiHJmItielaO+586XO6yDR96VKsbBkjj3S/jN+2K0TvjEo
         topA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2tfQCi3mTzbLNmI6d9X28QaSAPM3bQ2GVcTgZG9SmSs=;
        b=BAS3wTN3F0FGyRcO8IoOGytnZEZ1lDzAwJePKbxqjrrjovAdN9c89iHZEme5ouykNy
         ouunQLHv7QYkw88+kVTuL/o9T9WWC5v2S9OPllYvPQwpP0cIvam3dc0EZyqC8j3iKIXS
         lrMnPqVCr6KN8giY1YA4LtVnWmk1NGKA0QMA46nqyyeOSkb7pK9t0Pu9l2ZvH/8PyH87
         idie4WiO0/MJRSfDLuJxggLEC+XS05B3DRqwHHIZeZLdbp5SKue5FlDIdyCF2A6M2R/Y
         qOh82B1VEndmI/ca2jO0iMYSzIeu9lvCFmm7kj+MhrGi0NQkHBaEpAw61eitreUu1eKF
         EAFw==
X-Gm-Message-State: APjAAAUe+Dju4BptvIKTJg7ja5OOvbfrQT0uRpOJEH2nRc6zJwvFl8Wm
        bZmy3PCNSSY0KykgIytt7vqX0kA=
X-Google-Smtp-Source: APXvYqxkIEOY1rAQBevXbs5qjnLliNE5EuBcmZz9j5bwMydw8Z/uTrv5yITKNLaljcwwTew3G+WYoQ==
X-Received: by 2002:a02:9b31:: with SMTP id o46mr531836jak.93.1551385098919;
        Thu, 28 Feb 2019 12:18:18 -0800 (PST)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id l131sm3388808itc.17.2019.02.28.12.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 12:18:18 -0800 (PST)
From:   Robert Yang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Yang <decatf@gmail.com>
Subject: [PATCH 0/3] Add device tree support for kxcjk1013 accelerometer
Date:   Thu, 28 Feb 2019 15:18:08 -0500
Message-Id: <20190228201811.7582-1-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a vendor prefix for Kionix Inc. to device tree bindings.
  There is already one other Kionix accelerometer (kxsd9) with device tree
  bindings but this vendor prefix hasn't been documented.
- Document the kxcjk1013 device tree bindings.
- Add device tree support for Kionix kxcjk1013 accelerometer sensors.

Robert Yang (3):
  dt-bindings: Add vendor prefix for Kionix, Inc.
  dt-bindings: iio: accel: kxcjk1013: Add device tree binding
    documentation
  iio: accel: kxcjk1013: Add device tree support

 .../bindings/iio/accel/kionix,kxcjk1013.txt    | 18 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt    |  1 +
 drivers/iio/accel/kxcjk-1013.c                 | 11 +++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt

-- 
2.17.1

