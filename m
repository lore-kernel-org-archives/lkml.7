Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642B5FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380B1214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giOoN2iC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfKHFUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 00:20:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42180 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfKHFUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:20:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id q17so3291605pgt.9;
        Thu, 07 Nov 2019 21:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eFsH+L829oE/OwopODh0Rlc4QU2iHdxkZ2p54c8xCJE=;
        b=giOoN2iCH2gl4XYTC0DGivxErEzR5sLnO1BZwomEBJoVbi1J6uhyraLvE7dTiDRgey
         RkWQdvxY70+dcIFsnXXexmPODvZCOPIlDXW/h7JVh2rwqwO4IcSi2Xp2LHO5jmI6n6tB
         bSG64yvooZ4nvkoNm4Qujv/rOpUCB7Xx4fKc7nozepHxazodVWLgjGT1QV2j9BUqLXOb
         sjJOLcPM7mW+l1DR7IwNuGUDOOCUmyFf2w9zUslEEMAWW2Y2q7OpRZz42SNw2lhx5IQO
         UHG1cfVpvu3+COKSodN2RSBXIdlb06DLj4zDduX2n4+TrzKvHoGLE0BgQiEZD1irrt4k
         GUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=eFsH+L829oE/OwopODh0Rlc4QU2iHdxkZ2p54c8xCJE=;
        b=eRRau7hwkcFkl+vorjqKw8nJkLvPZuU7LVDP7GW9ePmefTEhF8CfHhy4r80lV7aal2
         KQ1EimxbvuMfH+bztzY1PxxOKYJhOuTr8qGKpHFqsCWOTAgrJuKYwOxI8PX/ZSmu6nMl
         v7zHl1734vDCf5olEhbfWCxf89qnB9Wj7xSpbXrOhWQMVnrHQKbnS9NV2GNUTindJTi5
         sqXnklD/YAtgANQSKCyRUMb23KsfBRvVQO1lg1bS+eHXPUBbhkmF7Ip88mU+999nZ3YB
         dcOcpPG3JbAnx1fVTAPV7dB5IXGO++aNfW4yltw2WfmYtyF0+cn1SL6GbWbkKlX/dv15
         AVMA==
X-Gm-Message-State: APjAAAVZjZot3RuxcDkYs0pTxFmbSITO4pn8Uepnuaydzd9p0cyqCKE7
        wgFlyY2IQvybfjs80csDEkY=
X-Google-Smtp-Source: APXvYqyH/KD6c9XA8sPBchDP+LUk0Aegmnor+q9X7ysQCpoU4EoBt0as0FnheT5yRmG7x8dClNiuiQ==
X-Received: by 2002:a63:234c:: with SMTP id u12mr9239958pgm.384.1573190399697;
        Thu, 07 Nov 2019 21:19:59 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id v19sm3798443pjr.14.2019.11.07.21.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 21:19:59 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>
Cc:     Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: [PATCH v2 00/11] fsi: Patches for 5.5
Date:   Fri,  8 Nov 2019 15:49:34 +1030
Message-Id: <20191108051945.7109-1-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series forms the FSI pull request for 5.5.

1-3 adds a FSI class type and updates the documentation for the sysfs files
4-7 makes some cleanups and fixes to the fsi core
8-10 adds the support for the FSI master in the ASPEED AST2600 BMC 

The driver has been tested on hardware for most operations. Future
enhancements include robust error recovery, DMA support and interrupt
support.

The fix for byte order registers is not squashed in as Andrew's commit
message is a piece of art that deserves to be in the kernel history. It
does not need to go to stable as it fixes a patch earlier in this
series.

Andrew Jeffery (3):
  trace: fsi: Print transfer size unsigned
  fsi: core: Fix small accesses and unaligned offsets via sysfs
  fsi: aspeed: Fix OPB0 byte order register values

Jeremy Kerr (2):
  fsi: Add fsi-master class
  fsi: Move master attributes to fsi-master class

Joel Stanley (5):
  ABI: Update FSI path documentation
  fsi: Move defines to common header
  dt-bindings: fsi: Add description of FSI master
  fsi: Add ast2600 master driver
  fsi: aspeed: Add trace points

kbuild test robot (1):
  fsi: fsi_master_class can be static

 Documentation/ABI/testing/sysfs-bus-fsi       |  16 +-
 .../bindings/fsi/fsi-master-aspeed.txt        |  24 +
 drivers/fsi/Kconfig                           |   8 +
 drivers/fsi/Makefile                          |   1 +
 drivers/fsi/fsi-core.c                        |  67 ++-
 drivers/fsi/fsi-master-aspeed.c               | 544 ++++++++++++++++++
 drivers/fsi/fsi-master-hub.c                  |  46 --
 drivers/fsi/fsi-master.h                      |  71 +++
 include/trace/events/fsi.h                    |   6 +-
 include/trace/events/fsi_master_aspeed.h      |  77 +++
 10 files changed, 785 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
 create mode 100644 drivers/fsi/fsi-master-aspeed.c
 create mode 100644 include/trace/events/fsi_master_aspeed.h

-- 
2.24.0.rc1

