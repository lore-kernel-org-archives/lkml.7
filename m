Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B607C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC36120820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613586;
	bh=Xm0EP9AhfA9yKFxXl9KwRa6xa8f5hEczxNn5M0FfEqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FxeqMN0qND63Ws5V9DIRQ++FfGRZSQ4xLMxy0lgZMn6K8O81IA6wju1E0/XJpdUgc
	 7bIytZMkoyw4QhTZ6urL1NbL1NcCIHzMEb3ncYOhwO12owMCH+8ZrHtGAk6U5ADo8N
	 L9d9G3L8TtFmtLF9lKhE3fQ4HjnsLv/OONABt7rA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfIDQAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732482AbfIDP7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:59:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C47AA2087E;
        Wed,  4 Sep 2019 15:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612787;
        bh=Xm0EP9AhfA9yKFxXl9KwRa6xa8f5hEczxNn5M0FfEqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xbKUYE9twAQb8LWcFAVoYn+uaZeqBNxrU3l+sLPjNa1YaXK4h00CLiX8fn3Aai9Ew
         0BBedz4IOwyxhq/ySvu/y2lYXnhwT41y/7ShyURF08sb9ILygI9xMd11JThs6Qoz/+
         4Ag7eYj1KsFVu2/uqT5GNLotwzt2RE5Pue7dkNCg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Len Brown <len.brown@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 82/94] tools/power turbostat: fix file descriptor leaks
Date:   Wed,  4 Sep 2019 11:57:27 -0400
Message-Id: <20190904155739.2816-82-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 605736c6929d541c78a85dffae4d33a23b6b2149 ]

Fix file descriptor leaks by closing fp before return.

Addresses-Coverity-ID: 1444591 ("Resource leak")
Addresses-Coverity-ID: 1444592 ("Resource leak")
Fixes: 5ea7647b333f ("tools/power turbostat: Warn on bad ACPI LPIT data")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 71a931813de00..066bd43ed6c9f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2912,6 +2912,7 @@ int snapshot_cpu_lpi_us(void)
 	if (retval != 1) {
 		fprintf(stderr, "Disabling Low Power Idle CPU output\n");
 		BIC_NOT_PRESENT(BIC_CPU_LPI);
+		fclose(fp);
 		return -1;
 	}
 
-- 
2.20.1

