Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3E7C10F0C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688CC2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UfKT7gC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCHXbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:31:01 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33568 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfCHXbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:31:01 -0500
Received: by mail-it1-f194.google.com with SMTP id f186so7597135ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 15:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyKi46/3lZKgO9wRb326RaXuA/9S3eKGPLtaU64kZXc=;
        b=UfKT7gC4crlP0hVjGkmMYK4IRiQKubJ81v3W4HLS5xs32/EMChBVpE3NyB1oEGMLcA
         hS5+SjWPxNFzvnrTAO/+JmFRuv3YD8xGBSq4IarcmY0DV3A+XUQFujimn1Z13EQ/icQI
         JPqsBnJbuD85nRCUDSN1hPYkxWGZESOfAmK8Po093C55fORjkPbSIpDor5EvSBkuPQCh
         4hnQshvSU8Pr21I+uAW1KFt5tE+vCSHSEE9tlDBQQhgN2PLHDqmUpymusQlFV1oZlPAb
         92bQMSf8mz2/gjSnRxZqrvQCs9UedGIuGeMOCEY1i9TLN/uSDIB8eh8hp+owq09M46O5
         wblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyKi46/3lZKgO9wRb326RaXuA/9S3eKGPLtaU64kZXc=;
        b=bMmC7mWGpPGLLz0jbia07vyrz8JHUqmVgovbS7tx4TghGr0AeRvjXdRMuz4ywLGJ+O
         VzTIHeSr3XS94YB8QWWMRVf76L+xifjgt96NHPuQ6tYLQuqyaKOJFXbyCe9eXmt/bamx
         RfGs9IaxV67RXMCeKR15KU3cb1y1AEkYVcGM+P5djdw0yq3EOlKyJOS0teE9n2Uzb/Ui
         4JqdI5fVGc+SO8IPBrvZWRPMaWHs3vTbf62VPRu8hdImJ46ZSXshdoLZrgFIas/eaZHx
         H8BzrHK2q/EBFdRsrF4CS2gg7aE4BjQKZp2njOf8xNTHrJiamB1XCBgHhxuTX+TvwcnH
         IYQg==
X-Gm-Message-State: APjAAAUVz+rUYBbonxYIbwVJt1XCHXPOTJvDe0aPzLhVwu/2RrpyvkCy
        mI3pBtKFBPNy2A2GpzfQn4wHxnhPEnGhstk0C0KMkA==
X-Google-Smtp-Source: APXvYqzDA336WF79EMiucNZseWjXkh0DJYToYzXNFfFhDWPPpKP7ueFQC9kDFJ+RVFCpnPt+sDbi/G7Qj2D/fBu4jqk=
X-Received: by 2002:a02:23cd:: with SMTP id u196mr11334146jau.103.1552087860113;
 Fri, 08 Mar 2019 15:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
 <20190306235913.6631-4-matthewgarrett@google.com> <alpine.LRH.2.21.1903090959210.12052@namei.org>
In-Reply-To: <alpine.LRH.2.21.1903090959210.12052@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 8 Mar 2019 15:30:48 -0800
Message-ID: <CACdnJuvhPd2dD7cWkxP78YMMFKU3FsigLHgkDntwhnbamNZr-w@mail.gmail.com>
Subject: Re: [PATCH 03/27] Enforce module signatures if the kernel is locked down
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 3:00 PM James Morris <jmorris@namei.org> wrote:
>
> On Wed, 6 Mar 2019, Matthew Garrett wrote:
>
> > From: David Howells <dhowells@redhat.com>
> >
> > If the kernel is locked down, require that all modules have valid
> > signatures that we can verify.
>
> Perhaps note that this won't cover the case where folk are using DM-Verity
> with a signed root hash for verifying kernel modules.

Mm. I can't see a terribly good way of doing this generically -
loadpin gives no indication to the module loading code that it comes
from a trusted source. Would making the lockdown/module signature
enforcement a separate config option be reasonable?
