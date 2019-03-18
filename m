Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F98C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7A12075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901776;
	bh=UWskMN7S/Lx/kOsum/kPHOUVsB1LHdjzYKxi4Q0Y4CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UdVxRh/SUws7D6JjKKYRuMPOOlK/j17Qs2M+gnhXfWt4we9G5nnm6u3aRVYOSW8Ua
	 9E6iDf2B9mD1+b6iwY14npUJER+r3dIu0qsLa/fOVbdbAZV2rzYlXk+N2W4ipC6V4q
	 XDeqdsYtfioObvNNfzSfM9gd8w8374CI0LyLVjBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbfCRJgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387602AbfCRJgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:36:11 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39212075C;
        Mon, 18 Mar 2019 09:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901771;
        bh=UWskMN7S/Lx/kOsum/kPHOUVsB1LHdjzYKxi4Q0Y4CM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hqm6SNpehcHLquOOvvaDBwFU84Wr+hRbEU9wew0cTrBIHnY4Mv9iKgTX1kgAW9KJW
         lNd9sjfZ6s6Dq5bY3fXaRWJxdXI4iVIEWCcChJjv2UvmLzj2rjbdN17qSKnVF7epz8
         73xft7imUmZHwrvX10Fh07NFVEiX9B+V84SscwNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 4.9 01/31] ACPICA: Reference Counts: increase max to 0x4000 for large servers
Date:   Mon, 18 Mar 2019 10:25:36 +0100
Message-Id: <20190318084210.452510416@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084210.397476003@linuxfoundation.org>
References: <20190318084210.397476003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Schmauss <erik.schmauss@intel.com>

commit 8b23570ab001c1982c8a068cde468ff067255314 upstream.

Increase the reference count limit to 0x4000 as the current one is
not sufficient for some large server systems.

Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Tested-by: Russ Anderson <russ.anderson@hpe.com>
Reported-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
[ rjw: Changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Frank van der Linden <fllinden@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/acpi/acconfig.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -122,7 +122,7 @@
 
 /* Maximum object reference count (detects object deletion issues) */
 
-#define ACPI_MAX_REFERENCE_COUNT        0x1000
+#define ACPI_MAX_REFERENCE_COUNT        0x4000
 
 /* Default page size for use in mapping memory for operation regions */
 


