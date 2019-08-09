Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F624C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23E22171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Laxjw3SD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406989AbfHIOHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:07:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47703 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfHIOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:07:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190809140737euoutp02db78ab16c1ac206238e21767a08e53f7~5RlCrrILq0769707697euoutp02o
        for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2019 14:07:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190809140737euoutp02db78ab16c1ac206238e21767a08e53f7~5RlCrrILq0769707697euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565359657;
        bh=Jnk5qUmdXGpY8skMtfaeEbiGzPLM3WRl+KTAG/hBkhY=;
        h=From:Subject:To:Cc:Date:References:From;
        b=Laxjw3SDHUL7GG2dcBV9rXwSFRQzBDbMH0VPReBaVc0EaxUCbpbRmB0mAO8Loisw/
         TuT61sDwACqbYGYUo1VOe1pYJIqHhdhPveHKoKRM39WxR4HKjmo1QxZqolyXvH0wdZ
         skPaIAAMRcixGCsXl5VbD/vnMynbmtOGWND0kQhI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190809140737eucas1p1e959583176472bdb9eefd482d81cbb9c~5RlCXT8yp2256822568eucas1p1i;
        Fri,  9 Aug 2019 14:07:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 12.05.04374.92E7D4D5; Fri,  9
        Aug 2019 15:07:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190809140736eucas1p2b14d3205aa7268cd1a6bba15ebd81066~5RlBifsfV1267712677eucas1p2R;
        Fri,  9 Aug 2019 14:07:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190809140736eusmtrp25a5aa358440e2c8dbce4df151fe11564~5RlBUf1m11842018420eusmtrp2L;
        Fri,  9 Aug 2019 14:07:36 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-31-5d4d7e2931fe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9E.2F.04117.82E7D4D5; Fri,  9
        Aug 2019 15:07:36 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190809140735eusmtip1a7fdab549a7159935ceec23e0249cfa8~5RlBBJkpv1392113921eusmtip1H;
        Fri,  9 Aug 2019 14:07:35 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [GIT PULL] fbdev fix for v5.3-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <22bfe177-272e-afe8-31d1-75bc0cf852c7@samsung.com>
Date:   Fri, 9 Aug 2019 16:07:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7qadb6xBps+c1lc+fqezeJE3wdW
        i8u75rBZPOp7y+7A4nFixm8Wj/vdx5k8Pm+SC2CO4rJJSc3JLEst0rdL4MpYtvYAc8Fejoob
        R7wbGHvYuxg5OSQETCS2buxn6mLk4hASWMEoMXXDSzYI5wujxMdbFxghnM+MEhvmfGGBaZnx
        bg5UYjmjRE97JwuE85ZRYvnRLWCD2QSsJCa2r2IEsYUFtCQOrpjBDGKLCBhJfH5xhRXEZhZI
        kPhy8zNQnIODV8BO4sZVfZAwi4CKxI1DH5lAbFGBCIn7xzaAlfMKCEqcnPmEBaJVXOLWk/lM
        ELa8xPa3c5hBbpAQ+M4mseZpJyvEpS4SF3ctYIawhSVeHd8C9bSMxP+d85kgGtYxSvzteAHV
        vR3og8n/2CCqrCUOH7/ICnIds4CmxPpd+iCmhICjxN1VwRAmn8SNt4IQN/BJTNo2nRkizCvR
        0SYEMUNNYsOyDWwwW7t2roS6xkOi98VZ9gmMirOQfDYLyWezkHw2C+GEBYwsqxjFU0uLc9NT
        i43zUsv1ihNzi0vz0vWS83M3MQLTyel/x7/uYNz3J+kQowAHoxIPb4OiT6wQa2JZcWXuIUYJ
        DmYlEd4rHL6xQrwpiZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5akZqemFqQWwWSZODil
        Ghgrbx/mq59VnF1gNbmIw2thZMqV39zln9+py2We9VXKXS9eFDxz27yZieyOlzO/a7EJx4ZP
        PhSs6MfhZ1+74Iy7z/8Eo5XbD13L+Jj6Jr2nU6e9/K7F89WmNw1+nH904seXZHOPld35bqpT
        BL7EnyuyeXV4457DP8qO3lz+qm/3sy7Ht3vzF7EosRRnJBpqMRcVJwIAqDr+hiMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4XV2NOt9Yg1ePeCyufH3PZnGi7wOr
        xeVdc9gsHvW9ZXdg8Tgx4zeLx/3u40wenzfJBTBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZ
        mVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GUsW3uAuWAvR8WNI94NjD3sXYycHBICJhIz3s1h
        BLGFBJYySrybkNbFyAEUl5E4vr4MokRY4s+1LrYuRi6gkteMEieeLWcDSbAJWElMbF8F1iss
        oCVxcMUMZhBbRMBI4vOLK6wgNrNAgsSm+1PZQGbyCthJ3LiqDxJmEVCRuHHoIxOILSoQIXHm
        /QoWEJtXQFDi5MwnLBCt6hJ/5l1ihrDFJW49mc8EYctLbH87h3kCo8AsJC2zkLTMQtIyC0nL
        AkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGxsO3Yzy07GLveBR9iFOBgVOLh1ZD3iRVi
        TSwrrsw9xCjBwawkwnuFwzdWiDclsbIqtSg/vqg0J7X4EKMp0EMTmaVEk/OBcZpXEm9oamhu
        YWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFRNTFv8gHBd3M5/624OdV91dzY
        1ttm7mEXt3ksCtr+36+nl+nonj33+JyW3H/0Z0G654+7Z0uZWx+WrT/FXZcrfZbl+saJolHr
        Pf3u2384N0/q6OoF23uaVGSzb/Wynzv/4XL/gXfiG+bPqdWUmOG6Yum27ARVVjfv07tdmlUD
        i5dJb319SznguhJLcUaioRZzUXEiAOfAZqibAgAA
X-CMS-MailID: 20190809140736eucas1p2b14d3205aa7268cd1a6bba15ebd81066
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190809140736eucas1p2b14d3205aa7268cd1a6bba15ebd81066
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190809140736eucas1p2b14d3205aa7268cd1a6bba15ebd81066
References: <CGME20190809140736eucas1p2b14d3205aa7268cd1a6bba15ebd81066@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev fix for v5.3-rc4 (fbdev patches will now go to
upstream through drm-misc tree for improved maintainership and
better integration testing so update MAINTAINERS file accordingly).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v5.3-rc4

for you to fetch changes up to 6a7553e8d84d5322d883cb83bb9888c49a0f04e0:

  MAINTAINERS: handle fbdev changes through drm-misc tree (2019-08-09 15:46:40 +0200)

----------------------------------------------------------------
fbdev fix for v5.3-rc4:

- update fbdev git tree in MAINTAINERS file

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      MAINTAINERS: handle fbdev changes through drm-misc tree

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
