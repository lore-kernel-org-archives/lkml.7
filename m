Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEFBC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B45921850
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="J6E7gPFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391260AbfEXRCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:02:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33227 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390532AbfEXRCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:02:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id 66so9352713otq.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uxIEMvL9NPIZt76HNNKGot2fHQFb8ScQQVFnfVEGVdE=;
        b=J6E7gPFqhGjQkK6F3GbGp2bqy4JZqM2JGDp4Q4363sxZZKkY1eebXwTOzadjVyNxa/
         AwEmFnD2OnTGLyCOsb4EVByimH7YKeH+ofbH0xOkO83ECfI0kA1wzco1g7dCyhxMmqn1
         lAjQLIEU87kbYcXgUjMEft09EG/s78/uSMvtXR561r30xuSwzTQgeEs/f23iRNxDK0Oq
         iv1DfXdnUJiXSNllUJOnrj1nEQzbEEh613meCgyIzDBkPavcXHBSW8mDbIRUarQv5EPB
         dh51oEmUu1WNnPiJZf+vDq4g8Yp9QXZQJUaZzJ7lJ/aNehbHAk4st7jpd1AxQslcrFO3
         kCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxIEMvL9NPIZt76HNNKGot2fHQFb8ScQQVFnfVEGVdE=;
        b=VR3Xsk4Xe2nx1DSVe/7CoRxwi6PR+3fK6Zov7lBXNWfGt3OKsbwUwVLvk2O1hoj64E
         Nap8+u5E09boEOdC56QJDFep2dv+JTNr7cST9o3Kuek3J7i7Qc8uSkF4qlP1zn7XSdlc
         fkecWnVjsuP5HrxU9kxa5xybyXSWlngxOh82qnRXHfFstLvEdgRreane359WhSDtKHWa
         YPu1fOXjhIGEu4ws3udB2QKhEEf5j/oL0gl04ATqKupCXAzDt7CxZbcNp1KuhSiq+ICK
         Yj3HUnpUy/XPLktbx0ChysPI+BlLf697uE7pTZc7zF/Rj8ZtwPbOGVvr3CULUOdjmxkJ
         jXqw==
X-Gm-Message-State: APjAAAWu+Z+cck6ya/cGHgKt6TNa8Znld4R8J5dm6XRGd8k4zFnnf2e5
        iOaNJdyM/89w5YzuREZnsgsOJsxjn/15krV6JfEHkQ==
X-Google-Smtp-Source: APXvYqxVRQpBpCep9TCI1kPQh1cOH82JFn3Gk+gMokzzTN7nj9KB6DFm/LKWbO3WZKAfI141c5e4MkYQ3VfCFR+tiNo=
X-Received: by 2002:a9d:2963:: with SMTP id d90mr14793834otb.126.1558717336323;
 Fri, 24 May 2019 10:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
 <1557417933-15701-3-git-send-email-larry.bassel@oracle.com>
 <20190514130147.2pk2xx32aiomm57b@box> <20190524160711.GF19025@ubuette>
In-Reply-To: <20190524160711.GF19025@ubuette>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 24 May 2019 10:02:04 -0700
Message-ID: <CAPcyv4hkocsPQLQ6sfF8SuwVoot_uXge_bTZtuM-6f4XxwFVhg@mail.gmail.com>
Subject: Re: [PATCH, RFC 2/2] Implement sharing/unsharing of PMDs for FS/DAX
To:     Larry Bassel <larry.bassel@oracle.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 9:07 AM Larry Bassel <larry.bassel@oracle.com> wrote:
> On 14 May 19 16:01, Kirill A. Shutemov wrote:
> > On Thu, May 09, 2019 at 09:05:33AM -0700, Larry Bassel wrote:
[..]
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index f7d962d..4c1814c 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3845,6 +3845,109 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
> > >     return 0;
> > >  }
> > >
> > > +#ifdef CONFIG_MAY_SHARE_FSDAX_PMD
> > > +static pmd_t *huge_pmd_offset(struct mm_struct *mm,
> > > +                         unsigned long addr, unsigned long sz)
> >
> > Could you explain what this function suppose to do?
> >
> > As far as I can see vma_mmu_pagesize() is always PAGE_SIZE of DAX
> > filesystem. So we have 'sz' == PAGE_SIZE here.
>
> I thought so too, but in my testing I found that vma_mmu_pagesize() returns
> 4KiB, which differs from the DAX filesystem's 2MiB pagesize.

A given filesystem-dax vma is allowed to support both 4K and 2M
mappings, so the vma_mmu_pagesize() is not granular enough to describe
the capabilities of a filesystem-dax vma. In the device-dax case,
where there are mapping guarantees, the implementation does arrange
for vma_mmu_pagesize() to reflect the right page size.
