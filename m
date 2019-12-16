Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3255EC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016CE207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520214;
	bh=QUuWlmukpB22zUiY0dYuQxdxdGq93Oj0RixZKBw1294=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hps8JXdNFqqGLwuv+M/CM0OR3xlnZ+q8rUjrlU5gPLyB3B4qGgtBN+DjSbHkIsTyZ
	 LWPpZGvMfiBrdO+sQatuFDwe9hzCghfC4y47nAeotHhlo9ByeLzmP6zpHOUjcFbMD3
	 4s4qNxENNgeke9tuXjdl8IrnijxJD6hcV8aOgtZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbfLPSQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:16:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731369AbfLPSQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:16:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47CB6207FF;
        Mon, 16 Dec 2019 18:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520210;
        bh=QUuWlmukpB22zUiY0dYuQxdxdGq93Oj0RixZKBw1294=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fD8Z8XyhoSrCtUntcAJArKlRsXaqPzTCQd8WlMJvn7MjscqRPQAhDjifG2R2HY7/+
         eraW+stjEjvb6owdoQcV0MQQpLDVQ2qQ3+aL0HzbsINAGPvjrRU8E2dC852ALB+Y2U
         TvHzH6bSa3Ji+23BysxW38PUk5QwGLxKA+zfQV10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.4 061/177] usb: dwc3: gadget: Clear started flag for non-IOC
Date:   Mon, 16 Dec 2019 18:48:37 +0100
Message-Id: <20191216174831.556504486@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit d3abda5a98a18e524e17fd4085c9f4bd53e9ef53 upstream.

Normally the END_TRANSFER command completion handler will clear the
DWC3_EP_TRANSFER_STARTED flag. However, if the command was sent without
interrupt on completion, then the flag will not be cleared. Make sure to
clear the flag in this case.

Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2719,6 +2719,9 @@ static void dwc3_stop_active_transfer(st
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
+	if (!interrupt)
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+
 	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A)
 		udelay(100);
 }


