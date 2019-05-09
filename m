Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA97C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D852C20656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428800;
	bh=9tbsKffdPUc+3OwTLv/iHQ2quWGjUaoqMPorFu9sQZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aXRbtW+oWpEj/WrTPonaM9bl3e3a/yVMkeaKBx0t8zVwBwy0LirQx+tDA6eegZT9z
	 4I4/A819VIzoUThVKWq5qR7DfSKMNaNDFevnnoUeMqfvBoZTq1H/47HEytYi9U973V
	 /RC8uXyJfHVz63AOygtOrjXKVsxAFXyfIhOL/8ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfEITGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbfEISqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:46:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D786921848;
        Thu,  9 May 2019 18:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427600;
        bh=9tbsKffdPUc+3OwTLv/iHQ2quWGjUaoqMPorFu9sQZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fAOsUInQEbpoDuPKh591XiZNPHD6Wj4yYWc7a7pogIU2ElYTUm77GEzuCdhftpnBL
         Yx2i9qIbFhndgJQ8cqinRArMt5WsokLulNOVVs9V3QhViwdYOLwZmC0mTNVpauYHS3
         HORECqMWUyyaeM+OccCOy2gcz+VJfqRC2DP1WvGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 31/42] usb: dwc3: Fix default lpm_nyet_threshold value
Date:   Thu,  9 May 2019 20:42:20 +0200
Message-Id: <20190509181258.968789081@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181252.616018683@linuxfoundation.org>
References: <20190509181252.616018683@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit 8d791929b2fbdf7734c1596d808e55cb457f4562 upstream.

The max possible value for DCTL.LPM_NYET_THRES is 15 and not 255. Change
the default value to 15.

Cc: stable@vger.kernel.org
Fixes: 80caf7d21adc ("usb: dwc3: add lpm erratum support")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1042,7 +1042,7 @@ static void dwc3_get_properties(struct d
 	u8			hird_threshold;
 
 	/* default to highest possible threshold */
-	lpm_nyet_threshold = 0xff;
+	lpm_nyet_threshold = 0xf;
 
 	/* default to -3.5dB de-emphasis */
 	tx_de_emphasis = 1;


