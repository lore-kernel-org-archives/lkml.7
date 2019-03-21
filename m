Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FE9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A25F218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NvpyZ8W7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfCUQag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:30:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40891 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUQag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:30:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id 3so4461126oir.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=piw7P3Z+dBjjk35YGVjM1WS+gNInjf05b7+/X36Vcbs=;
        b=NvpyZ8W7BITgihQT3qkoAyWdlJQKqZj24a7YYfWDl2KSGV4R37rgu4x1H0zSTatWcc
         dtXedHaWrlyyee3nFegcgX/cpEAweOU7/iuuqxDlZxI8gRt2+e9RjTBll+aVdcxUvKES
         gIBT07kXAYBDk+sGWq3cVTHbXSaIwehzkdW26PfiJe7gKotaXbtda+hcavuj1N4xhRSB
         U7JgNAsxKQDqfphOyqrBSH2gAHEMJDHbcyZPPXPfIAYEvz4KcYEvtqimZl0EgWI1i5rs
         csQnqgMuxQ771TwwbZMYLWavjfetiVe37Igx8dc/MCgS65LUBmA4E2WT5uNpjS8tVSFt
         0faQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piw7P3Z+dBjjk35YGVjM1WS+gNInjf05b7+/X36Vcbs=;
        b=dyTJh9+tqb8rcS2JL9awMpeHbgyH28oA/5DPvNtcExZOiSp3nG77pcqdND6DrbUcv7
         IgWcahCi48SLf+EFyQZ2UC15zaatyFa5VFBbQ2TK7hZuWdx1s+cyuArm2mZShnFgrmGn
         LLlPm8eMrqHuWqwCOyoN2nlVJtNVACnochbphuvtpRj65hFSoLueLvgwz/Qpdxenor59
         gHIXrfz2jkTU57jRiOfGtQHzNmAW2z9Wr2R4r+q7gkWlZe57USeFIi3tUCwgUVjTOX1E
         r9tzZY63PlUHqGtu3KnVsQD81zibQ2gxSVHDm+/MHCsJZzxJ0d1/UbXxXjTN2B0QdtvA
         7t8g==
X-Gm-Message-State: APjAAAWzmXt7a2TH/891db/bvWbelOHMt6OUb12GDhzl7Iv2pnb86VrW
        0LscvE5FvN8O4bPv/rsNRrXmR/oNtud9JjT15CINUw==
X-Google-Smtp-Source: APXvYqwx6iq/Mv0f8kNbfrhCvnJX82P6IzojhmxM9eXDB1t4/nxvB2pjKVWClU5SwUW1dnkpg3UlzhZdi+ZpVgxWeUc=
X-Received: by 2002:aca:f581:: with SMTP id t123mr135034oih.0.1553185835603;
 Thu, 21 Mar 2019 09:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190321135451.GD4603@linux.intel.com> <809e827b-fdbe-fbb8-8acf-2878ae9f7777@huawei.com>
In-Reply-To: <809e827b-fdbe-fbb8-8acf-2878ae9f7777@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Mar 2019 09:30:24 -0700
Message-ID: <CAPcyv4gc_KWedC12bTcX24KwjKiBCF=yvouRNzCbJKaLrgJdDg@mail.gmail.com>
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware TPM
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 7:27 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> On 3/21/2019 2:54 PM, Jarkko Sakkinen wrote:
> > On Mon, Mar 18, 2019 at 04:45:13PM -0700, Dan Williams wrote:
> >> Rather than fail initialization of the trusted.ko module, arrange for
> >> the module to load, but rely on trusted_instantiate() to fail
> >> trusted-key operations.
> >>
> >> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> >> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> >> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >> Cc: James Bottomley <jejb@linux.ibm.com>
> >> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >> Cc: Mimi Zohar <zohar@linux.ibm.com>
> >> Cc: David Howells <dhowells@redhat.com>
> >> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > It should check for chip in each function that uses TPM now that
> > the code does not rely on default chip. Otherwise, the semantics
> > are kind of inconsistent.
>
> If no other TPM function can be used before a successful key
> instantiate, checking for a chip only in trusted_instantiate() seems
> sufficient. Then, the same chip will be used by all TPM functions until
> module unloading, since we incremented the reference count.
>
> I would suggest to move the tpm_default_chip() and init_digests() calls
> to trusted_instantiate() to restore the old behavior of init_trusted().
>
> trusted_instantiate() should look like:
> ---
> if (!chip) {
>         chip = tpm_default_chip();
>         if (!chip)
>                 return -ENODEV;
> }
>
> if (!digests) {
>         ret = init_digests();
>         if (ret < 0)
>                 return ret;
> }

This patch already achieves that because tpm_find_get_ops() will fail
and cause tpm_is_tpm2() to return NULL.
