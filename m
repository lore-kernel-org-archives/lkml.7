Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129B2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D280420856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139092;
	bh=Tz86OgHisX80a8gsngNagDaD+AwdT6gqJOuaTWhS538=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U02nXDKJ0i6kIeU55hmbRj6bcDXMw59aOrUuBzkU+PAFtLXS6Kce0BOqFQw1tj4E1
	 dZ3rsBuO3bTM5ch3REDpc/dral1DgG3lLLI9uZ3rZtPKtH1G5pTF9ADxLmapJ1BEeW
	 BTQWX5z+jpQTJPABK+T17Jp9AGeFHdxLh5lDwPKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfDARSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731283AbfDARR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:17:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16490206C0;
        Mon,  1 Apr 2019 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139078;
        bh=Tz86OgHisX80a8gsngNagDaD+AwdT6gqJOuaTWhS538=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nj+PSXXvOEik2GzBXD0fKwheQM2F33bOOYTV54xhKlEJaHk1KjiX84+iPsz35UhDu
         WWZOA65wGvuvX9rOracFwUUEeBrpyAMJlg7hmIDkDQEL2IYjLRY80AtscN67dF9sPN
         ibdTyXxhTQMApWd6PFFkSllKDas++2s6BrYYNPW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yasushi Asano <yasano@jp.adit-jv.com>,
        Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 4.19 106/134] usb: host: xhci-rcar: Add XHCI_TRUST_TX_LENGTH quirk
Date:   Mon,  1 Apr 2019 19:02:22 +0200
Message-Id: <20190401170054.122633814@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yasushi Asano <yasano@jp.adit-jv.com>

commit 40fc165304f0faaae78b761f8ee30b5d216b1850 upstream.

When plugging BUFFALO LUA4-U3-AGT USB3.0 to Gigabit Ethernet LAN
Adapter, warning messages filled up dmesg.

[  101.098287] xhci-hcd ee000000.usb: WARN Successful completion on short TX for slot 1 ep 4: needs XHCI_TRUST_TX_LENGTH quirk?
[  101.117463] xhci-hcd ee000000.usb: WARN Successful completion on short TX for slot 1 ep 4: needs XHCI_TRUST_TX_LENGTH quirk?
[  101.136513] xhci-hcd ee000000.usb: WARN Successful completion on short TX for slot 1 ep 4: needs XHCI_TRUST_TX_LENGTH quirk?

Adding the XHCI_TRUST_TX_LENGTH quirk resolves the issue.

Signed-off-by: Yasushi Asano <yasano@jp.adit-jv.com>
Signed-off-by: Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-rcar.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -246,6 +246,7 @@ int xhci_rcar_init_quirk(struct usb_hcd
 	if (!xhci_rcar_wait_for_pll_active(hcd))
 		return -ETIMEDOUT;
 
+	xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 	return xhci_rcar_download_firmware(hcd);
 }
 


