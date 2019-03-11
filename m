Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F13C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 00:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3423E20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 00:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552263739;
	bh=+fYVJcw5DkwboQbB/YbTX6W4biXBHflDSH+/tjgETsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KPe6z+S18sVdfO5lHUF8/tKGW5t+EprHzzhOWjTExsp6yMCc0vD+fOCsdiTE0mf49
	 LJbpKmER6YjwDE7Tun8YZFB3NpCChsqtNFCzwBUTPRlEx8k0ftTS3zHFh9pgGMoKyb
	 lXVVKycii7FsLv4TJGXUrJ+N0nN2ZLMM9Z5R9xtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfCKAWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 20:22:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37318 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCKAWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 20:22:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id a17so2474507ljd.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 17:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=USal/yenJUzX8kjSBZHXwdRtQ9sO5CC+IzZC5KOfziw=;
        b=XVq1ghtYjN1/sHa7q+DbnpmkoIVjXWx0LKm+gjc4koF0NiUQMKEmmDQ+qtrzS8fOQz
         qRekkacO79XeJJxlCfS//OE6CsMr4WGsK1hsJarcPq7j0sOHz4lmWWdWHhRRDWAbu1hS
         FbxOim45mSwCQxidRdpb6mR8wOZh1FbYwETlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USal/yenJUzX8kjSBZHXwdRtQ9sO5CC+IzZC5KOfziw=;
        b=dzky4HUSxGbuR0rArGcPFe40A3T0aapk3xBviwFgXqBonuGBGXDu+5ZFtidRdUggw2
         TZpMzmJOQT+pGvnO28Asfm/50OCGikMPxkil7DhhFMP++/Ito7dWuMvvIsWufQjOIcDi
         IC5HO7m867L3mF+aS4ti0lu9+/UfZ0bGoSoZ++zWQUiJuznQiIRLsxaCvJCqy9RShjjw
         ajT2J1AWxy0a7qRb5DiLiWIPxqBmQdEz3jGi1rVaHjV92WMSolaGN3ZuBDDKx11b/rb4
         zdAg9V4QWyvgYGmQjkAY+YhVI77hnxRmPcuzbelyYpxRnrogSvtbekUpqnaXmiqMhjTM
         bCLg==
X-Gm-Message-State: APjAAAV4o/+sK8Yish2Q+NwYftt+6F/MkBwPJzOSyW5qxBKcm/Fix5xN
        PLZoIDUdpWzSQRLxRjXH/RoOQNENAOM=
X-Google-Smtp-Source: APXvYqwb3saMjXIRIqLpRk5E0ww5mVgmlwZKeIUvibDhUHfi3FBpt3IXwKs+uEst18aBwFUFFRWgRg==
X-Received: by 2002:a2e:9843:: with SMTP id e3mr13191246ljj.57.1552263734131;
        Sun, 10 Mar 2019 17:22:14 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id c5sm793053lja.90.2019.03.10.17.22.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 17:22:13 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id u9so2063280lfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 17:22:12 -0700 (PDT)
X-Received: by 2002:a19:700e:: with SMTP id h14mr15547896lfc.67.1552263732321;
 Sun, 10 Mar 2019 17:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
 <CAHk-=wjvmwD_0=CRQtNs5RBh8oJwrriXDn+XNWOU=wk8OyQ5ew@mail.gmail.com> <CAPcyv4hafLUr2rKdLG+3SHXyWaa0d_2g8AKKZRf2mKPW+3DUSA@mail.gmail.com>
In-Reply-To: <CAPcyv4hafLUr2rKdLG+3SHXyWaa0d_2g8AKKZRf2mKPW+3DUSA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Mar 2019 17:21:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTM93XKaFqUOR7q7133wvzNS8Kj777EZ9E8S99NbZhAA@mail.gmail.com>
Message-ID: <CAHk-=wiTM93XKaFqUOR7q7133wvzNS8Kj777EZ9E8S99NbZhAA@mail.gmail.com>
Subject: Re: [GIT PULL] device-dax for 5.1: PMEM as RAM
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 4:54 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Unfortunately this particular b0rkage is not constrained to nvmem.
> I.e. there's nothing specific about nvmem requiring mc-safe memory
> copy, it's a cpu problem consuming any poison regardless of
> source-media-type with "rep; movs".

So why is it sold and used for the nvdimm pmem driver?

People told me it was a big deal and machines died.

You can't suddenly change the story just because you want to expose it
to user space.

You can't have it both ways. Either nvdimms have more likelihood of,
and problems with, machine checks, or it doesn't.

The end result is the same: if intel believes the kernel needs to
treat nvdimms specially, then we're sure as hell not exposing those
snowflakes to user space.

And if intel *doesn't* believe that, then we're removing the mcsafe_* functions.

There's no "oh, it's safe to show to user space, but the kernel is
magical" middle ground here that makes sense to me.

                Linus
