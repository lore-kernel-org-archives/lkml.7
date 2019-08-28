Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360BBC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02942233FF
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dhNnulrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfH1Hpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:45:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43977 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfH1Hpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:45:40 -0400
Received: by mail-io1-f65.google.com with SMTP id 18so3966394ioe.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqkmpot9s6gPML1W2+U08e8kxWH1kqOpgIslvJ6ETaY=;
        b=dhNnulrZXhgiY7H6M+oJdiiIwYTeim61SHJlStKeam/O6Txv6bzIsCPGf1aTvCiGGC
         TX4oGm3mf/6F7uOsTWqquRw/W1VoA3P0uDRu7tmP2WSvzGWA/XKlTEvFiY+1asbMoW5T
         GOEa9uhLbKi979xcEOROpziFYXdhp8Wq1Mgow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqkmpot9s6gPML1W2+U08e8kxWH1kqOpgIslvJ6ETaY=;
        b=EGQBRJ0JiHDfgk/f348D/H/NgqOkKNcEDZc8uslYsZRss3WoN+ZmYTm5pf4tBSVtpC
         tp8RZ/jTnlvZvlfGfJDCBViz4YUdSeJVO099zHHRWU0CdHlSpAB/+7ta2/WvtK21zHRw
         UfSX9grKVLUp0h9fS7Sk6Op+gH4lrt8vsF0kkMkV9KJE3J3Uy4PovgKta8ZlHmzLnGAU
         O5sPqQPq2Mzy+k2PZX6/TgnepZDOVyOTqQO/pZ66lJsEQjYd3PCNfyYDxlhRhGeB/RfD
         MEN6+UD2yE9lt+ULPlBGbOhxWEuJ9FGEpBr5q/buXEB1BGDzrhyZzI0LYUg/SPlsMSNz
         k/0w==
X-Gm-Message-State: APjAAAUgQPpuPyLha5VYjNNdFsEMyHNaDR/ZjzEBGGpK2RWJxEvcBmB2
        BtDntn+C0S0g1NBOOoRcBUnd3cOnoSCxusN9SJmXhQ==
X-Google-Smtp-Source: APXvYqwvcgiWD5jnYj6W7sjF0Z06MFIOGVfOgyU6g+WXl4ZvJZBSr7UCmhcfmcV09SKbgqMIBLz+K7UVbXQPXD0ih5w=
X-Received: by 2002:a6b:6f17:: with SMTP id k23mr2169967ioc.25.1566978339324;
 Wed, 28 Aug 2019 00:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190821173742.24574-1-vgoyal@redhat.com> <20190821173742.24574-3-vgoyal@redhat.com>
In-Reply-To: <20190821173742.24574-3-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 28 Aug 2019 09:45:28 +0200
Message-ID: <CAJfpegu41FYEBfniEBPtujgLW4nC+w6_6VG2EmNi=kC8ZeNFtA@mail.gmail.com>
Subject: Re: [PATCH 02/13] fuse: Use default_file_splice_read for direct IO
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 7:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> From: Miklos Szeredi <mszeredi@redhat.com>

Nice patch, except I have no idea why I did this.  Splice with
FOPEN_DIRECT_IO  seems to work fine without it.

Anyway, I'll just drop this, unless someone has an idea why it is
actually needed.

Thanks,
Miklos
