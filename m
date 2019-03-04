Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD3CC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08AB20652
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kr2UkwNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfCDPTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:19:33 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42764 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCDPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:19:33 -0500
Received: by mail-io1-f67.google.com with SMTP id p196so4198954iod.9;
        Mon, 04 Mar 2019 07:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qjOizt/B+mgI/L2Rm33Yubo+OTp8ESDCKK7LbN4crks=;
        b=kr2UkwNkJHNOSZQbx8H7XS2WyXgxirNkqjxdAghiI+SwS+MCqBZ+WssiqbWmDJ9Nmy
         ZVHyXhWnNor1IyVPfg+NU5fFboF7gcYkeLiaBKOlZ8OtgfrDv9TvuQdRU64uzyfXa8DE
         U+l9+Q5zklZocwI+1i5bCzmhqwA8XWENAQNuOr4aIYKaHCXnJFkyZnZDLrgTSQd5J0c1
         Dr9KtZEWlpPN1l5qQuoQ/5SJjN9AmC8lkpppyfSQ0kKnc2EbdUytkwnwBUn7q+0nCZVG
         Rbe2n9Klrub+7dpjH9eTWhrHJLZ+U9y7e1Jq9TmimolL6BPItqLfiw3161k90fKw2V3i
         q3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qjOizt/B+mgI/L2Rm33Yubo+OTp8ESDCKK7LbN4crks=;
        b=Ep1nYn1zDgkMgbZAEqZXMEAL6ReVY6g4Z21klbxp8M3KsTqeAXXOk0OagDebID+jOd
         jzYCYqXHTg/bZ4sOzp8a8V3D+YUez1JuUW/hKRxUatA8EwLOQZFFsXb6zTC+N1UPW65r
         cGVD9KaOhtnI528o8KGgHLuLEIUnGYyffl89sjSm9t1UO/ic3m1ElLkxHUeICCmOBdxR
         hVif4YlVCsNkU1CyFNXEEnsKBjGqsjqco698xfUkghBXqG/V5vq7SQIaUaY+OwdoRhcP
         IFdRpEnGd7gHuvTnsZhNwplLBMg/rOkvCWOpQER8dpxqw1MSx4g9ZgJYSrVaLQt7gBC+
         gJNw==
X-Gm-Message-State: APjAAAV06nUCufRhTmxHTTEUyHgpB6sSEKGgk5yve+3cNfStKDTuyBL4
        g/8AlBRnnQagtFUkOWMSjw==
X-Google-Smtp-Source: APXvYqxze57TL4eFrbtWmWYKUK4WEXTcraM+3jn405mA59Ze5X5zKy66mOTS9PWGdxazUlLX9agktw==
X-Received: by 2002:a6b:c889:: with SMTP id y131mr10325712iof.106.1551712772255;
        Mon, 04 Mar 2019 07:19:32 -0800 (PST)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id 5sm3240615ity.40.2019.03.04.07.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:19:31 -0800 (PST)
From:   Robert Yang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Yang <decatf@gmail.com>
Subject: [PATCH v2 0/3] Add device tree support for kxcjk1013 accelerometer
Date:   Mon,  4 Mar 2019 10:19:09 -0500
Message-Id: <20190304151912.11485-1-decatf@gmail.com>
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

Changelog:

v2:     - Remove SMO8500 because it's an ACPI binding.

 .../bindings/iio/accel/kionix,kxcjk1013.txt     | 17 +++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt     |  1 +
 drivers/iio/accel/kxcjk-1013.c                  | 10 ++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt

-- 
2.17.1

