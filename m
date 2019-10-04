Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581D5C10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 03:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20274207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 03:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="i7xc3Bhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfJDDfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 23:35:55 -0400
Received: from mx3.ucr.edu ([138.23.248.64]:33947 "EHLO mx3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387463AbfJDDfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 23:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570160155; x=1601696155;
  h=mime-version:from:date:message-id:subject:to;
  bh=Z8VeGOGEm9LC9RfPoH1+Khc4hCaxDK2hry4bcLjvcEk=;
  b=i7xc3Bhynjy0kBIGjj1oX2C3NDYWiHoBOVFSLUkuOhD8ZoEGJbbMXs4j
   xH7iXv2sPLchAeruQGQtIwZbHznqay92c3zAN8l6nklmd5mnfefIDOAnA
   j8WuevTgab+63AhDjDsFf7NiE81yEblV1I3wzma12USOChiEo/K65XNNe
   ZlLks77+dF4tuPgYQnUJfkAySQ7eL3kPvCQurcVH/zPYIKS0BflZ5SXaD
   3ago/n91FWWUqRwP6YYZMk6hia/pDwv71zGJe/9n3KaViVE6sLV4sehwW
   GWZSchFvwvg30X9yPWioCcp6DRPrkqhu6u16iBw3JtNAFIYj5aKSCVVVP
   A==;
IronPort-SDR: 8GKzqSE2vnwKnURxtxdKkzrtNCtBbhi16FVfJUB8avb4ggWO4U7xgjkHpq90dwSp5oBGEj2u1B
 ZPoQ0UNTv1eqPu/K+WxnBVSsR2Ju2YhFxVzcVwMJPLfdXZt8eSwy2WwmEJrZ2+WP/76I0vrySP
 keIgU2f/kXT3V7XcxenoD7WZYzSPMUvPLTXGrLt82SPMww8UxCHur/i2W0idGmhxzvn4iCq7Zw
 RRMCPqcNJ1LskHJpU91hsev6ArS7uPrARFLj21btBeuRED8cQ2nXiSms+r7B8CmgSUHGO+Dxv+
 D6U=
IronPort-PHdr: =?us-ascii?q?9a23=3AYw46/x9AP1pjdP9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21OkcTK2v8tzYMVDF4r011RmVBN6dtqoP07SempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffgtFiCC9bL9uIxm6sQTcvdQKjIV/Lao81g?=
 =?us-ascii?q?HHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9Lm?=
 =?us-ascii?q?A6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD?=
 =?us-ascii?q?+/9KpgVgPmhzkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe84RS2?=
 =?us-ascii?q?hcUcZLTyFODYOyYYUMAeQcI+hXs5Lwp0cSoRakGQWgGP/jxz1Oi3Tr3aM6ye?=
 =?us-ascii?q?MhEQTe0QMiHtIPsXTUrMjyNKwPUu+1zLPHzTTeZP5R2Tb86YjIfQogof2QQb?=
 =?us-ascii?q?59f9HcyVQzGAPflFmft5HqPy6M2+kLrmOV7PJgWPqxh2I7rwx9uDuiy8c2ho?=
 =?us-ascii?q?XUh48YyErI+CR9zYszONa2UlR0YcS+H5tVryyaMox2Td48TGxwoyY6z6EGuY?=
 =?us-ascii?q?a8fCgX1JQr3x7fZOKDc4iP+h/jUfyeITZ8hH58fLK/iQu+/VGuyuD9UsS4yl?=
 =?us-ascii?q?lKri1CktnDsnACyQbf5dSASvt45kuh2DCP2B7P6uxcP0w4ia7WJ4Qiz7MwjJ?=
 =?us-ascii?q?YfrEXOEy3slEj3iKKabkAk9fKp6+TjbLXmvJicN4pshwD+M6UumtawAeUkPg?=
 =?us-ascii?q?QSUWWW4vm826H5/UHjXrpFk+A2nrHDsJ/GPcQburK5AwhN34Yn6ha/CSqm0d?=
 =?us-ascii?q?sBkXkEMl1FYhSHgJbtO1zVPvD4Aumwg062nDdo2f/GJLvhDYvJLnTZl7fhZ7?=
 =?us-ascii?q?l9uAZgz18CzMtS4dpmCqwIJv27Dl7wr9HeSA05LgWyzM7nFdxi24JYUmWKVO?=
 =?us-ascii?q?vRC6rWsFvAw+8vP+DEMJQcvDf5bf0o5+LnpX8kkEAQfO+i2p5BLDjyMv14Ik?=
 =?us-ascii?q?nRWjykp9YFFWoQ9EJqQOX0hViqXTdNanO2WKwgoDc2FNTiRYHOWoygnpSf0y?=
 =?us-ascii?q?qhWJ5bfGZLDhaLC3isP4GFXeocLSGfOMlslhQaWrW7DYwszxejsEn90bUjZt?=
 =?us-ascii?q?jU+zwFs9ra1dFzr7nBlRAj6DptJ8+GlXyGVSd5kn5eA3cd3K15rl1ggmyE16?=
 =?us-ascii?q?cw1/dDEtpcz/hSFBoxL9jRw/EsWP7oXQeUT9abSEuhCuemCDB5GsMjw9YPOx?=
 =?us-ascii?q?4mM8iplFbO0zf8UOxdrKCCGJFhqvGU5HP2Pcsoji+ejKQ=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HfAgBsvZZdh0WnVdFlDoVtM4RMjl6?=
 =?us-ascii?q?FFwGYGAEIAQEBDi8BAYcIIzgTAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIKYV?=
 =?us-ascii?q?AgjopAYNVEXwPAiYCJBIBBQEiATSDAIILoWaBAzyLJoEyhAwBhFkBCQ2BSBJ?=
 =?us-ascii?q?6KIwOgheDbnOHUYJYBIE3AQEBlSuWUgEGAoIRFAOMUYhEG4IqlxaOK5lKDyO?=
 =?us-ascii?q?BRoF7MxolfwZngU9PEBSBWw4JjWgEAVYkkXsBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HfAgBsvZZdh0WnVdFlDoVtM4RMjl6FFwGYGAEIAQEBD?=
 =?us-ascii?q?i8BAYcIIzgTAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIKYVAgjopAYNVEXwPA?=
 =?us-ascii?q?iYCJBIBBQEiATSDAIILoWaBAzyLJoEyhAwBhFkBCQ2BSBJ6KIwOgheDbnOHU?=
 =?us-ascii?q?YJYBIE3AQEBlSuWUgEGAoIRFAOMUYhEG4IqlxaOK5lKDyOBRoF7MxolfwZng?=
 =?us-ascii?q?U9PEBSBWw4JjWgEAVYkkXsBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,254,1566889200"; 
   d="scan'208";a="84987594"
Received: from mail-lf1-f69.google.com ([209.85.167.69])
  by smtp3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2019 20:35:54 -0700
Received: by mail-lf1-f69.google.com with SMTP id n5so545313lfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 20:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NHPkNFk4ddcSKGzRQIl5S9NE3sI5owUIMgWAvgZYtmE=;
        b=g5DcQFX99TC2fKqcvVuLC44QKZXmkzRWPNfhgRmPUlvCtlTtSRTnV+fsenyIVW6mnc
         Fw6CyliDXtDkXWM1+UWN06Qrj3VcWZWrai7Z+3VePCMvjeEYkTVRv4SJA0Nmfx3lQd6e
         nzATc80fYLdbut3apeUnnZwRD5Pc37LNY/wIuY07eHzRyz2O1pOr1cOabaHjTkiQPGWV
         T12SGAo3JulmHRenaksK/7wBGFWptS/rHvZ8SUgqhgSe+Bhe6IBPReK8G7F4YQiQArvy
         yP3rOMyWMZahSQ3CLWCV0zWEuK64zNSds14nbJnxEkYSzzrZRP59NoAD5dqLVIOyfmlj
         qKFg==
X-Gm-Message-State: APjAAAUmw5WGLZ4sd/Ho+D2eSmUOPuPSYWay2I7bp2rf0+RpEpoH5y17
        rbbObAj7YMU5hvqKYg+iU538yWshecgTAYmXIywLsLmxJFcPdpW4WriP7wRD387Om2k2KJ+7EyU
        L3FP8rdsuEXPP+50egrIKBfb1SBgIMSIelu/hOphlhA==
X-Received: by 2002:a2e:9753:: with SMTP id f19mr7976438ljj.197.1570160151878;
        Thu, 03 Oct 2019 20:35:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzavRFwyK4RgialwrG04QE2qj4cBa+T9m8wd7kE3DcN+LkDESOBcSAksIuOaOGx5op8dUGF43Cc7y62iJohxTk=
X-Received: by 2002:a2e:9753:: with SMTP id f19mr7976426ljj.197.1570160151696;
 Thu, 03 Oct 2019 20:35:51 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 3 Oct 2019 20:35:38 -0700
Message-ID: <CABvMjLTiwHQ7cpUCYXJFHfHk+syeE5uQe=3waUGhJSVc5Udb1g@mail.gmail.com>
Subject: Potential uninitialized variables in subsys net: hisilicon
To:     Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

drivers/net/ethernet/hisilicon/hip04_eth.c:

In function hip04_reset_ppe(), variable "val" could be uninitialized
if regmap_read() returns -EINVAL. However, "val" is used to decide
the control flow, which is potentially unsafe.

Also, we cannot simply return -EINVAL in hip04_reset_ppe() because
the return type is void.

Thanks for your time to check this case.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
