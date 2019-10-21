Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA32CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03B7205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WtfeZ/g3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfJUMfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:35:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40545 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUMfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:35:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so6565859pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFSoQzruwDjvkM2UWGpQtdqo3XZFLgQ/imuRyHJ84/w=;
        b=WtfeZ/g3228cf5xLw6dlCTjipQ97ZzTgXJNeAcjXFaXaKr5vD08JruOKMf72Q2/+bc
         LcVs33B3N+Z3qov+NTX/S9bs0MfCu0lQ9aAPEhKmOkh7gSlUfD+ELQKAFqKkPxI5ZLhi
         /NiPLjrZBjaCbKeUoe2mg0ZYAAOMQdcmcTkEzAD61MD5kyQ0jviYU8x8psNZj1qNEKCV
         XHPfDbFrQMrHBnEhh5qcWpmjQLFvCi85+yGnk3KjKgTiDSRAsXv9hxk6Sxr4GROmxTjS
         2B1nnzM5tmUjurS1GInwut89mpoAVEZyvikAEnrawh7ijDY7Kaik4LDz3C4e6dZ3IFOD
         oEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFSoQzruwDjvkM2UWGpQtdqo3XZFLgQ/imuRyHJ84/w=;
        b=abFghH4rKWmOM4Yax/6GHz64O2zoEiuNl6Qkiw6blH/iZfvTR/RiIfaNNJYZRPMTFG
         Ma3qKK/WMWFc0c7Nihl8+KXCRcqc6sHYEjqLBsODfYYg6GRUgWyyE/z2OYvQkRAYNk+y
         uz7ezpG6zKq+1p2H5kzCFJodEG84AkIfGhIp0dLcklvJvWbwF9seaVn2Jn5jWnyuUMNP
         3GvKnjsFi+8FJ1Yu81yolnqPAQVuFneI5bBV1nJKYyXGXaJNpQJBhTqMvjAg20aIkryo
         ol3jMDb/otoH0zx+s8tKoT9hnDzpZu3zwxEBChZB5If9+ZKfvo8DgCtjh1B3sCErSDj0
         c6AQ==
X-Gm-Message-State: APjAAAU13KekdEM2h3kMZLaX53KeM227bsndHOSHWQdkuvC/c6+38b+o
        4vADjSDHe2+hq+I1H0AzI4RENqqf6OFhO7Moyb7INA==
X-Google-Smtp-Source: APXvYqyv+kk9HcTiXQ61zU6olrRj4Z09puxOfgt1J1jMXxquXGcBRlgvwcyd+eLX0VyQLJoRGmKGBXLgaaVtM7jB7c0=
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr24084586plt.336.1571661323722;
 Mon, 21 Oct 2019 05:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <7a9d6e35873d52ec0ab1e6b9827d9299a1f4fb0d.1571409250.git.andreyknvl@google.com>
 <20191018180652.GA1186697@kroah.com>
In-Reply-To: <20191018180652.GA1186697@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 21 Oct 2019 14:35:12 +0200
Message-ID: <CAAeHK+xk6xo_+D_0xiS-=aP_chaGmeq1kNc0Rdg-KLkXL=h6sA@mail.gmail.com>
Subject: Re: [PATCH 1/2] USB: dummy-hcd: increase max number of devices to 32
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Jacky . Cao @ sony . com" <Jacky.Cao@sony.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 8:07 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 18, 2019 at 04:55:56PM +0200, Andrey Konovalov wrote:
> > This patch increases the maximum number of Dummy UDC/HCD devices to 32.
>
> Yes, that is a good description of _what_ the patch does, but it does
> not tell us _why_ you want to do that.

Will do in v2, thanks!

> Also, no signed-off-by, are you sure you ran your patches through
> scripts/checkpatch.pl before sending it out?  It's a good idea to do
> so...

Sorry, missed this, I thought the patch is small enough to not do that :)
