Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB487C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 02:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9875020714
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 02:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfKXCJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 21:09:28 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:38451 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726774AbfKXCJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 21:09:28 -0500
Received: from mr2.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAO29RMh019449
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 21:09:27 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAO29MWW016759
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 21:09:27 -0500
Received: by mail-qt1-f198.google.com with SMTP id x8so5909915qtq.14
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 18:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=ylJJysFLat85PTwAyehoagjp+KT4NMBEp9bpqGYm3vs=;
        b=SJPwCwi3dd84K2XmqKt/PW/sRwAC6IpF/Pj2zhlOlCIXCJfeIj2yD6nujKcHXCqRXj
         w4/6200On0yEKlA6yJoaaES1g4ShDp9IFGvPyEZ4nInfbUkc9Epzdi6y6aTnLM7McK97
         lmHI64jtRMek9E//+KjFpwlyjiBTAUUCOjVI3EJwvdB2+zZ98F5Vf4ueI6hWZAfATAt2
         Gl4LXX34ZVM6Y351Pk/u9czxraENMGGGhJSMKf5wjYuOQNepezpUrZ9PE+HN4ZyrDjEB
         PqcM7F5uV7YM2Kpcb42HtWkFOq6RfILV0YZv1L3D1t4xNyO/M5UodFnwCioghzmOujOC
         uz4Q==
X-Gm-Message-State: APjAAAVXQgg9WidNzuPGossC15Ba+UAwzEyoC4AZ35evkZXLwCLqn0Uy
        bKXQozM+M22nCmhT6CE6taGfzG9sdhmtBUjyQaN3Ei2pTixnrxemUcBFUwdpPbYnLHbnY/r5i87
        OEj7Jqo4hC+vPSNtMNjjiLGFLjYFukJO3woc=
X-Received: by 2002:a37:a050:: with SMTP id j77mr8935680qke.295.1574561361901;
        Sat, 23 Nov 2019 18:09:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxK+qK6t4xZxXYaYhbM8kDnayev+5P9D/vV155aaI3ftlF5n1esnO04oCjVIO1DjkefnCYrOw==
X-Received: by 2002:a37:a050:: with SMTP id j77mr8935662qke.295.1574561361592;
        Sat, 23 Nov 2019 18:09:21 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id j18sm1487037qtn.52.2019.11.23.18.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 18:09:20 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     kbuild test robot <lkp@intel.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, linkinjeon@gmail.com,
        Markus.Elfring@web.de, sj1557.seo@samsung.com, dwagner@suse.de,
        nborisov@suse.com
Subject: Signed-off-by: (was Re: [PATCH] exfat: fix boolreturn.cocci warnings
In-Reply-To: <20191123155221.gkukcyakvvfdghcj@4978f4969bb8>
References: <20191121052618.31117-13-namjae.jeon@samsung.com>
 <20191123155221.gkukcyakvvfdghcj@4978f4969bb8>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1574561358_2911P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Nov 2019 21:09:18 -0500
Message-ID: <329028.1574561358@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1574561358_2911P
Content-Type: text/plain; charset=us-ascii

On Sat, 23 Nov 2019 23:52:21 +0800, kbuild test robot said:
> From: kbuild test robot <lkp@intel.com>
>
> fs/exfat/file.c:50:10-11: WARNING: return of 0/1 in function 'exfat_allow_set_time' with return type bool

The warning and fix themselves look OK..

> Signed-off-by: kbuild test robot <lkp@intel.com>

But somehow, this strikes me as fishy.

Or more correctly, it looks reasonable to me, but seems to clash with the
Developer's Certificate of Origin as described in submitting-patches.rst, which
makes the assumption that the patch submitter is a carbon-based life form. In
particular, I doubt the kbuild test robot can understand the thing, and I have
*no* idea who/what ends up owning the GPLv2 copyright on software automatically
created by other software.

Or are we OK on this?



--==_Exmh_1574561358_2911P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXdnmTgdmEQWDXROgAQJtYw//Xzm2sVm0jwExjDrqgt/xKTNIP9CwwXgi
Uit/76mPgMQJpZcnfIUTk4G39Q6EYuX3DkrEcQbkgsPCz4FEBbXgRTTy5C9DmDDA
cJTrUq+hWtdEN77pXzB4kO//8S50mdSlVzj+cj5u1UEQZ3+fy+DH3O7vsvFSglcH
EQ4xopCk7mqcbN+W4Sj8GAIi8QTlFyBJ5sXLkDIKWQW2uSs6GGloYDtg70fDff83
qlubASKVNgiimJU3+jD+3AutaCZkq4v1KYIZq4yGrFy2TaYlSU5eeDCWV1AX/PDS
tq2tjfg42s66hcsEqcby3EF7ii12NTeEixlH1YGVnmL2x71Hag7BUx4vBt9oyS6R
HTy/u9VGTPGL9JrWvzG+Z/j7Kmx0/QhGNW7GGK8SXRt2J8YL4SBX3P5R6c829MoU
gT9aRKG4prJBA+Hk8JY/6Qd+8hvLzQ+2OP7/kgHVCZEwPMqLQooUlPdiUOW3Z0Rl
D9Lk+mYSpqmsIaXOn77UO6jf8eZDg8R2Qh6U4KgdD5NcjauRz0lgxghbAR8pZpW0
GQ30C0tyVKN4ckn2FsUdvNkJhavlCL8xA6Zp7s54KgzTxvlcNfntyj7DxR+oNFXa
W7f1kpKo2nFZcCXQpmcL6lSGyrAtcDqOxNzQbwCq67n+VBWXOU7ns77PJLEGJVrZ
+etkaUS+4X8=
=DjNi
-----END PGP SIGNATURE-----

--==_Exmh_1574561358_2911P--
