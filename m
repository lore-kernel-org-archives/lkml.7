Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67003C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418D32173C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404204AbfFMQrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:47:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36125 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbfFME7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 00:59:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so4182497pgi.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 21:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7WDCBC5qFx+f/Kahslw5ORYJBb3fYU7g6V0PD2h25w=;
        b=PxBLnRk5p4aUxz2HgIYzFkfpvujRACsQ2Pn44xsmO+JF4PcoNuHlIyVqVXyiab8KIE
         GJevLUjPjYowyw2Nj7mSeBaEAD9NGiwlWkO8+RVQNOafWRR9DtPPr5etJX5eDsEozmgw
         nwVxj4KFWuyXPGYnT1Op+LdpwfKsAw7obanVXzPzPChLiAZ2MVSHHN8hAGAmC1K7WXZx
         GkxFPe42NQh4+NAn5oVZKgP6xN5v25Ozcdsyra6S4kohDW7Tc7lC7tr+JbD9B5yIFqwO
         yq+7L5UwBIi2WIGcJTc0qCHdVQxMRyAWOMHq4mZlcLfbNJWczee5oEP7VOlfkIj2fqtw
         4hPw==
X-Gm-Message-State: APjAAAXCH6HA1ck6nb0W1do8Aea/Xswbm8opmaFdg3D74SAGuTnGM/Do
        /jYNy24MGdWaefIWgFeneAo=
X-Google-Smtp-Source: APXvYqynlMwaqsDKPUe5nel7CccY8UDY5gB3/QWR+ZWv7D7rB9qEUOnlWCP1qKidM88aV6+COX4Zqg==
X-Received: by 2002:a63:484d:: with SMTP id x13mr19594551pgk.448.1560401962810;
        Wed, 12 Jun 2019 21:59:22 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id o66sm1215327pfb.86.2019.06.12.21.59.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 21:59:21 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <namit@vmware.com>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/3] resource: find_next_iomem_res() improvements
Date:   Wed, 12 Jun 2019 21:59:00 -0700
Message-Id: <20190613045903.4922-1-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running some microbenchmarks on dax keeps showing find_next_iomem_res()
as a place in which significant amount of time is spent. It appears that
in order to determine the cacheability that is required for the PTE,
lookup_memtype() is called, and this one traverses the resources list in
an inefficient manner. This patch-set tries to improve this situation.

The first patch fixes what appears to be unsafe locking in
find_next_iomem_res().

The second patch improves performance by searching the top level first,
to find a matching range, before going down to the children. The third
patch improves the performance by caching the top level resource of the
last found resource in find_next_iomem_res().

Both of these optimizations are based on the ranges in the top level not
overlapping each other.

Running sysbench on dax (Haswell, pmem emulation, with write_cache
disabled):

  sysbench fileio --file-total-size=3G --file-test-mode=rndwr \
   --file-io-mode=mmap --threads=4 --file-fsync-mode=fdatasync run

Provides the following results:

		events (avg/stddev)
		-------------------
  5.2-rc3:	1247669.0000/16075.39
  +patches:	1293408.5000/7720.69 (+3.5%)

Cc: Borislav Petkov <bp@suse.de>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ingo Molnar <mingo@kernel.org>

Nadav Amit (3):
  resource: Fix locking in find_next_iomem_res()
  resource: Avoid unnecessary lookups in find_next_iomem_res()
  resource: Introduce resource cache

 kernel/resource.c | 96 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 17 deletions(-)

-- 
2.20.1

