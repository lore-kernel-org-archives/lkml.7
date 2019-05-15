Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8E2C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD74920815
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8tajLnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfEOPCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:02:34 -0400
Received: from mail-yw1-f41.google.com ([209.85.161.41]:45975 "EHLO
        mail-yw1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfEOPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:02:32 -0400
Received: by mail-yw1-f41.google.com with SMTP id w18so35210ywa.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JOLdwTp5zRnKj+hnZ/GDoFywULiYCABqyveX8EJm5BY=;
        b=K8tajLnUevxTs9F5zqowM410qkZAK9RFWtlu34lJ/mIkKmEnPdLHEDzVZZyuvMO4Cl
         ZT7hha/aWIN1JOqcnWJtq9c5byixcK6V73iTabiaIrYYXU1NuX9vAmE8/jcTJlcR7Yox
         t6YMB70z2IBohCh621ydwKso4naAlxgtPFpmsZeSq8dyMQ1YjH4lim4h1TVnGqWSYxwn
         Z7xuOkWOCe5xh/XxJegCGbY+qx7DeGwJ9Ut2heb16Q1CLBF3bFQo2WF95e8yNFm+uhug
         OkxNjXwqnXWCw7t8wdlkk/20/kul3QspQZpFzaQ3JCKeU3hpRUdc2qnWrMbSmbT4SlNT
         YTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JOLdwTp5zRnKj+hnZ/GDoFywULiYCABqyveX8EJm5BY=;
        b=d77i/CijFx7ba5ZP/BIorVJDZypAv0KEc0eut//daiMPLMvpjtSq5KkkZuWMWjAoqV
         doyPHzBihrsP3IVsVkMVnuzWcD/d70DCYSe9b9Ua1fSgThCMpZxPaARTzrwzy/qgLYfu
         6aZcT/hpw8U6W+HNe//nIK5yCBMgwxYMXdiz7LsMwpp2ef0jKhzN4JmWJRvTxYgl9DBK
         NVEaUhFFPCkAykDMcDgU3AMngKaDbULRT34zH2RinCNwjV6I87HJvHbWjfanfenON3e8
         OZRnU/JkJuqueSBZkvQVX871I6tvm7jZjRVVes51cs076Hnnyze6aplzNte55Sq5daSn
         DWVA==
X-Gm-Message-State: APjAAAUjY9wa8bpkKfHAsJNgjAe/7wTrPZgz2DD4ktEAIv5YAk4CFgNU
        jK4N3oItKi9Fhzc81bNUsG0ZCYiEclyd1te8Eto/0FouFyalLw==
X-Google-Smtp-Source: APXvYqxGnVrqH3KQxncl63mkJGYEYCoRKq72QJ6MHEZ+nCms2p/s0E4Z0+F6m1GJjsJtLGvK8ocwvuD0CoB3jyv1g/I=
X-Received: by 2002:a81:27cc:: with SMTP id n195mr21182715ywn.60.1557932550591;
 Wed, 15 May 2019 08:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <d68c83ba-bf5a-f6e8-44dd-be98f45fc97a@camlintechnologies.com>
 <14c9e6f4-3fb8-ca22-91cc-6970f1d52265@camlintechnologies.com>
 <011a16e4-6aff-104c-a19b-d2bd11caba99@camlintechnologies.com> <20190515144352.GC31704@bombadil.infradead.org>
In-Reply-To: <20190515144352.GC31704@bombadil.infradead.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 15 May 2019 08:02:17 -0700
Message-ID: <CANn89iJ0r116a8q_+jUgP_8wPX4iS6WVppQ6HvgZFt9v9CviKA@mail.gmail.com>
Subject: Re: Recurring warning in page_copy_sane (inside copy_page_to_iter)
 when running stress tests involving drop_caches
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Lech Perczak <l.perczak@camlintechnologies.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Piotr Figiel <p.figiel@camlintechnologies.com>,
        =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 7:43 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> > > W dniu 25.04.2019 o 11:25, Lech Perczak pisze:
> > >> Some time ago, after upgrading the Kernel on our i.MX6Q-based boards=
 to mainline 4.18, and now to LTS 4.19 line, during stress tests we started=
 noticing strange warnings coming from 'read' syscall, when page_copy_sane(=
) check failed. Typical reproducibility is up to ~4 events per 24h. Warning=
s origin from different processes, mostly involved with the stress tests, b=
ut not necessarily with block devices we're stressing. If the warning appea=
red in process relating to block device stress test, it would be accompanie=
d by corrupted data, as the read operation gets aborted.
> > >>
> > >> When I started debugging the issue, I noticed that in all cases we'r=
e dealing with highmem zero-order pages. In this case, page_head(page) =3D=
=3D page, so page_address(page) should be equal to page_address(head).
> > >> However, it isn't the case, as page_address(head) in each case retur=
ns zero, causing the value of "v" to explode, and the check to fail.
>
> You're seeing a race between page_address(page) being called twice.
> Between those two calls, something has caused the page to be removed from
> the page_address_map() list.  Eric's patch avoids calling page_address(),
> so apply it and be happy.

Hmm... wont the kmap_atomic() done later, after page_copy_sane() would
suffer from the race ?

It seems there is a real bug somewhere to fix.

>
> Greg, can you consider 6daef95b8c914866a46247232a048447fff97279 for
> backporting to stable?  Nobody realised it was a bugfix at the time it
> went in.  I suspect there aren't too many of us running HIGHMEM kernels
> any more.
>
