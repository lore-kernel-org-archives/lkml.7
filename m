Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2373FC32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8E9206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="yPVtcuIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfHFVMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:12:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46757 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfHFVMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:12:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so67778666ote.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 14:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxfvXS8dkeLPpXkICvCXwX+4rlE1NK6AW+Bou/1xFzU=;
        b=yPVtcuImiPOLRP461tix/AcQLCmPpM2hT6wfZ3z3u8rK+/Z4Wcy9TZYR1+pBKb1sEv
         8s5ZXsKoBm0t/6DdFcCMSQQnCtMuYyJQRjyChWPlRiCLIdVoUKmVW20uRNmVEQwz55Q0
         bE/hu0rH2S8PkC3OoCF8CUVDVOjsDrmQt5AwkwC3N5pRqe3g/DntzunlOcmsfFn2MCbD
         i/D13Z/hbxjfwNu62slNJ6Upz8aIY9OSQn0Oh9mvcGHdw8JdOq4oK7LKRHM//+sN1MJN
         6p+ftsIHRD7HxlD2OO+al3P77mmVq899M63tNAeQ9Mm+CdQEQz3bbwdYoFTGtLZ1zNlr
         Fcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxfvXS8dkeLPpXkICvCXwX+4rlE1NK6AW+Bou/1xFzU=;
        b=jVGdOm3GuWCvvuJns6uB9LA1I69VdxpJ0zy/E9FuAT50DY8bDyV029aVRu2Tain2J5
         OKxjDKOwBPy/FZ/ohT4py2YFVykQ60cZNobz/TYeNSOjYR233k6Yua5iQ4NwAycBfmUD
         4/epbtp5JaxWJfmxBDer89O4f2Ylrir94Afl7Ng7V0JTzfwR6TZiLpxvLY8cEuEJUo6e
         C5VOO7fAzAC5BDkL2YOvIVnFU2nb18oVK6FY2Po+TYnI72hh/N0OjJ1eRoQYf9c8pb9F
         O4mYA/F27bk7VlkMxyfFDjeMmIPExlixnLosl4UwgZwzy1Du3nm6xqJaW74O6lhNBywo
         tAtQ==
X-Gm-Message-State: APjAAAWvVd3+5lqIvhjIM+ulZabhtlLwWn+67rkDLB0Xr8LFLBK+EU9T
        hD3LLf7VywN1nNmAzpTGgLWG5Lfvq8Rv+VGAhNwkur/6
X-Google-Smtp-Source: APXvYqw9o9Yb/ND1MDNnGatZSfaVVbG1TKnSQ9e0LNGeNp1/ZpabJ2T1j/9smMMqoDrW/seGup0iO9zq36rzrSQKj2U=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr4580336otn.247.1565125927538;
 Tue, 06 Aug 2019 14:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <1565112345-28754-1-git-send-email-jane.chu@oracle.com> <1565112345-28754-3-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1565112345-28754-3-git-send-email-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 6 Aug 2019 14:11:56 -0700
Message-ID: <CAPcyv4jgtYMKgEB4jnQ0g4fQPO39BCOmQM8Zo231=_D7L6wH=A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS if mmaped more than once
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 10:28 AM Jane Chu <jane.chu@oracle.com> wrote:
>
> Mmap /dev/dax more than once, then read the poison location using address
> from one of the mappings. The other mappings due to not having the page
> mapped in will cause SIGKILLs delivered to the process. SIGKILL succeeds
> over SIGBUS, so user process looses the opportunity to handle the UE.
>
> Although one may add MAP_POPULATE to mmap(2) to work around the issue,
> MAP_POPULATE makes mapping 128GB of pmem several magnitudes slower, so
> isn't always an option.
>
> Details -
>
> ndctl inject-error --block=10 --count=1 namespace6.0
>
> ./read_poison -x dax6.0 -o 5120 -m 2
> mmaped address 0x7f5bb6600000
> mmaped address 0x7f3cf3600000
> doing local read at address 0x7f3cf3601400
> Killed
>
> Console messages in instrumented kernel -
>
> mce: Uncorrected hardware memory error in user-access at edbe201400
> Memory failure: tk->addr = 7f5bb6601000
> Memory failure: address edbe201: call dev_pagemap_mapping_shift
> dev_pagemap_mapping_shift: page edbe201: no PUD
> Memory failure: tk->size_shift == 0
> Memory failure: Unable to find user space address edbe201 in read_poison
> Memory failure: tk->addr = 7f3cf3601000
> Memory failure: address edbe201: call dev_pagemap_mapping_shift
> Memory failure: tk->size_shift = 21
> Memory failure: 0xedbe201: forcibly killing read_poison:22434 because of failure to unmap corrupted page
>   => to deliver SIGKILL
> Memory failure: 0xedbe201: Killing read_poison:22434 due to hardware memory corruption
>   => to deliver SIGBUS
>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Suggested-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Looks good, ignore the checkpatch warning about too long subject line,
looks appropriate to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
