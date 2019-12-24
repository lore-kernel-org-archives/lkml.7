Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81375C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 13:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433F420730
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 13:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="a1XflIgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLXNrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 08:47:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40421 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfLXNrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 08:47:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id c17so16048530qkg.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 05:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=gJSU2c7V0b8ZdILNENIi9JaOANjv/UG/dY9rvMfObQ0=;
        b=a1XflIgSEYNpJvpUhAyvvY/8pqmTpscYLPyOlUzC6qYXGsT/ftktR5ECLrk070j9Zw
         Qe6KW4fiampfcyY1sdzubGbwR3jBOQ3XqKWA4SHzzAlKVnpibJXXpttbqSVxLW3wU6rm
         kIlmeHuOexw62UGQESniUTMe2cEa6jZB/DDRR2QuJaJfO+ukdC0uBfc4QGNg9pFJFueo
         c3NGXtWjcKBjxu+DLtY5rBlhjOFGqozv0V1IqmUc44RSIhOWlRgFo7u08GVro97P8f3A
         2FPXjktQebmxkgNmNMHM+qx20hfmZyHYbPGZZiRc3J0lElrF052KAhcVsfwYMURkegtb
         8Eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=gJSU2c7V0b8ZdILNENIi9JaOANjv/UG/dY9rvMfObQ0=;
        b=PuY5nszATf+L6BQI5k6zKb8DrAKDzLGPAKNkSS4bCgOz5iebdbW0tor3QeO7sUDkNQ
         UhV50jC0vbBPfL7OS6g2TqKuKGia/aPI1/XxRSABXmT9WnNi5nMGECdNcoDVzM9JuzdA
         pQNK8e0lDmnP2omrM9DBODWsPiDR9UquDQJ2hrdIysKIZsE8S3vsah6gz+F6YMowM7QJ
         7G1MMKiHNmGL3jVWh7DaJWTpSDhuztndFYcW0HwTOr4GbaZxhEUeknRAkpeiexFN8Zm2
         6RRDGcVuqa2GAj7LclmBCo0s7vvypQgCeGLAcQDedkGbmqmuM4ppVHUVO+QXmHzY3Lru
         NJ1A==
X-Gm-Message-State: APjAAAVTw5vsH2dlyC22g/6QLGrXzr6rDClge4+ux33gsvVy52u+gMkx
        U98HCa8ZVTs070ct170rkmU0Jw==
X-Google-Smtp-Source: APXvYqwIoLmnlGecAq3xrlAoCzXA4v5nuuwvRo44+mVVe8A3lZxILyFHSq9kRU8TkLB5N4Pp4CdLPA==
X-Received: by 2002:a37:8085:: with SMTP id b127mr30055985qkd.424.1577195237928;
        Tue, 24 Dec 2019 05:47:17 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r44sm7586209qta.26.2019.12.24.05.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2019 05:47:17 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_owner: print largest memory consumer when OOM panic occurs
Date:   Tue, 24 Dec 2019 08:47:15 -0500
Message-Id: <5E08DE19-5B71-4245-8908-548BB4FA861F@lca.pw>
References: <1577169946.4959.4.camel@mtkswgap22>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com
In-Reply-To: <1577169946.4959.4.camel@mtkswgap22>
To:     Miles Chen <miles.chen@mediatek.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 24, 2019, at 1:45 AM, Miles Chen <miles.chen@mediatek.com> wrote:
>=20
> We use kmemleak too, but a memory leakage which is caused by
> alloc_pages() in a kernel device driver cannot be caught by kmemleak.
> We have fought against this kind of real problems for a few years and=20
> find a way to make the debugging easier.
>=20
> We currently have information during OOM: process Node, zone, swap,=20
> process (pid, rss, name), slab usage, and the backtrace, order, and
> gfp flags of the OOM backtrace.=20
> We can tell many different types of OOM problems by the information
> above except the alloc_pages() leakage.
>=20
> The patch does work and save a lot of debugging time.
> Could we consider the "greatest memory consumer" as another useful=20
> OOM information?

This is rather situational considering there are memory leaks here and there=
 but it is not necessary that straightforward as a single place of greatest c=
onsumer.

The other question is why the offensive drivers that use alloc_pages() repea=
tedly without using any object allocator? Do you have examples of this in dr=
ivers that could happen?=
