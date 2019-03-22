Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3450FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF32D2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256439;
	bh=wxfVRUHsFJC1DTkPOn88Ku5TqVNeGEgePxf3MzRojOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vB4ocD/DTiKgnvS8FqUadsz9YBgz8005bEIUotVr1J/siIyId2X1QTe/zDBGAOGSW
	 ghubrSfujwB86jsO9XXHq/uwpiroot87JQxf3CSFHR7vO80QZ37xIeok4UNy+H9zt2
	 FaR/5000pAxXFJMMqmIHxSJFNHbsCNn9v/Zn0yf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbfCVMHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388775AbfCVMHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:07:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58CCE21934;
        Fri, 22 Mar 2019 12:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256428;
        bh=wxfVRUHsFJC1DTkPOn88Ku5TqVNeGEgePxf3MzRojOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKHvCkKu+eNv2IsdPp0wUHTY/iZGhxOLFPPZdbI0YGqZsaoH22LvpfOo+SnLA0Cxj
         s7/fHYm+KegCiydrgXnERB+188y6I6Urxh5tHj/Rr6taYUxStLGxMlpiO2ugeAz2RI
         Hd4K2jWaJ54au6kcvZQl/4SwpFI7NsdAuzfRCROM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.19 207/280] i2c: tegra: fix maximum transfer size
Date:   Fri, 22 Mar 2019 12:16:00 +0100
Message-Id: <20190322111331.984408844@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

From: Sowjanya Komatineni <skomatineni@nvidia.com>

commit f4e3f4ae1d9c9330de355f432b69952e8cef650c upstream.

Tegra186 and prior supports maximum 4K bytes per packet transfer
including 12 bytes of packet header.

This patch fixes max write length limit to account packet header
size for transfers.

Cc: stable@vger.kernel.org # 4.4+

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-tegra.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -832,7 +832,7 @@ static const struct i2c_algorithm tegra_
 /* payload size is only 12 bit */
 static const struct i2c_adapter_quirks tegra_i2c_quirks = {
 	.max_read_len = 4096,
-	.max_write_len = 4096,
+	.max_write_len = 4096 - 12,
 };
 
 static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {


