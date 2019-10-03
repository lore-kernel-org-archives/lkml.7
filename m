Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF8DC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4BC20700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="j7uCFhGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfJCIVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:21:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32805 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJCIVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:21:14 -0400
Received: by mail-io1-f65.google.com with SMTP id z19so3599783ior.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLUXPRqEOCygu/EGgdl2O2z0foonvyQ6ZBGr8u4DDCw=;
        b=j7uCFhGnDcTfGd9C9paYejhHB74a6nNQtbtnb0HInonQwB1s+AQY9FDZF8m44u9dfN
         7Gt11+q0G+/ZxEmyC8mJdWk+z58fzsYt5CEl8HKd7cio977ku0tDKDpAa6SI1GljShFA
         hDmeMdwzayLvw40tl8qMr88agAoFqlhvyciK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLUXPRqEOCygu/EGgdl2O2z0foonvyQ6ZBGr8u4DDCw=;
        b=pcMasN6Ggo7Vrw4cDeoKCWnzn43CQDVT2P73QQV3cmOsyEk1GUXRqZxjWNW+EbQTQ8
         2snHnMALJSiSiB/kDMMhN3GTta8AIWUvnKTuwkWv1wKkyWkoVszBGib+bBRQAcB75l3v
         0Z3JWhXReEWTrjHS4cKyJxCWcKVdc8dUUZ2iDfNh00XnI3ACel/CrctE8en2iu3u4BVn
         yxE6NlPpHiYY8YOPKzGGGrkYi9Z6saYEW58A8cF01jnzKfNArzXVH5oLDJcOTqi5tw7M
         tdrbCxtvpS9PbDM9g/+/uDfTt0Y0ZwOX5UednMc5CR7si7o1DuYZusRyT6tS4amUKjF8
         e4cQ==
X-Gm-Message-State: APjAAAUeJd+Crg38ew8ScfMOwP9AGOJmo3fcmmEuHT596ZWID0NOVSr3
        CMeKMJp0wd9xi7PcIWJ8+du+SbE2CO7vbNkgWn55/sg+
X-Google-Smtp-Source: APXvYqy4Fzd3kvw63DCpxYSiPXoXOG4fCbSTFKpqvVSDmZ3mTPbijgIBFiRuA8AHLoBsTe2bqMFjuxiIPhRP+Lchwwg=
X-Received: by 2002:a92:d5c5:: with SMTP id d5mr8196061ilq.63.1570090873314;
 Thu, 03 Oct 2019 01:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <c09509ef-982e-d4bd-ed0b-da8389a7d066@virtuozzo.com>
In-Reply-To: <c09509ef-982e-d4bd-ed0b-da8389a7d066@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 3 Oct 2019 10:21:02 +0200
Message-ID: <CAJfpegtSLNBHDSTEm9aRhi2J+8JNPnZjcBBB_j5cjA6NtqZZOg@mail.gmail.com>
Subject: Re: [PATCH] fuse: redundant get_fuse_inode() calls in fuse_writepages_fill()
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 7:48 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Currently fuse_writepages_fill() calls get_fuse_inode() few times with
> the same argument.

Thanks, applied.

Miklos
