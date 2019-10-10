Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A03C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83001218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="tkjd0RcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfJJE4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 00:56:35 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:27053 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfJJE4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 00:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570683395; x=1602219395;
  h=mime-version:from:date:message-id:subject:to;
  bh=l8fka7UYOSDuLxUdqgi3tx7DvHNj0L8HgAjIPCh+cSg=;
  b=tkjd0RcGZuHPYaNLbkDNXv5uyop0AZvc4JQX6NUuM/5JUR0p12IjM90I
   HFrCxXKuDCEcpZU8j8YYv3yt1I7s1IIez/e7W8Mv/IY5mbf6nZh06US3c
   MO5pfFlNCCgHaxiOlbW2Q/tLmGJCQXt8tQ1VkAYdltEhlJpVr9rNwsbvI
   Bfeqjf1s34ZSp5mwaRkieUJKJpaoL6RA+vfcY9+hqMrpsmApIfhNVonst
   TSYoGXyYXkOCNwDnLknVF9shs7f4765Crtr3SCMUETEvdWEi9Iwp73RFl
   q8dlMYzc1tXuZiD6nE56+aFMF3BIhaZH5iIW+BVOKWNq0Ap00V46yi+ey
   A==;
IronPort-SDR: s/qN1uASMRCZWp4JYwc6ThIpqYnJGheojd4O33+jOPR7RfmpoukxfSBrIQOqTLEsQ2upLIOoND
 7qsvUniZDOGp1+GgaGM1RG27a0MhpYHdCeysze96F37+JRUWfBJKt8bvxSTagvW6XsExV7qyCV
 HegLhvPne8QGtyXk9YTsurN79ebqkGW9YrE/3uIHGzigsc79z8VerswHUFRgTOJWK+/L1UT4ko
 FfPmdYQeqTZpE5LRecmlb50wGfm9SQZuupzlLd0cKw0U3VMkuJgA+nxDuym0H8HonHP2n9g+Pf
 4bs=
IronPort-PHdr: =?us-ascii?q?9a23=3AEnSidBMe21SPoefMuFwl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/X7rarrMEGX3/hxlliBBdydt6sfzbSM+PG4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oLRi6swrdu80KjYB/Nqs/1x?=
 =?us-ascii?q?zFr2dSde9L321oP1WTnxj95se04pFu9jlbtuwi+cBdT6j0Zrw0QrNEAjsoNW?=
 =?us-ascii?q?A1/9DrugLYTQST/HscU34ZnQRODgPY8Rz1RJbxsi/9tupgxCmXOND9QL4oVT?=
 =?us-ascii?q?i+6apgVQTlgzkbOTEn7G7Xi9RwjKNFrxKnuxx/2JPfbIWMOPZjYq/RYdYWSG?=
 =?us-ascii?q?xcVchTSiNBGJuxYIQPAeQPPuhWspfzqEcVoBuiGQWhHv/jxiNUinL026Axzu?=
 =?us-ascii?q?QvERvB3AwlB98BsnXUrdT1NKcPVuC+0arHzTXZYPNXxDzw74jJcxEhof6WXL?=
 =?us-ascii?q?J8bdbdxEc0GgPYklqQs5bpMC2I2eQQqmWW6fdrW+G3i2M/tQ19vjyiyt0vh4?=
 =?us-ascii?q?TJnI4Z11HJ+CdjzIs3OdG1TlNwb8S+H5tKrS6aMpN7QsYlQ251pik30qYGuZ?=
 =?us-ascii?q?unfCgSz5Qn2gLfZ+SHc4eW5hLjU/6cITJii3JkfLKznhKy8Ua9xuHlWMm50k?=
 =?us-ascii?q?pGojBKktnLsXAN2BjT5dadRvRh+Ueh3C6D1wHV6u5aPUA5jbTXJ4Ilz7IqlZ?=
 =?us-ascii?q?cesV7PEjL3lUj0lqObdFko9vCt6+v9Y7XmopGcN5VzigH7Kqkvms2+AeQiPQ?=
 =?us-ascii?q?gPQ2SX5eqx2ab+/ULlWrVGlOM5nbTEsJzCP8QUura5AxNJ0oYk8xu/Czam0N?=
 =?us-ascii?q?IFnXgINV5FewyIj5LvO17QJPD1Fum/g1uynzdx3fzGPaPuAo/LLnfdlLftZ7?=
 =?us-ascii?q?F961RTyFl78dcKxZVUA7cHLem7ZULwstHCRks5Ogqyzv3PA9BlxogeViSIGK?=
 =?us-ascii?q?DPdOv3sFSI7+ZnA+6HZ4hd7DP9LPMm4NbtgGU/lFtberOmi99fVnSxEvVjIl?=
 =?us-ascii?q?/RTXPyk9sGDy9eoAY3Uv3mj0PEXTNNT3m3VqM4oDo8DdTiRYzMXIewmKepwi?=
 =?us-ascii?q?i2BNtVa3pAB1TKFm3nM82AWvEReGeXJ+dijDUPVv6mUYBlnRWvshLqjrlqNO?=
 =?us-ascii?q?zZ/gUGup/5ktt4/evekVc17zMwR/ad0nCQSSlNn2oOD2sk3KFuvEpk4lyYl7?=
 =?us-ascii?q?VzmbpVGcEFo7tiUgo8Oo/Bh9d9Dd+6DgnaedGGYF29BMitG3c8Qs9nkPEUZE?=
 =?us-ascii?q?MoKtSwjg3ElxiqCr5dw62ZBJU1qvqH92X6PYBwx2uQh/pptEUvXsYabT7uva?=
 =?us-ascii?q?V47QWGQteRy0g=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FXAwBKuZ5dgEanVdFlDoZEhE2OW4U?=
 =?us-ascii?q?XAY1pijQBCAEBAQ4vAQGHGCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEJDQkIJ4V?=
 =?us-ascii?q?CgjopAYNVEXwDDAImAiQSAQUBIgEaGoV4pEGBAzyLJoEyiGQBCQ2BSBJ6KIw?=
 =?us-ascii?q?OgheBEYsigl4EgTkBAQGVL5ZXAQYCghAUjFSIRRuCKgGXFY4tmU8PI4FGgXs?=
 =?us-ascii?q?zGiV/BmeBT08QFI9aWySRSwEB?=
