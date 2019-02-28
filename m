Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F00CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399172171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="TJXBEQR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfB1Nko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:40:44 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:36066 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfB1Nkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:40:43 -0500
Received: by mail-pg1-f179.google.com with SMTP id r124so9750568pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=QWIosyhlwuMTZs4JoGxaDk24R9n0qYCEPchN/8bY0wA=;
        b=TJXBEQR4m+2Gupg4wXEsv0wd0Xkh5+NBNfX1jJiZQlV/t5Tq0lzJ7ID/nIszOKbh7B
         xGBnx4Gw4m6hYcZYt4iwz7fIoS5G2jcOPmQ3OPMUD/sTGCO1aWDB2QVJCX30x6qf31KP
         BFhRZg+/FbixoYq2Hjq2PjCrKOPhTBoTftcoUI3vmAx6WbeBOGmW0vXUma7rWaU3DWMt
         eAM0/KlhRdz5pNW2jJ9Ai2IE4DuhGJWzOSVy4SvV8kpQ49cz8O/WAd4koAu8Rly3OqJx
         VBRHGIBDFfheA3/e+ZVZJGcmRvcQ1v2NuzRUfTd6PCPGxZ6cehlXdB5BK9CrQ/uMF9R/
         Gqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QWIosyhlwuMTZs4JoGxaDk24R9n0qYCEPchN/8bY0wA=;
        b=NDxIXXfG+PyJHPB6Jhmj5g3XY1DNVV5vq4qpx4WWM+W5EZcPIF0mdLHonxIen7FkjG
         rlxm8wkuDPt2DNL73qaZKjNGopilb9JZyE04nFTfY2DBpzrYm5rDdQhhEtVhZvW3j086
         HgSyfwC+i8J/ZcrJ2W8ptcjtkrN4YinhbUo+R4eWFdebmt0iQgkxmPd8STCPDW9G8AmD
         J82ITN+9SVUQ0hzUVfHEzIK96YLy6nbBG6U+xZBQ62SNXsabdYuRQELLMeYzT9xDCdST
         b3u3J3U8VBoJ7RUn4OVe1Dx+a/fxoWEQfq66WzHgULuwVOX5vvav6AeDK1Rbtd8ghkQO
         iEXQ==
X-Gm-Message-State: AHQUAuaJwEEucW59TTA/ZSJv4Xy5hmDW9cpl325Qtm/jb9AnE2yqfAhl
        ueEvVRdGY0PM3cp4PG71m3NMgg==
X-Google-Smtp-Source: AHgI3IbfPvyIienhS+uH4FM/CpWQdxODoYX5JudXO5nU7D3mIKVZdPGbvVKqlNL0GfIZBEeVneDtDw==
X-Received: by 2002:a63:e90f:: with SMTP id i15mr8525697pgh.430.1551361242368;
        Thu, 28 Feb 2019 05:40:42 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e706-b6eb-8c00-6a08-1689-4d5a.emome-ip6.hinet.net. [2001:b400:e706:b6eb:8c00:6a08:1689:4d5a])
        by smtp.gmail.com with ESMTPSA id 186sm36777133pga.36.2019.02.28.05.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:40:41 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        patches@opensource.cirrus.com,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        James Ban <James.Ban.opensource@diasemi.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 00/11] regulator: Add set/get_current_limit helpers and use it
Date:   Thu, 28 Feb 2019 21:40:11 +0800
Message-Id: <20190228134022.32625-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serial adds regulator_set/get_current_limit_regmap helpers for regmap
users and convert drivers to use these helpers.

patch 1 is a comment fix for existing csel_reg/csel_mask fields.
patch 2 adds n_current_limits and *curr_table fields to
	struct regulator_desc and then adds
	regulator_set_current_limit_regmap() and
        regulator_get_current_limit_regmap()
patch 3-11 convert drivers to use regulator_set/get_current_limit_regmap
	helpers

I don't have h/w for these drivers, so please test it.

Axel Lin (11):
  regulator: Fix comment for csel_reg and csel_mask
  regulator: core: Add set/get_current_limit helpers for regmap users
  regulator: da9055: Convert to use
    regulator_set/get_current_limit_regmap
  regulator: da9210: Convert to use
    regulator_set/get_current_limit_regmap
  regulator: lp872x: Convert to use
    regulator_set/get_current_limit_regmap
  regulator: lp873x: Convert to use
    regulator_set/get_current_limit_regmap
  regulator: max77650: Convert to use
    regulator_set/get_current_limit_regmap
  regulator: pv88060: Convert to use
    regulator_set/get_current_limit_regmap
  regulator: pv88080: Convert to use
    regulator_set/get_current_limit_regmap
  regulator: pv88090: Convert to use
    regulator_set/get_current_limit_regmap
  regulator: wm831x-dcdc: Convert to use
    regulator_set/get_current_limit_regmap

 drivers/regulator/da9055-regulator.c   | 45 +++-----------
 drivers/regulator/da9210-regulator.c   | 53 +++-------------
 drivers/regulator/helpers.c            | 86 ++++++++++++++++++++++++++
 drivers/regulator/lp872x.c             | 70 +++------------------
 drivers/regulator/lp873x-regulator.c   | 45 ++------------
 drivers/regulator/max77650-regulator.c | 74 ++++++++--------------
 drivers/regulator/pv88060-regulator.c  | 51 +++------------
 drivers/regulator/pv88080-regulator.c  | 55 +++-------------
 drivers/regulator/pv88090-regulator.c  | 53 +++-------------
 drivers/regulator/wm831x-dcdc.c        | 42 ++-----------
 include/linux/regulator/driver.h       | 11 +++-
 11 files changed, 181 insertions(+), 404 deletions(-)

-- 
2.17.1

