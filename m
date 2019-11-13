Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7646BC17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487A022459
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VOsFwWX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKMIXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:23:09 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:56648 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfKMIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:22:28 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191113082226epoutp018f89eeb7a4bc17839a545f85b2e3ebda~WqzDi9o4g2730127301epoutp01v
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:22:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191113082226epoutp018f89eeb7a4bc17839a545f85b2e3ebda~WqzDi9o4g2730127301epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573633346;
        bh=W/nvY8vh7b5VKEGm7/5P+NKNPdIjQbHkTzk7gijW0ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOsFwWX/bz6VsL9PnGd7awK9ZpE2qTS6zZK4fcJR7jN1fUChlodgiYFRUaroejWF0
         NrtOO0OdKrFezcQ0PRLPKcWwvhgP7I09B3vJmEjregLO40hLM0N3DG09rtuXa9vvA7
         XS/B1a/hHO0gKNMaRACMdWacEf5cTZWeeaDdsH7I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191113082225epcas1p31e045bb7debe6392277679948c378346~WqzDISfxD0729207292epcas1p34;
        Wed, 13 Nov 2019 08:22:25 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47Cczh4XcVzMqYkl; Wed, 13 Nov
        2019 08:22:24 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.93.04068.F3DBBCD5; Wed, 13 Nov 2019 17:22:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191113082223epcas1p3fae6dbb20c196884a9f57b3918ca186d~WqzA-xijQ1452214522epcas1p3K;
        Wed, 13 Nov 2019 08:22:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191113082223epsmtrp13f2b655836117ac22aa709a4a0e09397~WqzA-IoXS2837528375epsmtrp1c;
        Wed, 13 Nov 2019 08:22:23 +0000 (GMT)
X-AuditID: b6c32a39-f47ff70000000fe4-47-5dcbbd3f7041
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.84.24756.F3DBBCD5; Wed, 13 Nov 2019 17:22:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113082223epsmtip185e2d8047480cc796052ead17fe56c54~WqzA3S3AC2165921659epsmtip1j;
        Wed, 13 Nov 2019 08:22:23 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 11/13] exfat: add Kconfig and Makefile
