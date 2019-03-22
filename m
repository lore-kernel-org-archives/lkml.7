Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C1B2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254965;
	bh=eisnE4oUMpBFQGRbJmmu3pU+TMWlhCxSP9d+rNUOciI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uYRmPPqEAU8Xw69PNLronvTLMLSnD7XxD5jg0VxxMeIbAXsEV+WP+0yFD3qXj/xA/
	 3oyuh8TEHX+s6BJZ0LPWuzRsCEeRCMRWE2IPU9JaN31gr9sllVlAZSz4tD9PUa6ePr
	 iirzgAuF8mH2Xn2xfFcuu+xE50+9Mo4ALafAh1pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfCVLmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731574AbfCVLmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:42:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FAFF204FD;
        Fri, 22 Mar 2019 11:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254959;
        bh=eisnE4oUMpBFQGRbJmmu3pU+TMWlhCxSP9d+rNUOciI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KQZP/g/VZV6e0yF4qo34LV+PJ7PbloBF26lj4wmp2isqtJbVm1CcdKHylteUBJ4Me
         DqvTMCkQa1t9D5+C25ipmq1Se5jPCPiTetXLMqwxRRk4DR1mIOarvbcLYBJvPyWep+
         BJLJLfZrpD0f0Vro0V7DYvrA1IeeiGyX+2RjAil8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Oliver OHalloran <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 4.9 045/118] libnvdimm: Fix altmap reservation size calculation
Date:   Fri, 22 Mar 2019 12:15:17 +0100
Message-Id: <20190322111219.509168905@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

From: Oliver O'Halloran <oohall@gmail.com>

commit 07464e88365e9236febaca9ed1a2e2006d8bc952 upstream.

Libnvdimm reserves the first 8K of pfn and devicedax namespaces to
store a superblock describing the namespace. This 8K reservation
is contained within the altmap area which the kernel uses for the
vmemmap backing for the pages within the namespace. The altmap
allows for some pages at the start of the altmap area to be reserved
and that mechanism is used to protect the superblock from being
re-used as vmemmap backing.

The number of PFNs to reserve is calculated using:

	PHYS_PFN(SZ_8K)

Which is implemented as:

 #define PHYS_PFN(x) ((unsigned long)((x) >> PAGE_SHIFT))

So on systems where PAGE_SIZE is greater than 8K the reservation
size is truncated to zero and the superblock area is re-used as
vmemmap backing. As a result all the namespace information stored
in the superblock (i.e. if it's a PFN or DAX namespace) is lost
and the namespace needs to be re-created to get access to the
contents.

This patch fixes this by using PFN_UP() rather than PHYS_PFN() to ensure
that at least one page is reserved. On systems with a 4K pages size this
patch should have no effect.

Cc: stable@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Fixes: ac515c084be9 ("libnvdimm, pmem, pfn: move pfn setup to the core")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/pfn_devs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -515,7 +515,7 @@ static unsigned long init_altmap_base(re
 
 static unsigned long init_altmap_reserve(resource_size_t base)
 {
-	unsigned long reserve = PHYS_PFN(SZ_8K);
+	unsigned long reserve = PFN_UP(SZ_8K);
 	unsigned long base_pfn = PHYS_PFN(base);
 
 	reserve += base_pfn - PFN_SECTION_ALIGN_DOWN(base_pfn);


