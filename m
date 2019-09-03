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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DD0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318C621897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MdTKBUY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfICS4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:56:17 -0400
Received: from mout.web.de ([212.227.17.12]:35861 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfICS4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567536966;
        bh=1GA2J9m9mybjuD/wxFfCLvlV0J082nH7JNrhi5iBmYY=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=MdTKBUY1OUsK90er/NvlMnFfC1s9sVyz5YuMKEzUbDM87smtg9fASJ9bts6lTs7GI
         Lv3CJCs+2GSppTYfZo10LGgYSbwhrCmM08aGsDFOVTdN7zFA/QUX9l1n3q+H7YQlMg
         kNtX0sFNs4MlCxSCMS9TI7ZZje+s2Fv/0iKEQxCw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.133.43]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHp4r-1i2CdP0XhV-003hTo; Tue, 03
 Sep 2019 20:56:06 +0200
To:     kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fs/sysv: Delete unnecessary checks before brelse()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e5739a6d-cecd-5e76-df30-d74554681fd1@web.de>
Date:   Tue, 3 Sep 2019 20:56:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QNsdaFtEpANTCjcvNxlIY7CnI8zy+ZVBvH/d+X45fcfoXGu/NXQ
 IxNUTltQW09f4LEOyV+rPzuTvvybaU7Ba9g6e1HrZhaNqZV1cKaw6hxnTonIE9kFF02WEpL
 +jWUCJK32fs2mivw9LNmrzefKK42oh6Tr2R7rlG2L1tJl8iwl6BT4Wqbtj639S99hfaAg2v
 Oq+O7Ra8jm/TTFy7Ok/bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HX7DGUkQ+uQ=:7NRwHF45HIkxisULxOUc1v
 9vRhYq8Ti/OsxIuHERFWns6K4L72rLKJBmwKeCyANGEDCUCFdMyYwbaYXU1vRj1GDznzNYrZH
 9xVwKBmnazqZepfcUDdILP5291PEfG7+9p6kWI8jQHXeqkRaS58cEZess43GpLTNbOYOJ2Ep4
 CQnnmjnbiJu1O68stC5MiUD2qLEzp5e2xPF52Ojw68TxBFEt6i+51dTWbZVHPPQt0oXg5jo3O
 aABbuWUn0x75SrsPtr6mZshGfwShl7wMFMB6wCEiyRem/vamVr0kZhUq8BsdagJZnhwTT+L0M
 COvJGssuQ/wrDUQzHs7qhOPmoaibtz0MRZ3761URssLxK/LN9l1FdJz9LTJkW+txGerTt89o/
 ip6asUNOCsPuxAiDENF6o5gRtavIKPhQW02yGgMJF5OQutPA6BA3vx5BOiuYdSwc4KRhjIVLA
 LdsqA2o00lVxL2UdfCFzG9DUb4Ept5OH4BRj+ai0qtFEjk+pI7fstFQclwDFIC3diSsVkBrLN
 hAy2h9wuPjOHhRZHdxIj34YUFgIw6qqMFCK+HQAGmAYZAZCXuCXxfefnDqSqLi88rwY+MDaBF
 73FyqRkTYI1CL2Ovzq+4UnNNwvOKC+3i0YbpvfHIlmKQvKl6vC6SljUIg1n7gT3c1a7A19vEZ
 fkLBTvjdtFTMABhd5AK6P+udlZZ+OOpJSEuBDQ7OZ2McyKNJDhyJ0sn2fnVxujTdRfMVSHZbj
 KQPsIu4JHt4HT0UjG5ZguNKa6RqWICrjDhu/pe71HU/F1Yjcoa73OjJuU1r6Ta09TMWNHp7at
 UfeEGQE5DWWXKKy3XK9q2Pm8xkmK/KZBncKRWatr0QkYG4lsbPL8B/wSbPI/KrJh/hT9clmdI
 ZMajkzm3FA7bG29J6QHzVDFJ+jYNzABhJ5WtfGEQ96hekRe3LkjjQ3bvcCbMfkvYA11yYnUMT
 ZNb4QYoZbZkbL2wDTKUkvWIW3DnLmCsKASteNbmxVONyM334FBaiqHW3E3Xk29didnRisu23T
 5/CTUH9+evEX+POy8SO5dLPLmJwSy7HbyEcI7u+BSPMQsPALBolOwKfRvVwFAFUA1QJLH77fS
 +J6ZUQS5ggOLZydfHglzsmTZoCEdwf4fqExXsgPLq/a4IEStwfNM7NQkyw09wP//SPb+Zsn5S
 28l0PVfHZ9U/7M21vB4RWaTVkq72M3Ke1VHAWv690weJq+Gg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Sep 2019 20:52:07 +0200

The brelse() function tests whether its argument is NULL
and then returns immediately.
Thus the tests around the shown calls are not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/sysv/balloc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/sysv/balloc.c b/fs/sysv/balloc.c
index 0e69dbdf7277..dd7fdc728ba7 100644
=2D-- a/fs/sysv/balloc.c
+++ b/fs/sysv/balloc.c
@@ -195,8 +195,7 @@ unsigned long sysv_count_free_blocks(struct super_bloc=
k * sb)
 			break;

 		block =3D fs32_to_cpu(sbi, zone);
-		if (bh)
-			brelse(bh);
+		brelse(bh);

 		if (block < sbi->s_firstdatazone || block >=3D sbi->s_nzones)
 			goto Einval;
@@ -207,8 +206,7 @@ unsigned long sysv_count_free_blocks(struct super_bloc=
k * sb)
 		n =3D fs16_to_cpu(sbi, *(__fs16*)bh->b_data);
 		blocks =3D get_chunk(sb, bh);
 	}
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 	if (count !=3D sb_count)
 		goto Ecount;
 done:
@@ -224,8 +222,7 @@ unsigned long sysv_count_free_blocks(struct super_bloc=
k * sb)
 	goto trust_sb;
 E2big:
 	printk("sysv_count_free_blocks: >flc_size entries in free-list block\n")=
;
-	if (bh)
-		brelse(bh);
+	brelse(bh);
 trust_sb:
 	count =3D sb_count;
 	goto done;
=2D-
2.23.0

