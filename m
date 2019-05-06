Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E670C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 04:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00AB20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 04:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jBlCglUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfEFELc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 00:11:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39883 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFELc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 00:11:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id z128so4490435qkb.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 21:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a/9jBpXTZnQFeOciLXd3ZrvUElHq2Jv+0k02JlnPEJU=;
        b=jBlCglUaJPP/RHcXNVXHWy5SxyOg7l9yIUGv/SlPVrdvtfSkWMXBmufeK4XN6+N2CQ
         hrZrwGcS+vtGlcYninLD0qmZXP9pOHuNW5TkPN3kdv8uIuj4nboRj7XrstWxZXX0sXvh
         8Hjwe49h11MXj2vAuYKPaNlSXfLPJGZwopxWHySAX5FYinUkLTCYI/eR8Gp68Z/LW+Ao
         HuslEbmnRLs6LOsfzyw2kB4L/M2r363F34q06KGgmC7ptC2Nd75ubGNbAF5PjpKyNhVm
         xSFrwQ9nVlgtkvdRItuhcoYlxBL2JalPkVoalg4GdHX0cTkNBSF+0J7VlP8Y03OcJwZp
         9ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a/9jBpXTZnQFeOciLXd3ZrvUElHq2Jv+0k02JlnPEJU=;
        b=NmuAK9bvbBZoTD4c+MTd11vSEuWX4W427mpwAZOjrN+wDJWOqdcRgTMcbdHimxMI1L
         wu+poSVFynozLPBjWf1GfZT2mjxcBTeP2WMqfO2HM2pZ9qesZ17v/09a/q+CEflLTEdc
         btoQ200hqhjAO0GIcjktuukbvYsIMkj2JXNXdgNR1ShBtbrChs6Bk+Z8YpHVoplQihcx
         vFL24H8apvoBkT1AFxrulHZ2fb3uS8sqB7QEFH70NSpW7XmuivAoOLokAHHr/L2YC5ui
         z7+HUaQztJB/vAsBN4AaTbgStloxaeZEcFPqikC0ed+CJnEvOD5rivocX3MiRlTdZIuJ
         Begg==
X-Gm-Message-State: APjAAAVlVOSEkZdQUSB/2YaAbDemyd27OkFDqcaKj0URb6ylL2+MTLL7
        ijFl1+DFs83gDLLz4ZjGU3ZBHQ==
X-Google-Smtp-Source: APXvYqzDxKH7+7jB1OvTn40IPHrxitvDRhwmOASshkDIaRLNFor/C/gqgDxKs/ndQBhcJ743DS4ZIA==
X-Received: by 2002:a37:2d81:: with SMTP id t123mr17416678qkh.316.1557115890995;
        Sun, 05 May 2019 21:11:30 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h7sm4739467qkk.27.2019.05.05.21.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 21:11:30 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     gary.hook@amd.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] iommu/amd: print out "tag" in INVALID_PPR_REQUEST
Date:   Mon,  6 May 2019 00:11:06 -0400
Message-Id: <20190506041106.29167-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e7f63ffc1bf1 ("iommu/amd: Update logging information for new
event type") introduced a variable "tag" but had never used it which
generates a warning below,

drivers/iommu/amd_iommu.c: In function 'iommu_print_event':
drivers/iommu/amd_iommu.c:567:33: warning: variable 'tag' set but not
used [-Wunused-but-set-variable]
  int type, devid, pasid, flags, tag;
                                 ^~~
so just use it during the logging.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..52f41369c5b3 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -631,9 +631,9 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		pasid = ((event[0] >> 16) & 0xFFFF)
 			| ((event[1] << 6) & 0xF0000);
 		tag = event[1] & 0x03FF;
-		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x tag=0x%04x address=0x%llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags);
+			pasid, tag, address, flags);
 		break;
 	default:
 		dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
-- 
2.20.1 (Apple Git-117)

