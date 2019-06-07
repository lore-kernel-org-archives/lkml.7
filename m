Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38ADC468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9974E208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU69ps/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfFGUPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 16:15:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46743 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfFGUPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:15:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so1772694pfy.13;
        Fri, 07 Jun 2019 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Js401k7f1Ryk1ex5kRDT2lRk8XWqmZKTxzarHpgPqIY=;
        b=eU69ps/A/Xtg/dRY/kuE9sy7CGwMpIfU2fAhZL1fW4uKjBw6Olp/Mhwo709lc/hwv+
         C3VIxKSd1ah/tyH3gvOOc9l54pDO4StrMoEnf+NkAtnfDiTn1WF0LAe/bh62XmWOjuQN
         ERccVKdZt82bGxNIBeqj/urTCM5Xdi3BvGsFuq+Aymv26q7tyfzCvjO0NEvXGol60N0P
         +FrCG43uciUTKOLG7fk4d0XR3ZRMMs1LWEJBfdqpSwsckTr1fUuVz5ca39L2UF9DLYRN
         qfDOSKtos18oj3+Hd2WijW1sBGqRBbQReGq6jKUWVsyO8BW4HQa7JhIofE6y9EkJCmOc
         62NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Js401k7f1Ryk1ex5kRDT2lRk8XWqmZKTxzarHpgPqIY=;
        b=oXYiv+sH1ongTw3Nsy1E2e8YyEEFUxxcmR/w1V36z9U06NI3Txl0uuNIgSi+ul9SN3
         loWT4mxpeh6nWD0EeP/15UIf5FRyNXVLKaAY7t8p+RyEBBfRiefKtZBl1loMe2gK5gmg
         +uLAzZQmne7OjcuVOBmkcIj5zSVB1lkh7qH0afFdhB85gkb2gxY1eNGwDVPwNGBZnq6s
         NHva1s5HsIxwMVla1xtOzYJB6XK6I0ByRN3Npsvjz8PmVplFW3jUe5m213+gt9gII7VS
         liZDa3/ypP3E+ehW2dzst7ZvmSWfn03dy7I4YfrNyEgja8hVk2tGaiP9CwbTEqIXo4KJ
         9C+g==
X-Gm-Message-State: APjAAAV2bn2t/KVW3xuw6AmqQb2zkMfTRoSVGOPnYfTJZwiiSwZz+Y3S
        WACiSBuoCKflQD0Tw+to+o0=
X-Google-Smtp-Source: APXvYqy2Qbhprikqf4nLMXJnJgOhJdj92jTImW7qwtLpDQHx0Nrk8WLpXAq0y+Wc9Lli0A6nyYGV1A==
X-Received: by 2002:a65:5685:: with SMTP id v5mr4770556pgs.184.1559938510731;
        Fri, 07 Jun 2019 13:15:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x8sm3600233pfa.46.2019.06.07.13.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 13:15:09 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for hwmon-for-v5.2-rc4
Date:   Fri,  7 Jun 2019 13:15:08 -0700
Message-Id: <1559938508-12610-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux hwmon-for-v5.2-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.2-rc4

Thanks,
Guenter
------

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.2-rc4

for you to fetch changes up to 4a60570dce658e3f8885bbcf852430b99f65aca5:

  hwmon: (pmbus/core) Treat parameters as paged if on multiple pages (2019-06-05 18:36:27 -0700)

----------------------------------------------------------------
hwmon fixes for v5.2-rc4

Fix a couple of inconsistencies and locking problems in pmbus driver.
Register with thermal subsystem only on systems supporting devicetree.

----------------------------------------------------------------
Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      hwmon: (pmbus/core) mutex_lock write in pmbus_set_samples

Eduardo Valentin (1):
      hwmon: (core) add thermal sensors only if dev->of_node is present

Robert Hancock (1):
      hwmon: (pmbus/core) Treat parameters as paged if on multiple pages

 drivers/hwmon/hwmon.c            |  2 +-
 drivers/hwmon/pmbus/pmbus_core.c | 37 +++++++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 5 deletions(-)
