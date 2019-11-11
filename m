Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E712C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5000921655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498317;
	bh=W5+g3aWZRsakgU45RU0DonSXrjseJYQ0wgx+D1XXCgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PPQPMP+pSTrDsTVTeShlABEdsvQ6V3f+cgbS1REgxlu5MWnieQtVBZQbLfaghj/du
	 lXxucQQfWuAmrTsesbrNhjQTQ1vCENil/zxmfJuKLRu7e8KFw9kWLX5CXX7al50wMa
	 NITDY2IXFZBHugiKzrsk2bn86AjB7So+lOYILUAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfKKSvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:51:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730457AbfKKSvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:51:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B5C21655;
        Mon, 11 Nov 2019 18:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498312;
        bh=W5+g3aWZRsakgU45RU0DonSXrjseJYQ0wgx+D1XXCgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/S5a+8XlGxFJFpMDOzu6IGY9cnTb7NS/wyqIUe/DxYveEsSNR9xBEzHSDQ+tHmd+
         LieyfAHYw4MheyRaRtvorsiHGYPAFnwbE7Ddvp41wl1lyHCUCSSPZmDAzOSC9qSgOj
         cCy5DD9w9KJ4VBgKx6ISyt6HERsTTcJmiH+5K1yc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.3 067/193] intel_th: pci: Add Comet Lake PCH support
Date:   Mon, 11 Nov 2019 19:27:29 +0100
Message-Id: <20191111181506.043955725@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 3adbb5718dd5264666ddbc2b9b43799d292e9cb6 upstream.

This adds support for Intel TH on Comet Lake PCH.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191028070651.9770-7-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -200,6 +200,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
+		/* Comet Lake PCH */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x06a6),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
 		/* Ice Lake NNPI */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x45c5),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,


