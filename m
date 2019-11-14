Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B3C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD1420409
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RPQgdynY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKNKa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:30:27 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36534 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKNKa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:30:26 -0500
Received: by mail-io1-f67.google.com with SMTP id s3so6223635ioe.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 02:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0ODQMjiIKKDNHMHFmstYPQVkSDb52CtygX5wXt7a60=;
        b=RPQgdynYquk1oX1FlJYROA3WoECoE8TuBO6QFqoYnJX2y6zQvSgSS12bmkC2MMNyVm
         ubKNHkff9bsXOxrsS8frUFNImLf/lTOBrv4PDhNbvVsWy/jR33CM+eyXSDYWyvYXuH1R
         SsbDaX4F8xABNuwPY3VKxmfk0hUTpSr2JPeIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0ODQMjiIKKDNHMHFmstYPQVkSDb52CtygX5wXt7a60=;
        b=QR37aVeuQUHss9TK+IhKFa5M2ytu8auH3/DUZTC0XGyE74gehvOrTMrSjPqn8iwV7K
         Y95hXJ9k5d6kR7AR6e0/sgRCiznCI5Vo6n8mtbGVvNW0JBrJtpbJ69V5cS4sVGlchQpp
         kPuWa4w6dkQuY+7ma8tF2hIEh4Af2Cy7LVmISPzknx3NvuVM7dDfnAmLj6CHCvLeg+zG
         H65h9qyydKpXfQ6/nD4HGnBn7gfzmhBVKVrD+0Zr4gGy/m9jxBRPLhvp/LAUh7ay1qxc
         /RmI9kjsJPOY7zY/AmgR8DV9Cs2SA0H/mwmN7J+/QXbBZLTAREhu5AUETdWWP0iiJUio
         OARg==
X-Gm-Message-State: APjAAAV07FccYzii/O+fBdf4dQc5V632BQ08aG2ctxwuMfJdUtf8wbgm
        z/8583KyeA9CN8kuQIP7VwSjGjcxe0PBynv/D3+1pw==
X-Google-Smtp-Source: APXvYqyFB3goydsCrDzye1z3rnm33m5fU70E0wh+81ZMdqXoZNXF97wesNRGnM95NZF4bjAMv7oGDQM9lP5R7AgpLFI=
X-Received: by 2002:a05:6638:9:: with SMTP id z9mr6880049jao.35.1573727425730;
 Thu, 14 Nov 2019 02:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20191113200651.114606-1-colin.king@canonical.com>
In-Reply-To: <20191113200651.114606-1-colin.king@canonical.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Nov 2019 11:30:14 +0100
Message-ID: <CAJfpegug-saOEigqDNKfwMR5qdzrbLnRBD=0eN5juGioFH_L_Q@mail.gmail.com>
Subject: Re: [PATCH][V4] ovl: fix lookup failure on multi lower squashfs
To:     Colin King <colin.king@canonical.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 9:06 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> In the past, overlayfs required that lower fs have non null
> uuid in order to support nfs export and decode copy up origin file handles.
>
> Commit 9df085f3c9a2 ("ovl: relax requirement for non null uuid of
> lower fs") relaxed this requirement for nfs export support, as long
> as uuid (even if null) is unique among all lower fs.

I see another corner case:

n- two filesystems, A and B, both have null uuid
 - upper layer is on A
 - lower layer 1 is also on A
 - lower layer 2 is on B

In this case bad_uuid won't be set for B, because the check only
involves the list of lower fs.  Hence we'll try to decode a layer 2
origin on layer 1 and fail.

Can we fix this without special casing lower layer fsid == 0 in
various places?  I guess that involves using lower_fs[0] for the
fsid=0 case (i.e. index lower_fs by fsid, rather than (fsid -1)).
Probably warrants a separate patch.

Thanks,
Miklos
