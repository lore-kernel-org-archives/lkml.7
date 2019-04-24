Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AD2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199A42064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127826;
	bh=3RwNzqFLoeTiImL/zSE+UwQSYMR9bGr66tx4XXPNflk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dTvHo6A1kNE7ifh7J69ZkMpi9D0RTCKD/0d8Pn9e5IWnhi8FmHglEDNb7pSrkHJKi
	 kGZIKxMfuUKyTOKMsR2+684NZBvnlkutDlrMi56QccFjb99GoN7BZtK2t/7MXQShML
	 P4ZgKXeg3Dzs3NIXwFUrA0htHY7QhXOnVVf7V8Xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403977AbfDXRnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391831AbfDXRfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:09 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 604D72054F;
        Wed, 24 Apr 2019 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127308;
        bh=3RwNzqFLoeTiImL/zSE+UwQSYMR9bGr66tx4XXPNflk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFGKjFlaa5Oqzn17J3p08iWmt4xs0i9ahqfp3zQgFm5VY4vZN8tozQZK3gjpQZzlN
         EJF2bH485sxoc/fY+/n0kjkkBYIyHM6/az3mfA/MfmkrGbjHM8pSvtRACtAKvksg0s
         FGvrEsVGYjEHUshWJopt3G2VlAbP7LaRtrVrrBm8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 5.0 042/115] nfc: nci: Potential off by one in ->pipes[] array
Date:   Wed, 24 Apr 2019 19:09:38 +0200
Message-Id: <20190424170927.505476173@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 6491d698396fd5da4941980a35ca7c162a672016 ]

This is similar to commit e285d5bfb7e9 ("NFC: Fix the number of pipes")
where we changed NFC_HCI_MAX_PIPES from 127 to 128.

As the comment next to the define explains, the pipe identifier is 7
bits long.  The highest possible pipe is 127, but the number of possible
pipes is 128.  As the code is now, then there is potential for an
out of bounds array access:

    net/nfc/nci/hci.c:297 nci_hci_cmd_received() warn: array off by one?
    'ndev->hci_dev->pipes[pipe]' '0-127 == 127'

Fixes: 11f54f228643 ("NFC: nci: Add HCI over NCI protocol support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/nfc/nci_core.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -166,7 +166,7 @@ struct nci_conn_info {
  * According to specification 102 622 chapter 4.4 Pipes,
  * the pipe identifier is 7 bits long.
  */
-#define NCI_HCI_MAX_PIPES          127
+#define NCI_HCI_MAX_PIPES          128
 
 struct nci_hci_gate {
 	u8 gate;


