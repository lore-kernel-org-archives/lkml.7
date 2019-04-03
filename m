Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4F1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8626B2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfDCLzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:55:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39139 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCLze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:55:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id m13so11482533lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 04:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWiKYRBDLV0ovE0cTsbFPkeIiPj6XX2qtpqdYWsJSA8=;
        b=XgKzKBLZmaDyjEErDTTaKXuE5sPBRZQczjVMgjpTqewUMNPbzW/3aOZrs/mCA8dYUb
         wyabgg9W3u4zEDBOsocUklEGqSc9QbBGRr8KCSQDFlTUrjDaWdiOI6WOIEYWYooLE82I
         2Fh0F0yPZ8oQxUkDAwcLxzo5F7W9Z+rgWRddMA4lvNhZQNUrn8mvMwItXaWhiih/oiPq
         z0bugMKI7O0n33nLtlyhqNZJ/NwRKQNY+iIAOetIs+to/tSWNtekdyxfflZ8s7uwC93V
         bT34rWRVKk1ulfmHfzGXN/IS80VIwZCWZAUD+DF2DSUY1OlazZ+z4tygCQr0+ovHjGSm
         rc0g==
X-Gm-Message-State: APjAAAUqLgzNWz/kTbX3yLrtXj6ZBAbmHj2yLlMGTj0rLW984O+zUj8E
        8mu7yBhGXEJqv7394TDnWpd9booLnRuMFMXVRkwgOg==
X-Google-Smtp-Source: APXvYqwgdlJMceOEsN8iwRiay0vaz9rvq+ZepG1umE5GZzhjpLizfo50dBgpsaT/QbFPUhVWIcG0YPBNqJrIA6MKZoY=
X-Received: by 2002:ac2:4563:: with SMTP id k3mr38429432lfm.101.1554292532802;
 Wed, 03 Apr 2019 04:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190328130306.25384-1-mcroce@redhat.com>
In-Reply-To: <20190328130306.25384-1-mcroce@redhat.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 3 Apr 2019 13:54:56 +0200
Message-ID: <CAGnkfhxHhrzP7SWVQ8CCdP3yWmYrn5JQhkH1=m4_SdvacBxFTw@mail.gmail.com>
Subject: Re: [PATCH] kernel/sysctl.c: fix out of bounds access in fs.file-max
To:     linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Zev Weiss <zev@bewilderbeest.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 2:03 PM Matteo Croce <mcroce@redhat.com> wrote:
>
> fs.file-max sysctl uses proc_doulongvec_minmax() as proc handler, which
> accesses *extra1 and *extra2 as unsigned long, but commit 32a5ad9c2285
> ("sysctl: handle overflow for file-max") assigns &zero, which is an int,
> to extra1, generating the following KASAN report.
> Fix this by changing 'zero' to long, which does not need to be duplicated
> like 'one' and 'one_ul' for two data types.

Hi,

Anyone looked at this patch? Does my fix looks sane?

Regards,
--
Matteo Croce
per aspera ad upstream
