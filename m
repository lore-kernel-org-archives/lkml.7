Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0310FC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A5E20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Uhh7wOIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfKYPOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:14:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46748 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfKYPOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:14:14 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so16551552iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALu9igSRSsKi52hn+f9OyAjdyB0mBhNXe9BnXNqIOe4=;
        b=Uhh7wOIqPQR81MSbRooLEt8qyy+07qluJoDtNGDtuedJKTsKjd14fVckV+hyDQmbo6
         78MPzzDXsUkzjxgRhAEm9siOrRhNZUiy8r2DTW7OWcdnHo7YHAbfbIO7lH/4mUPXSThw
         yCn+Oo5iRpC87zL2LqOdI1JCfz+ssecH+ma6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALu9igSRSsKi52hn+f9OyAjdyB0mBhNXe9BnXNqIOe4=;
        b=AAW3JTw8Ebp/x/BLDAEjrHxoM6nnKS4NCIz5t3SbNc+g6QNV5n7eTAOaKO2sQLd41v
         1VL5Nm3nS4X8J1SgRWAJsNsUgLqZSL5holfFvvyde26n1mMTGjPYKVfkwxzsBjR6jq6O
         7dsqRsBs2CXMysWZiQV4ndehUwKSDEhIinW1OW8jeV04O54kwjYi8Y9TPryzUcA8oCbz
         Ko3Cc0POlXK7HZtUoI7/ECAU8n/YXPR25K6RE/KfRMNo/wMt3wEIZTRFQVwnHa3oeaiV
         vc7a0Xrt1QTSbeLP3ZgVqyanYI0v9TjhFYsbld6BxaMoSAR8YoBv+eiwoVOd/jg6xSqV
         k+VA==
X-Gm-Message-State: APjAAAX3ZV2BoXUmKJGqwAti5hd0kFEA+vMyksdANwVMpHIMeYyyKW4W
        hV9uFS8aWJJHOKsaTCWxocS3Gxs1ee142ihZ185sxQ==
X-Google-Smtp-Source: APXvYqymUw8TAznCvAM14YFrTvY36Km1p/Eylp7nwOHjzN72m1nqZQk+qCIweSmRGc14oNLOCMmjpk2sZSwXjZnmUyo=
X-Received: by 2002:a5d:91da:: with SMTP id k26mr26131450ior.252.1574694852323;
 Mon, 25 Nov 2019 07:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20191025112917.22518-1-mszeredi@redhat.com> <87r231rlfj.fsf@x220.int.ebiederm.org>
In-Reply-To: <87r231rlfj.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Nov 2019 16:14:01 +0100
Message-ID: <CAJfpegt_haMDwd6jo3mQzX2vchk_LLMH+V+h4yDs7geLmo4NhA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] allow unprivileged overlay mounts
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 3:43 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Miklos Szeredi <mszeredi@redhat.com> writes:
>
> > Hi Eric,
> >
> > Can you please have a look at this patchset?
> >
> > The most interesting one is the last oneliner adding FS_USERNS_MOUNT;
> > whether I'm correct in stating that this isn't going to introduce any
> > holes, or not...
>
> I will take some time and dig through this.
>
> From a robustness standpoint I worry about the stackable filesystem
> side.  As that is uniquely an attack vector with overlayfs.
>
> There is definitely demand for this.

Hi Eric,

Have you had time to look into this yet?

Thanks,
Miklos
