Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51857C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D07120828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pqooISqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfICOlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:41:25 -0400
Received: from mout.web.de ([217.72.192.78]:45557 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfICOlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567521657;
        bh=o+0MJJwjuQymdqHVXaUS6CftMqoiocFuw6zNIehbpuA=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=pqooISqpvFxAyPC9SR1KWZsOe7R5fYrVGqNZKU1OWqzvQYw5ZqJVVb/rQZ/nXDHLS
         iClwM80laM9hrNFZ4UqHxnj69xB03waqj/UqaMu/KZd2YwQS4MxfhmbXmvXPKqqDI3
         owbKo5TPL/6uFJJwDSfW7vzOkf8YoEbKjBHmUOuU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lg01f-1iXYdm1gXT-00peq0; Tue, 03
 Sep 2019 16:40:57 +0200
To:     ocfs2-devel@oss.oracle.com, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ocfs2: Delete unnecessary checks before brelse()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <55cde320-394b-f985-56ce-1a2abea782aa@web.de>
Date:   Tue, 3 Sep 2019 16:40:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f05WVogZNitrvu2zhBbX9dFOs26N8jtmzTvLYveGOnlbDlg+lmk
 WdpnJysyvxiKwAgPi2cItiE4VnOCELl0b81g5+d5qtEv8c798Gi57mG7tEciq4+upoEPCBw
 CCh2eRsJGDIl7PPHxUFegxEG1ZHF9XvvMGi32Ka/YjwaESpd/WR1oGGVjipEoh0dmD01kRo
 8zdH6azmyRuv+fU1r04cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4MAEzsAITdw=:FmCcmM0E0IdbJeZBVmvW5M
 HfnXulkZUCh8NIgK9tPgDeoxddD7fqfFU10jzvtQbY6zh5oi7Y2NFpL55Bi+LEAIGuLRRtk+4
 Cpr8KOZCWUIhowFNcX5DexEclcxXBOxTACMpas2naLZjqxRkCnAfPVjPtDXPuQ5SlLgurIRLq
 7G8EAE8Y1IZd5RQrmCmITrqWeVWIfMv3Fu4VW5XabCTfSNlnXs08V43wmXyJFPy9fzZHBWSoZ
 8h6FyUNWViSo2K/RkCTrMnGKeuJiXHnZTUClYQ7gUyEPi8B+YdMPUU10U/uCb7KLqU/Xe1nD2
 eNpZ0WJOO+hA2u43RXSvj+VVbcddk7cfnunqEhA26ujO7nO1Hu3i1dIbtdZTvWWdyoqxh6s32
 8sgqDosMSYMC481T3A8RTUq8PTH7D/BggL5nuQqfDw+3paVPa9woiaA8EZ+77mYJLRrfOg1Pm
 qtQAskShcqAAAgCnADEzgCaYEJ+l3nFl5RcEmVStRVoWpfwMSJSIHpYxz11RWzSJbdEIgBfRT
 B94UscO8oOydXYed/+6++Jqt3LsM+nP39k50+ImH83EMz30sPsNp/Rnpg84oZvViGYss92rQ9
 72OqkXGdXPk8tEEQNXiFW1Gfai6um9rQvLpWE6xj5H+O6tY2/h7zAxkhm7cNEhjxLnQN4DI8i
 dEKO3r+jlYi9ha5ZKT7xH2AKfPujRdEYKhbbUw2i5mojRBjCDhhSEQ2/B4+7p6JwAgjVGEksz
 BveN4BYy93k+oRkOg6finmV6T+StQs+6hGOvcqDI/2agaKPUuo1zPo9+bzmwTPsvnL2uXxx4A
 0meO6nE2P909tAZi7bUDxyBZ4p+xhq+RpuDUdtkOlG89Xb6GuN+UO3SqJd6CY3YslLXt//vUu
 ah4roYXAc6r20aZmFlK1U3daaZDqSDSPehuzWNEIOBwpmcqMtTwCk3Zm/jzoNaIXuo/9JyCMJ
 Jv3KdwlV8r5RxNK0msZUaOyfrv+S1kcyRPq7ZmZQ5Z8D6MLaJDirb7UHuaPr9pXEVuwImHC0O
 OBrFzsZk+bT/e3fXnLtFYMbOMKY1hAlL5Dp2ZDgmcPMk8b6uLAL9noCX9aIEqazsFHsvvP60E
 CQMVhv9LA8iIvTwasjCNB+98faJrqgNRkvieyxVVindj4oUhe4JOHiCouicIKiq5ui50j8QwG
 rTMajwtCso+UDDodlor322t62B0DL2rEez12qyiMS2Ixk4Iw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 16:33:32 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the tests around the shown calls are not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ocfs2/dlmglue.c    | 7 ++-----
 fs/ocfs2/extent_map.c | 3 +--
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index ad594fef2ab0..6e774c5ea13b 100644
=2D-- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2508,9 +2508,7 @@ int ocfs2_inode_lock_full_nested(struct inode *inode=
,
 			ocfs2_inode_unlock(inode, ex);
 	}

-	if (local_bh)
-		brelse(local_bh);
-
+	brelse(local_bh);
 	return status;
 }

@@ -2593,8 +2591,7 @@ int ocfs2_inode_lock_atime(struct inode *inode,
 		*level =3D 1;
 		if (ocfs2_should_update_atime(inode, vfsmnt))
 			ocfs2_update_inode_atime(inode, bh);
-		if (bh)
-			brelse(bh);
+		brelse(bh);
 	} else
 		*level =3D 0;

diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index e66a249fe07c..e3e2d1b2af51 100644
=2D-- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -590,8 +590,7 @@ int ocfs2_xattr_get_clusters(struct inode *inode, u32 =
v_cluster,
 			*extent_flags =3D rec->e_flags;
 	}
 out:
-	if (eb_bh)
-		brelse(eb_bh);
+	brelse(eb_bh);
 	return ret;
 }

=2D-
2.23.0

