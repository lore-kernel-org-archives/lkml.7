Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94106C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6485821D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="xps8RWHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLTO0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:26:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44258 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfLTO0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:26:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id u71so10188671lje.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=je3VhWK4L1xwgtUZ1dTlP8wEWW2OyupachAHCPAhUxw=;
        b=xps8RWHkl+7mcH+yV4Sx0iUf14Rt0lK/97Bvuq4RY0vND+WwVdokc3CMQjP2OXZCnl
         2SIVaQZmNzSuGFHzz8hoPfPu4q4jRfsWUmOWteACs1yt6qlcSBZGKEOzTlRguwAeHTdC
         KgwmDJl9cPSW4TDVQS0NjCs025+/WQESyf92Np8j5qQlUFeped9Gb48eGTP41wA7Klmj
         bSFI9/rmF7+Kd4b0aH/1jcY4ODT89H3D+HsTbdbXfah0ytl401ZHsiEXEflhA/Wdwuyj
         Xfrb7RmTLmqJi4ObipTkZy+M8Uh9XY8Bp6YKW2Y/rRM3VbscrHqj+hpQdb5cUXObI1kK
         LuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=je3VhWK4L1xwgtUZ1dTlP8wEWW2OyupachAHCPAhUxw=;
        b=N18ybSQ616dIkglEsS3waU+jIGTzaegDJ7P+n0VAiLOdLmlvOL2y9yS+Tjt4x/415J
         AAt39QOqFSOnKDLmFCm1NGD173y3xcOdqLOJqAb9xEvA5MNWoxQ74qBSVNYfx8iCqC0s
         zze4AP2jHeGDfNHA7kjR+n+DtLEY0AMmCwy1UCD2AbcGR2t1YQN40uum/7n9aUXIz1FZ
         ZU+/pqLIEgwN5lliRT+8b/zijG0j8au4oAILYRiymezNJa9iuY50/4CQEwEn0CLf12di
         e+qK4PxcDzFvnZ+kFrp7Y0w20ZepJX90gQUO6B+tID4kZ3t/a4FzAsENrNaY+dSg2ilq
         HCtA==
X-Gm-Message-State: APjAAAXIHkZ32KsuQJ0AhGksj77ySYSKyRqLBxEyvvO0kyMN9hDPsVBY
        VEYc96vRHPY/LdmvTIQMY617EQ==
X-Google-Smtp-Source: APXvYqwS3i53B5Z2qtdboztOMu59K0SEFYHAAYcQ/tdGVI2Xv5HxsMTwiqX3QXCESI3WaJjx4Hfm4A==
X-Received: by 2002:a2e:86c8:: with SMTP id n8mr8856186ljj.205.1576851957808;
        Fri, 20 Dec 2019 06:25:57 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y7sm4298527ljj.58.2019.12.20.06.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 06:25:56 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 32A511012A6; Fri, 20 Dec 2019 17:25:59 +0300 (+03)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Willhalm, Thomas" <thomas.willhalm@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Bruggeman, Otto G" <otto.g.bruggeman@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/2] Fix two above-47bit hint address vs. THP bugs
Date:   Fri, 20 Dec 2019 17:25:46 +0300
Message-Id: <20191220142548.7118-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two get_unmapped_area() implementations have to be fixed to provide
THP-friendly mappings if above-47bit hint address is specified.

Kirill A. Shutemov (2):
  thp: Fix conflict of above-47bit hint address and PMD alignment
  thp, shmem: Fix conflict of above-47bit hint address and PMD alignment

 mm/huge_memory.c | 38 ++++++++++++++++++++++++--------------
 mm/shmem.c       |  7 ++++---
 2 files changed, 28 insertions(+), 17 deletions(-)

-- 
2.24.1

