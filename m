Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467B3C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED8722CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Pt9pfbI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfH2FfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 01:35:01 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:18844 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfH2FfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 01:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567056900; x=1598592900;
  h=from:to:cc:subject:date:message-id;
  bh=ZUgPsOsoX6w3pMRjiaKvsB6IaVH8ARK5m0YcEybAzH0=;
  b=Pt9pfbI3LQmER8/hdUXsoYOpM5eOezwi08TUeFmfpkTvcrAhooBRRo1E
   5Nwhjj8SAqWgtu9ta3lruT75ItgV85e4MSZ5Mc47iLJTpbuu/OpMgI30Y
   u0PiVQIru0eVCT0K/tpNF+A8WWWIDgvg5kKaqNGX/jmVs5aERLWZPtkrw
   vitKAM+7jDeQ540TjD9+pwE81f2jFsBICSsN4yvNDvIzA3ZqVMqgVwn/X
   atWixgU12CZLPZRsamAYkr3dFka0fBvp3bbW+AlCV5ksDhJO4NHnAcoAt
   pvUlovdAQlizHxRE6r+t+jl+3vePn9JTfiWjr2f724JaGORuw1afX3GGm
   Q==;
IronPort-SDR: ILpTACtq7qGuCi4XvGX+Ju9Kwi0JWejfEA6pluxurwWnEPXXv1dxGQEN+w3UFHdNlQJP00gigo
 FwHnlE9Y4xvgHq5zH9BaH4h9rInIgkFUPlasQway5KE2U00FJaoE/KMxne3tiKzKUI5L8RmxgC
 GmwGQ4o+HyviuHX0XR8ihu9EXG3guvcXx1fXKbwYIuP1/PxPPUGfPm4K/uBEzNdAsP/5xAkzIt
 ASMxJJtKeiYJDNPjqdQNYoyakqdeiZ/RclDx34aB4yMs/rDTuq9KErZqA+IBqgmHl+mNhhiHgx
 5t4=
IronPort-PHdr: =?us-ascii?q?9a23=3ALaXjnhK+iHJ21ct9DdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgRL//xwZ3uMQTl6Ol3ixeRBMOHsqgC0rSP+PG8EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCejbb9oMRm7rBjdusYSjIZtN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjiCIGNz4i62HXi8pwjK1Gqxy/vhJ03oDUYICLO/p6Y6zWYNcWSG?=
 =?us-ascii?q?RdUspUUSFKH4GyYJYVD+cZPehWsZTzqVUNoxW5HgSgGP/jxyVUinLswaE2z+?=
 =?us-ascii?q?IsGhzG0gw6GNIOtWzZo9f0NKYTUeC10a7IxijEYvJW2Db96JLHchE9rf2QU7?=
 =?us-ascii?q?99atfRxlU1Fw/fkFqftJHlMiqT2+8QsGab9/JtWfyzh2MjsQ18oTiiyt0yho?=
 =?us-ascii?q?XUho8Z0E3I+CF9zYotONG1SUp2bcS6HJZetyyWLZV6T8I4T2xqtys3zKANt4?=
 =?us-ascii?q?ShcygQ0psnwgbSa/mAc4eV/B3uTP2RITJkhHJ9f7K/mgqy/VCgyuLiUsm010?=
 =?us-ascii?q?5Hri9fndnNsnABzgTT6seaRvdk8EetxDKC2gTJ5uFLJkA0kqXbK5o/zbIqip?=
 =?us-ascii?q?UTtkHDEjf3mEXwkqCWal0p9va05+njeLnrpZ+RO5Vqhg3jMqkigNGzDOA8Pw?=
 =?us-ascii?q?QWWmiU4+W81Lnt/U3jR7VKi+U7k6nYsZDaP8sbp7K1DxNb34s49hawEy2m3M?=
 =?us-ascii?q?4GknYaMVJJYAiHgJTxO1HSPPD4Cu+yg1CtkDdt2vDHMaTtApbTIXjZlrfuY7?=
 =?us-ascii?q?J95lVCyAo8099f/YhYCrIfL/LpXE/+qtjYAgU+MwyuzOa0QPtn0YZLaGOdAr?=
 =?us-ascii?q?KeePfDo1+B57p3eMGRb5VTtTrgfat2r8XyhGM0zAdONZKi2oEaPSvgEw=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EAAQCWY2ddgMfXVdFlHQEBBQEHBQG?=
 =?us-ascii?q?BVAcBCwGDV0wQjR2GXQEGix8YcYV5iC2BewEIAQEBDAEBLQIBAYQ/glMjNQg?=
 =?us-ascii?q?OAgMIAQEFAQEBAQEGBAEBAhABAQkNCQgnhUOCOgwZgmQLFmeBFQEFATUiOYJ?=
 =?us-ascii?q?HAYF2FAWeD4EDPIxWhUqDGgEIDIFJCQEIgSIBhx2EWYEQgQeDbnOEDYNWgiI?=
 =?us-ascii?q?iBIEuAQEBlEmWBAEGAgGCDBSBcpJTJ4QviRmLEwEtpXICCgcGDyGBMAGCD00?=
 =?us-ascii?q?lgWwKgUSCeo4tHzOBCIsbglIB?=
