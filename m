Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AC4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ACF21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH8NebHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfCVVau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:30:50 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52341 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfCVVas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:30:48 -0400
Received: by mail-it1-f195.google.com with SMTP id g17so5760219ita.2;
        Fri, 22 Mar 2019 14:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wgnh9GZfm6qdLmvZgnj3r3+BNlXkGOKn5T8ZaWKJok0=;
        b=OH8NebHDunzRV5JGQub2VtJ7qq4h4earirMR6lyAD1tbndqgaSQo6EHAFa1XOmj0Gs
         dVcO4mHB+I8Gzjx2PQQrJytnVorWQ136649AIwDqb+OrY0aZhZe/CAiDgikXseWKBQG2
         FkOiYPQ3ReZiCpOVfobxEopPeTsjWAbW4arVQm7GeTBum/QFo7st3RTKFW/k4BUo6iKi
         qqrOWnIunmKP+BcjLSDh5OjjWDpxn9ZH3R47GB9vvFeHXdgr8SGbrbJmFBbpxMtnf7r8
         gcRkEbTPG+V6sm+ujH2atRnCWCKSY69YXpLKQ3Gjo/8PWZNT9d+9uu3qs6PBsKPI7PrA
         gBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wgnh9GZfm6qdLmvZgnj3r3+BNlXkGOKn5T8ZaWKJok0=;
        b=gSYVd7QQ7qUNOQk1UmOSPTx7+XVdPmw6TYPnji/x9/rxOceC+Af6Ldc0R5ZyklR0M1
         K8n0cyFd3WWkfPfU5m3vK7W0pTk3Ogtux/YTffOff0m6vEYWj9DofzgCoR650ZhhT78I
         +1bbwbC6q7RpR/ps/c4PNaAvnXTTW0smYW0ETZntt0sHMw3NVAwHETWZs9KNeF8Jt8OI
         GcFz5MZuc4IhfgRirZaJITjF1w2mrDlj4bNBURfPmcFuy3EPbU8nuHsYJuoxlYdsc3gy
         OpRRNOwy6vFEZt/eIuK1RpR0UIEJx39EaBWgrSqmjxLFzCQL3i+L0pDdLNId8j9Jcuoh
         mW8w==
X-Gm-Message-State: APjAAAWg12cdImdBIwyTYzBZyrCTAAg5ziNGxktx9eyiVwR5qufW5Rh2
        9RfRQ68sCcnkzDOHzdkkMQAL2q+uk1G2MZW1ri8=
X-Google-Smtp-Source: APXvYqwmWYd90xIyw8yRh2ooXx60Z7HEDF1dbzChi7O8iR8by0Ikm8lKRK2GZFAQJ/A+sEyAwZAwm0xNODtGjD6Sum4=
X-Received: by 2002:a24:21d5:: with SMTP id e204mr910352ita.56.1553290247101;
 Fri, 22 Mar 2019 14:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com> <20190317183438.2057-3-ira.weiny@intel.com>
In-Reply-To: <20190317183438.2057-3-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@gmail.com>
Date:   Fri, 22 Mar 2019 14:30:35 -0700
Message-ID: <CAA9_cmcs+kUMA=j2UYwSRpEo+NMktTv5Od73fS-E9wxVr_v43g@mail.gmail.com>
Subject: Re: [RESEND 2/7] mm/gup: Change write parameter to flags in fast walk
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:36 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> In order to support more options in the GUP fast walk, change
> the write parameter to flags throughout the call stack.
>
> This patch does not change functionality and passes FOLL_WRITE
> where write was previously used.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
