Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB17C48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3330205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="TEa6RtLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfFXOyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:54:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46351 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfFXOyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:54:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id d4so22143148edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JQKwzZzBKlwQ+GJcTJXniJHeeWGAGIRp9LxyTrF6c7w=;
        b=TEa6RtLeTmBGp82xwRDf+v4B/mbgMCa1ukkDRBoDCFWuekkzUvLEhP9StjpXQsD32p
         EO8YXGJR1q79xVvaiZsfbkVWI1obKLoqEJSR0thzI605NpIL/WEYUunrk+/KYbqptWNq
         q6TzCS+oJiUn+xtxjMylWBJyIZZ9N97TEIAbC61s8Op5BGrb4EidBKQTaFnSMOvqe/WP
         VlTzBnFUk9aIJohzFF2v1eryC6+d4hKpOmTK98Zb+rdhe+1fIu4K6jAdGpYp9zOj4edg
         JHPgXiM/BXdR4tzQr498EpVUJocjyiNrbE1ByohItU9px/lzfUvdL6tJXMHAd+FVEKgq
         B3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JQKwzZzBKlwQ+GJcTJXniJHeeWGAGIRp9LxyTrF6c7w=;
        b=MMCuS3EyvDSwF+FqaSHzJ3YY3EOOoaTKFTPx0IBZbsVMDCJLFdXN2OUvXJoAttmeoW
         BpNg8d+i9+tqIK4MYwmPM3YHt/M980C+ORg5mJe68kG3MMhkGdxWXyddLOwcDXnbSaLz
         p0l0zKpBiLNJ/pRwVuXsIyJrk15lOFHpxAEVaQ6QzOE6+NQFRGdvmj2kVyWf0axM2t7w
         z3sdALTThzSEkeKQuGusXnQM3slyAbLGozVlbpGb66Oxb5QIWex+pyt9G5W0+iSmsLBc
         nvNg1mQ6ovLAjpR8RPYsVq2Tt6C6KSZkANOI96J7neLUn5Ce3kZ4Q71s6Jb8Y2rm0CtF
         TQgA==
X-Gm-Message-State: APjAAAUvTG9f+/AeV/fsz+AJhnRM6s0w3x9noxroEaRjCY0myhMgxcWr
        1tGxYXhy1/Hj7rwrPxsb3yM43w==
X-Google-Smtp-Source: APXvYqwpr/VG3RXa+GEBk10H3MUxE0Vu79XPyJZVrItMjUzVoSUnCSoiB5NZP13/iLswEhQVhC+FoQ==
X-Received: by 2002:a17:906:24c2:: with SMTP id f2mr10410756ejb.233.1561388088581;
        Mon, 24 Jun 2019 07:54:48 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q14sm1981165eju.47.2019.06.24.07.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:54:47 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6887E1043B3; Mon, 24 Jun 2019 17:54:53 +0300 (+03)
Date:   Mon, 24 Jun 2019 17:54:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hdanton@sina.com" <hdanton@sina.com>
Subject: Re: [PATCH v7 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Message-ID: <20190624145453.u4ej3e4ktyyqjite@box>
References: <20190623054749.4016638-1-songliubraving@fb.com>
 <20190623054749.4016638-6-songliubraving@fb.com>
 <20190624124746.7evd2hmbn3qg3tfs@box>
 <52BDA50B-7CBF-4333-9D15-0C17FD04F6ED@fb.com>
 <20190624142747.chy5s3nendxktm3l@box>
 <C3161C66-5044-44E6-92F4-BBAD42EDF4E2@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C3161C66-5044-44E6-92F4-BBAD42EDF4E2@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 02:42:13PM +0000, Song Liu wrote:
> 
> 
> > On Jun 24, 2019, at 7:27 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > On Mon, Jun 24, 2019 at 02:01:05PM +0000, Song Liu wrote:
> >>>> @@ -1392,6 +1403,23 @@ static void collapse_file(struct mm_struct *mm,
> >>>> 				result = SCAN_FAIL;
> >>>> 				goto xa_unlocked;
> >>>> 			}
> >>>> +		} else if (!page || xa_is_value(page)) {
> >>>> +			xas_unlock_irq(&xas);
> >>>> +			page_cache_sync_readahead(mapping, &file->f_ra, file,
> >>>> +						  index, PAGE_SIZE);
> >>>> +			lru_add_drain();
> >>> 
> >>> Why?
> >> 
> >> isolate_lru_page() is likely to fail if we don't drain the pagevecs. 
> > 
> > Please add a comment.
> 
> Will do. 
> 
> > 
> >>>> +			page = find_lock_page(mapping, index);
> >>>> +			if (unlikely(page == NULL)) {
> >>>> +				result = SCAN_FAIL;
> >>>> +				goto xa_unlocked;
> >>>> +			}
> >>>> +		} else if (!PageUptodate(page)) {
> >>> 
> >>> Maybe we should try wait_on_page_locked() here before give up?
> >> 
> >> Are you referring to the "if (!PageUptodate(page))" case? 
> > 
> > Yes.
> 
> I think this case happens when another thread is reading the page in. 
> I could not think of a way to trigger this condition for testing. 
> 
> On the other hand, with current logic, we will retry the page on the 
> next scan, so I guess this is OK. 

What I meant that calling wait_on_page_locked() on !PageUptodate() page
will likely make it up-to-date and we don't need to SCAN_FAIL the attempt.

-- 
 Kirill A. Shutemov
