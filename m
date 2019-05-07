Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD114C04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A4621019
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kpgce/hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEGXKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 19:10:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45394 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGXKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 19:10:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id a5so3967591pls.12;
        Tue, 07 May 2019 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PP6+fndUIG4IIkxYrEQFsbVdqZqEU6ScA9UQeyIypuQ=;
        b=Kpgce/hwwS3m0yYRu4AlEIBbliaNKE7pCuG22IqFi2+0C/o1qPz3yPhkswJLNnR4dL
         EZNN9imgzu6r7+650jRs/Aa9mhk+wRmMPbxaHmoLuBmz2s7F2BgoOrpbmK1YfZOPIsXq
         +NOcryVJ4zdm3pxAaCe1NgXfCy0wRvmb2D8bMw6OgwsHnnD6NBCKt1MJWLIv+eYN9VSc
         SYjtUvJ2nzbHfmklqK6TppCggVKzIhE+5TrBAQg4YGp2LNddiQjH8sJVw/OQiC5Nykn4
         gygKINbDiCpkvAFBltAOQDGC+NowC/gys4+axE/y9H0BeiF8Dod6/VluFGsW7/SBoRJk
         YFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PP6+fndUIG4IIkxYrEQFsbVdqZqEU6ScA9UQeyIypuQ=;
        b=IapTzk1DZ4oIkeFzGVcXJjnR7Pbtea1EXlsFBleAGIlkUPj7PI+434+D2L4/qkWY1B
         YfrYGm5D8GHfuoMy0zanpupGFFcVOGfEIJ6COjrN4pTi8sIZv+X/ow50iH6yqnOTZWP1
         AvHSDOkrooH1ff8xqcCIudaaU2THclXO+sjbaCceFw68lUXLgrl81IA0HHu9IXzLAKCM
         MW20vn/VQ9Nl6mqu9wWcNK+c4BkgVR4rHTFnVv2VOMs5EX5o8/ogT+Kok5j8AQzUFLyl
         fWXMZ1QUO/R7zhoKwddWxZAZ4Dl77NrEsqoMEho2wxQCa6x8yjaq3VG/Ollm/kvoW6zC
         caRA==
X-Gm-Message-State: APjAAAWK15Ivdnrz/qHGVGXeN9gfPO1dW6vwX+X1YK8VkzrXD1XYFcQL
        yfVEDjfPQ97zODzgnfncT4Ytdz2Q
X-Google-Smtp-Source: APXvYqyhousJMqD5DgnvXJFbKsTA00ZmyGSAFJJ6eypXpI5duu/6vzyNKl7HSIuPW2rqnyhPuGsdDg==
X-Received: by 2002:a17:902:5acb:: with SMTP id g11mr7135217plm.198.1557270613082;
        Tue, 07 May 2019 16:10:13 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id w12sm7154742pfj.41.2019.05.07.16.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 16:10:12 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v3 0/2] hwmon: scmi: Scale values to target desired HWMON units
Date:   Tue,  7 May 2019 16:09:15 -0700
Message-Id: <20190507230917.21659-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep, Guenter,

This patch series adds support for scaling SCMI sensor values read from
firmware. Sudeep, let me know if you think we should be treating scale
== 0 as a special value to preserve some firmware compatibility (not
that this would be desired).

Changes in v3:

- add a local __pow10 function to scmi-hwmon.c while a plan to provide
  a generic function is figured out.
- add check on power > 18 which would overflow a 64-bit unsigned integer
- use div64_u64() to properly divide a 64-bit quantity with an unsigned
  64-bit quantity

Changes in v2:

- added a helper function in kernel.h: __pow10()
- made the scale in scmi_sensor_info an s8 type, added defines for
  checking the sign bit and sign extending with a mask
- simplify computations in hwmon driver


Florian Fainelli (2):
  firmware: arm_scmi: Fetch and store sensor scale
  hwmon: scmi: Scale values to target desired HWMON units

 drivers/firmware/arm_scmi/sensors.c |  6 ++++
 drivers/hwmon/scmi-hwmon.c          | 43 ++++++++++++++++++++++++++++-
 include/linux/scmi_protocol.h       |  1 +
 3 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.17.1

