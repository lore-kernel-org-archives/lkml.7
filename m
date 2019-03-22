Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB406C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798B121900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="pKk8vaqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfCVWPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:15:25 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37657 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:15:22 -0400
Received: by mail-it1-f196.google.com with SMTP id z124so5773134itc.2;
        Fri, 22 Mar 2019 15:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NxtbMONzoE1s3tzmii8qj/NkqDi2oTH0iJ5EH+lwhzs=;
        b=pKk8vaqmEOWE7wmsQsAlpVqHxGSGlzdO18CvseUDa6Gqg3ToKg6HC+d6WIlSijUcfE
         eqZis0vwDECjehXasWtExjdgpfVBq/hrPtiOoQQSKzK3TjOl/nTT+9YmHvwUR+PM7IA4
         SOb/KicPs2Y3XnvO+puWR7yKpWhSgZFJhnJ6r4/irdDupSuupBFv6JOsvwLkAcOJVCvc
         /c6q0yBJIunL/GfMeaZCvO2zo7Le+40UBax9xxx16S5aZ0WDQh3P5CgePOvXOOBPFbgz
         HBnYydx8J6DIC1a5uoC8HcWUFBhtiH/ArOQmUpRQZYjiW5VzQldKh5YBRfOuJhQ/9xvp
         6L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NxtbMONzoE1s3tzmii8qj/NkqDi2oTH0iJ5EH+lwhzs=;
        b=jM0s7cYxPLNd6CpeWkl8RThH9s/2KWrZSwuU2OM6SqPw1nhcrZLC2HNfbqb9i5YpTY
         gatmLJzoF8B4ruI5UzsPiP/3T4lyyDL3rlzn09KcZQv/MpBgzgq7ySfIPfxYAl0hUKgh
         n35Ptuq4tqILxoU3iNCO8Jx+ZaSxpIAOD7Nlve6XpLhC2bR5qfJ66QJTc49sDjAVf6Qe
         U6Zs7tOYpMlH3CKuTxG4v3DSrIx4nSzFuBuis5nXVWAaAfUfoqWkC95CZa0EG4QQtkA0
         WbIo90h3dSWlycQm8Ed8U+w91QYxSq1ikAMUDw32jWctfaQEZZ3r2sne674odInkTJqx
         Spsg==
X-Gm-Message-State: APjAAAUyVTera3EHBCkjAfe9T6ybOzaRWR+3cJuw5w0Xd0HfA2zFridw
        8yHuDE7p3TYyagvpH2M/s1kkM6X2ufE4adbPqEE=
X-Google-Smtp-Source: APXvYqziYcin9TkCNIVMFnILirct4rYKpjMxOpZQfFl5u+ozFqvpcOi02iZydMgVTL758Vu3P43GvK0tXOYXgqNrS/o=
X-Received: by 2002:a24:298b:: with SMTP id p133mr3587931itp.43.1553292921652;
 Fri, 22 Mar 2019 15:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com> <20190317183438.2057-7-ira.weiny@intel.com>
In-Reply-To: <20190317183438.2057-7-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Mar 2019 15:15:10 -0700
Message-ID: <CAA9_cmdDxh1ZYn1fO+ED1crzDMCPWk0fLjNPfxkFKUb5kNHgxA@mail.gmail.com>
Subject: Re: [RESEND 6/7] IB/qib: Use the new FOLL_LONGTERM flag to get_user_pages_fast()
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
> Use the new FOLL_LONGTERM to get_user_pages_fast() to protect against
> FS DAX pages being mapped.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good modulo potential  __get_user_pages_fast() suggestion.