X-IPAS-Result: =?us-ascii?q?A2FXAwBKuZ5dgEanVdFlDoZEhE2OW4UXAY1pijQBCAEBA?=
 =?us-ascii?q?Q4vAQGHGCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEJDQkIJ4VCgjopAYNVEXwDD?=
 =?us-ascii?q?AImAiQSAQUBIgEaGoV4pEGBAzyLJoEyiGQBCQ2BSBJ6KIwOgheBEYsigl4Eg?=
 =?us-ascii?q?TkBAQGVL5ZXAQYCghAUjFSIRRuCKgGXFY4tmU8PI4FGgXszGiV/BmeBT08QF?=
 =?us-ascii?q?I9aWySRSwEB?=
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="13444717"
Received: from mail-lf1-f70.google.com ([209.85.167.70])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 21:56:32 -0700
Received: by mail-lf1-f70.google.com with SMTP id c7so1051234lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 21:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qNxdxggCQd3xr6rdB50E8SDcymvAFEfwkLrZ0yN0AVk=;
        b=j+14EuMEOM/anjvZvs8FdiYl3EyEEnK4opNgiqzpByqOzRqKd8uKZKRVveWTyCPTD7
         zwoMlGEJNvNelBzSQHMyU2eO80s1FnO+X9GQsym6zaaSV+pqx+CHDXHVIuajLRTzauTg
         kN0oQTudvkJxPnKKfDqrUr7pP+GDeCoSysuAs0C7Uku7LxAQToT1+YJtcH5yZvohgrBN
         JudUgqXj09nWLumLLfbC9yWQfKtrY6z6wW1W3ktTrHZrf5exBt0RzNi3sPSHEyKpEQJL
         cPNcsUFTtNJKt9TS6cPd0JvmqtBhnfL9dSXrX//448TCp35LEUxfQedgK5X24QiRM1Ix
         2Nmg==
X-Gm-Message-State: APjAAAWGMKWjAj9679VpSBA3mrrJvoIPqbQvvSxCPV0Si4jituYGtHqn
        hxpqZkJzZu8Mo43TuRJLnEC74WncJnF/m/Fqv0bxlNyuSf0n5yRBhAa4ay0+fy9XaEPLdsa/cA2
        u3OVqdhEHsiDjyWpxnzvvzB6D5Uybsz3o7VnjHjZGvQ==
X-Received: by 2002:a2e:8315:: with SMTP id a21mr4754242ljh.133.1570683389974;
        Wed, 09 Oct 2019 21:56:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy074NwSC68d15vpYDMj4CmQOd5kqAOtBUwTFkuYJ5w5L2OC3C3LTQnOPqg+KMLwvdE5weYDp2K5PS//xB4CKM=
X-Received: by 2002:a2e:8315:: with SMTP id a21mr4754231ljh.133.1570683389789;
 Wed, 09 Oct 2019 21:56:29 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 9 Oct 2019 21:56:04 -0700
Message-ID: <CABvMjLRgShsBiod+GVcqirmKeFLN_KfxdDDwGo22YK0wULepwA@mail.gmail.com>
Subject: Potential NULL pointer deference in mm/memcontrol.c
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:
mm/memcontrol.c:
The function mem_cgroup_from_css() could return NULL, but some callers
in this file
checks the return value but directly dereference it, which seems
potentially unsafe.
Such callers include mem_cgroup_hierarchy_read(),
mem_cgroup_hierarchy_write(), mem_cgroup_read_u64(),
mem_cgroup_reset(), etc.
-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
