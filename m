Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4109C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D8A2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh2zOgr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfFMPdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:33:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44089 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbfFMKpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:45:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so11577161pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YHBzv4ECslLKpMkzoxjS6aoXKy/SFXtprHmV+JrqNk0=;
        b=Gh2zOgr9bu+Tzr0HnGQ+mDT8OkUXS31CoKZCiImvLZkkl6q69mzX6Y9Hn3GwoO8JVf
         dtnKcxCHRIlz5+dyReJS5fGrudHhR1zZynm80yuqVFRbEs+OiEX3gEGuTDcheVRn8aAJ
         j02IfSd5WvBKV+C64bc+54++b3dRRFC/o446EASAeitsSlmTAJPqetf5dKkuiS8lch3L
         6fVAuTFAbWTED9Nh4GT4TtWektafSz9Mn5YtET6Rvl1yoSmtTWSY2RZ2jBlZGpgqGWLU
         vlFi7+o/YSBV+eCdzjBvwXH3WKZtd9XhuPGcxgmX+QM2DfIhEkp9bl8pREA7G5383mYx
         Rvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YHBzv4ECslLKpMkzoxjS6aoXKy/SFXtprHmV+JrqNk0=;
        b=ZND9FqbcxSbC/gohOsH4lIFbTr9obrEBCUwjOjaiaLptbD4dFp5uLd8mfNTcjG9Rb7
         Ydx+osO08Seq0AsXQRklF+7etNhZIw+24et/QeyrzyHx4YCXN3eAD+0HYFCFW6mM9+oe
         cSId3/NKWtB/Knd+v34YaBIDUpBQRbtNqzTvbLrOeiSL0ij/oke+xdNX8UZMrqP0sCN9
         JMNkpSE+cJA0FGnIsPKzfwvu3H30dznFpUyjX3hlNGbKH8LsnhZ5Q0xVrVw3heZza2M7
         MMp/ENiCOkAIx1Q7ENzmLgMFo6wlhRibggbux9UmzLPhkPip2FDezs62EyAXdfKKruH+
         OSnQ==
X-Gm-Message-State: APjAAAWnAI5gkZ84gxOW6pWR1HVtBdFe5Vuwckgsxk7pMfc55qNsmqQo
        KmPW9Y0ZOzPkAFcCZs+eYw==
X-Google-Smtp-Source: APXvYqxCcyskfrhNoa8a6tvucCyA7BESJMT49IgekYmQ2ko0v0dbnBSjI4RkW++kqxhqfDThrA+ABQ==
X-Received: by 2002:a65:42c3:: with SMTP id l3mr30267732pgp.372.1560422739999;
        Thu, 13 Jun 2019 03:45:39 -0700 (PDT)
Received: from mylaptop.redhat.com ([2408:8207:7825:dd90:9051:d949:55f9:678b])
        by smtp.gmail.com with ESMTPSA id a13sm2813285pgh.6.2019.06.13.03.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 03:45:39 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCHv4 0/3] mm/gup: fix omission of check on FOLL_LONGTERM in gup fast path
Date:   Thu, 13 Jun 2019 18:44:59 +0800
Message-Id: <1560422702-11403-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These three patches have no dependency of each other, but related with the same purpose
to improve get_user_page_fast(), patch [2/3]. Put them together.

v3->v4:
  Place the check on FOLL_LONGTERM in gup_pte_range() instead of get_user_page_fast()

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org

Pingfan Liu (3):
  mm/gup: rename nr as nr_pinned in get_user_pages_fast()
  mm/gup: fix omission of check on FOLL_LONGTERM in gup fast path
  mm/gup_benchemark: add LONGTERM_BENCHMARK test in gup fast path

 mm/gup.c                                   | 46 +++++++++++++++++++++++-------
 mm/gup_benchmark.c                         | 11 +++++--
 tools/testing/selftests/vm/gup_benchmark.c | 10 +++++--
 3 files changed, 52 insertions(+), 15 deletions(-)

-- 
2.7.5

