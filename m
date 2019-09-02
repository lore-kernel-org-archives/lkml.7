Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6574C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6598E20644
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="D+72l/Nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfIBJAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:00:12 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:35374 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbfIBJAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:00:12 -0400
Received: by mail-io1-f45.google.com with SMTP id b10so27798961ioj.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fd3FeCU7/lkSs+4hKTB7nxoikEcFVQTD+3XfAy5XBzU=;
        b=D+72l/NfpI56VPuqkndfTavFIl1l8xpVpWYNpMJq26fl5Rb9dZYzWjMFlz8/OBez41
         uZ3SohOL2xCQd1IRtsnU3Z4kGkO4u63E32khQETJH7ZkTZ1VFRdPBGlFHLqXU3IPnku2
         78mLg0FUgKTjRlWtQhJBluDOL1fI6hQCpB1vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fd3FeCU7/lkSs+4hKTB7nxoikEcFVQTD+3XfAy5XBzU=;
        b=KH9s9IUNsTgqtZqNLfjWOR/GofvLMEh/eDHGVpc+MykGJI9vEe8bldehOsyKbVq2fv
         lxWNEL2PtnyK33lalA0RJnrxgxr9Pq7dJYUSLeh9cLp+XMzU+mLZZIL+T4EHKWsO3hyU
         YyQgpx3Z7Rs2dq+DH2D85fwe1ZgjYsE72FzIxiZN/jgxGMwxX3ctF4HulmZNEvjaEf3h
         3Wt52IywZ+EdJ1x6Ue91DDiqgVhCR2EZkuuG5QmsYhkSBXGpykN0Hj6hs6I4WR1yo8cH
         ej82Yijrl7Cmb59UD6Ybz/eLKIPcFFgvL2yKxpNho60MXppBXsx/y/6xZOUpu9JCmeGX
         IN5Q==
X-Gm-Message-State: APjAAAXoqj3iGBYe3TksrpZq7Rz5K1mVttaq7kUYg40VagGTjGx74EAG
        pfBSsUbcJeaXbnhb2CNkLIgIa1rAo9IKRY7+PTAdwA==
X-Google-Smtp-Source: APXvYqxjmqayGM06FSCz0PH9m53ZWSr3HdWaxZGzrO4SUE8d24XHfTaq3fBlJDHoJgoSTjZM4jPv1Tjb1qVJQjm0lwE=
X-Received: by 2002:a02:cb9b:: with SMTP id u27mr3054872jap.26.1567414811516;
 Mon, 02 Sep 2019 02:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190830130119.446e7389@canb.auug.org.au>
In-Reply-To: <20190830130119.446e7389@canb.auug.org.au>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 2 Sep 2019 11:00:00 +0200
Message-ID: <CAJfpeguxmJvCV+PXr=wz5HXONKv4RDmZ1LpYNEqAtvw_smP5Ag@mail.gmail.com>
Subject: Re: linux-next: manual merge of the vfs tree with the fuse tree
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 5:01 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the vfs tree got a conflict in:
>
>   fs/fuse/inode.c
>
> between commit:
>
>   1458e5e9f99a ("fuse: extract fuse_fill_super_common()")
>
> from the fuse tree and commit:
>
>   2ad9ab0f7429 ("vfs: Convert fuse to use the new mount API")
>   48ceb15f98c8 ("vfs: Move the subtype parameter into fuse")

And the latter is b0rked anyway.

Al, please drop these patches from the VFS queue, I'll take (and fix)
them through the fuse queue.

Thanks,
Miklos
