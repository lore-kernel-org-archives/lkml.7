Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D88C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E522173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBB0oY7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbfDQTdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:33:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38188 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731927AbfDQTdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:33:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so7135pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HdZ2rAJcnY1L+PlHybMWMLk6Tu+139i4qxa9kcwwLRY=;
        b=GBB0oY7nLKBYICxo+e0cpdrV4hT8uP8TCpOLeNXdQ4SvQ3yraeyc6WhyWjJ1izWZuX
         CTBbOs9qYyPkxWR3pbXjWsE8oMNQLC/uJLilAmJCgWrALbr7hMF7ptMu1RNQ2WSbHbmu
         bwx+KbLgzVSCsc+KHE13mkCJDTCx1Asok/lfIQz1gh4yUVSv1yF1rODoAcSfVRnk9BXt
         5Vg8isxL+9wo2dbf4Nmhoc7GvkBbym2hl28B9Pcp2kDo6+vrpV/OLuWHw/jcydbm51Nf
         e7yJFT+zeazbAMQxnAmcL1WmRStMPA8atTaUo/QtfJc49Dx6PLSMjzIbX7biu0rQNHgi
         d4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HdZ2rAJcnY1L+PlHybMWMLk6Tu+139i4qxa9kcwwLRY=;
        b=Z/SgJaV9gZbSHbyZLe2yVV7rmIgfGlCzuhcp4pJ9W5c6GhRt77Dhb/XQiJ/VJas0r7
         8iaBq/Zm5XMF1cs32mnyfmdhicvSfWIDOCsgD8hZ95+crdUL6QaoAPpKIXVrty0O+DNH
         HFRbRvZtoCPo/rBgPqFAj3Zl7I+iZOaZAcQGIVWjfzDJ4UMKVwIxFAD+zytmzBG+HJFy
         3Inv0k0UYvwNix+yj/IBay/bShcq75Q59LjCAL6Oudb6HP6BD1v60kSxvbGlyWN0NC1d
         6SRU5wZmaCmvCCMyJQkekafEbu/EtOyrd7hoeH4DUvnA8QGwWWn88x+AfN2BbpNWjoGe
         qGbg==
X-Gm-Message-State: APjAAAXE3TnQ3TzP9KiDe47/Q8Y+s9t4v6dXqnhX//nOsC9at7kREMMH
        C2KjGzYX46UYIIsoHdYTFr4=
X-Google-Smtp-Source: APXvYqzndDzcZGVaxF0yxPMOkxfFZ4l16pNP7oSkOxU266QICB04Q5V78QIYK7O8LFL1bWgTSYyjvQ==
X-Received: by 2002:a62:2687:: with SMTP id m129mr90117426pfm.204.1555529618322;
        Wed, 17 Apr 2019 12:33:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k9sm75859983pga.22.2019.04.17.12.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 12:33:37 -0700 (PDT)
Date:   Wed, 17 Apr 2019 12:33:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/hmm: kconfig split HMM address space mirroring from
 device memory
Message-ID: <20190417193335.GA23825@roeck-us.net>
References: <20190411180326.18958-1-jglisse@redhat.com>
 <20190417182118.GA1477@roeck-us.net>
 <20190417182618.GA11499@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190417182618.GA11499@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 02:26:18PM -0400, Jerome Glisse wrote:
> On Wed, Apr 17, 2019 at 11:21:18AM -0700, Guenter Roeck wrote:
> > On Thu, Apr 11, 2019 at 02:03:26PM -0400, jglisse@redhat.com wrote:
> > > From: Jérôme Glisse <jglisse@redhat.com>
> > > 
> > > To allow building device driver that only care about address space
> > > mirroring (like RDMA ODP) on platform that do not have all the pre-
> > > requisite for HMM device memory (like ZONE_DEVICE on ARM) split the
> > > HMM_MIRROR option dependency from the HMM_DEVICE dependency.
> > > 
> > > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > > Cc: Leon Romanovsky <leonro@mellanox.com>
> > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > Tested-by: Leon Romanovsky <leonro@mellanox.com>
> > 
> > In case it hasn't been reported already:
> > 
> > mm/hmm.c: In function 'hmm_vma_handle_pmd':
> > mm/hmm.c:537:8: error: implicit declaration of function 'pmd_pfn'; did you mean 'pte_pfn'?
> 
> No it is pmd_pfn
> 
FWIW, this is a compiler message.

> > 
> > and similar errors when building alpha:allmodconfig (and maybe others).
> 
> Does HMM_MIRROR get enabled in your config ? It should not
> does adding depends on (X86_64 || PPC64) to ARCH_HAS_HMM
> fix it ? I should just add that there for arch i do build.
> 

The eror is seen with is alpha:allmodconfig. "make ARCH=alpha allmodconfig".
It does set CONFIG_ARCH_HAS_HMM=y.

This patch has additional problems. For arm64:allmodconfig
and many others, when running "make ARCH=arm64 allmodconfig":

WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
  Depends on [n]: ARCH_HAS_HMM_DEVICE [=n] && ZONE_DEVICE [=n]
  Selected by [m]:
  - DRM_NOUVEAU_SVM [=y] && HAS_IOMEM [=y] && ARCH_HAS_HMM [=y] && DRM_NOUVEAU [=m] && STAGING [=y]

WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
  Depends on [n]: ARCH_HAS_HMM_DEVICE [=n] && ZONE_DEVICE [=n]
  Selected by [m]:
  - DRM_NOUVEAU_SVM [=y] && HAS_IOMEM [=y] && ARCH_HAS_HMM [=y] && DRM_NOUVEAU [=m] && STAGING [=y]

WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
  Depends on [n]: ARCH_HAS_HMM_DEVICE [=n] && ZONE_DEVICE [=n]
  Selected by [m]:
  - DRM_NOUVEAU_SVM [=y] && HAS_IOMEM [=y] && ARCH_HAS_HMM [=y] && DRM_NOUVEAU [=m] && STAGING [=y]

This in turn results in:

arch64-linux-ld: mm/memory.o: in function `do_swap_page':
memory.c:(.text+0x798c): undefined reference to `device_private_entry_fault'

not only on arm64, but on other architectures as well.

All those problems are gone after reverting this patch.

Guenter
