Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326FCC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0755F214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568914916;
	bh=NlZteMVPAdJn2snK+8djGo5hS4QnBdcun4uuWQujV3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kf/XxNcvsy2Ur6fXCEy7aPrIbwIwKjdY1C7AEHX7MNoonSqN1ce30bu0XwTt/bZj0
	 969sal9UNAJaxSn2KlezC2FK4SGdl4aCV0kVe872UYH5+jpH11tLKYvR7TsE74gSza
	 z502yJcmufQlq36pkKzT1Rk7gZUYhHA1qwWu+JTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391010AbfISRlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:41:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40446 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389705AbfISRly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:41:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so4455576ljw.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FiZz07Z/205AAVNujcqJzuj2VRlA1gVyITjZ2X3S9P0=;
        b=LUgHYlFO2ivHWXkjIMWHXKro3f62RmlbsjtZDM3aN1lBnbF/0enyMjBYRqw1bvQU+o
         WjuX6sn56vnQRYqFCSVxl5+izbPmn5JthFgQ1CVdOhSEm0KaDtohrjU8sSopQtoAQ4n6
         i+xMWyf0WARK8PenV7l026IzYlve6DXyQGV3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FiZz07Z/205AAVNujcqJzuj2VRlA1gVyITjZ2X3S9P0=;
        b=AIUpm2Tf+Fp7WJo/lIoz9fhLKvj4wfCuvdLWCchCTQWMV60zBQ9Z56r8EAXdSSbeqp
         F00o8P3GHZAyMczYdkc6PdMLd+TcQUcu7p9zCcpb0TsiV/mVrG5bCN4byBDlivD0HJwY
         b0A5WwvJV3BkhOcJkdaTHkSyAE9ZSTkqfM9q99hsanYtnyVMZ18IAbcuuI2gllFp62F4
         3ri6HOVG2j8Ub1RNr653WibRJH7R8kmIZjxuRdXgzCE1gzOT2nov8GHTH/f6IQmuVFpd
         EbT7GOsAYA0U6MMQgrENTRctyoWygPpzhK0EnIqoxoS0uMkYUQCCDC90hDET5k+g6THr
         SvfQ==
X-Gm-Message-State: APjAAAX+MBSHV7o1SB5inCVEmo6Cn/dptmEP3lIQRGv8KBG8FquBC5HC
        IYmCVe3Rhxf6JNCqe+WjOgvwn4HURSA=
X-Google-Smtp-Source: APXvYqykPqad0kvPNa1QT1eYkvdy5x8Cz9I6F1hwN7oeHJg/n3RjQ3eFjEZuJ16NLj0/mdtOhscJKg==
X-Received: by 2002:a2e:b4c4:: with SMTP id r4mr6225647ljm.69.1568914911984;
        Thu, 19 Sep 2019 10:41:51 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id c13sm662525ljj.25.2019.09.19.10.41.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 10:41:50 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id t8so2960725lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 10:41:50 -0700 (PDT)
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr5665094lfm.170.1568914909864;
 Thu, 19 Sep 2019 10:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190917152140.GU2229799@magnolia> <CAHk-=wj9Zjb=NENJ6SViNiYiYi4LFX9WYqskZh4E_OzjijK1VA@mail.gmail.com>
 <20190919034502.GJ2229799@magnolia> <CAHk-=wgFRM=z6WS-QLThxL2T1AaoCQeZSoHzj8ak35uSePQVbA@mail.gmail.com>
 <20190919170711.GA9065@lst.de>
In-Reply-To: <20190919170711.GA9065@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 10:41:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgK7+TtDRbSAmcM5ihBDxF4eCg7zAXDkrNm7DOg+RtzyA@mail.gmail.com>
Message-ID: <CAHk-=wgK7+TtDRbSAmcM5ihBDxF4eCg7zAXDkrNm7DOg+RtzyA@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.4
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:07 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I personally surived with it, but really hated writing the open coded
> list_for_each_entry + list_del or while list_first_entry_or_null +
> =E2=94=90ist_del when I could have a nice primitive for it.  I finally de=
cided
> to just add that helper..

You realize that the list helper is even mis-named?

Generally a "pop()" should pop the last entry, not the first one. Or
course, which one is last and which one is first is entirely up to you
since you can add at the tail or the beginning. So even the name is
ambiguous.

So I really think the whole thing was badly implemented (and yes, part
of that was the whole implementation thing).

Doing list_del() by hand also means that you can actually decide if
you want list_del_init() or not. So it's

But again - keep that helper if you want it. Just don't put a badly
implemented and badly named "helper" it in a global header file that
_everybody_ has to look at.

                   Linus
