Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7C7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201A920715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=inango-systems.com header.i=@inango-systems.com header.b="RIksgq8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLWNor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 08:44:47 -0500
Received: from mail.inango-systems.com ([178.238.230.57]:34460 "EHLO
        mail.inango-sw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfLWNoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:44:46 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Dec 2019 08:44:46 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id D3B7310800C9;
        Mon, 23 Dec 2019 15:39:40 +0200 (IST)
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hxv_obqbRA9k; Mon, 23 Dec 2019 15:39:40 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id 628F9108022E;
        Mon, 23 Dec 2019 15:39:40 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-sw.com 628F9108022E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
        s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1577108380;
        bh=P2k89TmcdLALsz035J7qpiVvltx++d+keDI9sifdL9Q=;
        h=From:To:Date:Message-Id;
        b=RIksgq8pC4mW59bbKe9rFfo9CbDYET6IG51bDafBObYRhS55XwHqu/i30hSkGlTzE
         0UBFy+50a9eVed5iWsRrkxrvVhlzSlYsOFiP/Up8XHeR29YwVaXfcEZ8YultElNqBg
         EcLyjEUmOaarEadccL4BwWrBjX7CgvaciB9Vj8pnS3GrlJZ1iA0VN1gVC+Bh0PyM6U
         UPW6n1Q3fFW2YiAPHn0Zd3CzHO/JXRtfE2Iv/IAWiS6ummwQtlszM0z6bnrFhKg858
         scYUC+dJIEGOmn2txs4KBt8zPKrT09o5G/WSh+PpGY6DjvyG6KQWAj1Gr3LKn1wxAk
         W/dMvts14cKwg==
X-Virus-Scanned: amavisd-new at inango-sw.com
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wkrgZbBJtBE7; Mon, 23 Dec 2019 15:39:40 +0200 (IST)
Received: from nmerinov.inango.loc (unknown [194.60.247.123])
        by mail.inango-sw.com (Postfix) with ESMTPSA id 78F7A10800C9;
        Mon, 23 Dec 2019 15:39:39 +0200 (IST)
From:   Nikolai Merinov <n.merinov@inango-systems.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Cc:     Aleksandr Yashkin <a.yashkin@inango-systems.com>,
        Nikolay Merinov <n.merinov@inango-systems.com>,
        Ariel Gilman <a.gilman@inango-systems.com>
Subject: [PATCH] pstore/ram: fix for adding dumps to non-empty zone
Date:   Mon, 23 Dec 2019 18:38:16 +0500
Message-Id: <20191223133816.28155-1-n.merinov@inango-systems.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aleksandr Yashkin <a.yashkin@inango-systems.com>

The circle buffer in ramoops zones has a problem for adding a new
oops dump to already an existing one.

The solution to this problem is to reset the circle buffer state before
writing a new oops dump.

Signed-off-by: Aleksandr Yashkin <a.yashkin@inango-systems.com>
Signed-off-by: Nikolay Merinov <n.merinov@inango-systems.com>
Signed-off-by: Ariel Gilman <a.gilman@inango-systems.com>

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 8caff834f002..33fceadbf515 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -407,6 +407,13 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
 
 	prz = cxt->dprzs[cxt->dump_write_cnt];
 
+	/* Clean the buffer from old info.
+	 * `ramoops_read_kmsg_hdr' expects to find a header in the beginning of
+	 * buffer data, so we must to reset the buffer values, in order to
+	 * ensure that the header will be written to the beginning of the buffer
+	 */
+	persistent_ram_zap(prz);
+
 	/* Build header and append record contents. */
 	hlen = ramoops_write_kmsg_hdr(prz, record);
 	if (!hlen)
-- 
2.17.1

