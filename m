Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E220FFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC86921835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264551;
	bh=rw7PZVuCdsh//bzGeslxpHN6eG+PUEXUS7gZAtJ2DAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gudpAEabGa2FD91ixk/nWTXjq9cZL9m1CWoi4mseF9uqH/LsycZI7LaJeWujBwPPN
	 blP2QO1ZjvFTQfSNCjncvnIAZkXVAozbVfs4UT+IZI4muWuFk9amA4+bZjiOujjRao
	 tCbfFwh+CyY+4v4rme0hlF9glMIRiiEYSDvub8bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407649AbfJPWWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437460AbfJPVxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:15 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FEEC21A49;
        Wed, 16 Oct 2019 21:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262795;
        bh=rw7PZVuCdsh//bzGeslxpHN6eG+PUEXUS7gZAtJ2DAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ED7UrVTouiSjkuA2BiyFkRXzGkifxmc5kySnVTrN0+WMyiFURrmrskRAzxfC7E+Kt
         lYmv4YCVE3uc958Z18VmR97n/nwEXRQm7ZGWciP5St4MzX2hnU+KpuXdQz8XRqDTjE
         GCf6MVJwW+w12NxddnO1hVK+5dgGmobxAIUfHhI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Schmidt <jan@centricular.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.4 34/79] xhci: Prevent device initiated U1/U2 link pm if exit latency is too long
Date:   Wed, 16 Oct 2019 14:50:09 -0700
Message-Id: <20191016214758.692831955@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
References: <20191016214729.758892904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit cd9d9491e835a845c1a98b8471f88d26285e0bb9 upstream.

If host/hub initiated link pm is prevented by a driver flag we still must
ensure that periodic endpoints have longer service intervals than link pm
exit latency before allowing device initiated link pm.

Fix this by continue walking and checking endpoint service interval if
xhci_get_timeout_no_hub_lpm() returns anything else than USB3_LPM_DISABLED

While at it fix the split line error message

Tested-by: Jan Schmidt <jan@centricular.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/1570190373-30684-3-git-send-email-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4645,10 +4645,12 @@ static u16 xhci_calculate_lpm_timeout(st
 		if (intf->dev.driver) {
 			driver = to_usb_driver(intf->dev.driver);
 			if (driver && driver->disable_hub_initiated_lpm) {
-				dev_dbg(&udev->dev, "Hub-initiated %s disabled "
-						"at request of driver %s\n",
-						state_name, driver->name);
-				return xhci_get_timeout_no_hub_lpm(udev, state);
+				dev_dbg(&udev->dev, "Hub-initiated %s disabled at request of driver %s\n",
+					state_name, driver->name);
+				timeout = xhci_get_timeout_no_hub_lpm(udev,
+								      state);
+				if (timeout == USB3_LPM_DISABLED)
+					return timeout;
 			}
 		}
 


