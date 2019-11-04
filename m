Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8364BCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FFF21744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904656;
	bh=z0DvuLwhSC3a8DkNEt/tFpheLuPJ9uCVXMkkz4YfGcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i+3jB/GaJ7awdQvlmgRVxQbpQMipHUhYX/kRCdch/BES7TOt3mQlGaFhZQ8xmGRY/
	 wvnvFwpFyFNKQOr7smIioWbNSw9QiJ6zUtyzEMllm9n1ruIuNSxvtWSOzMnB+P/jzt
	 quVW5FUDoGoYKzDdSHTu9iTRRD/w0enK+2I9GplY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbfKDV5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:57:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388568AbfKDV52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:57:28 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 060BF214D8;
        Mon,  4 Nov 2019 21:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904647;
        bh=z0DvuLwhSC3a8DkNEt/tFpheLuPJ9uCVXMkkz4YfGcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJRxgp2GLXhZeDvD8p4xDMuecUSZSx/FnCniyfHJ9bhqhehV6H7sE3McaFsxd4mlS
         EMZRLSdLWKCaW4yhK0Mhg3eLJQRMi7St0S6tDuQEI8gbuzYaHHvrY/+9ldB+pv7fyo
         7rJCNb8ZhPZZ9hAo2wcS73YrHqR0SuGtg8Ojx08I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 020/149] bcache: fix input overflow to writeback_rate_minimum
Date:   Mon,  4 Nov 2019 22:43:33 +0100
Message-Id: <20191104212136.496169336@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

[ Upstream commit dab71b2db98dcdd4657d151b01a7be88ce10f9d1 ]

dc->writeback_rate_minimum is type unsigned integer variable, it is set
via sysfs interface, and converte from input string to unsigned integer
by d_strtoul_nonzero(). When the converted input value is larger than
UINT_MAX, overflow to unsigned integer happens.

This patch fixes the overflow by using sysfs_strotoul_clamp() to
convert input string and limit the value in range [1, UINT_MAX], then
the overflow can be avoided.

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 5bb81e564ce88..3e8d1f1b562f8 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -289,7 +289,9 @@ STORE(__cached_dev)
 	sysfs_strtoul_clamp(writeback_rate_p_term_inverse,
 			    dc->writeback_rate_p_term_inverse,
 			    1, UINT_MAX);
-	d_strtoul_nonzero(writeback_rate_minimum);
+	sysfs_strtoul_clamp(writeback_rate_minimum,
+			    dc->writeback_rate_minimum,
+			    1, UINT_MAX);
 
 	sysfs_strtoul_clamp(io_error_limit, dc->error_limit, 0, INT_MAX);
 
-- 
2.20.1



