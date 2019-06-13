Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8DAC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDB32082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfFMP3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:29:11 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:36461 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbfFML0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:26:12 -0400
Received: from [2a01:e35:39f2:1220:9dd7:c176:119b:4c9d] (helo=test.quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1hbNrs-00086j-QA; Thu, 13 Jun 2019 13:26:08 +0200
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Yann Droneaud <ydroneaud@opteya.com>
Date:   Thu, 13 Jun 2019 13:26:03 +0200
Message-Id: <cover.1560423331.git.ydroneaud@opteya.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:39f2:1220:9dd7:c176:119b:4c9d
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: [PATCH 0/3] ELF interpretor info: align and add random padding
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches are mostly focused on ensuring AT_RANDOM array is
aligned on 16bytes boundary, and while being located at a pseudo-random
offset on stack (at most 256 bytes).

This patchset also insert a random sized (at most 15 bytes) padding between
AT_RANDOM and AT_PLATFORM and/or AT_BASE_PLATFORM.

It also insert a random sized padding (at most 256 bytes) between those
data and the arrays passed to userspace (argv[] + environ[] + auxv[])
as defined by ABI.

Adding random padding around AT_RANDOM, AT_PLATFORM, AT_BASE_PLATEFORM
should be viewed as an exercise of cargo-cult security as I'm not aware
of any attack that can be prevented with this mechanism in place.

Regards.

Yann Droneaud (3):
  binfmt/elf: use functions for stack manipulation
  binfmt/elf: align AT_RANDOM array
  binfmt/elf: randomize padding between ELF interp info

 fs/binfmt_elf.c | 110 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 24 deletions(-)

-- 
2.21.0

