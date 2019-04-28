Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB05C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 05:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A51820881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 05:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="InzGZlCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfD1Fkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 01:40:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:55599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfD1Fke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 01:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556430027;
        bh=4FSSdG3cyGfUZVzuzJNxiy6EqzS1aYi1gLl02cn+fqI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=InzGZlCkYrG2YPgikkY9cSoLPCufsc+C0VjMzqTDdTpHKfW2QlXVj+4Czj2SxGkw4
         0fhOUr8rzKlkYbVgmT57PLodRur5bzOLbi7pnGNm3rqmsQpE1FbznU3aGITqWTivVF
         kU5ZtyoPg/lgEVsH8iHxooNAb4C0D+z2Y6qcuXeU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MybKp-1gZE1v0mL7-00z0N8; Sun, 28 Apr 2019 07:40:27 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] quota: set init_needed flag only when successfully getting dquot
Date:   Sun, 28 Apr 2019 13:39:21 +0800
Message-Id: <20190428053921.5984-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aZAQw7+Ys3uhB5VZD8rZHieigWmpjXU3oczqm8MUmTFRt8BIR+T
 l0DKFPG+GQ048dBtYqQjU/7NtUlAuGrcTrRNTqKBcSRq0eyLSWPCEJiyEOKvawF0GUXpTdq
 eSukeYssfa8hWQMsfOuahiFoBTtJ2x4bIm3zJsbfL0d3GumvBy+U+w24+fe4bgtvETgGM2X
 Z1hgvXu9Hdtc2/mPkugQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tklfBWhAadg=:MBCb7WtjmvC5EP46i5K0kR
 Tl88imlRh/TeCoRw0Fk19e/Y2pJRjOWvhLAflcgIqcp3Erst/EcS628qMs0a5FsVgNlFGItoJ
 ZxFeTTkNWZK3QLXwaeyBYRga2cgQM/rlN65Oa4Jp+mMJhgcwjfqPxqq5HIsiZWAb8kJyCZy3a
 6Or1aECRTZpOZZJXWq67PEMnpTOyVZRoerKDtFhEy+VNobKix1rDqUKpXtbrkNjKwR2ml0ixM
 kSXn5Sg3TzrxNoNcl6uGZm8SF9eNRKewbNpHNEq4mhiidbhmD88a0k2WhJhzAcc4nh9Rp651P
 s+UxF0Sb63OY0SHKsrjUCKrSPjoe0CbcgO8FyLVqllyxCl/x/WDe0SRM4nF2EzarXCDIsZUPJ
 roVEc9mXpCnRDIyjsf/sDqH1tPL4blvsAtUoL5kCSZY6GQMqtBc7dRQQv6k2n3uHXhyCdKXDA
 xabzaY5pcV0FseKkneWDJQb+EXHcBHKx7QhsPwfnZN8QBwUumi4o8yPR9Zz4DGqCuhlNQ1hKP
 311z0HgzOYpMLx1ZgJAHwu+5cVpSD53n76ueu5leVeOGJRDjIHqCcRgDxmoUJeB1ZKiIVdy2T
 pRpd7N1hpLXaXG+Iqkvw+jJwubXm6JDtv7NC9BBRRr/knSLj7xBcn93RHybSGRwn0dMzaQbA0
 QRiLxVVxcHLtvFvo5amfjY7GrHHuCSgaGkllCr6m5cjgHjesfoJSmCzQFf8Bov/xmYA0PB7XE
 Q7Zxd4yXsMO+DXmshSDt+pveGrtbVBtwwIq5ZH1csarOYHvVs7Ptc72znjEr9LjpC7yIo+Dpj
 EmKkdEsY6aBVDDYBCDd8sJ7gDdpgnPXBE8ny5qZ4nWjsqNbNgG83gLdoGGeC+5WEnZGyZaFfg
 HC+qYp8ZfpUUEhvaIWBAVtuTskGIZ8ChwYTlLYDDKNSYLIoXVaGaGkzxhoqwHI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set init_needed flag only when successfully getting dquot,
so that we can skip unnecessary subsequent operation.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
 fs/quota/dquot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index fc20e06c56ba..8d4ce2a2b5c8 100644
=2D-- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1449,8 +1449,6 @@ static int __dquot_initialize(struct inode *inode, i=
nt type)
 		if (!sb_has_quota_active(sb, cnt))
 			continue;

-		init_needed =3D 1;
-
 		switch (cnt) {
 		case USRQUOTA:
 			qid =3D make_kqid_uid(inode->i_uid);
@@ -1475,6 +1473,9 @@ static int __dquot_initialize(struct inode *inode, i=
nt type)
 			dquot =3D NULL;
 		}
 		got[cnt] =3D dquot;
+
+		if (got[cnt])
+			init_needed =3D 1;
 	}

 	/* All required i_dquot has been initialized */
=2D-
2.20.1

