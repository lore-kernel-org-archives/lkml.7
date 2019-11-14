Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B099C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6087C206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Gf3JcA/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKNPe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:34:56 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35022 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfKNPez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:34:55 -0500
Received: by mail-io1-f65.google.com with SMTP id x21so7284106ior.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 07:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TUlRU9cKKaNVZQJfAQT/do7G2k04lqCGA4z6vNnMsGQ=;
        b=Gf3JcA/6I5FyJbc72sKAqamUPXFxiPVt7Hj5319gDyzsYiJMudzuRdZXmvEpYlK/My
         4UW7i5B9KNCTYQn7nI9dTWijqpLioNvi2TfIVwOFIykEZObvThrKzFX9U8pmytRR07+e
         elXel76PlSzf5sFKyKbZ4XcUWsTA4iLSFjtn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUlRU9cKKaNVZQJfAQT/do7G2k04lqCGA4z6vNnMsGQ=;
        b=ovtfWDNX0L2JdzkQ3PGPMJomLTr5arQH6wcuBafVQBVP2Jg+BySBsSW4F2q51EudMR
         68o5VCXhLuvd8Jo76ZWVmod5RbzPDAfrqriodqJ4sWMqnwi2kBXMwB8bja955oshh57C
         BcaJGPJNJQBR0acUWp5SyOMfIxTYPLyZVeDWHH6USpkNfdQ5fqsbOlrQPhNnuCYsW/Te
         4KQNIKW1nrs+bbb4ToHgspX1QdunsnaW3AbPh7HyXqOjbKaT2nbH/2K/4x792yKfDvwf
         xf6d9NeYfAQ0wE8IJMNYp/giovZxYL2h6T0qWR0gPaLzBfQqGKjmsS4CQyISATm3vEm5
         nd9Q==
X-Gm-Message-State: APjAAAX0x0ikJJC8RK9/jRffIwQ12wvyefTGosSxK/cVkUMr6FJctKX4
        D4wBzof6/nnm+vAfI+O0XYQE1Sq88xLiKmmVZ/iRpg==
X-Google-Smtp-Source: APXvYqzSGRk8kaQZw1eAWtpTrcv0aiDPDHw7DokTcyToLRrifSAcy/pMiW4l+KCNIFd1O0AHk+CEm1Ze7LF4tMBSKQc=
X-Received: by 2002:a6b:3bca:: with SMTP id i193mr7558649ioa.285.1573745693624;
 Thu, 14 Nov 2019 07:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20191107104957.306383-1-colin.king@canonical.com>
 <CAJfpegtr_xg_VG2npTfaxC+vD7B8bKa_0n9pu5vyfU-XQ9oV9Q@mail.gmail.com>
 <CAOQ4uxhnpeyK6xW-c5NOQZ_h1uhAOUn_BbVVVYhUgZ74KSKDKQ@mail.gmail.com>
 <CAJfpegu7egxf=BVyVQKKW_icjMbjdLcLdd1FEw5hXLvDaiLNVQ@mail.gmail.com> <CAOQ4uxh8n-QW+zTe3Y56suyaQf8Tcascj337AbMmKF7jf9=sjw@mail.gmail.com>
In-Reply-To: <CAOQ4uxh8n-QW+zTe3Y56suyaQf8Tcascj337AbMmKF7jf9=sjw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Nov 2019 16:34:42 +0100
Message-ID: <CAJfpegvKnWR6_aPFwjcP8E7CRPesHPc3Svk=n9=39CnM=Mjfvg@mail.gmail.com>
Subject: Re: [PATCH][V2] ovl: fix lookup failure on multi lower squashfs
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        stable <stable@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 3:37 PM Amir Goldstein <amir73il@gmail.com> wrote:

> What Colin has now reported brings to light the fact that
> decoding lower file handles was also required for making inode
> numbers persistent.
>
> So the bad_uuid condition is required for all of the above, not
> just for decoding origin.
>
> > Can we do a message that makes
> > that somewhat more clearer?
> >
>
> What about the logs:
>
>                 pr_warn("overlayfs: upper fs does not support xattr,
> falling back to index=off and metacopy=off.\n");
>                 pr_warn("overlayfs: upper fs does not support file
> handles, falling back to index=off.\n");
>                 pr_warn("overlayfs: fs on '%s' does not support file
> handles, falling back to index=off,nfs_export=off.\n",
>
> Should we also change them to reflect the fact the decoding origin
> is not supported???
>
> Seems like a lot of hassle that will end up writing too much information
> that most people won't understand.
>
> IIRC, we also do not guaranty persistent inode numbers for hardlinks
> when index=off.
>
> As for the change in question (falling back => enforcing), if that bothers you,
> we can get rid of this change by testing emitting the print only if
> (ofs->config.nfs_export || ofs->config.index).

That makes sense.

It would also make sense to have a section about inode number
persistence in the documentation.

Thanks,
Miklos
