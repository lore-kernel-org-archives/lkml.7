Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5CDC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D8F21726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGeJ+U42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfH3OXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:23:30 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:45948 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfH3OX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:23:29 -0400
Received: by mail-io1-f44.google.com with SMTP id t3so14232616ioj.12;
        Fri, 30 Aug 2019 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAKN2+5gOLPMPuf7BlJbUSjK0cWgyfFP2uN2z8ewCJg=;
        b=dGeJ+U42tAGk9rSl2hMfBIfQAJpAlT/1/zDEnfF05khwqumThOytKi8gtwnEtRZbN9
         LixkjUHYfb/WITvZ01c21aFhxGgvRafaohxZlh9Y3ZX6JuYlTsa32WkGdW5DtyKMyZ4h
         9WqxA4H+3+tSLWstQpXbrWWwzljRFSo6hH2S3QQzTuDTioSbAo/ljkOExntlHY5n+VtO
         GhWE27ZLeMduZS0yLIiThQNDilngVjYxPI60gupwzrc2Aedl9o5dVxq4aZV8uxoFdvgc
         u7V/acNyPMIDx+4BVh9Ezws3DUmQSIBKr7938W8S4Y/Yq6xmlpYFouV2U2WFsfFUHKam
         1tgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAKN2+5gOLPMPuf7BlJbUSjK0cWgyfFP2uN2z8ewCJg=;
        b=iWvuf8iJpulQrnPz29hied7+iC/FcbXVqPy58gx6xE5mEDZCXWwhkhdxJM8IXZ90cq
         kMeJhQZFqh/PYF6SgtNOQnJkYoor/59/Y51/P9YoaarLcKw/37hOgiwDHo/sZM+SwS5B
         NtTPLlzLcvcDHd8pEhwg17lqFzXHNsCZF4ScDDvhTPhIVd9Q1V+6JoVNortxgG1V1SgL
         HAwPX9io9DkFwUkcoNwbU45Lf3fUyYpebFDa8jh6WIAYyLydWKBi6KGekjTXUO+bMPET
         +GbYs7lbk5iRiKk4QqLYFYX4Mjf4o/kWEp5ZxTXtjqS1iKKoOR9vuwFNHVcn06pzwrER
         UsFw==
X-Gm-Message-State: APjAAAWiPguvsjhPUjUYucs71Keba95vizh1ZO9w5JgxTPzrnBGXC6ya
        3KRhfhFUGs87DD4p/dLiiMVj8M1gkPQ3MCSmD5o=
X-Google-Smtp-Source: APXvYqwpFvalYsCne/ND6Uu8f0n9Qhicy+mp0atcatB2VB0PQJvW2LXDJmPSYERIVaKNF1rr6SuUVYo83e7pGmfkkU0=
X-Received: by 2002:a5d:8444:: with SMTP id w4mr13537606ior.51.1567175008927;
 Fri, 30 Aug 2019 07:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <3a4ff829-7302-7201-81c2-a557fe35afc8@canonical.com>
In-Reply-To: <3a4ff829-7302-7201-81c2-a557fe35afc8@canonical.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Fri, 30 Aug 2019 16:26:33 +0200
Message-ID: <CAOi1vP9x1SS9YGFgHuZcpga5fTYac-y3vazsAKr9N8WJB7-hpA@mail.gmail.com>
Subject: Re: bug report: libceph: follow redirect replies from osds
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 4:05 PM Colin Ian King <colin.king@canonical.com> wrote:
>
> Hi,
>
> Static analysis with Coverity has picked up an issue with commit:
>
> commit 205ee1187a671c3b067d7f1e974903b44036f270
> Author: Ilya Dryomov <ilya.dryomov@inktank.com>
> Date:   Mon Jan 27 17:40:20 2014 +0200
>
>     libceph: follow redirect replies from osds
>
> Specifically in function ceph_redirect_decode in net/ceph/osd_client.c:
>
> 3485
> 3486        len = ceph_decode_32(p);
>
> CID 17904: Unused value (UNUSED_VALUE)
>
> 3487        *p += len; /* skip osd_instructions */
> 3488
> 3489        /* skip the rest */
> 3490        *p = struct_end;
>
> The double write to *p looks wrong, I suspect the *p += len; should be
> just incrementing pointer p as in: p += len.  Am I correct to assume
> this is the correct fix?

Hi Colin,

No, the double write to *p is correct.  It skips over len bytes and
then skips to the end of the redirect reply.  There is no bug here but
we could drop

  len = ceph_decode_32(p);
  *p += len; /* skip osd_instructions */

and skip to the end directly to make Coverity happier.

Thanks,

                Ilya
