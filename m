Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3C7C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7A0214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561683016;
	bh=YoIDG1dTvCB14b302XP/vNEBGjMdQh1wzbBccBY39PQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aKiqtxhJJGf4WALVC7IRlNwo8yjqQqPE4EuQeWlwc9z0m65JMx+Nw6LcXu7NqUhIh
	 H+sjnNWWlgteZCwFf3TOykoXfmO+oh6hY9XoHrquT4dvkM6Kjd1qdLJ5YcDTrSIY/3
	 1KKNP4gobVn/7bLIE5IurvOrBTTl6uMEjZ3EeYSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfF1AuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:50:15 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:46471 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfF1AuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:50:15 -0400
Received: by mail-pg1-f176.google.com with SMTP id v9so1760104pgr.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/2sb9hYyfsw8WeSVT5nzjFqwXBw7n6CAVVqtEtqe5yo=;
        b=lRvyXSQsS2U/HHANHUkIFKkmeGd6aFPfOTTAFeWHsMWnUOQOW/dp/M9J7cb5xcNZG1
         gNpL8dUJCCvQjCiiWT7R8f2WxzLfHBTgowMfraYUinDytjw6jELgg8QxyVDuMoE4aGTn
         fh0Od2jvO3KHQj5Sl37WuwFb9oDthueH5M3sFHnL+c5JlGZ39fr3f2kKERMEKN7gLufn
         9TVFHVDABdFsnBAtc4C8gylQ2rC3n/IvaSdbfJJ39/PlRVsMTmZyjyWvJH/L3RT32K4y
         NGepclZT+dsGm7nThkQVEwP3UqgE70meJdNUt1vPrUwttfgiS6nN5Xn79Epz7TnFkkqj
         QQEg==
X-Gm-Message-State: APjAAAVa3MyUoJ5vJ7l0wEQg0zuf31XOT1cE86ZHhULqC0obcH8awhSB
        xXIP13aLzrakqP9FlQyiQVG6Bw==
X-Google-Smtp-Source: APXvYqxgwYFE0x/C7FEGII/7g2GTw0w2jtCjz9Dt3boSx0JghIsMGG6LzP+pgOPkeurX1/r+fwbtKg==
X-Received: by 2002:a63:593:: with SMTP id 141mr5704119pgf.78.1561683014046;
        Thu, 27 Jun 2019 17:50:14 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id n7sm280544pff.59.2019.06.27.17.50.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 17:50:12 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 00/15] FPGA DFL updates
Date:   Thu, 27 Jun 2019 17:49:36 -0700
Message-Id: <20190628004951.6202-1-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

can you please take the following patches. They're mostly new features
and some cleanup of the DFL internals.

They've been on the mailing list and have been reviewed.

Note: I've seen that Mauro touched Documentation/fpga/dfl.rst in linux-next
      commit c220a1fae6c5d ("docs: fpga: convert docs to ReST and rename to *.rst")
      and fixed up PATCH 05/15 to apply on top of that.

If you prefer the original series against char-misc-next let me know,
and I'll resubmit.

Thanks,

Moritz

Wu Hao (15):
  fpga: dfl-fme-mgr: fix FME_PR_INTFC_ID register address.
  fpga: dfl: fme: remove copy_to_user() in ioctl for PR
  fpga: dfl: fme: align PR buffer size per PR datawidth
  fpga: dfl: fme: support 512bit data width PR
  Documentation: fpga: dfl: add descriptions for virtualization and new
    interfaces.
  fpga: dfl: fme: add DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
  fpga: dfl: pci: enable SRIOV support.
  fpga: dfl: afu: add AFU state related sysfs interfaces
  fpga: dfl: afu: add userclock sysfs interfaces.
  fpga: dfl: add id_table for dfl private feature driver
  fpga: dfl: afu: export __port_enable/disable function.
  fpga: dfl: afu: add error reporting support.
  fpga: dfl: afu: add STP (SignalTap) support
  fpga: dfl: fme: add capability sysfs interfaces
  fpga: dfl: fme: add global error reporting support

 .../ABI/testing/sysfs-platform-dfl-fme        |  98 +++++
 .../ABI/testing/sysfs-platform-dfl-port       | 104 +++++
 Documentation/fpga/dfl.rst                    | 100 +++++
 drivers/fpga/Makefile                         |   3 +-
 drivers/fpga/dfl-afu-error.c                  | 225 ++++++++++
 drivers/fpga/dfl-afu-main.c                   | 330 ++++++++++++++-
 drivers/fpga/dfl-afu.h                        |   7 +
 drivers/fpga/dfl-fme-error.c                  | 385 ++++++++++++++++++
 drivers/fpga/dfl-fme-main.c                   | 120 +++++-
 drivers/fpga/dfl-fme-mgr.c                    | 117 +++++-
 drivers/fpga/dfl-fme-pr.c                     |  65 +--
 drivers/fpga/dfl-fme.h                        |   7 +-
 drivers/fpga/dfl-pci.c                        |  40 ++
 drivers/fpga/dfl.c                            | 169 +++++++-
 drivers/fpga/dfl.h                            |  54 ++-
 include/uapi/linux/fpga-dfl.h                 |  32 ++
 16 files changed, 1776 insertions(+), 80 deletions(-)
 create mode 100644 drivers/fpga/dfl-afu-error.c
 create mode 100644 drivers/fpga/dfl-fme-error.c

-- 
2.22.0

