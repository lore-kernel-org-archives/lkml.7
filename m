Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C706C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5F420665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890305;
	bh=5W9Egi4zKehIZf+zXK06b5qupqNkKPfecanbW4wj9z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=REzYxF3ru66osoezawbIMuwKFScZ3I/kO+fHz6AaOfvJC3RIlD53R7fdB/JQs+ue8
	 InHgyz44cQLiUyvGveWvFkC0VPPbgqVM68fWFrrrw+UOROdfA1cx8PSySV+3LA4J2J
	 reDkdSxSWGJ6vuO1x7U6HVXRz4+CjbZlewd15JRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfK0UyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:54:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730304AbfK0UyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:54:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCBAF2086A;
        Wed, 27 Nov 2019 20:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888049;
        bh=5W9Egi4zKehIZf+zXK06b5qupqNkKPfecanbW4wj9z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fK/OZmT1ROoS0wwmyLXWxdUvAKhXDxiLGsygGD6ToWnPdwzzP/qh3nVoX9rvoBQ4w
         CujJuP+3tTiXeOtgMir5wdH4SWZhQ5DCGR945VinnCDoLnz3DDtE/NVhgTej18UPCj
         hV1g78ROtAjvbIfm/f/OfIUDRxCmw6ebmSaZOSrU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hewenliang <hewenliang4@huawei.com>
Subject: [PATCH 4.14 197/211] usbip: tools: fix fd leakage in the function of read_attr_usbip_status
Date:   Wed, 27 Nov 2019 21:32:10 +0100
Message-Id: <20191127203112.241810566@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hewenliang <hewenliang4@huawei.com>

commit 26a4d4c00f85cb844dd11dd35e848b079c2f5e8f upstream.

We should close the fd before the return of read_attr_usbip_status.

Fixes: 3391ba0e2792 ("usbip: tools: Extract generic code to be shared with vudc backend")
Signed-off-by: Hewenliang <hewenliang4@huawei.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191025043515.20053-1-hewenliang4@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/usb/usbip/libsrc/usbip_host_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/usb/usbip/libsrc/usbip_host_common.c
+++ b/tools/usb/usbip/libsrc/usbip_host_common.c
@@ -69,7 +69,7 @@ static int32_t read_attr_usbip_status(st
 	}
 
 	value = atoi(status);
-
+	close(fd);
 	return value;
 }
 


