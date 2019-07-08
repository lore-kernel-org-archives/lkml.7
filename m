Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0088DC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C415C2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599049;
	bh=HQzwS0w3Prp2h1SScAgw7qsC0Aw7VqIFeQWKRx99Qn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CIzrk/5wvn5u3RFYwrRLo5XRn8IoClXASdCBsv2jmN3BnxG7aomSKLZrtuzVEoE9s
	 tDhfwouWXWu3XhzRFlU3r2oV01CJNLewtTjru1m9cMh28wka7Fqs/hDXTFwJXKO9/u
	 qO5Mu3AUR2e0cpC3WpSr5l222rLJR3Fd7TAi5yJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbfGHPR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732790AbfGHPRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:17:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5C6C21707;
        Mon,  8 Jul 2019 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599045;
        bh=HQzwS0w3Prp2h1SScAgw7qsC0Aw7VqIFeQWKRx99Qn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wpj9X/RkP5yoZesjOXkkOzaY3ilDInXpBdvp3DWNXvWJepIBasM6+VbYg/d77h4oE
         4qbj//Nt/Z9Li+vII2mxU3cmWxJ1muvQ4fRqsnVWsR9gtC/HjQiAKyhpv9jKUZmNeP
         mhyHBB67xBBnPJ7YdFGDTPvW5+/8KV6dRnjyWzHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 59/73] swiotlb: Make linux/swiotlb.h standalone includible
Date:   Mon,  8 Jul 2019 17:13:09 +0200
Message-Id: <20190708150524.450510989@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 386744425e35e04984c6e741c7750fd6eef1a9df ]

This header file uses the enum dma_data_direction and struct page types
without explicitly including the corresponding header files. This makes
it rely on the includer to have included the proper headers before.

To fix this, include linux/dma-direction.h and forward-declare struct
page. The swiotlb_free() function is also annotated __init, therefore
requires linux/init.h to be included as well.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/swiotlb.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -1,10 +1,13 @@
 #ifndef __LINUX_SWIOTLB_H
 #define __LINUX_SWIOTLB_H
 
+#include <linux/dma-direction.h>
+#include <linux/init.h>
 #include <linux/types.h>
 
 struct device;
 struct dma_attrs;
+struct page;
 struct scatterlist;
 
 extern int swiotlb_force;


