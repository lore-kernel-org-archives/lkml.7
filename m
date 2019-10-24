Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D873CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 04:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D752F20679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 04:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfJXETz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 00:19:55 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54670 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726605AbfJXETz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 00:19:55 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9O4JrIK028797
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 00:19:53 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9O4JmJG008463
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 00:19:53 -0400
Received: by mail-qk1-f197.google.com with SMTP id g62so22216942qkb.20
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 21:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=e3lVWuoYb48rG6zeUx+p/TUMH7VigBDZ9uiKsaip3Yo=;
        b=JnEQrh0EQdMLJL4yHdXtmZ9Ck4l2kV9R6fUsmnxqd3EYI7ukNpVSQ6agptQ1gNTN7S
         piBDIVMZTm+9Q4K2BzmhJ53/TiOY5dTSnxewoWmrYqAJoAvaOtOUXwuJjKCZAhTwv1Oe
         w7nWTU22QrBQy3tiCddGD3j06CdZUyE2bDtpiqg/xxtkBB6o+/pbEa2hTECGPvRgg3db
         ILU+FUgmU9qwdQAKEdVqhpmwAQgbTRGPmBz0tqfYXlOZ2FLv2ZWZ/hzCn72CuEnd0vrt
         5JV19Q3vVh+A7BdmV+In//bxRluoD1zRsTgQru655wbF2qX2r5Jwcw5gD/WnwrHgLV+h
         CXnQ==
X-Gm-Message-State: APjAAAWSliDXgWDxjInHxbm8NxJNzhBAK/CxnAN1yfgIkEXpBj5F0aTx
        s79w6Ys0Wy83X1xWAiMk9jRTph3nS8AUUNOTJop4Oq7HmlhsB/p/MbR2ZGx530eQ4f3f74odOMf
        2/QC3sDd8I4vNI9BahBH/u6SJlCQe8T5wc+Q=
X-Received: by 2002:ac8:518f:: with SMTP id c15mr2132925qtn.352.1571890788057;
        Wed, 23 Oct 2019 21:19:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxa7J8OsteOSjEJjhCtOyDIR65UTz1VHmhdrCFqFbWt9lEWO9rUP9zN1LcTtsDYCerZv69bQw==
X-Received: by 2002:ac8:518f:: with SMTP id c15mr2132918qtn.352.1571890787808;
        Wed, 23 Oct 2019 21:19:47 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id q64sm13786791qkb.32.2019.10.23.21.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 21:19:45 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next - sparse warnings after prefered/preferred patch.
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1571890783_59326P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 00:19:44 -0400
Message-ID: <822877.1571890784@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1571890783_59326P
Content-Type: text/plain; charset=us-ascii

Building with C=1 W=1.  After this commit:

commit 79f0cf35dccb1df27436c11b1a928b7a46152211
Author: Mark Salyzyn <salyzyn@android.com>
Date:   Wed Oct 23 11:25:16 2019 +1100

    treewide: cleanup: replace prefered with preferred

sparse throws messages on every single .c that includes sysctl.h:

 CHECK   kernel/sched/wait.c
./include/uapi/linux/sysctl.h:561:36: error: Expected } at end of specifier
./include/uapi/linux/sysctl.h:561:36: error: got __attribute__
  CC      kernel/sched/wait.o
  CHECK   kernel/sched/wait_bit.c
./include/uapi/linux/sysctl.h:561:36: error: Expected } at end of specifier
./include/uapi/linux/sysctl.h:561:36: error: got __attribute__
  CC      kernel/sched/wait_bit.o
  CHECK   kernel/sched/swait.c
./include/uapi/linux/sysctl.h:561:36: error: Expected } at end of specifier
./include/uapi/linux/sysctl.h:561:36: error: got __attribute__
  CC      kernel/sched/swait.o

The build has only gotten through 471 CC's so far - and 327 have thrown warnings.

--==_Exmh_1571890783_59326P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXbEmXgdmEQWDXROgAQLXHA/7BweN7dgnFZVpsAjcRgtCk4NhyGqe3aqR
XgXRHCIa6FzwJi+bgsaFIX1q6mb13paEiUBlUDKF+W/2brZ0jLdzf8ttTIKe7BzS
RtNjhksM+eU9MY26vbO2dHWHPv7DGKJRJh6C2O1Y8+815nMV+vnU6HyRA8OYMb7Z
Ep5+hNUaQ0uO+x+t8ocK6xzqDhFdwwMRvUyUdw9YDZUwhLwIA0kFtpF76aS9idCY
KUY1E9xtbHXjq97+VGe19nwqzm7E0GiE3tQNRMLQnWt1TXcJ/VrO13Cw0/D2nVhE
Swn+3sQLLIKmkgLbi/1QL47K+aTgP/jBztWxFBMZ70rA4A4ZgyoJbOnnEepOVN1j
Dfet8HaqKQnUvSDhJAMRk18Q9Mpy90y9H/jtNyhKvr02nMWsuWNVrfpSe05cp/Ni
LETaQmwARubsPSOUjYm9xOrV/TJ+qpQFJ/F3Dx0ALDRVXeii6FNZLhIWBfD0g2rP
k65YiLVXzE4Yb5KmXvdTfxKOvL94nLH9nHDGdSklehbZiPowp+BHEflToZIKr8Rk
xpkWmZIgGEBUMHHBD2oqO+Aai0qbgS7akGM8sylpzOBS9u5fWx/ivBaz7IjjXYvy
AHdswQqHYgD2bsEvDGt+D7j5TFrtNdDJG84X4JULBQk/Rk2bD6X2K+l96Q8HQFEK
cvmVJWcPKgc=
=mR8C
-----END PGP SIGNATURE-----

--==_Exmh_1571890783_59326P--
