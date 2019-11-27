Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25980C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC44D2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888589;
	bh=66OswkvPZoALuafR5qsSA0Pwjf5yODcChCiMsXuUxx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=prKXqKnc3uqzxj8B2oG0iR37b0l4739igmx1Rpzv/0u1VPBtfMN+ASlwB1nxZKszg
	 xfhv9C6yfEgNejsZOdRe4eFdAw4k2f7NPrPM8geBDoXE94TaO1WEkpncVByiP5otvD
	 qNESCP8t6hekZVsTsDB0Ctm88n6n/oYLpDVuPI3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbfK0VDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:03:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731980AbfK0VDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:03:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BF7B21569;
        Wed, 27 Nov 2019 21:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888584;
        bh=66OswkvPZoALuafR5qsSA0Pwjf5yODcChCiMsXuUxx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5iRmP4/+8KlWGbcWNwOnS/SHUW5bi/qndO2GEAcHCuVUTONzJ3nCnZOau35hiDv7
         ZJwXoWOOv4m259xYrvx9g1DDa15GkKnjV0c3JFyXmoX2mCGONjkTsQ2BJV94p6ykiX
         4LuT2PS4MSaQu8eKQu7nXP46S86hHOrtBlmAMgwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 149/306] tools/testing/selftests/vm/gup_benchmark.c: fix write flag usage
Date:   Wed, 27 Nov 2019 21:29:59 +0100
Message-Id: <20191127203126.388274174@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit 319e0bec1aecb36c5ac6d23812af487ff2c8f47f ]

If the '-w' parameter was provided, the benchmark would exit due to a
mssing 'break'.

Link: http://lkml.kernel.org/r/20181010195605.10689-3-keith.busch@intel.com
Signed-off-by: Keith Busch <keith.busch@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/gup_benchmark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index 9601bc24454d9..17da711f26afb 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -51,6 +51,7 @@ int main(int argc, char **argv)
 			break;
 		case 'w':
 			write = 1;
+			break;
 		default:
 			return -1;
 		}
-- 
2.20.1



