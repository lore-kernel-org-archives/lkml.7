Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322D7C48BE2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028812083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561026318;
	bh=3ihoOPo5uYqiD4QV67dGSIY/2PGmijlFDatNdmjbsY0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=b6DHv3TPpt6agO5jBF0yWBbQlFI1rB8njzubnQhDyCliOXIroGgSzjLt7bpxIZbPm
	 nY55tcWR0gMJzRMyn7/mA+jhtVlozJAnbmulSF7QGlFxUEvSeh/iDK8kYD6/QSo+xF
	 UiUSLx1yTE/SbJOF3IeTdy8neKGqwTasPv/JXj3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbfFTKZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfFTKZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:25:16 -0400
Received: from localhost.localdomain (unknown [106.201.116.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1260206BA;
        Thu, 20 Jun 2019 10:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561026315;
        bh=3ihoOPo5uYqiD4QV67dGSIY/2PGmijlFDatNdmjbsY0=;
        h=From:To:Cc:Subject:Date:From;
        b=M1vWG7IbE231acj5Rm7J5lY0MkbNVh/1dKZMmgGUGRouYMpaakzI59I6/JhsvgKol
         d0lfKhFRAR6+Xsh7wXK8bUVWLZdWkGwYnfUhkN6HVc7Y8dD2D5MG4aS29yFwy6AXUc
         /ueNmmekviTpmC9LTAAGPF9LTaJoB5PV6/v6Y7zk=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] usb: xhci: Add support for Renesas USB controllers
Date:   Thu, 20 Jun 2019 15:51:49 +0530
Message-Id: <20190620102154.20805-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for Renesas USB controllers uPD720201 and uPD720202.
These require firmware to be loaded and in case devices have ROM those can
also be programmed if empty. If ROM is porgrammed, it runs from ROM as well.

This includes two patches from Christian which supported these controllers
w/o ROM and later my patches for ROM support and multiple firmware versions.

Christian Lamparter (2):
  usb: xhci: add firmware loader for uPD720201 and uPD720202 w/o ROM
  usb: xhci: handle uPD720201 and uPD720202 w/o ROM

Vinod Koul (3):
  usb: xhci: Use register defined and field names
  usb: xhci: Add ROM loader for uPD720201
  usb: xhci: allow multiple firmware versions

 drivers/usb/host/xhci-pci.c | 962 ++++++++++++++++++++++++++++++++++++
 1 file changed, 962 insertions(+)

-- 
2.20.1

