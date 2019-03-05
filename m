Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61675C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3008A2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfCEIev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:34:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37208 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfCEIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:34:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id a48so8161411qtb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 00:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMVtnd/QdJ4T1acw/rhWxMKJH0y8Q1v97kzTlEz+Tt0=;
        b=A5xeuZIthFBxA7g2Y1AMnmiUNYJJ/TgmgI688EGxhz1BxkuKlTghe7LX72ZBfOtKio
         gjicvSpWhkK9Z8OsCoCjai/UHvNwIaIN2YZCWZIQV/W1csFBhx6SslWePYbNCoadtBrs
         7uI2vMGt831V8e0d8Hg6blEQrCFU5UueIzjEJ1jE/b5yVsGoo/QJLWlk8WGuvaKqd1TK
         3WnxWg1gyvd3lROIEMAbj1aGkE2wBsOrIw6cT//ZLxavOZMpRmaFONiuyD2fF8nD0LyS
         +6B+1HHRV4zDaqb3dZm9R2SsPhazCWR3WgzB0HZ0EkcW+cHnGBmUlK4XhlSGGo3vcOLH
         o1Vg==
X-Gm-Message-State: APjAAAWKXCwMA5cp9K3RdyaFnjzWlcp2bDakhEtevNddiMb7/XqYB99e
        tyjjdP8r7h1gHrF+/0zUQLviBb6V1ILvgWUGS4o=
X-Google-Smtp-Source: APXvYqyBpD51V8udl30qZBl/wWku3sP8Nm6IvFcbto/waT2UazECHOgBlD08rK9TVKJ3d2YOctQ8lsVaiUmkgY2uxeY=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr1154386qve.149.1551774890097;
 Tue, 05 Mar 2019 00:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20190304204826.2414365-1-arnd@arndb.de> <0eaa0d35-0be8-0053-1dcb-feb61d441bd2@suse.com>
In-Reply-To: <0eaa0d35-0be8-0053-1dcb-feb61d441bd2@suse.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Mar 2019 09:34:33 +0100
Message-ID: <CAK8P3a3vbjOzKAD6zce09Gc438tW=nYuMAJCE0MrODhBjO71xg@mail.gmail.com>
Subject: Re: [PATCH] xen: avoid link error on ARM
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Matthew Wilcox <willy@infradead.org>,
        Paul Durrant <paul.durrant@citrix.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 7:39 AM Juergen Gross <jgross@suse.com> wrote:

>
> Can we avoid that ifdef in the Makefile?
>
> I'd rather have an architecture independant builtin driver added which
> is always included for CONFIG_XEN. This would allow to move redundant
> stuff from arch/*/xen/ into it (e.g. xen_vcpu_id).
>
> So: rename mm.c to xen-builtin.c, use:
>
> obj-$(CONFIG_XEN) += xen-builtin.o

Sure, I'm happy to change the naming and the Makefile logic. The way you
suggested sounds fine to me, but it will make the xen code slightly bigger
even if that code is not used. We could also have a silent Kconfig symbol
that turns this on and still avoid the ifdef:

obj-$(CONFIG_XEN_BUILTIN) += xen-builtin.o

(or using any other symbol name that makes more sense than that.

Let me know your preference and I'll resubmit.

      Arnd
