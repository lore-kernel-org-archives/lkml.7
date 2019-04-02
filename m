Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC45C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABCB20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbfDBNnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:43:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43606 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731512AbfDBNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:11 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe4-0002or-7z; Tue, 02 Apr 2019 14:40:08 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004xE-QE; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Yan, Zheng" <zyan@redhat.com>, "Ilya Dryomov" <idryomov@gmail.com>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.667684510@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 84/99] ceph: don't update importing cap's mseq when
 handing cap export
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Yan, Zheng" <zyan@redhat.com>

commit 3c1392d4c49962a31874af14ae9ff289cb2b3851 upstream.

Updating mseq makes client think importer mds has accepted all prior
cap messages and importer mds knows what caps client wants. Actually
some cap messages may have been dropped because of mseq mismatch.

If mseq is left untouched, importing cap's mds_wanted later will get
reset by cap import message.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ceph/caps.c | 1 -
 1 file changed, 1 deletion(-)

--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2830,7 +2830,6 @@ retry:
 			tcap->cap_id = t_cap_id;
 			tcap->seq = t_seq - 1;
 			tcap->issue_seq = t_seq - 1;
-			tcap->mseq = t_mseq;
 			tcap->issued |= issued;
 			tcap->implemented |= issued;
 			if (cap == ci->i_auth_cap)

