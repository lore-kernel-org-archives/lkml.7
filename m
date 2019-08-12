Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B561C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AFD206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rG0dFUj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfHLUgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:36:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41361 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfHLUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:36:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so39720788pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JmUZr7y0Vz2xdCv3h+uqvQ8rGr3KsFz2eHJHYMvJh/8=;
        b=rG0dFUj7rqFxLYUcS0Cl/+bBlfn0vxQ4HWngVOp21pFxw6lq/KzhhDSznW3J87rEMa
         dFAQl10nuUQwmCt9l6ekbkPPd2bFCzydLmUORfOuDM0+UaVEdaod420qe0IgaHsUqCCv
         ahUb/2XWujO52+WJhX0vBthKQUIYrR48hR12iJzIKEU/d6qXHx/wQZeHYg6+emIT6InX
         VL5suQAGwauW8UJRK5pcroiM1jD0zbTAmtme2prRjcEqMLvwELSZw0Cx5R2FxRDVpTLc
         rAkprfGc1K3fX92MGMI8mhRm9ViL/qJHidlqfIIPGjw1SJrKaZfDWvS+tVLevc9Iybxz
         lpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JmUZr7y0Vz2xdCv3h+uqvQ8rGr3KsFz2eHJHYMvJh/8=;
        b=E0/rJlofO49sGk6FhTWTwAHfjrd4MLaXRf7f9m279sefXnk0kHGNJe7PL1sA/U5V+h
         ixPg/+guw6YY1O0Hm0RDBO6PV58yPRIb+KNjHqFGTiveJrV8PlJ4dTQpzDGRoqaDLzP5
         TVuPmP2MhF+QZUE0Puz30VDgnCulDaNEwDVVZx9UGGWqMYbT5X4pD6M/9vHFz1GlGfKQ
         5bM8xAFxJAOfj09Wg/n3zeOtQe407TbM9Tf3mYyilfQkHFxiW5PpATvG9z2eVPUjALTr
         lWI+nlZKK2SJPUV0hr7tzKxo703JclB9PKsB9GgJOuOK/t+UwMXYVIPYFuN2D1/fk7C4
         lJwg==
X-Gm-Message-State: APjAAAUPftIu5vEVwgNBeNj6OWTIDuih1uSf/3rEz3LCWQF2Es1I+4/K
        0htnFOyD9keEn97xxTSMlhIfoQ==
X-Google-Smtp-Source: APXvYqyDaod1Q2sAKlRtRSeBrWfVVeu4bsRdV3UDrzaWFpPL3Qya8lka3ODeB7cFVNwLPTX48WepJA==
X-Received: by 2002:aa7:9882:: with SMTP id r2mr5141299pfl.146.1565642176946;
        Mon, 12 Aug 2019 13:36:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:f08])
        by smtp.gmail.com with ESMTPSA id m145sm9023428pfd.68.2019.08.12.13.36.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:36:16 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:36:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v10 6/7] mm,thp: add read-only THP support for
 (non-shmem) FS
Message-ID: <20190812203614.GB15498@cmpxchg.org>
References: <20190801184244.3169074-1-songliubraving@fb.com>
 <20190801184244.3169074-7-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801184244.3169074-7-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:42:43AM -0700, Song Liu wrote:
> This patch is (hopefully) the first step to enable THP for non-shmem
> filesystems.
> 
> This patch enables an application to put part of its text sections to THP
> via madvise, for example:
> 
>     madvise((void *)0x600000, 0x200000, MADV_HUGEPAGE);
> 
> We tried to reuse the logic for THP on tmpfs.
> 
> Currently, write is not supported for non-shmem THP. khugepaged will only
> process vma with VM_DENYWRITE. sys_mmap() ignores VM_DENYWRITE requests
> (see ksys_mmap_pgoff). The only way to create vma with VM_DENYWRITE is
> execve(). This requirement limits non-shmem THP to text sections.
> 
> The next patch will handle writes, which would only happen when the all
> the vmas with VM_DENYWRITE are unmapped.
> 
> An EXPERIMENTAL config, READ_ONLY_THP_FOR_FS, is added to gate this
> feature.
> 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Rik van Riel <riel@surriel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
