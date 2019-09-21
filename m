Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466C0C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 16:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1741E208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 16:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dy2DmS2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407775AbfIUQJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 12:09:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36362 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407764AbfIUQJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 12:09:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id k20so4304061oih.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nBi7HZ9yDa4JTOl5bhGG+3rVsUpAvLqUeab5GdL4x+0=;
        b=dy2DmS2GmQbZ27qbfn7yW9Ukr99IPJCkHsSkLjibCPoDEsD0fr2sfhru+qXSVGu0gE
         7gq3Mcg2Df/qk8iAGiKwbShet0jVjLXOoEKvGVzh1f7PQataZBKz9QBMoc7y3DyAWMAy
         KETS6WpMj2GyHz6yGdd5XRGlwGyjScWpj3nRSrT9awfLC0qtZZh6Dhhw+S8LaruP8MxY
         Y0dyFld+EoAX8bOZJYaYfXM1v5JJHWCr0HdovXOVuTSXX7fbSi47bwVbHqVknocjkYdM
         +0YmolBzt4hf0pPwhJaxb0aniqMrUIKSwxQFfHdln0WyWFiR2APdfxVvME/oo2BkLScC
         XCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBi7HZ9yDa4JTOl5bhGG+3rVsUpAvLqUeab5GdL4x+0=;
        b=EadxC/im0IwtEdt+QlW3Gy+sclA+2MGscPXfNMWthiOZwDMX36++wjZmMOciJdSnqj
         SfKBJI6eVcHTef5SzMB/Gp+O9wGFud62jYcbyD2hT55Vze3ypUBi90Bqd4rTwnL3C0wd
         eE5dminWJ0pgEadXSF/zboa/9phwwy/7KPW/fPKkmSV5ZqqAuO9p9FmtnPKu2z9RDJdk
         Jn7HocfNqLlDQvfvQrfMMFuuxg93YZ4CUjV1boW2dpBQ1vQjerV64cXiEb8R0nE50DO6
         XDqJozc9Rsq+mRNiQy0C5mt6iUA6HarlcENve1DiFIc0Ax6cGGhwgYU2O84c0b4YohQc
         bnuQ==
X-Gm-Message-State: APjAAAXYmnBnRfN0+53EBoEip0DVKBIw+x9hybuA3gfa7GB7QzVffxLe
        nfTX4PRoQm2UOlBRUHUuWFMvbrUEHqXHYekEq3dDGxh8rIQ=
X-Google-Smtp-Source: APXvYqxQJR7nyuTjwekOUNBLU1LMVXBipOYGs618Q3tTz6bwh88PeAaADZSsvcX6K0o09klXrzxLiVkXer0KaQYX5TQ=
X-Received: by 2002:aca:4b05:: with SMTP id y5mr7078977oia.70.1569082173661;
 Sat, 21 Sep 2019 09:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4g9TpgciDdVpQajSxEYTaHxB4+R9KWF0d=Emt9J7LkAqg@mail.gmail.com>
In-Reply-To: <CAPcyv4g9TpgciDdVpQajSxEYTaHxB4+R9KWF0d=Emt9J7LkAqg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 21 Sep 2019 09:09:22 -0700
Message-ID: <CAPcyv4jXamkc7ytxCw0R=9ZeXTBbifnZKQpHdLP0J04yfx0TBw@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm for 5.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 4:57 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Hi Linus, please pull from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
> tags/libnvdimm-for-5.4
>
> ...to receive some reworks to better support nvdimms on powerpc and an
> nvdimm security interface update.

Btw, minor conflict with your tree due to a fix that went into
v5.3-rc8. Here's my resolution:

diff --cc drivers/nvdimm/pfn_devs.c
index cb98b8fe786e,ce9ef18282dd..bb9cc5cf0873
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@@ -724,9 -751,10 +753,11 @@@ static int nd_pfn_init(struct nd_pfn *n
        memcpy(pfn_sb->uuid, nd_pfn->uuid, 16);
        memcpy(pfn_sb->parent_uuid, nd_dev_to_uuid(&ndns->dev), 16);
        pfn_sb->version_major = cpu_to_le16(1);
-       pfn_sb->version_minor = cpu_to_le16(3);
+       pfn_sb->version_minor = cpu_to_le16(4);
 +      pfn_sb->end_trunc = cpu_to_le32(end_trunc);
        pfn_sb->align = cpu_to_le32(nd_pfn->align);
+       pfn_sb->page_struct_size = cpu_to_le16(MAX_STRUCT_PAGE_SIZE);
+       pfn_sb->page_size = cpu_to_le32(PAGE_SIZE);
        checksum = nd_sb_checksum((struct nd_gen_sb *) pfn_sb);
        pfn_sb->checksum = cpu_to_le64(checksum);
