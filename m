Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47758C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1093120823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688240;
	bh=jxB70l1tT7A6lNQNLj535nMieyZYI/+079iRE8qJNqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oeb7Ez+ThtsTz5svjR/7/G9q4z7Ki3F9PS+4plevvrphAiL+nPcRVJudxKfaFK6JG
	 fKt7XgFH6eMhLXJ3tsM2QOpNh9+Z5gZBBSR3CsGN200jwvkOqNtGNKEt4R2lfeSEM6
	 WmhoTN6z0FZgT+9kEVYgFgqvMmKPX4KUKN1tHlkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfCDIai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:30:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbfCDIaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:30:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836B020823;
        Mon,  4 Mar 2019 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688235;
        bh=jxB70l1tT7A6lNQNLj535nMieyZYI/+079iRE8qJNqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GXYSJpubapNhQXRSWkvKcZJ1xllwcXFFKmQyQimcmDXblOVaDAWV13nVQ78nnh0ae
         VNq5W1xIoqWgoIwjBB4Ym4hdcywy7JMivyU2kuhAn6pa2cw4RctXLg/BNM3C7f0D04
         /DyUMwdqppvJjbXBzsLfpBRhw91FJO2uf9fuTwQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 24/78] selftests/vm/gup_benchmark.c: match gup struct to kernel
Date:   Mon,  4 Mar 2019 09:22:07 +0100
Message-Id: <20190304081626.579078181@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

[ Upstream commit 91cd63d320f84dcbf21d4327f31f7e1f85adebd0 ]

An expansion field was added to the kernel copy of this structure for
future use. See mm/gup_benchmark.c.

Add the same expansion field here, so that the IOCTL command decodes
correctly. Otherwise, it fails with EINVAL.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/gup_benchmark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index 36df55132036f..9601bc24454d9 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -22,6 +22,7 @@ struct gup_benchmark {
 	__u64 size;
 	__u32 nr_pages_per_call;
 	__u32 flags;
+	__u64 expansion[10];	/* For future use */
 };
 
 int main(int argc, char **argv)
-- 
2.19.1



