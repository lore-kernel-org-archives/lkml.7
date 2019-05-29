Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A015C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C36724297
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ugedal.com header.i=@ugedal.com header.b="EtEkBupW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfE2WZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 18:25:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37862 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2WZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:25:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id h19so4116750ljj.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DK/ogr6pZZUphW9lU4h1f+fFgOabCak3KXyja9ZoLt0=;
        b=EtEkBupWZk2J/O72xoPMmoNFOSLqen/od3RSkObixQLiBW0S7B4LBoMgiN1OJs5lTI
         7eQsLP01PJJoMg2Rx3TXT2fHK9oKRyTMsSxuM14Bv/AhGUfZbEp+jOWiJjg08NWOPWIn
         60jXRmoCOn7ULv9kGZ6Qa3BukeR4KLALFfbLjl+hFFUdKHdpARIjb7oq/IA0fCdMe6Jw
         CGumH0h5cYi/VpKQ+Q0RElMr9yUgKn5Qljab6cDKdX0txp1pFfhPYKT+HwcU8Rt1cCYS
         WLSjSr5B2qq/nQyorb4FdVBSJC+ONV8G5I9EocBK2BtkSCoIadihUFJo7fO60LGyljtK
         4pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DK/ogr6pZZUphW9lU4h1f+fFgOabCak3KXyja9ZoLt0=;
        b=syNdttBG16/COpdn+w9Sjn03XJUNS8HKpnF1kARNclSEvr89+ZTPGxH57rySBZvzR3
         MUKJkfpnDLlkCpXPI3wQgpw9CVoD9Rxy0weV+spuun4tmbJ6ZSJKL260+2wWSBJ6c4xG
         DwdGx5K/euFk0gStum6sq5JmkRWuAm8u3sTi064eGVI9ZargGRU/931It1AR/FLhg4sC
         tqKvgRv/KqP4Jq0MQWreZyjqoXa9RaGRXB126/nIXa1kBtWUyGzvlLNXbs785sepDelD
         Uuo5hWwCayomV9PvNeSyvyV4/UGwwFLnrDST5NlDzdyQ89d3e0cahQ/ZlaNLlVk+JGsM
         w2dg==
X-Gm-Message-State: APjAAAWGOyNYFgV2XhgCyiJNogltJ6OtTNywS+8VqO0TAUqzcr2lVpoV
        dN5lyVOMHZRtQtsUxxRH+3TUtQ==
X-Google-Smtp-Source: APXvYqy0RN6ic0nj6bgyH0NezC2bwxY/JEYIDLewQ/OEvI+10SkZ2sUZRbFizdUdOEoeHXmIvT/NkA==
X-Received: by 2002:a2e:b0e1:: with SMTP id h1mr118902ljl.171.1559168702343;
        Wed, 29 May 2019 15:25:02 -0700 (PDT)
Received: from xps13.ZyXEL-USG (84-52-230.83.3p.ntebredband.no. [84.52.230.83])
        by smtp.gmail.com with ESMTPSA id s12sm113843lji.34.2019.05.29.15.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 15:25:00 -0700 (PDT)
From:   Odin Ugedal <odin@ugedal.com>
To:     odin@ugedal.com
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs cgroups: add another example size for hugetlb
Date:   Thu, 30 May 2019 00:24:25 +0200
Message-Id: <20190529222425.30879-1-odin@ugedal.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another example to clarify that HugePages smaller than 1MB will
be displayed using "KB", with an uppercased K (eg. 20KB), and not the
normal SI prefix kilo (small k).

Because of a misunderstanding/copy-paste error inside runc
(see https://github.com/opencontainers/runc/pull/2065), it tried
accessing the cgroup control file of a 64kB HugePage using
"hugetlb.64kB._____" instead of the correct "hugetlb.64KB._____".

Adding a new example will make it clear how sizes smaller than 1MB are
handled.

Signed-off-by: Odin Ugedal <odin@ugedal.com>
---
 Documentation/cgroup-v1/hugetlb.txt | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/cgroup-v1/hugetlb.txt b/Documentation/cgroup-v1/hugetlb.txt
index 106245c3aecc..1260e5369b9b 100644
--- a/Documentation/cgroup-v1/hugetlb.txt
+++ b/Documentation/cgroup-v1/hugetlb.txt
@@ -32,14 +32,18 @@ Brief summary of control files
  hugetlb.<hugepagesize>.usage_in_bytes     # show current usage for "hugepagesize" hugetlb
  hugetlb.<hugepagesize>.failcnt		   # show the number of allocation failure due to HugeTLB limit
 
-For a system supporting two hugepage size (16M and 16G) the control
+For a system supporting three hugepage sizes (64k, 32M and 1G), the control
 files include:
 
-hugetlb.16GB.limit_in_bytes
-hugetlb.16GB.max_usage_in_bytes
-hugetlb.16GB.usage_in_bytes
-hugetlb.16GB.failcnt
-hugetlb.16MB.limit_in_bytes
-hugetlb.16MB.max_usage_in_bytes
-hugetlb.16MB.usage_in_bytes
-hugetlb.16MB.failcnt
+hugetlb.1GB.limit_in_bytes
+hugetlb.1GB.max_usage_in_bytes
+hugetlb.1GB.usage_in_bytes
+hugetlb.1GB.failcnt
+hugetlb.64KB.limit_in_bytes
+hugetlb.64KB.max_usage_in_bytes
+hugetlb.64KB.usage_in_bytes
+hugetlb.64KB.failcnt
+hugetlb.32MB.limit_in_bytes
+hugetlb.32MB.max_usage_in_bytes
+hugetlb.32MB.usage_in_bytes
+hugetlb.32MB.failcnt
-- 
2.21.0

