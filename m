Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F36AC2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C31D2084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ktHGldMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfLDPAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:00:36 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39369 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfLDPAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:00:35 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191204150033euoutp029e54d8cb17ee5b7ef93af6396fc6c0cb~dMxqCa9xl1387513875euoutp02C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2019 15:00:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191204150033euoutp029e54d8cb17ee5b7ef93af6396fc6c0cb~dMxqCa9xl1387513875euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575471633;
        bh=W5ao0meWKTybj06Bc1aZgt0BhhgCe2gxqPXyK+RzKHY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ktHGldMXKE8h/NHcQXD6U0baub1k/pzZubWfrWDVjnzJW+ukBuAkN3t+hbuJQnQ5J
         9Wo1+yKDK6zQjcfg8+rEy+kTZ3CrZIJRKKWX7RpMfFmyLa0YlKtjyIIJL0A+7qKhuS
         fhd6hbpSny+k4UOmi/kwizB+h7qqDuwJO0GWY4uA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191204150033eucas1p1ce1850993105993e40bd66d564234a1c~dMxp15JR40811808118eucas1p1R;
        Wed,  4 Dec 2019 15:00:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A4.68.60698.11AC7ED5; Wed,  4
        Dec 2019 15:00:33 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191204150032eucas1p1c10713b3308e45e086dd66099057e2b6~dMxpZ4tMY0813008130eucas1p1U;
        Wed,  4 Dec 2019 15:00:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191204150032eusmtrp1c2d7647b48e92c5af382a8aa11dff488~dMxpY_Svz1247512475eusmtrp1F;
        Wed,  4 Dec 2019 15:00:32 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-bd-5de7ca11917c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A7.ED.08375.01AC7ED5; Wed,  4
        Dec 2019 15:00:32 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191204150032eusmtip164717530c7cca1c6cc932a00b305b9b7~dMxo2D9wA1893018930eusmtip1t;
        Wed,  4 Dec 2019 15:00:32 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v2 0/3] devfreq: improve devfreq statistics counting
Date:   Wed,  4 Dec 2019 16:00:15 +0100
Message-Id: <20191204150018.5234-1-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djPc7qCp57HGsxp5rXYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLs01v2C0u75rDZvG59wijxdojd9ktbjeuYHPg9Ni0qpPNo2/LKkaPz5vk
        ApijuGxSUnMyy1KL9O0SuDJ6921jLrjCUdH4qZG1gfEPWxcjJ4eEgInEmfPvWEFsIYEVjBKn
        dqd2MXIB2V8YJX7fWM0MkfjMKDHlZDRMw9JPyxghipYzSvzcdI8VruPSkRvsIFVsAvoSB8+e
        ZAGxRQSkJToXTWQCKWIWOMYksevQX7B9wgIuEocXzAZawcHBIqAqsfJ8HUiYV8Ba4tDCRhaQ
        sISAvMSctxoQYUGJkzOfgI1kBgo3bwXp5AIq+c4msfXaDEaI61wkTu+/yQRhC0u8Or6FHcKW
        kTg9uYcFwi6XeLqwjx2iuYVR4kH7R6iEtcTh4xdZQRYzC2hKrN+lDxF2lHj6fhkbxD18Ejfe
        CkLcwCcxadt0Zogwr0RHmxBEtarE81M9UBdIS3T9X8cKYXtIbJ1wHxqesRJ/Nv9lnMCoMAvJ
        Z7OQfDYL4YYFjMyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAtPM6X/Hv+5g3Pcn6RCj
        AAejEg9vw6bnsUKsiWXFlbmHGCU4mJVEeLdJPI0V4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN
        8CBaSCA9sSQ1OzW1ILUIJsvEwSnVwFg6P7ZmxWw2ta6GkHm6ihGbyltlnx809pky24191U1G
        lrsRs1ZtElbxdlD6Vya0iHn/3/aZ0X7Zk9RPiW+IPzn7Hf8ktkdXJZnCa42UtqrfiOE2yTe6
        Nfm/fXFY3ey8D8FW051+K0iK3HncNK9n+1bW0EXZYadjZ87TOVidlHhDU/bI/IxndUosxRmJ
        hlrMRcWJAKRkOqcvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xu7oCp57HGvx9Z2yxccZ6VovrX56z
        Wiz4NIPV4vz5DewWZ5vesFtc3jWHzeJz7xFGi7VH7rJb3G5cwebA6bFpVSebR9+WVYwenzfJ
        BTBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GX0
        7tvGXHCFo6LxUyNrA+Mfti5GTg4JAROJpZ+WMXYxcnEICSxllPg77TszREJaovH0aiYIW1ji
        z7UuNoiiT4wSi4+/YQVJsAnoSxw8e5IFxBYBauhcNBGsgVngDJPEr5YKEFtYwEXi8ILZQEM5
        OFgEVCVWnq8DCfMKWEscWtjIAhKWEJCXmPNWAyIsKHFy5hMWiCnyEs1bZzNPYOSbhSQ1C0lq
        ASPTKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAA33bs5+YdjJc2Bh9iFOBgVOLhbdj0PFaI
        NbGsuDL3EKMEB7OSCO82iaexQrwpiZVVqUX58UWlOanFhxhNgU6dyCwlmpwPjL68knhDU0Nz
        C0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MNnP6+i9wyq89EhKZrhUsbiTf
        snY349nt6e+kJ/Y/4VE4tPOfBB+fp4zKgiWTtpVt+rbBkOesx17luA+/akOmdf/eOyslV/Xx
        9eB59czvsrYdmvCU7/mvoxnccR+dr92MYGiun7rhTugVGZedfmzXOHeXTWmY03UkeatrE4+0
        2ntDFpHA01u2KrEUZyQaajEXFScCAI7hyVeGAgAA
X-CMS-MailID: 20191204150032eucas1p1c10713b3308e45e086dd66099057e2b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191204150032eucas1p1c10713b3308e45e086dd66099057e2b6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191204150032eucas1p1c10713b3308e45e086dd66099057e2b6
References: <CGME20191204150032eucas1p1c10713b3308e45e086dd66099057e2b6@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch series tries to improve devfreq statistics:

- do conversion to use 64-bit jiffies for storing elapsed time and prevent
  counters overflow,

- add ability to reset statistics using sysfs,

- move statistics data to separate structure for improved code
  readability and maintenance.

Changes in v2:
- added Acked-by to first patch
- dropped spinlock patch, there is mutex used for protecting stats data
- rewrite clearing statistics, suggested by Chanwoo Choi: reuse
  trans_stats sysfs file, any write to it will clear devfreq stats
- dropped change var name last_stat_updated
- squashed three last patches into one, as it turned out that freq_table
  from devfreq_profile is used by other drivers
- rebased on linux-next

Kamil Konieczny (3):
  devfreq: change time stats to 64-bit
  devfreq: add clearing transitions stats
  devfreq: move statistics to separate struct

 drivers/devfreq/devfreq.c | 86 +++++++++++++++++++++++++++------------
 include/linux/devfreq.h   | 31 ++++++++++----
 2 files changed, 81 insertions(+), 36 deletions(-)

-- 
2.24.0