Date:   Wed, 13 Nov 2019 03:17:58 -0500
Message-Id: <20191113081800.7672-12-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113081800.7672-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmvq793tOxBhNbDS2aF69ns1i5+iiT
        xfW7t5gt9uw9yWJxedccNosf0+sttvw7wmpx6f0HFgcOj52z7rJ77J+7ht1j980GNo++LasY
        PT5vkvM4tP0NWwBbVI5NRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCQ4MCveLE3OLSvHS9
        5PxcK0MDAyNToMqEnIwjbzwLOngrJvxpZmlgvMTVxcjJISFgItF9p4e9i5GLQ0hgB6PE0WuH
        mUESQgKfGCV6LulCJL4xSsyYsIsdpuPcxn+MEIm9jBJfZ91mhXCAOpZvvcLSxcjBwSagLfFn
        iyhIg4iAvcTm2QdYQGqYBeYwSuzoncUIUiMsYCZx+4o3SA2LgKrEseblbCA2r4CNxOE7Sxgh
        lslLrN5wgBmknBMofm2tLcgYCYENbBInjy5ihqhxkVix/AYrhC0s8er4FqhDpSRe9rexg/RK
        CFRLfNwPVd7BKPHiuy2EbSxxc/0GVpASZgFNifW79CHCihI7f88Fu4BZgE/i3dceVogpvBId
        bUIQJaoSfZcOM0HY0hJd7R+glnpILH5/kQUSIP2MEp8vXGSfwCg3C2HDAkbGVYxiqQXFuemp
        xYYFpsixtYkRnNi0LHcwHjvnc4hRgINRiYdXYuGpWCHWxLLiytxDjBIczEoivDsqTsQK8aYk
        VlalFuXHF5XmpBYfYjQFhuNEZinR5Hxg0s0riTc0NTI2NrYwMTM3MzVWEud1XL40VkggPbEk
        NTs1tSC1CKaPiYNTqoFRc1Fw9I5tIf7CJ91b/ZVv9uqvXV3lOYt90uyTU37W7ptqytU0Rf/Q
        Tab/BnsP8+XorGax8FzN+EvP99uz6MCdpn/XplWoztWdKeziXr7A7eXlrGfb9C19vh3UXuDR
        qezx/PblyeweeQs4NwtfeMAyx+9+5o/vZ4oeuoc53Ij4u+1GUsmFo48WKLEUZyQaajEXFScC
        AI3Dl9OCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSnK793tOxBpuXylo0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2KC6blNSczLLUIn27BK6MI288Czp4Kyb8aWZpYLzE1cXIySEhYCJxbuM/
        RhBbSGA3o8TuXyUQcWmJYyfOMHcxcgDZwhKHDxd3MXIBlXxglFi6v5kFJM4moC3xZ4soSLmI
        gKNE767DLCA1zAKLGCXefZzMClIjLGAmcfuKN0gNi4CqxLHm5WwgNq+AjcThO0sYIVbJS6ze
        cABsFSdQ/NpaW4hrrCW+vj3APIGRbwEjwypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxN
        jODw09LcwXh5SfwhRgEORiUeXomFp2KFWBPLiitzDzFKcDArifDuqDgRK8SbklhZlVqUH19U
        mpNafIhRmoNFSZz3ad6xSCGB9MSS1OzU1ILUIpgsEwenVAPjgrpZD5QZDvEd+Pk6xltj4qxe
        7rbHR5VucaiFv73Zve7977UbHh67KLNiztyTipfeK14Lil42c93Lwu/8XTNarvE0b7iSs1O6
        OmS+8dOf0zZtLam3kXa8ceGM0LzNV/NcWMWsAmOnfntqKb5i+cXQ2WXfZ2d6x5t5hD9YI/B4
        25tJ3452JopGJCixFGckGmoxFxUnAgDvPkK+OwIAAA==
X-CMS-MailID: 20191113082223epcas1p3fae6dbb20c196884a9f57b3918ca186d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113082223epcas1p3fae6dbb20c196884a9f57b3918ca186d
References: <20191113081800.7672-1-namjae.jeon@samsung.com>
        <CGME20191113082223epcas1p3fae6dbb20c196884a9f57b3918ca186d@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the Kconfig and Makefile for exfat.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/Kconfig  | 21 +++++++++++++++++++++
 fs/exfat/Makefile |  8 ++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 fs/exfat/Kconfig
 create mode 100644 fs/exfat/Makefile

diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
new file mode 100644
index 000000000000..11d841a5f7f0
--- /dev/null
+++ b/fs/exfat/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config EXFAT
+	tristate "exFAT filesystem support"
+	select NLS
+	help
+	  This allows you to mount devices formatted with the exFAT file system.
+	  exFAT is typically used on SD-Cards or USB sticks.
+
+	  To compile this as a module, choose M here: the module will be called
+	  exfat.
+
+config EXFAT_FS_DEFAULT_IOCHARSET
+	string "Default iocharset for exFAT"
+	default "utf8"
+	depends on EXFAT
+	help
+	  Set this to the default input/output character set you'd
+	  like exFAT to use. It should probably match the character set
+	  that most of your exFAT filesystems use, and can be overridden
+	  with the "iocharset" mount option for exFAT filesystems.
diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
new file mode 100644
index 000000000000..e9193346c80c
--- /dev/null
+++ b/fs/exfat/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for the linux exFAT filesystem support.
+#
+obj-$(CONFIG_EXFAT) += exfat.o
+
+exfat-y	:= inode.o namei.o dir.o super.o fatent.o cache.o nls.o misc.o \
+	   file.o balloc.o
-- 
2.17.1

