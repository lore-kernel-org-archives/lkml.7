Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF012184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="PbQzOVrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfCNHeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:34:46 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40652 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfCNHep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:34:45 -0400
Received: by mail-it1-f195.google.com with SMTP id l139so3132964ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5j7xlTpPCfN62y7RLvULhwbqVmECMd1pBios9Gk8yCo=;
        b=PbQzOVrvNnnL6aGps6qRwBVqplB+yUbNaSKxPEvW9gz2kiMJEZ1k9+A9c3ZFkGNOqq
         CXzYb6s47WoUkXCoTGy42LFP4KS8bRlHk2F1MvR/WuX9mXdxnF3SvTqqxMOHxGrpdFj5
         H4FaJfHcjQIdh5DyFxThUt/qvMR73JWYtEh3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5j7xlTpPCfN62y7RLvULhwbqVmECMd1pBios9Gk8yCo=;
        b=FYMDXxryCldR64NCFfXa/6FK2Mdzes8pV+FTMQy5xLDkPU1i3nHoYz+HuC+dtuylCT
         KoHcq5N00I3W6bsm7kvjOt+Kppx26oDGuK2uplnk+4pON5xckIpO0tPywq4lXTrYoZS6
         hXbz56qBf2/oR0uvh4VAlFL+w/bTNylfOFCTIrtALNiRKhVbKc+8OJ57rxzZ/9hvuT7I
         1cbDZwnJkxg6lZ7t7Gz5BNjQrjsBFpiEkj0sB5yO/0V0o+aopOORgvzptmzSNLM7aox1
         x4egFUIugiWV/c9O/ZQgmYQJRp6vZXLDpl9TvU74UZAF+vNK75XJ3OWKu1XF1B56ljDl
         JlKQ==
X-Gm-Message-State: APjAAAWAN1MU4WYPv5AjRn6pvi7PMgNxmhK/edJK2JifvE5/xhLkyhZ7
        FWew0HvBqOLNRY5goKvQtCx4JxMA0zlsEC2WyZgslg==
X-Google-Smtp-Source: APXvYqzCiQVr5TF9z2qS6mwXDvX9wPnScA+1X9nrCp6IYmHfaNqlkVTqi/NaQPW9b7SemkgvbN5wFagoE5oJ8WPPrzo=
X-Received: by 2002:a24:1947:: with SMTP id b68mr1054204itb.121.1552548884924;
 Thu, 14 Mar 2019 00:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <4603533.ZIfxmiEf7K@blindfold> <15244624.W7e5yEypHC@blindfold>
 <20190313222610.GF10169@gmail.com> <4098793.CtYQtWW4dM@blindfold>
In-Reply-To: <4098793.CtYQtWW4dM@blindfold>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Mar 2019 08:34:33 +0100
Message-ID: <CAJfpegvX4ANfso-Jn1zaB+m4Q_0eK9i-+MCJ+sTH5QzD3PZFMQ@mail.gmail.com>
Subject: Re: overlayfs vs. fscrypt
To:     Richard Weinberger <richard@nod.at>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 11:42 PM Richard Weinberger <richard@nod.at> wrote:
>
> Am Mittwoch, 13. M=C3=A4rz 2019, 23:26:11 CET schrieb Eric Biggers:

> > What specifically is wrong with supporting the ciphertext "view" of enc=
rypted
> > directories, and why do you want to opt UBIFS out of it specifically bu=
t not
> > ext4 and f2fs?  (The fscrypt_operations are per-filesystem type, not
> > per-filesystem instance, so I assume that's what you had in mind.)  Not=
e that we
> > can't unconditionally remove it because people need it to delete files =
without
> > the key.  We could add a mount option to disable it, but why exactly?
>
> You are right, fscrypt_operations is the wrong structure.
> My plan was having it per filesystem instance. So a mount-option seems li=
ke
> a good option. Of course for all filesystems that support fscrypt, not ju=
st UBIFS.

Yes, please.   Changing filesystem contents based on a mount option is
orders of magnitude more sane than doing so on key insertion/removal.

Thanks,
Miklos
