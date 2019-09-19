Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7655CC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C89217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932452;
	bh=rB60oEYgCyg+9soH/TdumL1Wm7jIh7jsADvD/I5McB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CTPi99IJtBQFfzd+rfIzmW7IcyG3VMRch39rkBsy6m53bEvu1f9TNC9e5J2ffjEFv
	 mrRNYWrtUeT7CZKdzoRZKtsX9jmgt42ZpoXmE/2zLac9uL/BLIQTEOTgyFm0k5Fw2J
	 sJNsfzgfOuRKl+G3XpaD1Rd1E9RUokaXyaQoSRIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405648AbfISWKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405627AbfISWKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:10:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC7D218AF;
        Thu, 19 Sep 2019 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931014;
        bh=rB60oEYgCyg+9soH/TdumL1Wm7jIh7jsADvD/I5McB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MtsP5PTtXl0DZ4eAzGZlcnNSocpoZ46kpUsoeycy4gqge1zUdiUA7gKOrKbrSzvJg
         7dzNvyIgFAxHsLokoDzHL9kRXv61RTZ+od9NU6eACHjga928S6VYH9KAydSNfAf5mF
         7Ss3LqIv1Xf+6Rq9NriWCG7x1S18dABexsdalu9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Len Brown <len.brown@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 096/124] tools/power turbostat: fix leak of file descriptor on error return path
Date:   Fri, 20 Sep 2019 00:03:04 +0200
Message-Id: <20190919214822.548475916@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 15423b958f33132152e209e98df0dedc7a78f22c ]

Currently the error return path does not close the file fp and leaks
a file descriptor. Fix this by closing the file.

Fixes: 5ea7647b333f ("tools/power turbostat: Warn on bad ACPI LPIT data")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1cd28ebf8443b..efc8d07364c61 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2938,6 +2938,7 @@ int snapshot_sys_lpi_us(void)
 	if (retval != 1) {
 		fprintf(stderr, "Disabling Low Power Idle System output\n");
 		BIC_NOT_PRESENT(BIC_SYS_LPI);
+		fclose(fp);
 		return -1;
 	}
 	fclose(fp);
-- 
2.20.1



