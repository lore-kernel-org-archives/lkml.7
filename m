Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42636C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203B62075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfE0MdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:33:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50214 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfE0MdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:33:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so16010540wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 05:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2A04f9HaZNMB40s7FDmagBXi4VteUjR4wwzslZJ6poM=;
        b=plj2/MgAHNOHfEqtwd1G8V8T41tSS4MgCL9I3weHiyG7maRBKmZDNVNo9MNGdgNwdU
         6r98zgU7BrmMJ0R0O2W8Hb3hlB2UcKKtF379eVoqELxaqpSmXiFE+HBnHRu2Ni3cbmoK
         0ZQIyxtIitBKyfYgNXBNIpjERhHiyLQZoWsmlq03W6+aVFtx3IgxJfGjw6c6H5x8xXd3
         WXPfQsx52duVlUVEEIBtOtedkG0GrAgV/Zx9Poi7+i3cyYqWeogCXzqAtT9NgYS2QI6L
         n7laAe/dOY1yM1XCs/M1gdDGGXDR1iz6w+aZ1tgYs2B6AWuSvqKiZGY0bFML68yNCtZ6
         q3Vw==
X-Gm-Message-State: APjAAAWMPgczEROnu+03GNyASrY1a2gwbUq9lulu/nN0QU+I8sTlCQLz
        grPzjFvGsKgTB3bwDADOuMqxrEX9hpQ=
X-Google-Smtp-Source: APXvYqyfyZiyQXGV6PqCF7c2IO5JUIC3+A6dAwpVyQH6lHro05CRPOzIynwiJ5C8FTv8HcDWWnAu7A==
X-Received: by 2002:a7b:c943:: with SMTP id i3mr9080617wml.128.1558960391360;
        Mon, 27 May 2019 05:33:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c92d:f9e8:f150:3553? ([2001:b07:6468:f312:c92d:f9e8:f150:3553])
        by smtp.gmail.com with ESMTPSA id s13sm12469362wmh.31.2019.05.27.05.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 05:33:10 -0700 (PDT)
Subject: Re: [RFC/PATCH] refs: tone down the dwimmery in refname_match() for
 {heads,tags,remotes}/*
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <CAHk-=wgzKzAwS=_ySikL1f=Gr62YXL_WXGh82wZKMOvzJ9+2VA@mail.gmail.com>
 <20190526225445.21618-1-avarab@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c9ce55c-2c3a-fce0-d6e3-dfe5f8fc9b01@redhat.com>
Date:   Mon, 27 May 2019 14:33:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190526225445.21618-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/19 00:54, Ævar Arnfjörð Bjarmason wrote:
> This resulted in a case[1] where someone on LKML did:
> 
>     git push kvm +HEAD:tags/for-linus
> 
> Which would have created a new "tags/for-linus" branch in their "kvm"
> repository, except because they happened to have an existing
> "refs/tags/for-linus" reference we pushed there instead, and replaced
> an annotated tag with a lightweight tag.

Actually, I would not be surprised even if "git push foo
someref:tags/foo" _always_ created a lightweight tag (i.e. push to
refs/tags/foo).

In my opinion, the bug is that "git request-pull" should warn if the tag
is lightweight remotely but not locally, and possibly even vice versa.
Here is a simple testcase:

  # setup "local" repo
  mkdir -p testdir/a
  cd testdir/a
  git init
  echo a > test
  git add test
  git commit -minitial

  # setup "remote" repo
  git clone --bare . ../b

  # setup "local" tag
  echo b >> test
  git commit -msecond test
  git tag -mtag tag1

  # create remote lightweight tag and prepare a pull request
  git push ../b HEAD:refs/tags/tag1
  git request-pull HEAD^ ../b tags/tag1

Paolo
