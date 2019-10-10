Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05142C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D146C206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="cspYgve0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfJJEph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 00:45:37 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:4024 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfJJEph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 00:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570682737; x=1602218737;
  h=mime-version:from:date:message-id:subject:to;
  bh=+Ge6RQ5EEbk2NFp4KXFfiQFXMowpb4uMY3rL+1ZBbVc=;
  b=cspYgve08Cs3OvAENJG0VVX/ZGgKqqM8cT64MUbqe46ykmrhJJk1CIC5
   tuZC4mrxTUmmemNXqtsaLsv9COl4eIjxoqtiTEUo6vr5dVaA+a+IbdNog
   FUwhPJFfQ/iXMr7/Ho6UxwX1DC0WNuR1MOyYBZjFj0uBD8XD6uGy9gYC4
   xlFHNzbbX+biKv6FWyA6kfwZEHHkIk8cHDJZCjUcjDN46FNSq3Zry3A9x
   7r7M9nQCvJmwDHdEHdl3xbw8yOPbs4xv11mXwzuvpVkGjVo6me6NCgRra
   ocn1uUlJUOYdwsuHV+3UfUqR1Uk+tCse35J+72Ju98lArCa0Voj9KYiRT
   A==;
IronPort-SDR: pu5PO8ZGJnqbt8TIqeSmueHM3D0dd6jsq1nJfaMGIg29BxaXPoH9GyjTw4zU8u2Bvhu9CTpxG5
 6Xhqj/RFuOE3sU1vEwpjtiVgB29MjQqIfPkiYD3UTi2Yl/0bpAhztA8x2tKTnL88H1mIYMuBfx
 eVXLBOzH5mdp1HK/LSptIn3a2OH4X7TyxNbMBQzgoQ/hcIaDuwLIl10FZjF4Od/FkIQkKCeiPB
 gcIVy6jBjeSLQSEpZ1MRbJzQsqFaD92u7PzP3ZqlfrsvttjihEi5Bdq25NNMwrUOli6gusOV+5
 tCQ=
IronPort-PHdr: =?us-ascii?q?9a23=3AArSaMxYbV88TFcaVYDmXC4L/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsq/bnLW6fgltlLVR4KTs6sC17ON9f66EjxQqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsrAjdqMYajIhhJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BMXCJDH4y8dZMCAOUBM+hWrIfzukUAogelCAmwGO/i0CNEimPq0aA41e?=
 =?us-ascii?q?kqDAHI3BYnH9ILqHnbrtT1NaYSUeCoy6nD0DbMb/NM1jf89YPFdRAgoPCMXb?=
 =?us-ascii?q?1qcMrd1VUjGg3eg1WNtYPlJSmZ2foQvGiG9udtU/+khW0/qwxpvDSj2sMhhp?=
 =?us-ascii?q?PKi48V0FzI6zl1zYUvKdGlTEN2ZdipG4ZKuS6ALYt5WMYiTnltuCY917IJp4?=
 =?us-ascii?q?a2fDMPyJQ73x7fbOGHc5SQ7hLjSumRJTB4iWpgeL2lhhay9VGsyun+VsWpyV?=
 =?us-ascii?q?pKoDdJn93Iu3wX2BzT7c+HSvR5/ki/wzqAywfT6uRcLUA1k6rUNYIhz6Yump?=
 =?us-ascii?q?YPtUnPBCz7lUXsgKOIakkp+fKk5/njb7jivpOcMpV7igD6MqQggMy/BuE4Px?=
 =?us-ascii?q?AOXmma+eSzzrzj8VHlTLhElfA2j7XWsIrAKcsFu6G5HhdZ0pw/5BanEzemzN?=
 =?us-ascii?q?MYkGEDLFJEfhKHkofoN0jNIP/mF/e/hUqjkDNwyvDYMb3uHI/NImLAkLj/Z7?=
 =?us-ascii?q?Z97VBTyA4pwdBY/ZJUBeJJHPWmf0j3tZTjDhgkOkTgxuHhCc5V044aXWuJBb?=
 =?us-ascii?q?/fO6TX5xvAyuUyLKGoaYMbvyzxY6wp4/Pig3gjlXcHcKWp1IdRY3e9SLAuAU?=
 =?us-ascii?q?yCZnykrcoHDWcNpBIzBLjoh1KqQz9ef3v0VKtqonk/CYS7HcLZSoWkqKKO0T?=
 =?us-ascii?q?39HZBMYG1CTFeWHjOgc4SCRudJay+IJMJluiILWKLnSII70xyq8gjgxP4vHO?=
 =?us-ascii?q?rV6zAe/avi3d49s//TlAAv8yVcBN/bzmqXCWx4gzVMDxQ20aZwsFE18VCF3u?=
 =?us-ascii?q?AsiOdfE9N77OgPTwwgc5PQ0ropJcr1X1fwf8WJVVHucNWvAHllX8Axyt5WOx?=
 =?us-ascii?q?1VBt64yB3Pwnz5UPcui7WXCclsoern1H/rKpM4ki6e2Q=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FRAwAmt55dh8fQVdFlDoZEhE2OW4U?=
 =?us-ascii?q?XAY1pijQBCAEBAQ4vAQGHFCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCm?=
 =?us-ascii?q?FQII6KQGDVRF8DwImAiQSAQUBIgE0gwCCeAWkQoEDPIsmgTKEDAGEWAEJDYF?=
 =?us-ascii?q?IEnoojA6CF4ERgmSIPoJeBIE5AQEBlS+WVwEGAoIQFIxUiEUbgioBlxWOLZl?=
 =?us-ascii?q?PDyOBRoF7MxolfwZngU9PEBSBaY1xBAFWJJFLAQE?=
