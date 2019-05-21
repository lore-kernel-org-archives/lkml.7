Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E7AC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A92D217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8+Nl3k3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfEUIfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:35:14 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44305 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfEUIfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:35:14 -0400
Received: by mail-ot1-f65.google.com with SMTP id g18so15550080otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zhesb/W9XipgqrrNPLPqdvD2/za82zT6LyixgGoAM9s=;
        b=g8+Nl3k3OmDRuhKnSDZ37atwAn9xDqShtEIgKkznYcwmj+Zel0rTQe6B+bM7VVqTg6
         HftrbAok5EBMpmqmEzsERSjy5C2VBa4UqvgS0MANQiWbirTmoYJHLvaDE6Jp7AdU7/9S
         PBOV0OKabhqHvwZyjvdsKEJPtubnCVxFQjp9/cmsDxFOyq03txxbSuDPZ1UfnnABV29f
         oW6MJug9tmEdAuvq5xAjLP/7k5WUxUi45x5BafEHdBjLryz/mwl8ny+KBbUHB7DxgocO
         uOtcFo/PY9TTGrIo5ykqyZDnTBQ3BC9Rq3JqT3MpcO6iP7VzQd3v9DiytY2FSSwGnm7H
         +38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zhesb/W9XipgqrrNPLPqdvD2/za82zT6LyixgGoAM9s=;
        b=HRLi1K8kaB9jhrWwQ9ODzBakxNXo3BWawy+qExC5uF2U9+g1xVHTIYjpJ39ALvcMqe
         90pZ+Smml5wjOTB1Es6yW1DIjRA78we9BbDv70YfAnrcnUtkTVU5hGfyVE62YMPPBb1g
         jXUwr7Ok1qI6QTcZDFLgIplpRrWymsQyIyU5bjJRzjtTFt4jVPXHRGN02Ho4DDb4/Ipy
         ZHOZ6HxpByro4qYWump+U8F8+2JdY6FfdM3S71FLlys/yPmdctElNhbvYGNAhVx9oVHG
         T3B7ebmaF4sEK1Ntj0oI47V11HIuDM9iDR4fXFnZM6FDo12Db9vgUgAb+IOMzdy1W7RE
         Lizg==
X-Gm-Message-State: APjAAAW9s32LHjDR2gkVNHEMG9qwwIBCLsCx6tuw+AMy3IC9nIYVArTm
        fAvtyWqOZhnlcaj3uy/tsiBlgU8ZaPVORB1eWt4=
X-Google-Smtp-Source: APXvYqz3hpBMsWdirjkxZ8tRVzOfXjig/h3dw4rm3JyHPeypK3C2UNCfDy6OzMjDYsO+eF9M1hj183BMkseb63C8G8o=
X-Received: by 2002:a9d:10d:: with SMTP id 13mr19056614otu.14.1558427713459;
 Tue, 21 May 2019 01:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558146549.git.gneukum1@gmail.com> <20190520083026.GA13877@kroah.com>
 <CA+T6rvENoDXbUWEi4C5kXxsdamkZKVP19MwzEuxs0qC=ckMyeQ@mail.gmail.com>
In-Reply-To: <CA+T6rvENoDXbUWEi4C5kXxsdamkZKVP19MwzEuxs0qC=ckMyeQ@mail.gmail.com>
From:   Geordan Neukum <gneukum1@gmail.com>
Date:   Tue, 21 May 2019 08:34:52 +0000
Message-ID: <CA+T6rvHrhTQLL_WCAPbj9nXngH2NCoW+kMXgGpGWB7+rLfYEOw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Updates to staging driver: kpc_i2c
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, May 20, 2019 at 10:30:26AM +0200, Greg Kroah-Hartman wrote:
>
> All now queued up.  I'll rebase my patches that move this file on top of
> yours, as kbuild found some problems with mine, and I'll resend them to
> the list.
>
> Thanks.

** Same content as last reply, just realized that I had configured my
** email client to do something wrong. Resend for readability's sake.

Additionally, I plan on trying to clean up that driver a bit more. Should I
base my future patches off of the staging tree so that I'll have the
"latest" driver as my basepoint? I don't want to cause any headaches
for anyone in the future.

Apologies, if I missed something obvious on the newbies wiki.
Assuming that I did not, I will certainly go ahead and try to document
this case either on or as a link from the "sending your first patch"
page.

Cheers,
Geordan
