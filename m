Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EBEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E40214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802203;
	bh=PRZDTsD1LsSooiggYeuvBmEtcHKdPUVGbbOgby/GcT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v8EWlocsufx/xfQKBw3sykCjv+UA0mlvsPf0cInhIJvOT8GAVbaMM2UJpUkW0DPvz
	 xy7PoW+oI7uT4fnfEQw2mZx5v5tWu+vOnGob3QW0tDn6Qr2wz+t0MPl8sREWNNG7i/
	 bC8WEzN8Q4pujBPcahZdG3QheJUdZ9lChgEYi9I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfHNRDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728898AbfHNRDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:03:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88E912084D;
        Wed, 14 Aug 2019 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802197;
        bh=PRZDTsD1LsSooiggYeuvBmEtcHKdPUVGbbOgby/GcT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yB16fewS7j7mk38QUJEKn/9gCj8GOHxiyIQOzKpoUK540Nm1ngsOCJccAeVFrL98G
         puV0KxJ/NPL/rDJzUVk0GHysBpe7zrypObR8P/22EFlDHCxwqQfomn+WaRaK1rgk3u
         dAQ3K81EbKRql1oNz+yZd0+OLBEE9/a0IVu3LTzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Bornyakov <brnkv.i1@gmail.com>
Subject: [PATCH 5.2 007/144] staging: gasket: apex: fix copy-paste typo
Date:   Wed, 14 Aug 2019 18:59:23 +0200
Message-Id: <20190814165759.793112610@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Bornyakov <brnkv.i1@gmail.com>

commit 66665bb9979246729562a09fcdbb101c83127989 upstream.

In sysfs_show() case-branches ATTR_KERNEL_HIB_PAGE_TABLE_SIZE and
ATTR_KERNEL_HIB_SIMPLE_PAGE_TABLE_SIZE do the same. It looks like
copy-paste mistake.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190710204518.16814-1-brnkv.i1@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/gasket/apex_driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -532,7 +532,7 @@ static ssize_t sysfs_show(struct device
 		break;
 	case ATTR_KERNEL_HIB_SIMPLE_PAGE_TABLE_SIZE:
 		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
-				gasket_page_table_num_entries(
+				gasket_page_table_num_simple_entries(
 					gasket_dev->page_table[0]));
 		break;
 	case ATTR_KERNEL_HIB_NUM_ACTIVE_PAGES:


