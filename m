Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B4BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542972171F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Qxg6Tqxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfCSAaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:30:35 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36867 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCSAae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:30:34 -0400
Received: by mail-it1-f196.google.com with SMTP id z124so24331022itc.2;
        Mon, 18 Mar 2019 17:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ll+wfkPgCAihfYwAbpjE59r2Ng0HLVXKbeuh1xw3Qo=;
        b=Qxg6TqxgJeCYvIAGo8HPfdAH2out7/jIYue07LhXyev8pyrpLo+qSg/0WyPp/kVR8R
         5VNvdCWZD/LvnH5vyNyT4uzj0+EBfvMFL7lgSXvJsGQ7t+3sWRACikaVHvG2FExR+WiM
         40bSGBNdzZi5PsV31zXr7/I25L9ugDFtzWtdwWeXrFcV8xrdrQB2W2bBYVPVa1aI9kVF
         ruEFVAJK682ceUS1F2D3L+j2bJkg8ExzVy/bDP74OLOmiajzljeoQVP32XrWWUDd5Rt7
         mhHlhBNgcSFyjXXUslBS8JQ/FLfVjmaKukW69aY9KQFOYXPD5f0BBFcRlyl1yp9osNgi
         YDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ll+wfkPgCAihfYwAbpjE59r2Ng0HLVXKbeuh1xw3Qo=;
        b=LC+mJAqH6et7w66jI/hfY3AokKKrbkvDRHX2PrMyjUMPTIXaIrUkWyhfR5dHaAW8EI
         hDTV2woYFNmBDZAF7Dr93aarZwOr0zSXk4SEyDIbR2pcW7kDnpsXwhuHhOigQsW9S7Sb
         IdGizuud6F0i8+qzp7W5b7EyjVgQpj7IByyW5dYvM1H7O0XSyo3TbehsChTu/qrUVYdz
         qhoMrarj+BomsVXGKelvF6XUi7u4V8mfBfeJJI/EpiJLWev9XJdVEF0wo11PN5gNlznf
         FruUW1HCmuawfBfi4VHIDy6alQlFv/YKl/YY7AMwlRNn4WJMlwwnbnZd6XKKFogqBH85
         yVug==
X-Gm-Message-State: APjAAAWSg+5H1c0U8Fc6MkD9O+FYDgBvUXYfFXVo+BojE9mAln/RwHt+
        aY4owuJNxXzFyZp/PzJexbjvzpIWWao8Ehj3on+hlsi+nupS5w==
X-Google-Smtp-Source: APXvYqzLlLZkwlcyrq+OqFniPoPkLCf8z7ITQFMA+nVblSM05CdF23WClDPkJbffJJ81NHYqNfrHTLya9KzpsetwX0U=
X-Received: by 2002:a24:21d5:: with SMTP id e204mr1043379ita.56.1552955433622;
 Mon, 18 Mar 2019 17:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1552955080.2785.26.camel@linux.ibm.com>
In-Reply-To: <1552955080.2785.26.camel@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Mar 2019 17:30:22 -0700
Message-ID: <CAA9_cmcOD2zPaaNbkYAaH5DRDRAebPkW+hwPA0zPKY4kU8R-rg@mail.gmail.com>
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware TPM
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 5:24 PM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Mon, 2019-03-18 at 16:45 -0700, Dan Williams wrote:
> > Rather than fail initialization of the trusted.ko module, arrange for
> > the module to load, but rely on trusted_instantiate() to fail
> > trusted-key operations.
>
> What actual problem is this fixing?  To me it would seem like an
> enhancement to make the trusted module fail at load time if there's no
> TPM rather than waiting until first use to find out it can never work.
> Is there some piece of user code that depends on the successful
> insertion of trusted.ko?

The module dependency chain relies on it. If that can be broken that
would also be an acceptable fix.

I found this through the following dependency chain: libnvdimm.ko ->
encrypted_keys.ko -> trusted.ko.

"key_type_trusted" is the symbol that encrypted_keys needs regardless
of whether the tpm is present.
