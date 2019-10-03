Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F75C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362AD222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="j3MiQ+sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfJCLCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:02:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39649 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfJCLCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:02:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id a15so2043430edt.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2yr0v9T8YeaaTatF75tYCF7LKBpK+bmv6hiDMUW5HMs=;
        b=j3MiQ+spuIixpMTCuFWJg5r+P0mU4h1/50zeP/MX/3xA/u/FlgZn96nR6SghMXoebG
         u8T88+aeUpJDVPQxUrzRIWq2auwDcYLwQQrwkEwquVpRb3Oez18pnd3uXcAfypmQ8oYB
         JVyQhw6zflogMsiitL7VDEtYZFiFC56jzzVK33qUdzJegN8ujS8/OA4dvjvm+9hOcmfa
         9e+RWVn+35pxabziZXtdsV/9M20BZgoigeZDyacArnReXFyqWGXX1U7LHsY/sz3QO/3r
         MtZ/EsI70QcdaJFpD9t2kzgON2tLP9fD+B9UzXIV1ntfoB5wzec9ldWWtXCKuhppCcA2
         jlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2yr0v9T8YeaaTatF75tYCF7LKBpK+bmv6hiDMUW5HMs=;
        b=Bv5zJ/qsV/AfMeRj62/XXrnjJrF6DzqNs0LJ/+lqHWSSqNJKrk6+gXpuy1jGFtLn7V
         c4U/BQlq2nFedmLvSdxACWsEDFJHu47r31jVN1AIgIQOCb223vtFcotcRGXS3LxOIKIV
         j/o84ajRelj+0PQiPs+ifU279KVI/hpUfga34Yx7MTWP5e/i1Fsb9eE6yX+bU6kHBEOb
         ZBPFJlv9Of1A4KrdZGAeQevrtGuXDeD8lrFlVlWxNewuXMW5wKuLZphCX5diE9Wsn8av
         uNv4AtFqc6qWuq2CohGIJ+I0gCr1N5y0CqoaYvs8F3PmXBtQSi8sCdRgTnH0PjsSdxJH
         W3yA==
X-Gm-Message-State: APjAAAVGC0x51wigXUPoMDwn5JPJ3EdHPQ4od8bQf1knr2JDVQ6m5AkB
        S6PHHJEi0zlXMDv8UudxcQm4UPCSAEMi+Q==
X-Google-Smtp-Source: APXvYqy+QWEEIgbVQAodYl+ftjM1HBFJ1R08+8l0ilUCkgY1I2L0f65weTelyk44C89o8KMG8zuR4Q==
X-Received: by 2002:a05:6402:184d:: with SMTP id v13mr9020898edy.56.1570100551931;
        Thu, 03 Oct 2019 04:02:31 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a3sm404503edk.51.2019.10.03.04.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 04:02:31 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 499B9101174; Thu,  3 Oct 2019 14:02:32 +0300 (+03)
Date:   Thu, 3 Oct 2019 14:02:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v3 1/7] mm: Remove BUG_ON mmap_sem not held from
 xxx_trans_huge_lock()
Message-ID: <20191003110232.mltuantcw5pcrybo@box>
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-2-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191002134730.40985-2-thomas_os@shipmail.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 03:47:24PM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> The caller needs to make sure that the vma is not torn down during the
> lock operation and can also use the i_mmap_rwsem for file-backed vmas.
> Remove the BUG_ON. We could, as an alternative, add a test that either
> vma->vm_mm->mmap_sem or vma->vm_file->f_mapping->i_mmap_rwsem are held.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>

The patch looks good to me:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

But I looked at usage at pagewalk.c and it is inconsitent.  The walker
takes ptl before calling ->pud_entry(), but not for ->pmd_entry().

It should be fixed: do not take the lock before ->pud_entry(). The
callback must take care of it.

Looks like we have single ->pud_entry() implementation the whole kernel.
It should be trivial to fix.

Could you do this?

-- 
 Kirill A. Shutemov
