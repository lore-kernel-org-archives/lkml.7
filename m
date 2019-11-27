Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63576C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C96921556
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889500;
	bh=in531OI/aSvSHnK/VUVcGLFwWJ/vlmpNhxmEMvrlhx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LE1oJ0V81zwjDiGrsvOEi1RJKsUuLhbi5sYt5q9LWGd4DJ7q1+zu2uCd9tld3IEfU
	 ZtCBhhYy7wT/zExzBySpHAueuWI8rzagy+OFYtqqu/7j+HUgtpv5a40hGFG9+mEWR1
	 E44kHcMBrdEsgrCgKWYibNaIaNzB//sfAffRl/oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733213AbfK0VLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733208AbfK0VLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:11:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC4D21555;
        Wed, 27 Nov 2019 21:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889102;
        bh=in531OI/aSvSHnK/VUVcGLFwWJ/vlmpNhxmEMvrlhx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=giOzjXztk7ATahFiFb23C0CIN8RXNy1TCQ/U3G28rtY5XxgEqBPG+cOshZRC0zM3J
         nZm2w795ooyXD42j1/4FDmYAmkPTaU2wfqlaTvrEIK+s7U2/KBI8kIfpSObj2TUABk
         smQMvvQ9mzHM8Tc7l68X+me5nW0vdfn5NX7YRiHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hewenliang <hewenliang4@huawei.com>
Subject: [PATCH 5.3 82/95] usbip: tools: fix fd leakage in the function of read_attr_usbip_status
Date:   Wed, 27 Nov 2019 21:32:39 +0100
Message-Id: <20191127202950.051880520@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
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
@@ -57,7 +57,7 @@ static int32_t read_attr_usbip_status(st
 	}
 
 	value = atoi(status);
-
+	close(fd);
 	return value;
 }
 


