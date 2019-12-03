Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C587C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A10207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4qWuLdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfLCXM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:12:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43875 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfLCWjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:39:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id h14so2547406pfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 14:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PooeH2U9l4e0abyw2b34fiXdiQuPMqsoVdOri4vyWA8=;
        b=Z4qWuLdzmbQTwgVTPkTffJkS/6pNJFJU52Pv5anld3AdBN2RKrp/QNd1ONA86GCT4X
         Ue7OKCSynqRiSFtptrF3HrNk43XMiXsTQ2B0hgCska6BooFqIZFkPDO2/D24Z9Nquoaa
         wm5Z9A+sS3IkccLQquaDr/DfefHCZZUj9H4vgVMLNNvKvukZfQs7lne9YWKfrNG4zLb9
         EHOyQnKZfLEu0it+urUIkOotHnUuBQSoEytGqEP1moY7TceKQ3RaPVjFaxcxV680ACSY
         cAD51x/PTdUvx4vPH5x/HrR9owsPzsP1j9WGcfG4gxtfx0o31QH3nq6CaIq7UZ+E1KoD
         tfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PooeH2U9l4e0abyw2b34fiXdiQuPMqsoVdOri4vyWA8=;
        b=UFpgUwUFnh0aL4+q6SLrToF5SYejsEsS2bTQnd72EidaCM3HkTygYmMkTA0FDkqTth
         OUwZgEWABTkLBwyFplCxWxYDi8u9e5n7aDLXVXEWvByVZZs9wNxwFqvn8Lcpvp61RtPL
         /BPevFrLmNaWWW3TNW2YyHrKAAE6kedSb3Jx/JAC8vstB9+KzVcPizdULGdwsZ1PlhxJ
         Pl4EYccZg2CkRcChehx3Uz+vWQhJiGv4n0KjBJRdXYgEDXaQ88j7w0JkOLFShyyZEsLk
         u6lwvHaIwCT81zyxShPJMxz+VGo9Bc5Cq3x5yloYcFhHtKlE1Y4uQ4geEgVBtoGe1MDU
         HwNw==
X-Gm-Message-State: APjAAAUtaZKJ1+SXOhmgtTuLj6UMntwdtPpZHMwpfT8bNBN6lNIj2C8r
        sY5fxj0bELhFpnxobdvSerbaMP6r9LwsP164hdkhHg==
X-Google-Smtp-Source: APXvYqyopdizFtuRaXmHpNZY01aJqLAUpTS7fHYCocl6WpG8VXrtTOu+n9u17wqq8KlX1dRoJ6xGABbIJHbMC+vv96s=
X-Received: by 2002:aa7:961b:: with SMTP id q27mr238999pfg.23.1575412793102;
 Tue, 03 Dec 2019 14:39:53 -0800 (PST)
MIME-Version: 1.0
References: <1575396508-21480-1-git-send-email-sj38.park@gmail.com> <1575396508-21480-4-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575396508-21480-4-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 14:39:42 -0800
Message-ID: <CAFd5g47CtpRusO1tit3x+65p8EWVy-PSWU1rhwZ6x6ubbig=rQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] kunit: Create default config in '--build_dir'
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 10:08 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> If both '--build_dir' and '--defconfig' are given, the handling of
> '--defconfig' ignores '--build_dir' option.  This commit modifies the
> behavior to respect '--build_dir' option.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Suggested-by: Brendan Higgins <brendanhiggins@google.com>
> Reported-by: Brendan Higgins <brendanhiggins@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
