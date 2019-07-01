Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BED5C06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF81D204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XCX/CRqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfGALrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:47:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53291 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfGALrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:47:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190701114710euoutp018aae8d14c634775dacdc325f1f5763a0~tRgSCoNzm2561625616euoutp01f
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2019 11:47:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190701114710euoutp018aae8d14c634775dacdc325f1f5763a0~tRgSCoNzm2561625616euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561981630;
        bh=z+lS/EEwuYVzD0aKq4UzHQZ2sWlz7ZXp9Pd3gqP5uzM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XCX/CRqKlJFZtdZzprCO3t76Yy6dz8QGJVBfFtaqpszpW+8/y2Uz/Nz3iVuAnowgE
         meqxOEL8nCSfQ/JPhizo7gCmnys4JUXa7J60REAA5hH3ZBPdezbvA//WVz2Xojjom4
         9r2QiimcWH6A35EOVXG5Oo4RQ7T1cefIedncpaRI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190701114710eucas1p26adfabd4f1792ca7ac88f8ddfe68bd69~tRgRrwUSt3100031000eucas1p2N;
        Mon,  1 Jul 2019 11:47:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 79.BD.04298.EB2F91D5; Mon,  1
        Jul 2019 12:47:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190701114709eucas1p135d990205d5df237abd550d89e3de02b~tRgQ_RZyZ0505405054eucas1p1-;
        Mon,  1 Jul 2019 11:47:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190701114709eusmtrp1c220b4524020cb4fa8e72b19b79d8cdf~tRgQwPQ3L2999929999eusmtrp1X;
        Mon,  1 Jul 2019 11:47:09 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-22-5d19f2beb021
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3E.B5.04146.DB2F91D5; Mon,  1
        Jul 2019 12:47:09 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190701114709eusmtip1e051cb1178b1abde45348d960b1daae7~tRgQXiuZq0817608176eusmtip1d;
        Mon,  1 Jul 2019 11:47:09 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux@armlinux.org.uk, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] clk: Add missing documentation of
 devm_clk_bulk_get_optional() argument
Date:   Mon,  1 Jul 2019 13:46:51 +0200
Message-Id: <20190701114651.16872-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7djP87r7PknGGsy5KGzxseceq8XlXXPY
        LA5N3ctocfGUq8XhN+2sFv+ubWRxYPO4fO0is8f7G63sHptWdbJ59G1ZxejxeZNcAGsUl01K
        ak5mWWqRvl0CV8bmNY+YC06zV2yc/oO9gXEDWxcjJ4eEgInE1vU7WEFsIYEVjBI9LS5djFxA
        9hdGibPXNjNDJD4zSjR/8Idp2PiyjwWiaDmjxI2Dh5nhOt49XscIUsUmYCjRe7QPzBYR0JVo
        X7aPDaSIWaCRUeLBjzawhLBAlMTRxt9gu1kEVCU6v+wBi/MKWEvM7VjPDrFOXmL1hgNgGyQE
        zrBJXJ/bzwiRcJH4vHQ61BPCEq+Ob4FqkJE4PbmHBaKhGeih3bfZIZwJjBL3jy+A6raWOHz8
        ItBqDqCbNCXW79KHCDtKfD+3gQkkLCHAJ3HjrSBImBnInLRtOjNEmFeio00IolpF4veq6UwQ
        tpRE95P/LBC2h0TrlUNgU4QEYiUuPw2fwCg3C2HVAkbGVYziqaXFuempxYZ5qeV6xYm5xaV5
        6XrJ+bmbGIHxf/rf8U87GL9eSjrEKMDBqMTD23BHIlaINbGsuDL3EKMEB7OSCO/+FZKxQrwp
        iZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5akZqemFqQWwWSZODilGhj5Qjg/1zGsiTfO
        /8pbOME9+87W4K13TDOlnZ8vfqe36DdH0fRrDJIX0pguvJMOCzu54OWiC6vFRC6/VF+u9TP/
        1ErtU4pS5yb5OHTy6eRfkIgx83q5hHeJ8pRj73QTeb4Y9U7Z8GTayQNC5vnPkhbocec/8/vH
        9YLN5JRvycS5J4zeVS44lVynxFKckWioxVxUnAgACjzB0PsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsVy+t/xu7p7P0nGGjw+Im/xseceq8XlXXPY
        LA5N3ctocfGUq8XhN+2sFv+ubWRxYPO4fO0is8f7G63sHptWdbJ59G1ZxejxeZNcAGuUnk1R
        fmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbmNY+YC06z
        V2yc/oO9gXEDWxcjJ4eEgInExpd9LF2MXBxCAksZJa4+P8HaxcgBlJCSmN+iBFEjLPHnWhcb
        RM0nRompa9eDNbMJGEr0Hu1jBLFFBPQlJrdtABvELNDKKLFl6i12kISwQITElV+TwWwWAVWJ
        zi97wBp4Bawl5nasZ4fYIC+xesMB5gmMPAsYGVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIE
        Bt62Yz8372C8tDH4EKMAB6MSD6/GLYlYIdbEsuLK3EOMEhzMSiK8+1dIxgrxpiRWVqUW5ccX
        leakFh9iNAVaPpFZSjQ5HxgVeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg
        +pg4OKUaGHOj9xv+U5ugFrps43sFOV353IJX2XNfBV4V9xEOd+ju1Glx+blKOGaN6L2bCq3J
        f0U8V23PEOr1tCya6BB5bplyfcTad11b7N/IBAudC2Up2qDpmuiZsmlJ/P4za2W65PcutT78
        otK8Y0Zj7one7Q8P/n3OkF2aLG2xXW2tkbFK3hWzDfOeK7EUZyQaajEXFScCAKKgnj9SAgAA
X-CMS-MailID: 20190701114709eucas1p135d990205d5df237abd550d89e3de02b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190701114709eucas1p135d990205d5df237abd550d89e3de02b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190701114709eucas1p135d990205d5df237abd550d89e3de02b
References: <CGME20190701114709eucas1p135d990205d5df237abd550d89e3de02b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an incomplete devm_clk_bulk_get_optional() function documentation
by adding description of the num_clks argument as in other *clk_bulk*
functions.

Fixes: 9bd5ef0bd874 ("clk: Add devm_clk_bulk_get_optional() function")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 include/linux/clk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 5e7b2dd84965a..0868703925028 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -362,6 +362,7 @@ int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 /**
  * devm_clk_bulk_get_optional - managed get multiple optional consumer clocks
  * @dev: device for clock "consumer"
+ * @num_clks: the number of clk_bulk_data
  * @clks: pointer to the clk_bulk_data table of consumer
  *
  * Behaves the same as devm_clk_bulk_get() except where there is no clock
-- 
2.17.1

