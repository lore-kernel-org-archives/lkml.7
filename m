Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8055C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F8A20835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUFGUAJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfCSC34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:29:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39345 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfCSC3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:29:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so6101634ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9LeluuAwbLdhqLKYrLQeqJxgvFSi8zRhy1PLSOWg3I=;
        b=MUFGUAJAl/zJoucy75Z3xPtEwYsA3nnr8nu3V/s7YNK7VD/HcTmcZGLwodlNVAkQj9
         X2Q0/0gM9y8qxFg+jjinDtvWD9oO1eLRRRaql73i9CtaS9pZSPHFSzStnCRcej3tHrRS
         gEwwyBLNZYt3bOaajqMqeOgWqQ5tXYVnkgjp5Y8V84ZBh15cihEoIlvsg0YER61WxGsw
         yMse9WUsVwQ0Hr7WhFyn1iBq68dgV0BlEg9FB0Rp8/VgmkDyqAtjo7mufoEzhgminBR6
         LdmhTXwmnVQ2mXybEaEb3BPoWOt2gY7X+b+6axfJIQuclT0XSKXUhRuEWDO8Byng+qju
         cagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9LeluuAwbLdhqLKYrLQeqJxgvFSi8zRhy1PLSOWg3I=;
        b=PhBqWhSBXut9ZpJj8bcjj74M8Z6PMMAa5AB8aLhoLrwxORxEX4hobw1f9V53wq++6v
         RYPVB71Gc4Yq9broa3o6qHMhF9DC7820eHDN9/nmWpmPajy57e9sKIsGi3FoBfmKg32K
         NfqOzzWLopY3vmx6gngryLJql2+WZwV9Tafskz5QEJeYleEBqGEq2S++bzZkDrPiQk0u
         fyBaaMH34v0etg29wDw/AhUpOKdo0CbaGLZMIkcvaIz0KNyoLN2RsuM4LadJbEDO9cO6
         OrwXyzJakezOOO8fBJNoMRdCwjaXPSdB3Tp5NxcioafPTOLtN0hkGVBtVNIFhuv08gx1
         Xjpg==
X-Gm-Message-State: APjAAAWDCKPgiZkpBdmIBjUjYJlmUIGrfRl4pP+YB8q3ybGxzPIvMXOY
        zoH2HPNL8LRiU31Y5WBgohWG1khMbyQ4AnC3XOY=
X-Google-Smtp-Source: APXvYqyMNBOknG2i9I+qR+MgQA8ikKE9fRNsSolPoJmGJ499CeDc0Uj+pjoMPEgi1xfawlVpPq2FCybbiCZpKxkvEFo=
X-Received: by 2002:a2e:9916:: with SMTP id v22mr12140112lji.68.1552962593789;
 Mon, 18 Mar 2019 19:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190318162604.GA31553@jordon-HP-15-Notebook-PC> <08a039da-6bc2-0da9-e83e-46cce6d7264b@oracle.com>
In-Reply-To: <08a039da-6bc2-0da9-e83e-46cce6d7264b@oracle.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 19 Mar 2019 08:04:19 +0530
Message-ID: <CAFqt6zah2hM1X5-TCsrGN6xVG+CYRygvMiZ98jBdSeepFqaSew@mail.gmail.com>
Subject: Re: [PATCH] include/linux/hugetlb.h: Convert to use vm_fault_t
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 5:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
>
> On 3/18/19 9:26 AM, Souptick Joarder wrote:
> > kbuild produces the below warning ->
> >
> > tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   5453a3df2a5eb49bc24615d4cf0d66b2aae05e5f
> > commit 3d3539018d2c ("mm: create the new vm_fault_t type")
> > reproduce:
> >         # apt-get install sparse
> >         git checkout 3d3539018d2cbd12e5af4a132636ee7fd8d43ef0
> >         make ARCH=x86_64 allmodconfig
> >         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> >
> >>> mm/memory.c:3968:21: sparse: incorrect type in assignment (different
> >>> base types) @@    expected restricted vm_fault_t [usertype] ret @@
> >>> got e] ret @@
> >    mm/memory.c:3968:21:    expected restricted vm_fault_t [usertype] ret
> >    mm/memory.c:3968:21:    got int
> >
> > This patch will convert to return vm_fault_t type for hugetlb_fault()
> > when CONFIG_HUGETLB_PAGE =n.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Thanks for fixing this.
>
> The BUG() here and in several other places in this file is unnecessary
> and IMO should be cleaned up.  But that is beyond the scope of this fix.
> Added to my to do list.

I can clean it up if you are fine ;-)
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> --
> Mike Kravetz
