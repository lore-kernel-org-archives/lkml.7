Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47697C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1155D20882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km5FYIM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbfDBN4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:56:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38575 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731186AbfDBN4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:56:20 -0400
Received: by mail-io1-f67.google.com with SMTP id v4so10964438ioj.5;
        Tue, 02 Apr 2019 06:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eyIe8u6Gr9VYhYSE410erruSd8jDIrKaP8cUiBOsxSQ=;
        b=km5FYIM27ScmBGI8oKFEVytngyHRxu4jyDItUvdOhornWRoka5QMu9V8eEaT97vSeI
         VhSbsmvjbSNd8pRBsc0SC1vADlXEJA03fwnydA+JB1DH9/dkxd8eWy60iCvwjxJh2wZj
         56DcVz5ZE2X01/76Zm+DqnfoHONW6hTGkcGjPqvrSGeq0n3KPEfVAF5sMxOYVX8Usuqi
         1XKwsJkgmzjFwFuhjz5OIIXvUjTF96x17F6Ey9G8tgANFrUf0SCSsWYqTBLpTpcIVQM8
         26nheNiJlG5hj3cA0RN2LJ1xuEzZc4fBM4wd26loHSUxaa7STv7RC9Ea+MrBNIJZt+5s
         BQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eyIe8u6Gr9VYhYSE410erruSd8jDIrKaP8cUiBOsxSQ=;
        b=HUnGFxdat3OEoY4zn9y/xBYF0Nf1W2N8kVGeF95eFPTkfmSx4AP+LaiWw456f5hJmS
         vz4yK4o+b+WfGBsoZBHdDtxdCzQ58+4AKUnQ2llCnV+d84079//alQ8suMFgJKgOPP7J
         C9DvPn+x8rsTYgPB/o4PuLDn32pzYCCWInoHyLCWxVwgU/acGm4DPleds0OKYleBesdq
         Ev5pVZeTp6qpGLrKMCpKgNsyAyL/um4SlKPBFJqYW5H5CmHzDtg54rwxtj+Tso0IymJg
         tTv6GPPNWDUQYuJ4EeOIQptej7zeDiRQGStab9QWOJuRnHwasMwidq5ela8CaCfrLo9M
         ScpA==
X-Gm-Message-State: APjAAAVP8vuhCRWRLvmi3UkLvwKdaaLG+xsIFtLnxkx5i5TfDz9P+BFa
        LidwSOV3y1z2nBzfKYgpJUmNeaGTe46GVOt0514=
X-Google-Smtp-Source: APXvYqy+DqS914UWXRpYWBKcUTv9FxWUFXybOqQw6QZmmMpKDje5XoI4jfNoz7t+dNC7223acJkq1Uhr8dla1yWw4bw=
X-Received: by 2002:a6b:8d87:: with SMTP id p129mr48072633iod.10.1554213379755;
 Tue, 02 Apr 2019 06:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190402105006.48f93e53@canb.auug.org.au> <CAKGbVbvj9cZnJuey_ra7U+xm-JhoB17bpTgcXKiKaHWbjB9Sxw@mail.gmail.com>
 <20190402112656.GE22763@bombadil.infradead.org>
In-Reply-To: <20190402112656.GE22763@bombadil.infradead.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Tue, 2 Apr 2019 21:56:08 +0800
Message-ID: <CAKGbVbuY3mKAZ6bA9G87NHq7mdxkw95p7OoO_QyUU_101yQEuQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 7:26 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Apr 02, 2019 at 01:55:03PM +0800, Qiang Yu wrote:
> > Thanks, patch is:
> > Reviewed-by: Qiang Yu <yuq825@gmail.com>
>
> This looks like a fairly naive conversion from the old IDR API to the
> XArray API.  You should be able to remove mgr->lock entirely, relying on
> the xa_lock for synchronising free and get.

I'm afraid the a little complex free path may involve some might sleep
functions so use a mutex lock instead of spinlock.

> If you think it's worth it,
> you could even use kfree_rcu() to free the ctx and kref_get_unless_zero()
> and then your get path would be lock-free.

I can take a look this way, thanks.
