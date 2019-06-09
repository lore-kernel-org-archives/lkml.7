Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F533C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C00F205ED
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099437;
	bh=VphfbzlgHyn6OK3FErbHf/D75U3ORSr31UcD+mkCyLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WBEhK5xwNpiQN277kMy98AACbhl+wS2rdWxdOqOqgxVccp/sGpDCFhbIu8eLZ7AiT
	 fXvzlqKYdaEkrNiyXO77jk2k8PgEFecRC2mNX1x+BUM5AbgNjuANjUSxTF7xXeeLN+
	 JLRL0m8z7uKHqMrsUytBrgIuXMH2rAkBDZRZKFqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbfFIQ5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732147AbfFIQ5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:57:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F789204EC;
        Sun,  9 Jun 2019 16:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099433;
        bh=VphfbzlgHyn6OK3FErbHf/D75U3ORSr31UcD+mkCyLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0eqJZZ0F8S6OIS3PAAA8vjh/CHz9vjeNxFdz84ho0UJ21BHc3qQECjPp/LsFFDDU
         A/yqAo9i51vVq9PQIGGDeeO1yOEByHuVW0E/JTkan8GaFCXVHYWTmi9/MP3t2QeIZX
         MbunJgD+XICV0yWLmI/sYNT0TQCM4iyAqKCws1RA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.4 037/241] stm class: Fix channel free in stm output free path
Date:   Sun,  9 Jun 2019 18:39:39 +0200
Message-Id: <20190609164148.844921030@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

commit ee496da4c3915de3232b5f5cd20e21ae3e46fe8d upstream.

Number of free masters is not set correctly in stm
free path. Fix this by properly adding the number
of output channels before setting them to 0 in
stm_output_disclaim().

Currently it is equivalent to doing nothing since
master->nr_free is incremented by 0.

Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: stable@vger.kernel.org # v4.4
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/stm/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -210,8 +210,8 @@ stm_output_disclaim(struct stm_device *s
 	bitmap_release_region(&master->chan_map[0], output->channel,
 			      ilog2(output->nr_chans));
 
-	output->nr_chans = 0;
 	master->nr_free += output->nr_chans;
+	output->nr_chans = 0;
 }
 
 /*


