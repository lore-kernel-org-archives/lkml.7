Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EB5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC92A20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688829;
	bh=EoJbkOQtQz0i9BmwvDUQOyFZsORnpTo2B+kS8AUy98U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mcEms6HsAZzYEhbvkyfzsI98X+jzGT8ZJ3P83ToRlnBOOgSio/7uuAYArrQqIErux
	 yuHju9SqomePHkWOleXfTcGjoEwSgdI8i3APwit0uftUMcoggT1GWEY/jMBLD+edT6
	 6+9IF0DMPil+u2ZWLICPum4k2U+I7IVYm9WwBiMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfCDIk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbfCDIcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:32:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60FE52146E;
        Mon,  4 Mar 2019 08:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688369;
        bh=EoJbkOQtQz0i9BmwvDUQOyFZsORnpTo2B+kS8AUy98U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1PT3eQStHvMW7kgIX5Ke0YVOK2kQCr/mevUJWoP9ad/jUh0Wxl0AQwZIfb3Pzs2Ma
         2jAt6/LFUWHi5sgkCq/2JbfYCE632MGGPtzPZOaS7I3IkP5V03UuHb5gGmUEyuhQ1r
         QPmQccWtnOoRa3qtUoeaBiBbYLgQnvcfqnZZ5gi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 24/88] selftests/vm/gup_benchmark.c: match gup struct to kernel
Date:   Mon,  4 Mar 2019 09:22:07 +0100
Message-Id: <20190304081631.565868394@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 880b96fc80d4c..c0534e298b512 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -25,6 +25,7 @@ struct gup_benchmark {
 	__u64 size;
 	__u32 nr_pages_per_call;
 	__u32 flags;
+	__u64 expansion[10];	/* For future use */
 };
 
 int main(int argc, char **argv)
-- 
2.19.1



