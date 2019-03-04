Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB6CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156B120835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvDXohdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfCDULU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:11:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44403 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfCDULU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:11:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id u9so328434lfe.11;
        Mon, 04 Mar 2019 12:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SiDdRvkV8Vz7kT3zpo46WOrXWzcN/Rv4xYz6C7lBoYE=;
        b=tvDXohdJ1nMAYzDQux3WeaYk/+Q2l3D66dm9pmKtlCCVgmnDq2WEovh5rMZPUyVLUJ
         QMA7jE2VtDSPjZBwD1s68lIbPieH9qACttfxtWGRFbClP2PGfPPVFV/Sr1onLBTB3j0A
         slimGDATgZyAHQrNz/tmVYo35v9NtN6shilt3GLsX3Ka0BBLxxn4RWZwJFUuFtDlkT4Z
         nOOPAMpAn/kQSPc8YV+e6mvyhvNn3fKvUc5U9biAJ+d4PyNx4hroo/q4u5MzEjvlU6aY
         ci0vvwOb5QyYv34NOR4h0sbqkIPDf3JLB6DQ+ArzybxOi5tJIkGWtZr+lXqpRjKlcRdJ
         qIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SiDdRvkV8Vz7kT3zpo46WOrXWzcN/Rv4xYz6C7lBoYE=;
        b=ml3aqgBXAqFJ+CbccrYRM52W0AhoL+GMMdTq4t/OctjYMXOHgbS2G+jk/EnuXinSeQ
         +ECge4d+lkuwZLKJgXRMsZRuGLAs9iCxENRWOQor3xRgWlOfD/1X+c7q9kpFSNqqXtvd
         R7aHgutkDIT4LuzYBK/fbVKdxmGdnW94X/sqQW19uWI9YNZC2muDl7Rc6LljGygElgir
         h7dzZNPMmPHFfshdqbNhKMz/vuweVTwdm9AH/y+HilQf3lIC5kMXahGS1Ciyram5PS5v
         NKoBsn57uavpiZBAg/s90hojo4cMFsMPpebakpqdOoawIVvqY5ADVFRLcBfmUfqAWQZE
         o6zA==
X-Gm-Message-State: APjAAAXFV3kYNOid0s8v5+JS1Bj3iiwdY4X0F/1fHyHEpx2snouOgjcH
        Ade1hgA9drf7SUpVzlYl9qQ=
X-Google-Smtp-Source: APXvYqy3kCosg0J3b0zomI+Br1JbW8DlleSMQsKDHEDEmt8hCKBS4E7yGxSreGTOtI2Gj36++TYNnw==
X-Received: by 2002:ac2:5230:: with SMTP id i16mr11325865lfl.119.1551730277971;
        Mon, 04 Mar 2019 12:11:17 -0800 (PST)
Received: from myhost.home (cjk115.neoplus.adsl.tpnet.pl. [83.31.60.115])
        by smtp.gmail.com with ESMTPSA id q3sm1383190lfb.37.2019.03.04.12.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 12:11:17 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, krzk@kernel.org, michal@plume.com
Subject: [GIT PULL] LED updates for 5.1-rc1
Date:   Mon,  4 Mar 2019 21:11:10 +0100
Message-Id: <20190304201110.3969-1-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull LED updates for 5.1-rc1.

We finalize previously announced support for initialization of pattern triggers
from Device Tree.

Beside that there is a single fix for null deref on firmware load failure
in leds-lp55xx-common.c.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/leds-for-5.1-rc1

for you to fetch changes up to 5ddb0869bfc1bca6cfc592c74c64a026f936638c:

  leds: lp55xx: fix null deref on firmware load failure (2019-02-14 22:03:44 +0100)

Thanks,
Jacek Anaszewski

----------------------------------------------------------------
LED updates for 5.1-rc1
----------------------------------------------------------------
Krzysztof Kozlowski (5):
      dt-bindings: leds: Add pattern initialization from Device Tree
      leds: Add helper for getting default pattern from Device Tree
      leds: trigger: pattern: Add pattern initialization from Device Tree
      leds: trigger: oneshot: Add initialization from Device Tree
      leds: trigger: timer: Add initialization from Device Tree

Michal Kazior (1):
      leds: lp55xx: fix null deref on firmware load failure

 .../ABI/testing/sysfs-class-led-trigger-pattern    | 51 +----------
 Documentation/devicetree/bindings/leds/common.txt  | 12 +++
 .../bindings/leds/leds-trigger-pattern.txt         | 49 +++++++++++
 drivers/leds/led-core.c                            | 30 +++++++
 drivers/leds/leds-lp55xx-common.c                  |  4 +-
 drivers/leds/trigger/ledtrig-oneshot.c             | 38 ++++++++-
 drivers/leds/trigger/ledtrig-pattern.c             | 99 +++++++++++++++++-----
 drivers/leds/trigger/ledtrig-timer.c               | 34 ++++++++
 include/linux/leds.h                               | 13 +++
 9 files changed, 259 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
