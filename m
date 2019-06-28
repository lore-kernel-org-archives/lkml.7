Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229A0C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0F62133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="D1ToJybd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfF1Qdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:33:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40014 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfF1Qdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:33:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id e8so6547890otl.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5XhcDU6eHDsjHZSBvruupbGEAPLyXEBQaVgsJASp/M=;
        b=D1ToJybdEnzma0OsziYT5+nxDaSkNPJrp7CNsMBtITOLU9+/6mSU8iSJzl0odLczf6
         J+NJ1U3WVt6iz4ZNtK7O4B+I6SwhPHdmd0LCP3FM9Q7M8PpdCLD3yCikHMF8JisbHojD
         8KdWhr837Jg14qpnK2c26np5bgqk4Sdt9wQpeW52XG/+opLeMhyE5Zeknlc5DM7hM1vd
         gJXR5dqR48+7h+PE8PF0EAZtcQGoyieYya5bpdNretH4jGkw3uFBm3qz/4rEkogPFffJ
         I8zmVSNFi8wJTP08HjuI3oB0cMcDmI8+DeCY4U9/lHmynz1ISjtE4qtidP1lMsdP9lD1
         2zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5XhcDU6eHDsjHZSBvruupbGEAPLyXEBQaVgsJASp/M=;
        b=B2LJ9X+WQ5OM6aZkNyk/pkqbysveftYK5uteMMOXqzZOw587KoJ7MdHDLLKLnpYTUj
         NCxBVuARmbEMHA12ceKnonVD4vaGnzri3206KUCMLyBs2BUIFVjQGnzFFFy96jLQdxni
         jpCF+dbU0gymnTgTAU6BV4TERoLlY85XXK9InL4lALGFScZ5uLdZa5n9Lqf3QISTe717
         c5CFxjkb2JCj4krVWT9T2aWETApmLyTgBOlpq766dNwfNO7tLE3Bmket1qvc+5+5KX+w
         Bu5Oaacn6wcnwzSwJjGKn4kdCIAB2L/rGepoZBsyKiteP5taIM15xs73OIX/I2ZP0pJl
         FODw==
X-Gm-Message-State: APjAAAWVlXZSEJv+bKTLwMrTGR9BjQ145+pN+FKIotcjyqmFui16P9ON
        jpyeArLM2RTkthRIggvheI6NMdtUnXhYsW1mLq7K92pv
X-Google-Smtp-Source: APXvYqzzYpdHgz4eglyne1uwTiVU7YP+ALyFG4sJtW5FcR4KUORfrVfDmiYmCAAGckLspi0ARU5vSc0QNvBcZT5BUKc=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr8593114oto.207.1561739630274;
 Fri, 28 Jun 2019 09:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561724493.git.mchehab+samsung@kernel.org> <bd756f3565213887a1fe82a382f7dfe7f9119f1f.1561724493.git.mchehab+samsung@kernel.org>
In-Reply-To: <bd756f3565213887a1fe82a382f7dfe7f9119f1f.1561724493.git.mchehab+samsung@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jun 2019 09:33:39 -0700
Message-ID: <CAPcyv4jGcXEvqYZ5aE1QUCd-zeJ8cO=yGtjcwGbYd59A+6FYxw@mail.gmail.com>
Subject: Re: [PATCH 04/39] docs: nvdimm: add it to the driver-api book
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 5:30 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> The descriptions here are from Kernel driver's PoV.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Dan Williams <dan.j.williams@intel.com>
