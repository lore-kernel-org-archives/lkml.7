Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82666C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4589A21917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254826;
	bh=IkIsnFnFyDxV8zICOYkA6yYLnLlmcJ4grHornt8nRKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o8QmfECqb2kE8RAcNoiSsDCq9OcWh5CxCs8/4xdoLwTsIhxuKIqPZlASE7E0LcVzs
	 sRpCzJCIIiODIaRWHD/ukY5VsiGIZhvgFv4mZwe655WmtgEfhAfjeS6/f6FnfRO/nI
	 tnFDgPd6jQ2UmQM+FgInp1SGpPpqMtHzUiU5NUbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfCVLkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbfCVLkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:40:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A422821B68;
        Fri, 22 Mar 2019 11:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254823;
        bh=IkIsnFnFyDxV8zICOYkA6yYLnLlmcJ4grHornt8nRKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8U0pyJ+xAD5T6oYeC/coBn6uspBYqgbiSz6VDOoDOUnRHfNUBfcF5hnMP8UmtBpH
         7CoOX05oCfqjHQLrU2LhTIlK+VzJ13enGn6FeGfo9osrV32v+2XxWj5w/rpp5nNhIZ
         gNmRaTHIfrLWT55hZZuvlA6LP/OBz/vXyVfQSCjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhi Jin <zhi.jin@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.9 006/118] stm class: Fix an endless loop in channel allocation
Date:   Fri, 22 Mar 2019 12:14:38 +0100
Message-Id: <20190322111216.433455055@linuxfoundation.org>
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

From: Zhi Jin <zhi.jin@intel.com>

commit a1d75dad3a2c689e70a1c4e0214cca9de741d0aa upstream.

There is a bug in the channel allocation logic that leads to an endless
loop when looking for a contiguous range of channels in a range with a
mixture of free and occupied channels. For example, opening three
consequtive channels, closing the first two and requesting 4 channels in
a row will trigger this soft lockup. The bug is that the search loop
forgets to skip over the range once it detects that one channel in that
range is occupied.

Restore the original intent to the logic by fixing the omission.

Signed-off-by: Zhi Jin <zhi.jin@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
CC: stable@vger.kernel.org # v4.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/stm/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -252,6 +252,9 @@ static int find_free_channels(unsigned l
 			;
 		if (i == width)
 			return pos;
+
+		/* step over [pos..pos+i) to continue search */
+		pos += i;
 	}
 
 	return -1;


