Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E3EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398142089E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556258441;
	bh=xS0C9hQ0B4Q/f2Z2eoxQvYH/vuRy+UzfW3TIJqfXBPU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wpp6lStFICHhfTzOEVzAUPMXTj5iWHFjitF0pTEuxGh2ECGwmc6rgK6G0YCmXhuj4
	 4/Lvs2yWyBa0p5xW8+4tI9WJoj1vV3Ud5RTw/0j6c5dRKy3iRF9/umRsfe7NrEamJ5
	 SiT0VTheNpABhAwUSN8nCVE7qqONoE0q5gLF78jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfDZGAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:00:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39835 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfDZGAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:00:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id q10so1778853ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 23:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZUfIdeqHOWo3dqMxjPmY3TFL9GhxFEZwoUKcZMv+Hg0=;
        b=K2Rs5kxD5xIykTitUKdNS/WCtJdVTVaEbDCgWuRjl8uIbzxrrmVpTu6mt2/JYAgxev
         RvcEiY4rp9UM/q0HCAUgtpMrEuaCmquMadofqHHbPY8H9MTEKFYLMUa+C0Nl4RWJxAWL
         Sgqavp8TiyKxlGnvadb0ncaVwy0nGCmLjRyfxS/PriW9CpKeO78HF5r0SUqCy46NvyZY
         asUSVi2SU4NXmqTkol+0idxyovDZyr8IDQCbQMFpWX+kEoxodDuUhGkt8ebeEli1zBTX
         ZpSp4clQv91JRu6dM5deEyEr8R3TE3FylPpO7JXhRpL4v24CEi+lpMzyFmlzUVMCEWP9
         MW7w==
X-Gm-Message-State: APjAAAW8l1R/Kc7fmUNAIeU/oFUF0agtcSWn8aGFRDZ2cZE9gMufBKim
        wTG3Fmjaf+VR518Z0HKxh6A=
X-Google-Smtp-Source: APXvYqzHW/yjz4vdybiF9bL/JOO4CmYaO1GBuDyRUtm7I9DEXLGqRSjwBdhskr0D37BTv9SIEFI/pQ==
X-Received: by 2002:a05:651c:14b:: with SMTP id c11mr23396444ljd.185.1556258404792;
        Thu, 25 Apr 2019 23:00:04 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id o17sm4917001ljc.66.2019.04.25.23.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 23:00:04 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1hJttz-0003Vz-FL; Fri, 26 Apr 2019 08:00:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] tty: drop unused iflag macro
Date:   Fri, 26 Apr 2019 07:59:22 +0200
Message-Id: <20190426055925.13430-1-johan@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the RELEVANT_IFLAG() macro was unused in USB serial and
turns out there were a few more instances that could be dropped.

I have some pending changes that may conflict with the corresponding
change to USB serial so I'll take that one separately through my tree,
but perhaps the rest could go through Greg's tty tree.

Johan


Johan Hovold (3):
  tty: simserial: drop unused iflag macro
  tty: ipoctal: drop unused iflag macro
  tty: cpm_uart: drop unused iflag macro

 arch/ia64/hp/sim/simserial.c                | 2 --
 drivers/ipack/devices/ipoctal.h             | 1 -
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 --
 3 files changed, 5 deletions(-)

-- 
2.21.0

