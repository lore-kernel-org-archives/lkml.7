Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC846C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D0C20684
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lcL9mS3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfDZHjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:39:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:44451 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfDZHjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556264336;
        bh=eXVuQ4GxcSyfn1xn0uo5tTdWse+H/ZssVULo+dS1BoU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lcL9mS3LSWTYbsmDr75NK0+owYv4AKZjIIcYOa8UGx5JB/gjP2Z9MyzVcJTieCEbT
         A02tQAMCB6AymIs1RLbNwZacgyUh9zDSZTzDbVJkrVVMFTxqrn7bPlFlcDtCvGt9Kg
         J/IhaJIhQLQSxUld3zwqIEWdrquTN9YeXN2tIf8o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LwXCt-1gjEo41SRD-018I5Y; Fri, 26 Apr 2019 09:38:56 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [RESEND PATCH] chardev: set variable ret to -EBUSY before checking minor range overlap
Date:   Fri, 26 Apr 2019 15:38:37 +0800
Message-Id: <20190426073837.23086-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jnnTDKRqPbZvDx0A1eDgWqsaN67fPTgX38a3r2ZqdcyNAxNwdVI
 MZvaX+ciStiXcxrhZjAvRhm8j5wOD0RZl1Qi75+aQoY8IDD5kwGlF+mvEvZazW6Lqb8JG1K
 0yG8G4I1bvxj5IqhR8BDtZfKuw5a/TnrDvUmoIYVgf5TdxXnhwRnzvbPuv8s9RRuZuHrauU
 2sN2rLYhlpK0E8L1w/t2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oNbZKfoyKYA=:Z8ApCNUhkpE/xtVgxngKFw
 89Rlw4JFrb+XiV29Cbb5uPeu8llW8gbgJhHRuU6PV+jt5zE5UDyB3HPnxIRNGaU1qy0rSepGb
 Symvh75azF1L5hfukz7nSMJVCsS89ZDx9irMdhnbTQ/1hHnwf0UDrJHGT1YVftZUi9rEL8hnK
 Pou/R++bvpRDm1wFSzdXHKqQkv2ZawB+LcIal40xXYehI4lAuGS6xindXqqugT/I1nsUwIPqj
 EbJoZvNzoHUSTeTOcckZSncULF4t0PPJmqIwDrajN3HCUXTcPmT9trxk4wY7QpT2ZsZ5KMs8A
 5jpnpiucAEyvqzUiFOAY8HQUWPOxiG2dKKTYccVB9se4KsR0+ireh6tOoh6G64G8zFIw/MQ/3
 aDr11gV/dTuvhWr00Fjb1zGWhHoV5Amu42ACokIpeuUbW/CwGTHWLskxXy3tIvDZZKMEI/2pB
 HLvHtmdT6sjxZoqioGx+gmyc8qzxET3BSGHrsmvCf/0At3Nq9rlWnWWdzlFuy595FHFJ55fU/
 MiaX0DY6g2j9WDn4yCHwSVel0+c7gt8TgFZhJpgD/kp/ASnEeQeHxuG+tqxn6m7906iBeewXH
 WBfsUDstrYa1nO1XqGNih8+C+UZ6Rfhb2znZ9WmwuLhkTm6Y1uBG2J+UyB0Ct4oCP435/pf28
 KKSacRwGI4AOXuyWDrQj/zPAhMlDd7LpIJ6+S/N+za18/FhMMU1M6tiry4n4e9muFlNkQxo0H
 Txfmh+WDRYUaLcIUrMfoZc+M6zZqMFSQhosUoRG0ycVIOEbh1k6sS/AUlp8PTdHvddzjxUMnG
 OHwdaUwNxmBBl6tmLp/DV5KluW5PY4rFyyVTswWOnbH3QgA49emIxgQJ6HemGiZaDBydMV92K
 EoK+GbjAMTe5LDDVrzrbKnSJsJDmK2g1b4S8yDfzz+8/7iY0aMYKGi2TQNuLLn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating dynamic major, the minor range overlap check
in __register_chrdev_region() will not fail, so actually
there is no real case to passing non negative error code to
caller. However, set variable ret to -EBUSY before chekcking
minor range overlap will avoid false-positive warning from
code analyzing tool(like Smatch) and also make the code more
easy to understand.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
 fs/char_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index d18cad28c1c3..00dfe17871ac 100644
=2D-- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -98,7 +98,7 @@ __register_chrdev_region(unsigned int major, unsigned in=
t baseminor,
 			   int minorct, const char *name)
 {
 	struct char_device_struct *cd, *curr, *prev =3D NULL;
-	int ret =3D -EBUSY;
+	int ret;
 	int i;

 	if (major >=3D CHRDEV_MAJOR_MAX) {
@@ -129,6 +129,7 @@ __register_chrdev_region(unsigned int major, unsigned =
int baseminor,
 		major =3D ret;
 	}

+	ret =3D -EBUSY;
 	i =3D major_to_index(major);
 	for (curr =3D chrdevs[i]; curr; prev =3D curr, curr =3D curr->next) {
 		if (curr->major < major)
=2D-
2.20.1

