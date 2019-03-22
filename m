Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D854BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8D6206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bMVg2xzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfCVPYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:24:14 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45406 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfCVPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:24:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id y84so1969463oia.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SiUB6GjdRDUvfPlt5GeWB4/3VlUtKceTbjUSCfKanHs=;
        b=bMVg2xzknwWrsKHdURPAH4td/i+DnG34a8+YryPxxGHzVICC8nfrl7CYBl3D4eUc6d
         rgWQJeMadfip2iVs+y1R3ObEqQqcHIJ4iWVQBbLWOhKi941FO3c2Xl1q2mqy5GSe43Ns
         lsM3YT+S54h//AvmGLFQihQaypGCzRknjC07PoGuChcNiI7YlGxC7FrnV5QfCLBasiOQ
         C+ubvIiCL1fA2Dwu/MrVXl7O6rG+FYaoARlfyWjjwdktX86RvrFp73axcgOuPma0VE9g
         nF5AVun+Zh0Wdx6/jCwP4uTeX5lpsYvhHCJSetr/Xzizn+5CF4IgdXmJKO+92Z/lFach
         LATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SiUB6GjdRDUvfPlt5GeWB4/3VlUtKceTbjUSCfKanHs=;
        b=t5qYzUTxehDriYocV7M5LMErQR6mzDKLkRBLdBf8/BejYcfwCxQY64ZIOH46lEHHRl
         qLFn1Z+wsfK9JkQN5aDzMETdQaNNU30ZzmfJT16ENR26BMulCLs6bB0S3ekfeWqCRmMb
         lUn+NKOOgFkZYZUTvOCnEEzxfVBSPGBGW/oSdcnz6XURNDoUxUdglKEiufvNFnr3IXJI
         3H7uwP9YaSSeF9wqkJEAookzmDZjMJfzjzebtQsxMiZkg5C8tx5CD7hingxk20JbjuHa
         EUV5cEyO8OBPHjSq5twFyNmO0dGJcz2EpNK+g8QdkQ96RTQpYmZiSOFkoAL//aK3/Mqa
         kI5g==
X-Gm-Message-State: APjAAAU6IxHvY3+3QGLgLGBhojuQ406v5vhBc6dlby9EQz4EOAN1tUkG
        fZrnNLi3xckDiu8TBJzd9oBRAHSACRwBifhmg5JypQ==
X-Google-Smtp-Source: APXvYqxvsdgrXSTwlEwbN3qSidxJAdAhRPrGdh+vb5iMw7DxT3s00r4H3fjVoGOrj8J6cap1YSmtX94ncF4RtLRxOCU=
X-Received: by 2002:aca:df57:: with SMTP id w84mr2303809oig.105.1553268252709;
 Fri, 22 Mar 2019 08:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190321135451.GD4603@linux.intel.com> <809e827b-fdbe-fbb8-8acf-2878ae9f7777@huawei.com>
 <CAPcyv4gc_KWedC12bTcX24KwjKiBCF=yvouRNzCbJKaLrgJdDg@mail.gmail.com>
 <d0434a90-4010-8c76-c02e-bb1a6ec831ef@huawei.com> <20190322101227.GB3122@linux.intel.com>
In-Reply-To: <20190322101227.GB3122@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Mar 2019 08:24:01 -0700
Message-ID: <CAPcyv4g=W9Fc=nfYjXG9-mpzn2cfiYEz4J7ksP3ziFUc_5k1OQ@mail.gmail.com>
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware TPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 3:12 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Mar 21, 2019 at 06:45:47PM +0100, Roberto Sassu wrote:
> > On 3/21/2019 5:30 PM, Dan Williams wrote:
> > > On Thu, Mar 21, 2019 at 7:27 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
> > > >
> > > > On 3/21/2019 2:54 PM, Jarkko Sakkinen wrote:
> > > > > On Mon, Mar 18, 2019 at 04:45:13PM -0700, Dan Williams wrote:
> > > > > > Rather than fail initialization of the trusted.ko module, arrange for
> > > > > > the module to load, but rely on trusted_instantiate() to fail
> > > > > > trusted-key operations.
> > > > > >
> > > > > > Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> > > > > > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > > Cc: James Bottomley <jejb@linux.ibm.com>
> > > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > > > > Cc: David Howells <dhowells@redhat.com>
> > > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > >
> > > > > It should check for chip in each function that uses TPM now that
> > > > > the code does not rely on default chip. Otherwise, the semantics
> > > > > are kind of inconsistent.
> > > >
> > > > If no other TPM function can be used before a successful key
> > > > instantiate, checking for a chip only in trusted_instantiate() seems
> > > > sufficient. Then, the same chip will be used by all TPM functions until
> > > > module unloading, since we incremented the reference count.
> > > >
> > > > I would suggest to move the tpm_default_chip() and init_digests() calls
> > > > to trusted_instantiate() to restore the old behavior of init_trusted().
> > > >
> > > > trusted_instantiate() should look like:
> > > > ---
> > > > if (!chip) {
> > > >          chip = tpm_default_chip();
> > > >          if (!chip)
> > > >                  return -ENODEV;
> > > > }
> > > >
> > > > if (!digests) {
> > > >          ret = init_digests();
> > > >          if (ret < 0)
> > > >                  return ret;
> > > > }
> > >
> > > This patch already achieves that because tpm_find_get_ops() will fail
> > > and cause tpm_is_tpm2() to return NULL.
> >
> > In addition, the changes I proposed would allow users to create trusted
> > keys if a TPM is added later. CONFIG_TRUSTED_KEYS=y and
> > CONFIG_TCG_TPM=m is a valid configuration.
> >
> > Jarkko, Dan's patch seems sufficient to fix the issue. He could include
> > the changes I proposed in his patch. What is your opinion?
>
> Agreed.

What changes?

Robert, please feel free to re-author the proposed patch however you
see fit, I just want whatever will get libnvdimm operational again in
the shortest amount of time.
