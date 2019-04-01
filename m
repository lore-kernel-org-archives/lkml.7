Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E57C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B7A20663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554142047;
	bh=An7fO9qWvjuhMPOvmb6JsZbkRjGPglHi3qs52Cva6uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CjRAHWANzPc56+2GF8tzwENjn1eQTbIVOVtgkVtvIuWX1xCQZEJNlc+gedUirfheU
	 a2n3VwIVxfyDnjt3yHikaQbwpajQpsVrLzdI3l5WApEPeCQ66LWld0H+j15smmGqK9
	 GK3lKIY/YAsVWs+yAvfDH4FC92PkPmqKTU5TzWNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfDASH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729383AbfDARLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:11:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BFA621929;
        Mon,  1 Apr 2019 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138680;
        bh=An7fO9qWvjuhMPOvmb6JsZbkRjGPglHi3qs52Cva6uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHP910vkT4xXetAcN3J9trPnbi8JCMKm2GyEvAbk9bWfT6VFLbhL8oHWH+AvLhYRt
         vjfueMHa5ruwuAEWq0tUBtAB/oLVCbzROYvIVK6W8iOL61Q6UBcp6PT03CLjnYCHeY
         gknzOJGn2mOo/Uv5ml9DXzjDJ3WwL/HOK9Nf1W5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.0 138/146] powerpc/pseries/mce: Fix misleading print for TLB mutlihit
Date:   Mon,  1 Apr 2019 19:02:30 +0200
Message-Id: <20190401170059.766366645@linuxfoundation.org>
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

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

commit 6f845ebec2706841d15831fab3ffffcfd9e676fa upstream.

On pseries, TLB multihit are reported as D-Cache Multihit. This is because
the wrongly populated mc_err_types[] array. Per PAPR, TLB error type is 0x04
and mc_err_types[4] points to "D-Cache" instead of "TLB" string. Fixup the
mc_err_types[] array.

Machine check error type per PAPR:
  0x00 = Uncorrectable Memory Error (UE)
  0x01 = SLB error
  0x02 = ERAT Error
  0x04 = TLB error
  0x05 = D-Cache error
  0x07 = I-Cache error

Fixes: 8f0b80561f21 ("powerpc/pseries: Display machine check error details.")
Cc: stable@vger.kernel.org # v4.20+
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/pseries/ras.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -550,6 +550,7 @@ static void pseries_print_mce_info(struc
 		"UE",
 		"SLB",
 		"ERAT",
+		"Unknown",
 		"TLB",
 		"D-Cache",
 		"Unknown",


