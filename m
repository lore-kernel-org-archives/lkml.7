Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9483CC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7D0208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556298550;
	bh=dSDo+1xZIEAlrJkWU0RKqeoWlA3MeLcQ0rNaLLYCezc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xuNJKDU4sGYtYS2UoE85sea+9RmZslw15YpFzxU9swTB0xggR3/hh+iRkA9hg5AfH
	 R9gFbgddrzK2vtUV9DmZglmz8px9NXaAQh2CFGEN4VvppBxN0xsH29p5RiY/g1jwOb
	 Fv4y2XYoSGHExFMMannAm3Jf5hdIrCuy6DrJV4EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfDZRJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:09:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38919 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDZRJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:09:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id d12so3003454lfk.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y6nDzAc3WuT+D3ggXnpnocD80VY/NBrdpemv3g0GHJ8=;
        b=GwqL+TvawBwczI+PsRHix16G6+AQoGgSUfzMyE2vmxR6GKwSCz+eXZhSJveO6Uc//U
         QamDzHRWYnX5I31oGtadaqnR0J8p3JOUZ4e/Qof6O5defPK+XvNDa8wmUJIkiNfl1GG1
         dDjaMTE89j8GCUTO+sqAzHWE3rsfth/r5URr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y6nDzAc3WuT+D3ggXnpnocD80VY/NBrdpemv3g0GHJ8=;
        b=OAzvkzCZbYlKihV68HtB4/kDIfmthmr1sSu2AuK0Da0/ziEDd1Ho1V5KL4jniJy50i
         fW2U+6ht9IbJkQEYx1/yZP1XQsazSVfG9GfiEFVci3nYhqhEcZbTJKmOqfwdI1JMh/qJ
         Kb6O67fcONcrCWZ25gM2ulTt9VqUoCGU+rkfsWJJff+yWKxWO8IsmaMiZA4o6p5EJR6x
         MMV3CuDdXTdhkCdCINrJ7QVwkhQ05z6fO4dW29wQO7a0E4FLeub/W5d0RUb5KIvPVL3L
         iHORsjYMQyyEodb6BqFiihlyF+Z+XPHZblDpdoCHNCx2gv0z478WRNp6rXw2Ib6fXWLP
         nd6A==
X-Gm-Message-State: APjAAAVW477oeW9WAU42Ky+YempRl5CRZ2ae+xhLOUJw9ycokqqMos8W
        BRMTbm/oVJDOx7A+34r+5ap25XB1vc0=
X-Google-Smtp-Source: APXvYqxHrOwrNPrl4WTC8seKqZ1AvT/nUdeUyM0N4S5tr3/aPl6X9Z/vydg+U1x1MA3mfU4KtAY2lg==
X-Received: by 2002:a19:751a:: with SMTP id y26mr4080546lfe.47.1556298546649;
        Fri, 26 Apr 2019 10:09:06 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id d3sm5219396ljc.15.2019.04.26.10.09.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 10:09:05 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id i68so2870651lfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 10:09:05 -0700 (PDT)
X-Received: by 2002:ac2:547a:: with SMTP id e26mr4435805lfn.148.1556298545193;
 Fri, 26 Apr 2019 10:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190425174739.27604-1-idryomov@gmail.com> <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
 <20190425200941.GW2217@ZenIV.linux.org.uk> <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
 <CAHk-=wiaZoELovfo4gkfxB0zi6k5pQJNkmSRsEoWYr_z-oupiQ@mail.gmail.com> <20190426170108.GZ2217@ZenIV.linux.org.uk>
In-Reply-To: <20190426170108.GZ2217@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Apr 2019 10:08:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgm37dg541ok7pOjM-3ifM8tbsNDSBO79FP_n7T-gPuOQ@mail.gmail.com>
Message-ID: <CAHk-=wgm37dg541ok7pOjM-3ifM8tbsNDSBO79FP_n7T-gPuOQ@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:01 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What I don't understand is why would anyone want to mess with
> name snapshots for dentry_path() lookalikes...

Talking about dentry_path()... Shouldn't the ceph path walking code
also check the mount_lock sequence to make sure the path is actually
stable?

Maybe it doesn't matter.

                  Linus
