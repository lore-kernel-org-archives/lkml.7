Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FD7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F8A2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foreca.com header.i=@foreca.com header.b="fGN46b3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfDKG0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:26:15 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37988 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDKG0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:26:14 -0400
Received: by mail-yb1-f193.google.com with SMTP id w206so1803455ybg.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 23:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foreca.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XBlYTTQ+rwt23q5R6DRfoOejUm/EuCQ+hMmOxtX/Ais=;
        b=fGN46b3XaG1ZzLAKHET7HvsBGTfCtcHPQnCbIHj/58KI5sek59EahshSzC2EY82cnb
         ks+ZtcUhcBFPERvM/Hz4rxyrBBV1SISS23tcAEj8umarY06j0fcKlVqJ7Ec5Xl6TjsJQ
         JCtVY7lz9PdxH4PnaviopnJkbtkBHjxpWMiiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBlYTTQ+rwt23q5R6DRfoOejUm/EuCQ+hMmOxtX/Ais=;
        b=gryjKVBolBlZO7awr9abxzX05VWuEX5OfilYZELyNrXB+xJhrHi2k3bOFR+jCGsrpG
         AoX+512WYiblyjTnhHhp/SDVqdnUesfdFo7Qfyl/vUrB6Lecm90bq7gK5uL8rdwFn5s6
         +9Ewop19kC1OdhFlpp1o2llNGEGZr0E5Ifpx/yjhz1NctEYwYyqOmpfXO0tBlmxSgrHN
         qZ11Kr6O2m03YrbDEBUhmk6G4etptJjLl2UjN2z/xZPWcxNjtMMUrgfIZOraf6lVF5P6
         D8CvZif0CWj6ExS3ztOCgDnnlldn36olSsSwma1rAJ7YLgv40QM3ewGjQbV54qFSyeeO
         1Z2A==
X-Gm-Message-State: APjAAAWoAqvVOlOeRxcSXHjJENU+AxYS1M4Ny5fJxuO0wpiBrVrnM0Ep
        AQm/vUJ7NUZNVgEyxbh9vH4Z5VY5nxDGWNivrouyVQ==
X-Google-Smtp-Source: APXvYqyXs92NIoGSgwwn1orAp8rvk0wgdrM+45ronn03pn6bFbeSO1/yIh1S14zYIpv1TfgRjf4W5Sp10At524SIMbg=
X-Received: by 2002:a25:7a81:: with SMTP id v123mr39074063ybc.144.1554963973890;
 Wed, 10 Apr 2019 23:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190410101947.8603-1-juha-matti.tilli@foreca.com>
 <CANn89iK9DcDi68WQn0z2R65L1fQpa88nUnpe_di1OWGhhoqAQw@mail.gmail.com>
 <CAA1_w3_4ZeOA-viD4W0QH1rUYPczcwS2KpnsvRhCX2hQniV-kQ@mail.gmail.com> <CANn89iLmzADQF5=htGsjNwXrUZxMUYaYZB+6WOM_vo6zG+JB9A@mail.gmail.com>
In-Reply-To: <CANn89iLmzADQF5=htGsjNwXrUZxMUYaYZB+6WOM_vo6zG+JB9A@mail.gmail.com>
From:   Juha-Matti Tilli <juha-matti.tilli@foreca.com>
Date:   Thu, 11 Apr 2019 09:26:02 +0300
Message-ID: <CAA1_w39v3sjg9qOoX68bSNx_WeWVJxEh3MKrx7G-uJTO7UxhiQ@mail.gmail.com>
Subject: Re: [PATCH] net: add big honking pfmemalloc OOM warning
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Murphy Zhou <xzhou@redhat.com>,
        Yongcheng Yang <yoyang@redhat.com>,
        Jianhong Yin <jiyin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 6:36 PM Eric Dumazet <edumazet@google.com> wrote:
> Before diving into the details, can we first double check which exact
> kernel version you are using ?
>
> In the past some pfmemalloc bugs have been solved, I do not want spend
> time finding them a second time.

Of course I can tell the kernel version.

The NFS server is 3.10.0-862.14.4.el7.foreca.x86_64 where "foreca"
means we've applied a custom Samsung SSD TRIM patch, nothing else
different from regular CentOS / RHEL kernel.

The NFS client is 3.10.0-957.5.1.el7.x86_64.

The pfmemalloc problem happens at the server, not at the client.

The exact patches in this kernel may be a bit complicated to
determine, because RHEL apparently likes to maintain their own kernel
version. They do not have the SNMP counter even, which is why I opened
a bug report to RHEL Bugzilla. I have extracted source code, so if you
can tell a list of git commit SHA1 hashes that could fix the issue, I
can check manually whether they're there, and open bug reports to RHEL
bugzilla to have them backported if not there.

I at least see this in the exact kernel version I'm using:

static inline bool ixgbe_page_is_reserved(struct page *page)
{
        return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
}

...so ixgbe shouldn't be reusing pfmemalloc pages.

BR, Juha-Matti
