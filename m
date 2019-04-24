Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4953AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD537218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jJLw1QbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfDXNuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:50:12 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35813 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfDXNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:50:10 -0400
Received: by mail-it1-f196.google.com with SMTP id w15so6308196itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mKz/luMtBy17RLYnZeF6UP5kIdo60vBRpeptyrj0nHk=;
        b=jJLw1QbIzB/Ybb/nEKkvhOLuDfRA68gaWMF+LCcOdFaR1gdjvEZS6LHCPsN/B64yF9
         R6nKme2aRak2nRR8MWdtGQ/bBhT6hRbGpU4NsD1DVdjmI9PamqCMIVGIp/9+vXAP6xDW
         ejnKZIo7WkXbsLoUE8rgkVxzrwOmGv7ji7b2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKz/luMtBy17RLYnZeF6UP5kIdo60vBRpeptyrj0nHk=;
        b=ZAu0fSXUutTrQrlRR/cvgTh/PqHQgwQbQBd7wR/jYBci5DGFCeyRj/zPS1AB6fknRz
         yxfxgKbS6kIcwjIsqwQyZREnXNhXFITXM/M+XrmzZTwl+aWl+HwPxV30lGSn5m89QhT8
         /rrPNU24PAUfAi+a4o6XtPdfoNnle459RLJDbuG/xLJ8Ivn4vf8UG2zfNO55owNbUnHP
         X83wonux2HbSZ/5MqeMVzhkP8q0zsJQl6equE3ZQzI7sKVjvgImB/XPSPA79dIJtnp/v
         8NNFISEcgFrEfafgxxMibD8MZITvXWOdpiOvBKm1KVKFLjwuapz31m9Pa9TK/1SyBzXb
         F3tw==
X-Gm-Message-State: APjAAAU0LqlDKCI0ai5RCwpwqzD3VzK5OtNIpeeHbb3Nshg9DDrjtZNw
        MhiynKAG8gxqO5Km4sdxk1e20b2T1B/u5hl878gSUA==
X-Google-Smtp-Source: APXvYqzx0xeC/wjWFLY/OEvZX8cI+84+BQ2oenSdoQNyEiXjh02dwzsYU3JcbtKTXdftrMJ3iJ+T8G5UCl+dFEYDojY=
X-Received: by 2002:a24:1342:: with SMTP id 63mr6371719itz.69.1556113809602;
 Wed, 24 Apr 2019 06:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
 <155373025917.7602.9176080493180672665.stgit@warthog.procyon.org.uk>
In-Reply-To: <155373025917.7602.9176080493180672665.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Apr 2019 15:49:58 +0200
Message-ID: <CAJfpegt6NXBHWnTHMnoCaszFhfRY+TDmyUaCaTGm-0vHYh7iMw@mail.gmail.com>
Subject: Re: [RFC PATCH 30/68] vfs: Convert fusectl to use the new mount API
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:44 AM David Howells <dhowells@redhat.com> wrote:
>
> Convert the fusectl filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
>
> See Documentation/filesystems/mount_api.txt for more information.

Applied to fuse.git#for-next.

Thanks,
Miklos
