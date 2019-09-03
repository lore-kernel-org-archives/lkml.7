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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F55C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4372341F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EkdxYR6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfICM3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:29:10 -0400
Received: from mout.web.de ([217.72.192.78]:41083 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbfICM3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567513742;
        bh=y2nCAjLsqH+/IXyuFBbt7GyPuAFQotExBGJT1ob3De8=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=EkdxYR6jd/ks01EgjhP+5qv1LKPb22071kr4TmafKue3e3532gtJP/bgJc/HkQd26
         7ZVOv/IkImjTT9i1OTsvW5N7ZJ04f1neNndaQOASTgEJj/KaoLJ4TgPecCHyfgn+fm
         kydQyVpNu2Svx8BcaABoCIHxD4byqfQ8Q7Z5pwBY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqDQS-1iiqOz3d0C-00drSB; Tue, 03
 Sep 2019 14:29:02 +0200
To:     kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] efs: Delete unnecessary checks before brelse()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8fcea3ac-469f-a84b-e4d2-347f047307f8@web.de>
Date:   Tue, 3 Sep 2019 14:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mkJf4icPGGu4cXc3P8YCKrD9X/5lFFX8/10Zu0bwlguxg9YurBG
 iJEtrQqaFr92yYFD6pv1VqWDz0fMhb/HjJQF9GmNXp9ParBG8oTqL25DSshK90VcODGosga
 XaZVhY1gBkcBlo5lvjg2pJoI8lAGyZuY84C9C/ADltFJCA3PRpSlpTmDxhGy780liqtcAV1
 GX1IzBDxU+aDDTUyqPLkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n5BTdjf5Yko=:RZuWevuKG0yqx+aNVz1nA0
 nB8JYSAt0tUdoYhQpgxrl7dzMDlR8XFxuh8IGHLFcMuJxAjTuSJd0XAMlXaKs4CewkG4opxo+
 toC52bihW15DHGVZN5CDDpV0c4SgCdlckfueNYpaA8LoVLL2AZ5HP8DQdRNFI+2Bd9JYkEkuq
 /QWwI3yj8wqFiRnrC9ImDJHd42BdF6O0C2jkfKfh+/MdQhWqEHGxsTXEgg3pE8188S/FUUxoP
 k/dPS4AjGALXV28N4TGuzw3eeOg6jJ2LMxyn9evyRed3DGzCQrGXPfv9PEgoMiaLmlV5inuE7
 NK5uskQdFIdk/kvBJcZAH1GuCR3Jnc28igdjBl9JNj5M6XtrrGu8UgOh7POOfSJpTmFsBjuh/
 pP8bhrZDQ2qjzRu6cq5r6w5CB8Qufsu93fFaX5GjcTlCW5l3L178oUr3Z3SXsJLDI7f1iqOj+
 4Im2+TRT1fX895mNkRVsUeA0BT2eu2Yn22lsie/vG2XINPVrdSY9ZGUiGZslP1ovMD36m7+R9
 SwtpPx3/q5h+njtfC3YqNdCRnAwiJagpetPlQi9/8sZizi5KP+t4QMtTGNeEYEHEThghdcQiJ
 325gW9bKI3JcPMFQGmSQ5h/JYtHfiR8ipkJcUe/U/r0cTglXvQTxLKekArdwgr3uPIH5p0uCi
 uwDHj3j0E058aJRYBGSbgbq0oaT5ASZ/p+DfgL964k4girybeQMv6yT9xIqXmT6TolIeQYXhH
 SVpvfeO2lJkzYh/JeUEt4wNQGtSq7+9LviCf3SeDwB/5rt2RyChcZm5obXTN+RY9Kv73yLZQ1
 WnY3YY2ZQYW7OET9TBw+QOtDuzW1kZFPEfR5r2N/lTd5oSTs7Ax96pAj9Qb3ii7331u+nYRVM
 NPCclTw1sFKwyykGm3BaljAb81zYoszlzT3bbK8IGvtenWmnP0ne9RJY8FyEXkHZp4x4g/zmH
 o9728iPABfojSQPfxBLFgM7Y/gXYDEqVfL/8gQmNlwgYzUsQOcOi3jl9Sl7FiGoGcfnjYftZ7
 KQbXubiJSOqAKaV37ulab4OZCoGIGBJX3UQqu/p6yuguETH34jxIPSRFcwYCBghF5djNuSYUS
 V6slfFSLgR91jo4pcjHqEVMiqMUykeKRCAm3uK6c1NCNnMxfjCwBkcZVEYyEsIpTIM3I1+1ks
 yPuRMu0AFzMtzHBygeXDZqwZS/vtS1rpg916LTW5A67t7Vpw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 14:24:38 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the tests around the shown calls are not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/efs/inode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 89e73a6f0d36..176061d107ed 100644
=2D-- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -262,7 +262,7 @@ efs_block_t efs_map_block(struct inode *inode, efs_blo=
ck_t block) {
 			/* should never happen */
 			pr_err("couldn't find direct extent for indirect extent %d (block %u)\=
n",
 			       cur, block);
-			if (bh) brelse(bh);
+			brelse(bh);
 			return 0;
 		}

@@ -274,8 +274,7 @@ efs_block_t efs_map_block(struct inode *inode, efs_blo=
ck_t block) {
 			(EFS_BLOCKSIZE / sizeof(efs_extent));

 		if (first || lastblock !=3D iblock) {
-			if (bh) brelse(bh);
-
+			brelse(bh);
 			bh =3D sb_bread(inode->i_sb, iblock);
 			if (!bh) {
 				pr_err("%s() failed at block %d\n",
@@ -295,17 +294,17 @@ efs_block_t efs_map_block(struct inode *inode, efs_b=
lock_t block) {
 		if (ext.cooked.ex_magic !=3D 0) {
 			pr_err("extent %d has bad magic number in block %d\n",
 			       cur, iblock);
-			if (bh) brelse(bh);
+			brelse(bh);
 			return 0;
 		}

 		if ((result =3D efs_extent_check(&ext, block, sb))) {
-			if (bh) brelse(bh);
+			brelse(bh);
 			in->lastextent =3D cur;
 			return result;
 		}
 	}
-	if (bh) brelse(bh);
+	brelse(bh);
 	pr_err("%s() failed to map block %u (indir)\n", __func__, block);
 	return 0;
 }
=2D-
2.23.0