X-IPAS-Result: =?us-ascii?q?A2EAAQCWY2ddgMfXVdFlHQEBBQEHBQGBVAcBCwGDV0wQj?=
 =?us-ascii?q?R2GXQEGix8YcYV5iC2BewEIAQEBDAEBLQIBAYQ/glMjNQgOAgMIAQEFAQEBA?=
 =?us-ascii?q?QEGBAEBAhABAQkNCQgnhUOCOgwZgmQLFmeBFQEFATUiOYJHAYF2FAWeD4EDP?=
 =?us-ascii?q?IxWhUqDGgEIDIFJCQEIgSIBhx2EWYEQgQeDbnOEDYNWgiIiBIEuAQEBlEmWB?=
 =?us-ascii?q?AEGAgGCDBSBcpJTJ4QviRmLEwEtpXICCgcGDyGBMAGCD00lgWwKgUSCeo4tH?=
 =?us-ascii?q?zOBCIsbglIB?=
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="73212253"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 22:34:55 -0700
Received: by mail-pg1-f199.google.com with SMTP id a21so1344331pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 22:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x9yrvZ4wkX74WwrSCWzDoAmr/dXTn7DD+NasDgaVg0g=;
        b=ZpnMpVtxosWK5E5UaD3Zdp2tGYkQLK+4KBu+iBI/jQoqUejG4j+0Hb+Syc5/ioIPI4
         SYAp8W9bxiPG049a9/XRfQb6JO5FaeaVEVuNz+DzzZDrx9+rcIhaCkubCbHl2nTDEumB
         Cj4e8oKC6MU3HOBzzzF4o0WrHYZXHJEMz5Dv72UoFe0iJIP8gMm3CdJC19QNl6JgYq+B
         gGSYyf/vADEvFfmgSfyE1s3dgP7/QZzcrU23XEsc7rdOyFs7j2hsxklfXDjdey2zXyg6
         W/X2fKQYTfMfEtuwzg6a3qucOZZTYQw30gQzGFOUSWWzGxMRf6ExBOg+ywG653OjVlml
         /JCw==
X-Gm-Message-State: APjAAAWYa32pP/gofxVOikroGbCPHegOnxKBpewia7fMPctgJC7agUtb
        /pmKWqdZsP3FEcBJuW+0Rhc5O4hziFM3EPow2tnaxzFcqVaORYkYSIFWH2b77PYI34spunvfNuv
        PKpbs6ST00nSo2qFTf8nkWYPJVQ==
X-Received: by 2002:a17:902:a60f:: with SMTP id u15mr7949177plq.201.1567056893854;
        Wed, 28 Aug 2019 22:34:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+02izdiTOlrfmvgOCN12z9/vG39pduCGcbwj1Cxr5CNfbxOdOvIu3Gv+/HEOMavc+dFNKBw==
X-Received: by 2002:a17:902:a60f:: with SMTP id u15mr7949157plq.201.1567056893473;
        Wed, 28 Aug 2019 22:34:53 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id e17sm931337pjt.6.2019.08.28.22.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 22:34:52 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] adfs: obj.file_id is uninitialized if __adfs_dir_get() returns error code
Date:   Wed, 28 Aug 2019 22:35:28 -0700
Message-Id: <20190829053528.15702-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function adfs_dir_find_entry(), obj.file_id could be uninitialized
if __adfs_dir_get() returns error code. However, the return check cannot
promise the initialization of obj.file_id, which is used in the if
statement. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 fs/adfs/dir_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 0fbfd0b04ae0..d7fc47598e78 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -335,7 +335,7 @@ adfs_dir_find_entry(struct adfs_dir *dir, unsigned long object_id)
 	ret = -ENOENT;
 
 	for (pos = 5; pos < ADFS_NUM_DIR_ENTRIES * 26 + 5; pos += 26) {
-		struct object_info obj;
+		struct object_info obj = {};
 
 		if (!__adfs_dir_get(dir, pos, &obj))
 			break;
-- 
2.17.1

