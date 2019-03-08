Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10986C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC00520657
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WsoIzT7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCHQTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:19:11 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42325 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCHQTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:19:11 -0500
Received: by mail-vs1-f68.google.com with SMTP id c189so6970488vsd.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 08:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpZzO9XkPD4/cDUzRNFUbP2NDMj3FfZHV1xGEaMmMMU=;
        b=WsoIzT7JtVFNtQei1YpBCJtdC8L+BhAHG7OgS9SK5xLAAXPCAEdvuSTt2Vty5JWdAo
         6Y/Tk+38mhuguH67uUcH3UmbgTypLvw+8sCWSVA1Z4NDjRrGyGUowj6LH+bvv47t+v9s
         2c5AsEMXlQynfjZgYtxl6jfuVaCXhCV2IIr00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpZzO9XkPD4/cDUzRNFUbP2NDMj3FfZHV1xGEaMmMMU=;
        b=B1GPijJ01z6yDAJn5CS2BEV6rhVD/C0nDlDGeNOMpe3bc6VhbjydJxKSgz8qai/n5+
         2aQ9hldsbJ+YE4M4mfM6tW7BLIIAe/DvdMfGJKs4gmi3GZqT8OhIBrNHnNJ+YHue1yNG
         0CBKkDbzVXAvYcRUB9Anu2nXNWi7/ZzfItc64p6aP0iWquxYdEBwmf78J8ykhefc9tom
         GQN3knZq0u8eE9cbbyVlCpA8LsY2OHGMYjRLSsYuqHs0GM8fJb+eE9F+PgSWGA5Bz5hh
         dIVzLUUK0GdQg1vFvDTS762xy6dBPZ+gjrtcV9fpDXTGEjQrzbqvLyMRi5qIbl1c9ajd
         2gJA==
X-Gm-Message-State: APjAAAUjk5VP5r9/nJYtCMA7ZbO8zh2idr7ShUJtqS0u1tE4M5VkL0Uo
        7F60/iKmz5cGdXBLb+Wlg/Y83fcPTOk=
X-Google-Smtp-Source: APXvYqw3n2ZoRSAxklfIV+K0OdN61vqnEGhz8GqVYzXF+IKOWIhLwFBw2EzPdyj6KNrPlGsrgt1/wA==
X-Received: by 2002:a67:c78e:: with SMTP id t14mr827433vsk.180.1552061949707;
        Fri, 08 Mar 2019 08:19:09 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id a3sm1880320vkb.29.2019.03.08.08.19.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 08:19:09 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id l136so4702907vke.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 08:19:08 -0800 (PST)
X-Received: by 2002:a1f:2acb:: with SMTP id q194mr9427356vkq.92.1552061948574;
 Fri, 08 Mar 2019 08:19:08 -0800 (PST)
MIME-Version: 1.0
References: <20190306214226.14598-1-tobin@kernel.org> <20190306214934.GA16461@eros.localdomain>
 <20190307211858.GA28495@eros.localdomain> <CAGXu5jLdCQ0QtCdbbfE+=JccZk01aSdV_5dWVj6g8X-dKpOr8Q@mail.gmail.com>
 <20190308052353.GD17221@eros.localdomain>
In-Reply-To: <20190308052353.GD17221@eros.localdomain>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 8 Mar 2019 08:18:56 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+EdCMj-kE0He1Y=KJx_j=3Z3ft9ANKibW=58=2Nxqp-Q@mail.gmail.com>
Message-ID: <CAGXu5j+EdCMj-kE0He1Y=KJx_j=3Z3ft9ANKibW=58=2Nxqp-Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] lib/string: Add strscpy_pad() function
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 9:24 PM Tobin C. Harding <me@tobin.cc> wrote:
> Two weeks and I'm throwing eggs at your house.

If you can gets eggs from there to here I have a whole new
international shipping business proposition for you. :)

-- 
Kees Cook
