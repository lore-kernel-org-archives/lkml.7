Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B992EC04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C18921530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf/JjJpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfEHRAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:00:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36106 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfEHRAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:00:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id v80so10808144pfa.3;
        Wed, 08 May 2019 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=reuVuInEGSPVqhLJ9GfTV+s0+z5HcOAxAjqzHbqMNXQ=;
        b=hf/JjJpboF2fHUPqQd52zL+q2Ztg6NGjvdjZBXvCpJs7Ni7ozPM0anw0BA//1DrmUd
         YXGr2x/hDjlYst07ErUwpTeEJj3FAMxmaYHilkH7RsUb1W5Y72VjJUxXJUcKbO3g8zP8
         j0zWxRF0YjHE8VbzipIj2glS0NjJ728rzsRg6gV4WmceL38CmyaETPVPhLiV8coF93Ue
         ihppFWu7EzkugKZ+zWY/j1+KyyBrB0fvfMEN+fozovuA51S7dU6u4c4FS8hLNt6ItYE4
         keczlXyBoz7S1eh20MdyJ5IW7QZkpyLUD/uATHzxvSkU+9sXwZ+dOupepzuBQkBbsZVs
         MhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=reuVuInEGSPVqhLJ9GfTV+s0+z5HcOAxAjqzHbqMNXQ=;
        b=fbm1bHUZO42FTd11cm5q31ZWC52wZzOKuOD6KB6p14H353tujTqOju60151UigTFAO
         qPFgfLI4PHOQZxRhN+iLvD5oe1vDZflvcQiQhGEdjvgVrj17uSWaQV7fn+JHHyrGhh3J
         U0pgFQRYo6M08S/FTEqYn7E/iNisOA5dcjaomzk5xKLTyLRjfK0O+zYzjKruYzh6yeN4
         P13TUgA6r3cwUmPB+WaRbww5rD9U5PLPe5sXApymRjFLTfKihVq9Z3i4+lGnWcwXwqLU
         Bjwa+4TcAgaLSz8xhZEEu+fzdFn/j/FkY1i52/YOITpqbcDXoRumdIZOIZBUl6DifLMA
         JwiA==
X-Gm-Message-State: APjAAAWpWFGqysD0SSJhc28yEXrjlmthvlyO8f4S6cRC1uXXSx85+gwk
        OdeGGsxJnPzsZBBhcpT2pH3Rpnj7
X-Google-Smtp-Source: APXvYqwddnrPq2MkpKs7xjxlDXgLahFp33wBgfHSukJs3hHHDgLSDN0lv63czoL2gfgFDo1BcR1V6w==
X-Received: by 2002:a63:471d:: with SMTP id u29mr1994172pga.39.1557334839281;
        Wed, 08 May 2019 10:00:39 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id a80sm11347773pfj.105.2019.05.08.10.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 10:00:38 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v4 0/2] hwmon: scmi: Scale values to target desired HWMON units
Date:   Wed,  8 May 2019 10:00:33 -0700
Message-Id: <20190508170035.19671-1-f.fainelli@gmail.com>
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

Changes in v4:
- deal with overflow in the caller of __pow10() as suggested by Guenter
  which makes us rework a bit how the value argument/return value are
  passed
- don't harcode the latest power of 10 factor to be 18, just rely on
  overflowing the u64 value instead

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
 drivers/hwmon/scmi-hwmon.c          | 46 +++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h       |  1 +
 3 files changed, 53 insertions(+)

-- 
2.17.1