X-IPAS-Result: =?us-ascii?q?A2FRAwAmt55dh8fQVdFlDoZEhE2OW4UXAY1pijQBCAEBA?=
 =?us-ascii?q?Q4vAQGHFCM4EwIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCmFQII6KQGDVRF8D?=
 =?us-ascii?q?wImAiQSAQUBIgE0gwCCeAWkQoEDPIsmgTKEDAGEWAEJDYFIEnoojA6CF4ERg?=
 =?us-ascii?q?mSIPoJeBIE5AQEBlS+WVwEGAoIQFIxUiEUbgioBlxWOLZlPDyOBRoF7Mxolf?=
 =?us-ascii?q?wZngU9PEBSBaY1xBAFWJJFLAQE?=
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="81371735"
Received: from mail-lj1-f199.google.com ([209.85.208.199])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 21:45:27 -0700
Received: by mail-lj1-f199.google.com with SMTP id b90so819825ljf.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 21:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=V6cjM2qh3lyKS09CLhQGgKKcyIxkLzht81qjdvHNaNU=;
        b=IAf9dtkNnWXcy9JOabbRNJdvXGG9kZj61/saYGvL68pizqJ2Paq0RE0WPX5SrVoOLP
         bj0Cbl1paPWO3ZRXdzXHsLZK6cijEaiixpB15CaREuV6oajl8UnOC5ZxTSSE0U/K+zVk
         kQuC8Aw23E/kWTwbbEsthOgaN496q3eon+dZOO7jgIBIbH09f4fi6jswwxX6750oRmLu
         3EhPrVzno18b7j2RwihQG+2ec9JUkWD8UkkBbzFjmY4XFzwwenC5QKW/AwVwli6vPTt6
         /Rygz3tcYHIsgBg0zdaK0PNGp9eQjRYxVhqu/OB/3LjlXtt1dOedaltD4SDZLFEwMNNP
         CKxQ==
X-Gm-Message-State: APjAAAWMx8uVVAPx6WKGMG+DWMvcrDKHe3wFvc4yctm2lNkiclu+ani2
        R/naoyBvNuJpxsWt9j1NhcLUQGB9Uq0hCnXZtd2Wr4jstq/O9x486FTqxG31SYVsRXluHby+YwD
        M8FEm+uIFGkyGjyZLDln9pYfRtH0U86XccFpZf9keUw==
X-Received: by 2002:ac2:4845:: with SMTP id 5mr4293577lfy.191.1570682724810;
        Wed, 09 Oct 2019 21:45:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw1x9AZgLV+61XMXXlIC+oLuJtWCWzXpz8VHNyPNzHXul+5fsFjuz78wD6ofpSibIsZLzZdbbAZUx6k7PFAKRM=
X-Received: by 2002:ac2:4845:: with SMTP id 5mr4293560lfy.191.1570682724585;
 Wed, 09 Oct 2019 21:45:24 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 9 Oct 2019 21:44:58 -0700
Message-ID: <CABvMjLTZ3ztSR6XkHa94iLTnHDK3-P3wRo+31UdivSMavzeq4g@mail.gmail.com>
Subject: Potential NULL pointer deference in RDMA
To:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:
drivers/infiniband/sw/rxe/rxe_verbs.c:
The function to_rdev() could return NULL, but no caller in this file
checks the return value but directly dereference them, which seems
potentially unsafe. Callers include rxe_query_device(),
rxe_query_port(), rxe_query_pkey(), etc.


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
