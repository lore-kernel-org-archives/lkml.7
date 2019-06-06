Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDB7C28EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6872083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="W6owKkia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfFFWGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:06:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34701 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbfFFWGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:06:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id z24so67652oto.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 15:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EIr4OnOI1xF9wai5ier5nmSpwnMBcVJFFbPwhyrlfw8=;
        b=W6owKkiaiucLtIk2d/rhThge65YAuZhOXdGbJAq1YJnZeuj3agBqhdzoWw4pAHpEGG
         yCCRRgubBcq/P+3tO+QxBLrGvQWm34ZFjVhCGGnC25tsI1wz0ookadExgISatwc+xFwx
         9F3A1KcbDxhZpKNcMECopMoti2uf29JMv8oNXtACIP4ZdnAKSAeFcKK0Z75QstHVe1Kk
         FSNS/e4ugOpcEKATo1xHjQe71a839vKxrezJgS4nSTbtKrDnRK96iahNefKSCqeqIl7K
         GpNADCiQeyijYdm/jA366lM8s7uLcFJlrvqzsE5Q567T+TEojZQ525tKJu3IpPIztD1S
         rFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIr4OnOI1xF9wai5ier5nmSpwnMBcVJFFbPwhyrlfw8=;
        b=PPdToR9COdZh67ky5ACdzmVBuJabz7ibV2JeCIo/vFMyWLZ95igzlcfx6RAsQDhfyy
         DZhMQxYWJ2Kr5D2RxbWypEXp0PwVHHaKx19oMAQSWE6KMEnqLkI3J6D7aODmQxRTpXvc
         6VhSiU7n9MA8NSmMsaUjKD+2flG3xvhU9tUl6QGIiYerUbXesJ/3t1KQ/RNV3E8JnwRh
         cfRwFF1zHj31conh0BEC9VTzRK4V4zjMMIh6rIwDyCtSUTVpEM/xlRQ8vqPQreOQynAz
         CCbYpkyM0c3lWDfmbZYavMrKSVYqGJQFCNZT0KYYpZWTFptVAFZ/KSwYg4Oh5AKxVRvv
         oYlQ==
X-Gm-Message-State: APjAAAURDPFP08GhmjDB7TSozQnz+SSGnlOyKoeqjvLKq1KYEzPY4pqF
        OLY5UWRGazSTHCSbCTUzx1gNH388Rw3wOmcIU+PNEA==
X-Google-Smtp-Source: APXvYqycw+T+CReJfdLZE2qHIqv0pPOCCdRZcOCC2XXW8oc8RYjE0NVBkRV9yjOJGx4MnVYldEDTHY2D/nu9EblRWvQ=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr12110810otn.71.1559858798146;
 Thu, 06 Jun 2019 15:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977193862.2443951.10284714500308539570.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190606144643.4f3363db9499ebbf8f76e62e@linux-foundation.org>
In-Reply-To: <20190606144643.4f3363db9499ebbf8f76e62e@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 6 Jun 2019 15:06:26 -0700
Message-ID: <CAPcyv4hHs75hYs+Ye+NHHiU31C6CnBqCFdo=2c5seN7kvxKOrw@mail.gmail.com>
Subject: Re: [PATCH v9 11/12] libnvdimm/pfn: Fix fsdax-mode namespace
 info-block zero-fields
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 2:46 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 05 Jun 2019 14:58:58 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > At namespace creation time there is the potential for the "expected to
> > be zero" fields of a 'pfn' info-block to be filled with indeterminate
> > data. While the kernel buffer is zeroed on allocation it is immediately
> > overwritten by nd_pfn_validate() filling it with the current contents of
> > the on-media info-block location. For fields like, 'flags' and the
> > 'padding' it potentially means that future implementations can not rely
> > on those fields being zero.
> >
> > In preparation to stop using the 'start_pad' and 'end_trunc' fields for
> > section alignment, arrange for fields that are not explicitly
> > initialized to be guaranteed zero. Bump the minor version to indicate it
> > is safe to assume the 'padding' and 'flags' are zero. Otherwise, this
> > corruption is expected to benign since all other critical fields are
> > explicitly initialized.
> >
> > Fixes: 32ab0a3f5170 ("libnvdimm, pmem: 'struct page' for pmem")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> The cc:stable in [11/12] seems odd.  Is this independent of the other
> patches?  If so, shouldn't it be a standalone thing which can be
> prioritized?
>

The cc: stable is about spreading this new policy to as many kernels
as possible not fixing an issue in those kernels. It's not until patch
12 "libnvdimm/pfn: Stop padding pmem namespaces to section alignment"
as all previous kernel do initialize all fields.

I'd be ok to drop that cc: stable, my concern is distros that somehow
pickup and backport patch 12 and miss patch 11.
