Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1918FC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB4C20989
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfGBRWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:22:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36577 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBRWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:22:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id q26so11996500lfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 10:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvnDOFwx6G7d+yAjk4B98e8llL7nNglDsAedEdiJxn8=;
        b=s3pCEKVbe33vUaxqf1Z4S0zG+PHeCnDsJLTuriwoIGW9YQm951Z68+IqvGZHOl/LWo
         6ZUsc/7gj5H7nyyy7kt5mkEEN+jmwAvbP8zYV8BMpgpT7WTfppn1Cfbn5dGckLOcG8fE
         vS5Q2Fr89x9N6qiSk+rY+xaRmrdfmx/DsglBv4nkw3MLXGtdLsQIAElWJ2zFNhran3rx
         wR4ezgrS6t//Os2bSY34No1k07XiG7FNtj8wfWqEk7MW5TCuqn2LCPDIqk1CGbacZCi3
         wzUcViGJ56VuBIIAXMWagVaN76Z1mLhQt3ZVym48D/b7GfcTgLhzzL6g4FLDVmorZIqP
         J6Fw==
X-Gm-Message-State: APjAAAWsB5qR0SiXYUPYo+RKq+VCIfCjp6md/vwQVcA9O+j4lbkXDJ0l
        p55zAQ8u4UOntvSEV0hvr9jjObp623P5VhLlOX5Yxw==
X-Google-Smtp-Source: APXvYqwe8rPzx6WbcilbAAMBCLX758kdHtQ+zBozdZr9n3CYJ4FZMdsNLFeRkdcfFHDhvi/4sOdbVFpkPAB6cmKCs3A=
X-Received: by 2002:a19:48c5:: with SMTP id v188mr803228lfa.69.1562088130005;
 Tue, 02 Jul 2019 10:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190702170228.GA4404@avx2>
In-Reply-To: <20190702170228.GA4404@avx2>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 2 Jul 2019 19:21:33 +0200
Message-ID: <CAGnkfhxPhHxmNFCMHj8QTYKtLi08O8C5-6Qua8zRz4FX=8g+pw@mail.gmail.com>
Subject: Re: [PATCH] proc/sysctl: add shared variables for range check
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 7:13 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> > -static long zero;
> >  static long long_max = LONG_MAX;
> >
> >  struct ctl_table epoll_table[] = {
> > @@ -301,7 +300,7 @@ struct ctl_table epoll_table[] = {
> >                 .maxlen         = sizeof(max_user_watches),
> >                 .mode           = 0644,
> >                 .proc_handler   = proc_doulongvec_minmax,
> > -               .extra1         = &zero,
> > +               .extra1         = SYSCTL_ZERO,
> >                 .extra2         = &long_max,
>
> This looks wrong: proc_doulongvec_minmax() expects "long"s.
> The whole patch needs rechecking.
>
> > +/* shared constants to be used in various sysctls */
> > +const =======>int<========== sysctl_vals[] = { 0, 1, INT_MAX };
> > +EXPORT_SYMBOL(sysctl_vals);

Yes, you're right, that chunk must be dropped.
Anyway I've checked the patch, this was the only long field touched.

Regards,
-- 
Matteo Croce
per aspera ad upstream
