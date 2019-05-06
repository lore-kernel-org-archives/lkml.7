Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26156C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D322082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYxXCXjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfEFWlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:41:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44695 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFWlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:41:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so7510104pfm.11;
        Mon, 06 May 2019 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rpxbdKqagbkKW6bRErcLm1VGK57u1T3ItS0aEgPa12I=;
        b=IYxXCXjTt3+Quzmpq5O1q0UAtIi8l4WbNguVshSC1FO6x1jFMWFnwjdoF0N646pXc7
         afKTLrxIddOxOBDv2nfWrUYRIDm5z6vtRdWK/DGa9o0j/wwVt6koWyhJSzvk5eFU9nuI
         FOFhwV/qNwbZzm86kIdXkpj88q5fEUAsOcVMmUa0adwZlGs82KYUCdr6Q3xuvfH91jf+
         Tz5jT50v4lXaRXgq2Cv1UeXPZaQtjOrkHPtX2ztgDDshd3us3wB5qqi2Br3NxpIPYdZQ
         U/2piYAL/XFsgC0Q4hNdPB7pJKfYfKOPQFMEyVHkR9WB5wYomgmcF45xB5cffoeQqVXi
         ring==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rpxbdKqagbkKW6bRErcLm1VGK57u1T3ItS0aEgPa12I=;
        b=WJtGsvylYhJP5RPezaJJnZJustmTvkozZ3cmrJC8xD0gZyy63LNSspWLyZ8HWURGxI
         2uTG8tJOqVqbORSMDFLfhu8686JfBRxQ2S/mfdTazuvehp9AE13bC/A/6ZOU/KqaODXn
         4vfrHldMhDB3viNLpJJsgQj+rZNUq2WGlzj1rJIUiu6PgB+4UeMv1h3dWxAsWp7sQ4VT
         XIV1ufbdn2VFOA0/JhIymzDZHN+gfFSUTIMAOG5hmpl2B+waK1Z+iQS8y+wgmkfjyv/4
         eAtc94s3I/0Vg52Rej6Bze0xhL8JY5yh1j6q6N/EkV0X7/2fzguBLLGeEuqGdBS9tJrl
         upVQ==
X-Gm-Message-State: APjAAAVFOuMzgFD7VgqzG5kRA48YCOVSK6mjHx0JAWF2TVJlVmprPpcK
        mKFhCb0wkEO3vbI8F5Ybwgn4YuHp
X-Google-Smtp-Source: APXvYqyL9KgkGJ673pktlj24hvy16jhjBP24eNFCAaO7fqwyUMgtOgpvh732fHWCJyI8i0cSUME6WQ==
X-Received: by 2002:a63:c203:: with SMTP id b3mr8974823pgd.398.1557182475712;
        Mon, 06 May 2019 15:41:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id s11sm19784153pga.36.2019.05.06.15.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 15:41:14 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH 0/2] hwmon: scmi: Scale values to target desired HWMON units
Date:   Mon,  6 May 2019 15:41:07 -0700
Message-Id: <20190506224109.9357-1-f.fainelli@gmail.com>
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

Thanks!

Florian Fainelli (2):
  firmware: arm_scmi: Fetch and store sensor scale
  hwmon: scmi: Scale values to target desired HWMON units

 drivers/firmware/arm_scmi/sensors.c |  7 +++-
 drivers/hwmon/scmi-hwmon.c          | 55 ++++++++++++++++++++++++-----
 include/linux/scmi_protocol.h       |  1 +
 3 files changed, 53 insertions(+), 10 deletions(-)

-- 
2.17.1

