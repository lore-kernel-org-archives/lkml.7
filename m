Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49514C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1504621900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Qp5qjzlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfCVK7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:59:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:38947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbfCVK7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553252356;
        bh=XLVVM07+Y4/mwdIJqRAavdY0zo8YMb3foFHwazk6OOA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Qp5qjzlJWGYY6TdM9OQk61nJvXJjwyibTi35xYZHGHaElaogiADqEQZqq062Zdtov
         5FjL+68iU6370Oahbrjqpaj8ZHbAhvUoYYljjGVSPM6qSEUPGb+OrDvAy11j7kjqhO
         bC8AlRuwVEVpx3jz1DzYp3s5HDVD5WdXDBopVPKo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0LaWlT-1gijBk3Ux5-00mKGc; Fri, 22 Mar 2019 11:59:16 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     davem@davemloft.net
Cc:     keescook@chromium.org, ktkhai@virtuozzo.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH net] netlink: fix a memory leak on error path
Date:   Fri, 22 Mar 2019 18:58:45 +0800
Message-Id: <20190322105845.25046-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N601Tzg6Yb36hQkDf5T+7WdQ3PRhFqyrDtcG/C1EEjXa5CjIgqh
 mIjjMqQpjU/cguNYFDtGNuOaCNXQzJ44LJxTFyIxZKy9sNe35NmizTy4PeKt/l3ZZV7k++9
 MPhY2OSXmuaCUT3anlglLfc0LBKNaoP4MzifQWxHRaEv3IbamnegA7gxqWcaF+y8ASJvMM3
 +a35nDlMb9TjmPWmBHygA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fVU3FDfzVk0=:ogJLMIw5VvhJYCTxdRu6IZ
 ViI/hzk6ZRjtEquUkGhr3wdmHMnuSu0NIvyHofEW4HF/4gjQBZvdgmJvXy4gg9LsvHg1pt+7V
 j9wKlCzGpUGYYByrS2KodbsBXpon/BcUuWYxW+krdIANf1NW9vLn4uD/TSJ5XuUrsIQuqvwxT
 D3gYsXGlnQovGmFm0ly1ZPfIHH86QQPDapyYvb3ws9Kcjep3Ca5nJNz2qwdxl0s3K7CjGK8y/
 ONAsgc7hEV9lcTYQO7j1+Q/c/56mmJokL/BrzYvSAybv5urUNb0XCSCW31bigp6/2GojOQGFb
 n8qToNrUSeGy9iQXGPmjNGkFIS9TECesl9yCtV+wwvqbQn5kFiei1fc+yXgqVTGPtCMzGNOn2
 NpNyBheKlAsVdsKwIh6iTC8Kn/gQlezHuCIWY+cJ806WI3z5gAVzlA0J7Y4nIQLNB1M6zGx+K
 KjhN4WyT+oChfQmuUkKfqOsZ6PNo4DP8F9UwSOLL5mZgd/r8ld780EJS7GG7WsK8S+UetR5fW
 9F+BkiH/E6Su+YjQmvmYdJvi0pNVtW8Ku46qBmGpftGirphy079Gg4tfezBHY17iBpHwJJw1i
 p3mTNKPJoT3WHRJriaN3XPWAZYfty+uwvQuWdLkdk5suekiTm/rYWI6m/QBgqLL1MsrurS2KF
 zeeMMT0EErrZhAdIbkt2Y3sr+2xGXSsNpSoRPa5jb4V7jrhFqEt4OS6FHm8MRYr96EeXvwDvP
 jbborVv6kEB+ete+kVtw+UM1xYtng/tW6so3gNotL1zB0zQ6gPZTLwSA3v/g7AaiRAF/bF+cm
 USIi/TVt1qs2QdPtKaRB0ZMLM98Q9hSG8z7JYvi0Zbfpg2HIgG6zQ/JsfEqeenDRQksTh4t4K
 UgdQz/Sv8b7ykW18soYIUKQlyD0tq3jVOFY39ILVesjx2q8EXSjI4kIpDVQS7B
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In genl_register_family(), when idr_alloc() fails,
we forget to free family->attrbuf.

Note, some callers call genl_unregister_family() to clean up
on error path, it doesn't work because the family is inserted
to the global list in the nearly last step.

Fixes: 2ae0f17df1c ("genetlink: use idr to track families").
Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
 net/netlink/genetlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 25eeb6d2a75a..f0ec068e1d02 100644
=2D-- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -366,7 +366,7 @@ int genl_register_family(struct genl_family *family)
 			       start, end + 1, GFP_KERNEL);
 	if (family->id < 0) {
 		err =3D family->id;
-		goto errout_locked;
+		goto errout_free;
 	}

 	err =3D genl_validate_assign_mc_groups(family);
@@ -385,6 +385,7 @@ int genl_register_family(struct genl_family *family)

 errout_remove:
 	idr_remove(&genl_fam_idr, family->id);
+errout_free:
 	kfree(family->attrbuf);
 errout_locked:
 	genl_unlock_all();
=2D-
2.20.1

