Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720F1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4179D215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="p5seTyJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfICNUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:20:53 -0400
Received: from mout.web.de ([217.72.192.78]:48199 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbfICNUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567516843;
        bh=8p6F/11SX6cVpViLiKvZcfvZTKjngOdYepqGz4ztNyg=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=p5seTyJFOtpIJJHnrG3yU7LAaVnrr1A1ePV70hLqP9B2CgAQ1dSoVE1GkqdlcLDfD
         KM9rjzoYVPfEMWUCrCU1nufOdQ+V75OlxTOxug/77k+TM730xKksfAeiC7B3XirVDi
         WfILzeL2FPXnnktNeUlgIEjfamlfx9Xrw72NquZk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwqJw-1iGBKl2TN2-016Kpq; Tue, 03
 Sep 2019 15:20:43 +0200
To:     cluster-devel@redhat.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] gfs2: Delete an unnecessary check before brelse()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0ce30a08-be05-8211-27b4-47d0397ba330@web.de>
Date:   Tue, 3 Sep 2019 15:20:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SGxoDjSyOvQOvRDOqpSUATKqC/64l3Cg2KFvmAKuI0LhdScNLQk
 fq8cfoqATJHq9tAemX6uLBCjexPyRe9R2ygElolFu6LenFIxgm+i5OHY2i4/7nfukXYwHdO
 thFojfhLpQ/dFjgOHnAGSkma647c/05FvJy7NfcU4siXjSvzJElxckMLUjGmGPLB6lO9VW2
 mdk/M3E+PW83PeGVd9IHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IHK5K+LR3xE=:4cYlU05DLFEoIZKXzcyPTF
 VbOQL/WnMxM2NFe2ptbJ6WhWA96jdLpzLoTMRX0je/hIwd6JlczmozWm7Aec4geHXBA0A7IF4
 EWbqaOdwyZioV5KxgkWkvdeR/CrC2prSQOjU3YZrbklRw8AXstNx3uCKEw2gSFTYhfMdmbMEK
 RSX03OVNhgRAHOCfDBheQ/1JcxlTAcOJesWo/KOmdyFznFxRC5n+Kt8Z3DZtYisdhKPoWbRdd
 PQq7q4XCk5JL6KvYZCzuqPZOsVP9cDCxa4U55gb7EtlfjcP03bUEbvngH5VW5RWtZ/gxlr7Yy
 mAG3QZwyPPNXUI+ci7os0zToaIHzLx6bVdBvkUxdfnNF3kTQmSL3tLyCPiHduF1+0MIHvmmAP
 6QQ93HFl51l8lRtQ9UBSWzrEXbrIYTXVDCBG3liMSSQzhHPpj7n8hw8UlyS1Ze2xcPBzCgt1O
 bGlGiYz6B0EYT1ELs4IpRVUyBh1U4p/Ke7STVniAewn2ZV8AMx7+7bcPQb3m2sHgGc8zg506F
 aqyGqYEkxBfMl6XYXWLgtXGfegkZ+p4mMGxPpM20umcrUwaIhoMgZlmWgW39CoIe1QsMBwUSl
 +2gEDfyw2Z9lilziM60YYBRUxtK6STVoXA7ZAXZHNSqlvbccBbkiUe49sCEfvZezS6SXF0EsW
 9977mJ9HpnchI5Z1fDJ6PPGPaAJpLsKSPnmlzfOiF/Vz+dU8IxGoXWO73ct/FfuIU26eFK8CD
 PHTgu6LqwplEVhrYG9s3PHykude5J4ydJ0NxvQB3C4227vwsVJ7KKMb3jkNlo/wyAvWKTiDkE
 A6B+uV15yltb2D9GJ1U7hdRbxUFvgDZfkib1dFJbRBMW6zROi5B2q4o0THwR21EYeFoAB9QAV
 EN/71XFNMLbLAN+iTwbmSKFGov6fAeh9NtyFFffC8BE4h6FhsezEsKcS2JYSK6EriV/QChFuf
 Umzv+7xSh8uwI7vplGB1Gp+oZkr/9I0C9l1tKK5JoCIfY5yObb7BzmyshZtjYBPuiluX8iHad
 3WwNDilGNV8/tOZU1aDSVC7nB7rKSWJBRuSQHac3vRBWt1hbiQ+BDUR7wvdGS0RU+7eq8K2Lg
 t1CKxcaL9eYQ9Gp0T97FZCAejrM3TeSyTfBVjl5ZSoLbKLxtc9iA0r20aTXUKUt1S3v7oTHVk
 9s7MGnqJniYnO6rPkPg3hQYI6wjnHxL/ikBKgZVjrMyMDtxQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 15:10:05 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/gfs2/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 6f35d19eec25..eb9c0578978f 100644
=2D-- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -1463,8 +1463,7 @@ static int gfs2_dir_read_leaf(struct inode *inode, s=
truct dir_context *ctx,
 				sort_offset : entries, copied);
 out_free:
 	for(i =3D 0; i < leaf; i++)
-		if (larr[i])
-			brelse(larr[i]);
+		brelse(larr[i]);
 	kvfree(larr);
 out:
 	return error;
=2D-
2.23.0

