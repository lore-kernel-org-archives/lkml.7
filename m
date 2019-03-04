Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E71DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11D4206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfCDVX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:23:28 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34619 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDVX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:23:28 -0500
Received: by mail-qt1-f196.google.com with SMTP id w4so6778034qtc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 13:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24k8rj5UTmUkT63HVuPN119nt2Rc7xNcBxmTuFPY2Yc=;
        b=rYvqQDL82vKjoSLV2i69akhUS//HdW7XopzzYppy6gXGbKAZ5YzCL6ZUog9NdHfYln
         +xXcODOHFCUXlai8ytrCi0kMPSKKPa0swAvy7bq5bfaMY9exokjfnXsH6QbOAXtPLQB3
         0nbB39szXtEx9Sur/r8++1VVOE4Ah926FUuTgc0uRayGK5zMDOzyXvR/rH6MKoKPD+aa
         m3KT8j5P9joKhLEOmdVwd+r1wPRiil88/Hasg7sWsPWgrFS5fgbKmr13NUZtmmKRsG17
         nDmTBts/bgltUo7uo3dw47J3lUYd/iO7wG+EUCBNrmEtc+ZxJ7YoRhkQ+CSxI7HPpzkG
         7YiQ==
X-Gm-Message-State: APjAAAWDo9XWA/O0FVPlFNY179mkG9BEBVV8ooAbJDxl7Iuy8RDQr/a0
        jyh5zkLC7V8zng8Ph4B0N7vyuGeRdqv92n5+/2Q=
X-Google-Smtp-Source: APXvYqzxTXLA+QxQZi9csv7TqCIuf8IG5+atXgd+LjGxkQLhD5l1B6MWju0G0t3EVP5Og+U/wjRW2hP/cdBJb68LRvU=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr16064917qtb.343.1551734607474;
 Mon, 04 Mar 2019 13:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20190304204826.2414365-1-arnd@arndb.de> <7b1ae554-8d23-a282-4175-37e6743d0290@oracle.com>
In-Reply-To: <7b1ae554-8d23-a282-4175-37e6743d0290@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Mar 2019 22:23:11 +0100
Message-ID: <CAK8P3a1NXXNBUzb7tHtF6ohCcR+_rFhxXSd3ziSmnkhg7bdrpA@mail.gmail.com>
Subject: Re: [PATCH] xen: avoid link error on ARM
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Matthew Wilcox <willy@infradead.org>,
        Paul Durrant <paul.durrant@citrix.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 10:19 PM Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
>
> On 3/4/19 3:47 PM, Arnd Bergmann wrote:
> > Building the privcmd code as a loadable module on ARM, we get
> > a link error due to the private cache management functions:
> >
> > ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
>
> Can __sync_icache_dcache be exported in arm32, just like it is in arm64?

Russell wants all cache management operations to stay private to the
kernel, as they tend to get abused by other drivers:

https://lore.kernel.org/linux-arm-kernel/20181218100908.GL26090@n2100.armlinux.org.uk/

      Arnd
