Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF7AC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91459207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569345624;
	bh=5CX8cWEh52M6eXKtDcxHy91sCi4jxF17tAgZFQmi99U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dgfYQ0ZWnZ+KQtTISzqRT2+3CbmOZV4p3Ncg0BG0ps49x6FjqXgZBmVcnS/CqgGXL
	 yJhq5272+okD1I1u42Y9f1gbgj4BhzIrmbv6Z3FZlhbVQ05Z72NrdvzkzuJNAIj/Gl
	 o2ci/dGqff4cSsYiZbME40k+dipXbEUZs+gACXgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407341AbfIXRUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407128AbfIXRUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:20:23 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55EBB21655
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569345622;
        bh=5CX8cWEh52M6eXKtDcxHy91sCi4jxF17tAgZFQmi99U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HtIH7+DTaMfgDuFZZm2Q5aAdDqDincUCdHqcGVKO582dP9uJyMi4Wq916IUqI/qmS
         7f+DJAiql//0jbozXJbDs4mc5enc2OeDfKojA5aLwdnvnuSOC3lRl863t1Uow4dWPW
         8u5tZl8kH38BVl7F/UM8KUjJoKQWXSymCFbe1e2c=
Received: by mail-wm1-f54.google.com with SMTP id y135so2076467wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 10:20:22 -0700 (PDT)
X-Gm-Message-State: APjAAAUW48FnXMQlCcUckTtyH2I5R3zG0wJiI5TxbJF9SZy/MJ8kxYXL
        YYxOPlDnsoh/fVq10kAuCuNx2UYAcGSydnbQfmnU1g==
X-Google-Smtp-Source: APXvYqwgvpCgffx4sTD+nFnvIO2e9YCvIvNIqALEckl6CKy6QshFAP/F5Rr8p9fBeqJUvbt5mLvZaUoi/7foIbqrxMA=
X-Received: by 2002:a1c:6143:: with SMTP id v64mr1278559wmb.79.1569345620772;
 Tue, 24 Sep 2019 10:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142655.21943-1-jarkko.sakkinen@linux.intel.com>
 <eed916f3-73e1-2695-4cd1-0b252ac9b553@intel.com> <20190914134136.GG9560@linux.intel.com>
 <8339d3c0-8e80-9cd5-948e-47733f7c29b7@intel.com> <20190916052349.GA4556@linux.intel.com>
In-Reply-To: <20190916052349.GA4556@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 24 Sep 2019 10:20:09 -0700
X-Gmail-Original-Message-ID: <CALCETrWDLX68Vi4=9Dicq9ATmJ5mv36bzrc02heNYaHaBeWumQ@mail.gmail.com>
Message-ID: <CALCETrWDLX68Vi4=9Dicq9ATmJ5mv36bzrc02heNYaHaBeWumQ@mail.gmail.com>
Subject: Re: [PATCH v22 00/24] Intel SGX foundations
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-sgx@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        nhorman@redhat.com, npmccallum@redhat.com,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "Katz-zamir, Shay" <shay.katz-zamir@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Svahn, Kai" <kai.svahn@intel.com>, Borislav Petkov <bp@alien8.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        David Rientjes <rientjes@google.com>,
        "Xing, Cedric" <cedric.xing@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sep 15, 2019, at 10:24 PM, Jarkko Sakkinen <jarkko.sakkinen@linux.inte=
l.com> wrote:
>
> =EF=BB=BFOn Sat, Sep 14, 2019 at 08:32:38AM -0700, Dave Hansen wrote:
>>>> On 9/14/19 6:41 AM, Jarkko Sakkinen wrote:
>>>> The proposed LSM hooks give the granularity to make yes/no decision
>>>> based on the
>>>> * The origin of the source of the source for the enclave.
>>>> * The requested permissions for the added or mapped peage.
>>>> The hooks to do these checks are provided for mmap() and EADD
>>>> operations.
>>>> With just file permissions you can still limit mmap() by having a
>>>> privileged process to build the enclaves and pass the file descriptor
>>>> to the enclave user who can mmap() the enclave within the constraints
>>>> set by the enclave pages (their permissions refine the roof that you
>>>> can mmap() any memory range within an enclave).
>> The LSM hooks are presumably fixing a problem that these patches
>> introduce.  What's that problem?
>
> I've seen the claims that one would have to degrade one's LSM policy but
> I don't think that is true.
>
> With just UNIX permissions you have probably have to restrict the access
> to /dev/sgx/enclave to control who can build enclaves. The processes who
> do not have this privilege can mmap() the enclave once they get the file
> descriptor through forking or SCM_RIGHTS.

As the person who originally raised the issue, I feel like I should
rehash the issue:

Right now, using SELinux or probably other LSMs, it's straightforward
to prevent programs from having any executable pages whose contents
doesn't come from an approved (e.g. appropriately labeled) source.
With /dev/sgx/enclave, at least as initially designed, a process that
can open /dev/sgx/enclave can execute whatever bytes they want by
sticking them into an enclave.  I fully expect that people will want
to combine these things: have unprivileged users run only
admin-approved code but *also* allow unprivileged users to run
enclaves.

> *If anything*, I would rather investigate possibility to use keyring for
> enclave signer's public keys or perhaps having extended attribute for
> the signer (SHA256) in the enclave file that could be compared during
> the EINIT.

The latter is very much like the labeled-enclave-file thing we talked about=
.

>
> I think either can be considered post-upstreaming.

Indeed, as long as the overall API is actually compatible with these
types of restrictions.
