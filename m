Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAA4C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCDD20673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561107754;
	bh=6Fsldr5ySj7ombUaOz/6PYPhO3cHLQdyQZ5gwcAdiNo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZZI4TxrfJAGqKCaCPJ2mDU102CTNEgljywF81rDby75sRY8Z1BN0w6nKOLrWZ8hr7
	 NPC0p5R9jhHws/xoPCjGK5kpbMG1ab6wVOhL/93xEEFwQHp2jrqzYhZ7ZnK83Es85H
	 kwHShHjsg5w0xLP63AHL6i5o4Q6kM1ytCBbzvLgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFUJCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfFUJCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:02:32 -0400
Received: from localhost.localdomain (unknown [106.201.116.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF2AE20673;
        Fri, 21 Jun 2019 09:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561107751;
        bh=6Fsldr5ySj7ombUaOz/6PYPhO3cHLQdyQZ5gwcAdiNo=;
        h=From:To:Cc:Subject:Date:From;
        b=lPEynh4Mgr2RjzIZPl0bAO1eC375blSNspKB7UcsMp2GkV3un+KGosvRNWsqHOP8Q
         jVQq8d5BEgLK+API8yDXTVn36aUQYD81leGlLBEn0uwGqPBhiyOKu6URQ0XnKWio0z
         aPNMn7iph7x0jdROzaJGM2NEp1LUwjP4cmgOOn2k=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5]  usb: xhci: Add support for Renesas USB controllers
Date:   Fri, 21 Jun 2019 14:29:08 +0530
Message-Id: <20190621085913.8722-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for Renesas USB controllers uPD720201 and uPD720202.
These require firmware to be loaded and in case devices have ROM those can
also be programmed if empty. If ROM is programmed, it runs from ROM as well.

This includes two patches from Christian which supported these controllers
w/o ROM and later my patches for ROM support and multiple firmware versions.

Changes in v2:
  used macros for timeout count and delay
  removed renesas_fw_alive_check
  cleaned renesas_fw_callback
  removed recurion for renesas_fw_download
  added MODULE_FIRMWARE
  added comment for multiple fw order

Christian Lamparter (2):
  usb: xhci: add firmware loader for uPD720201 and uPD720202 w/o ROM
  usb: xhci: handle uPD720201 and uPD720202 w/o ROM

Vinod Koul (3):
  usb: xhci: Use register defined and field names
  usb: xhci: Add ROM loader for uPD720201
  usb: xhci: allow multiple firmware versions

 drivers/usb/host/xhci-pci.c | 942 ++++++++++++++++++++++++++++++++++++
 1 file changed, 942 insertions(+)

-- 
2.20.1

