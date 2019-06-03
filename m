Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30FBC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB46724FC5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqTz1839"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfFCRrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:47:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34445 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCRrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:47:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id y198so3797795lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f1Dtl9xXT8tEGwrUxBzQBfGddt3tp9MI+UPqkpN1WN0=;
        b=mqTz1839SvTGVA6JMBG6+XjE0xYwF2fSddZ7+seYCgdrXgukg0+NU1E4tXpmGF15Im
         UZJXC+yUDioaBsN6la1dNtjTzmPzvL4teQe+GSwWL7g0C0GQ8xS+7Y5L2BBcCfXp+86x
         wmMcAuVi4hbPPf8Pu4a/f2A02J0NXA367FrEGeAtR7D+OzvyqwIKbnX6pmohPchdxcab
         om1NVhjh5ihdIMLobhgkrDeIrhVafIUwILMNvwzW9QzXJf7xfvMfpFZqOPjCRzZdWpdS
         xCDuNsMcjH7LJDGLtHTp/dy+CwlmAJLQAjPt9FsfMow6RPEaUZ3hCIdNIW31jvDpVBA0
         Et6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f1Dtl9xXT8tEGwrUxBzQBfGddt3tp9MI+UPqkpN1WN0=;
        b=DDfIEuMVBS7ypq6Rl8VdBzC7GPDDJ/b7fyYid/ejXPVtw1pqAHtj+67BqXyt7HskY6
         6tKksyqSMB1bVqqS0ZW8Ng8Wz32C2IAwoKAJ9KURRptKsmOAVgysx5gOI7c5gom3FzgT
         PW5QizjTA+sQJEm9+Y3HlhOQrdqZLMSoqRLQfTgTwIhS2nXYEU6FlcfqW/N7RIUDPpOQ
         8dhVtv6IVJu27+RUjwSjeQhMz0JoeqfeDzuKvpuvgcbAeEvFAxpqGfq1WubRwW+E+PTq
         sr/zQsZ3EwQkgXKp3s4f1t17XOd51dWXv5rSjk4B1oz+xP2b8SRD0N52xGHuLNy41Co3
         EDrg==
X-Gm-Message-State: APjAAAXW29R+051qHkDQV054dmtBkFSUymx22nnTgNdCpjitqe+C5tH7
        b42+i3X5qvtwhupKNNftGOY=
X-Google-Smtp-Source: APXvYqxCQNjDQHJYWJnJyGea/doMquTKfXFLsAZndtY60a6k8pR2NhL8Rsw2Q/prcSP3U/G6IrOLRg==
X-Received: by 2002:ac2:599b:: with SMTP id w27mr15110769lfn.184.1559584057528;
        Mon, 03 Jun 2019 10:47:37 -0700 (PDT)
Received: from localhost.localdomain ([188.150.253.81])
        by smtp.gmail.com with ESMTPSA id n7sm2803532lfi.68.2019.06.03.10.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:47:36 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v4 0/9]ASoC: sun4i-i2s: Updates to the driver
Date:   Mon,  3 Jun 2019 19:47:26 +0200
Message-Id: <20190603174735.21002-1-codekipper@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

here is a patch series to add some improvements to the sun4i-i2s driver
found whilst getting slave clocking and hdmi audio working on the newer
SoCs. As the LibreELEC project is progressing extremely well then there
has been some activity getting surround sound working and this is included.

The functionality included with the new patch set has been extended to
cover more sample resolutions, multi-lane data output for HDMI audio
and some bug fixes that have been discovered along the way.

I can see more usage of the tdm property since I last attempted to push
these patches and the examples currently in mainline sort of the opposite
to what I'm trying to achieve. When we first started looking at the i2s
driver, the codecs that we were using allowed for the frame width to be
determined based on the sampling resolution but in most use cases it
seems that a fixed width is required(my highest priority should be to get
HDMI audio support in). We're using the tdm property to override the old
way to calculate the frame width. What I've seen in what has already been
mainlined is that the i2s driver has a frame width that is fixed to 32
bits and this can be overridden using the tdm property.

I still need to investigate the FIFO syncing issues which i've not had a 
chance to change or address the concerns that broonie and wens brought up.
This change has been moved to the top of the patch stack.

BR,
CK

---
v4 changes compared to v3 are:
- Moved patches around so that the more controversial of patches are
  at the top of the stack.
- Added more details to commit messages.
- Fixed 20bit audio PCM format to use 4 bytes.
- Reduced number of flags used to indicate a new SoC.

v3 changes compared to v2 are:
 - added back slave mode changes
 - added back the use of tdm properties
 - changes to regmap and caching
 - removed loopback functionality
 - fixes to the channel offset mask

v2 changes compared to v1 are:
 - removed slave mode changes which didn't set mclk and bclk div.
 - removed use of tdm and now use a dedicated property.
 - fix commit message to better explain reason for sign extending
 - add divider calculations for newer SoCs.
 - add support for multi-lane i2s data output.
 - add support for 20, 24 and 32 bit samples.
 - add loopback property so blocks can be tested without a codec.


Marcus Cooper (9):
  ASoC: sun4i-i2s: Fix sun8i tx channel offset mask
  ASoC: sun4i-i2s: Add offset to RX channel select
  ASoC: sun4i-i2s: Add regmap field to sign extend sample
  ASoC: sun4i-i2s: Reduce quirks for sun8i-h3
  ASoC: sun4i-i2s: Add set_tdm_slot functionality
  ASoC: sun4i-i2s: Add multi-lane functionality
  ASoC: sun4i-i2s: Add multichannel functionality
  ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
  ASoC: sun4i-i2s: Adjust regmap settings

 sound/soc/sunxi/sun4i-i2s.c | 242 ++++++++++++++++++++++++------------
 1 file changed, 164 insertions(+), 78 deletions(-)

-- 
2.21.0

