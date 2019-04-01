Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4116BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46E1206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138680;
	bh=gnvx0E5d/E2X+/TEkUI2F88PTOy9EN1UFl5LY7WU5us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RX8n/G/BKW0eikkPmIKSMEy1EaTUWRF62oJJElVOfQrRKJqtUSvcxY7ABBO9PZomJ
	 gHevv5uDjLlIgl7Wi8lEDRTzjtBZLw9iyrrK4BBfAxyyjjG0AXmTR+mkvEs0by+tXG
	 lIRSGp870nGoZikEovtY5y1LlmGkMQmAKympQVAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfDARLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729526AbfDARLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:11:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4889D206B8;
        Mon,  1 Apr 2019 17:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138673;
        bh=gnvx0E5d/E2X+/TEkUI2F88PTOy9EN1UFl5LY7WU5us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ayz/A0hThn1+DmdmZSo+QeyNicoUPwGoiGRw/Gvw5r1JlM5HIPlkkbvdxa/3Jo2tl
         sWBJ7PWwt2YMwJdLDp/LYmOV4wBqL5Qw/YgXCq12LMCQWvR6Sj1hYmIYnSrerNuqbh
         2hP1hmoOWJ4VSVRomaVzYQnYD7CszkUj9YQazhJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Pavithra R. Prakash" <pavrampu@in.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.0 136/146] powerpc/pseries/energy: Use OF accessor functions to read ibm,drc-indexes
Date:   Mon,  1 Apr 2019 19:02:28 +0200
Message-Id: <20190401170059.614669770@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

commit ce9afe08e71e3f7d64f337a6e932e50849230fc2 upstream.

In cpu_to_drc_index() in the case when FW_FEATURE_DRC_INFO is absent,
we currently use of_read_property() to obtain the pointer to the array
corresponding to the property "ibm,drc-indexes". The elements of this
array are of type __be32, but are accessed without any conversion to
the OS-endianness, which is buggy on a Little Endian OS.

Fix this by using of_property_read_u32_index() accessor function to
safely read the elements of the array.

Fixes: e83636ac3334 ("pseries/drc-info: Search DRC properties for CPU indexes")
Cc: stable@vger.kernel.org # v4.16+
Reported-by: Pavithra R. Prakash <pavrampu@in.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
[mpe: Make the WARN_ON a WARN_ON_ONCE so it's not retriggerable]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/pseries/pseries_energy.c |   27 ++++++++++++++++--------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -77,18 +77,27 @@ static u32 cpu_to_drc_index(int cpu)
 
 		ret = drc.drc_index_start + (thread_index * drc.sequential_inc);
 	} else {
-		const __be32 *indexes;
-
-		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
-		if (indexes == NULL)
-			goto err_of_node_put;
+		u32 nr_drc_indexes, thread_drc_index;
 
 		/*
-		 * The first element indexes[0] is the number of drc_indexes
-		 * returned in the list.  Hence thread_index+1 will get the
-		 * drc_index corresponding to core number thread_index.
+		 * The first element of ibm,drc-indexes array is the
+		 * number of drc_indexes returned in the list.  Hence
+		 * thread_index+1 will get the drc_index corresponding
+		 * to core number thread_index.
 		 */
-		ret = indexes[thread_index + 1];
+		rc = of_property_read_u32_index(dn, "ibm,drc-indexes",
+						0, &nr_drc_indexes);
+		if (rc)
+			goto err_of_node_put;
+
+		WARN_ON_ONCE(thread_index > nr_drc_indexes);
+		rc = of_property_read_u32_index(dn, "ibm,drc-indexes",
+						thread_index + 1,
+						&thread_drc_index);
+		if (rc)
+			goto err_of_node_put;
+
+		ret = thread_drc_index;
 	}
 
 	rc = 0;


