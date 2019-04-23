Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3705C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67D3214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJxD2reQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfDWRqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:46:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45940 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfDWRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:46:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so14275998ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idflYGrccr6bk59JwBNLLGo6oGTM1fGQypHi1BhPbHA=;
        b=HJxD2reQVHiCjnNm0Ow6U9669crivX5a5mP3y98hoPsY5LacR2W74B6PJtzV6Vr+pj
         6OfrhF9YR3B56kHyK5i9T8goHoqaU9mOUIfABZI4srPPdj4vty9g3wYYEzTTVewApyho
         yXg/UgyU64NH4vt9K5TUYU25fzssx6E/Y/EdTeXMXixmHHQ87G6BJAr4yAK/1vm7AJRk
         YzfL9NlIgatp5Jo78xaDjGClOgWg8JV9nnCMu6++9j2WYDcxHU+FVepH1+Owgv5muaDy
         HF/NzUcJaHtZe5K0FNzb1E/N/UxWr1DEJ+I8TBBQfBhHQJO+5Se/CWY+f4k5hdTzFpRU
         UJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idflYGrccr6bk59JwBNLLGo6oGTM1fGQypHi1BhPbHA=;
        b=FlZFZUpGYtw80Day7V77CXjfAR9z2o1xFqUXjhMzXzy2ryyVE3+zIyClspwDGQjS1w
         SavO+oZJ9yYmqxl7LuuBm1mHeq0omkM0Z10TcrjHyvI6JqfZnu0qcWynckibXDNFBctN
         3jWb8N+QORSkN3Zv54YFSl06+GrbM38ZY/9j2LPYqVTzq4Qy0fZxWxyNtZca4at2POY7
         +AgVvMANVQ9u6flG4OPyhsyoetAt28hDZA5bKIZn7sl1uo7ZUN4T9mM69CYCrmJ8nFcs
         3zpVRslvMkYdNGUbJ0q9Tc1oW2ui+2uES2e1sGZlafztVKnJhIuLPSbsrlyNjv9zlA0s
         kAzQ==
X-Gm-Message-State: APjAAAX1vWB4E0kG8wMno/29mE635exiLqjQjYq7ikhpuJnbO/qC7cFO
        w8rQL0/3fD67kFbKK3Pc44NyF5BbAMFkklqD9Co=
X-Google-Smtp-Source: APXvYqwRgfRWADk5DevouOYXuEdhpKHva0yD2oZsqkMam3rMeOmL0nqQAxD2lzpaIUyzPq+axL45PHvKpW4b3a1IfOU=
X-Received: by 2002:a2e:9753:: with SMTP id f19mr15505033ljj.54.1556041580042;
 Tue, 23 Apr 2019 10:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190214083145.15148-1-benjamin.gaignard@linaro.org> <e25b2626-231b-28d7-93b0-004a21a3685e@st.com>
In-Reply-To: <e25b2626-231b-28d7-93b0-004a21a3685e@st.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 23 Apr 2019 14:46:18 -0300
Message-ID: <CAOMZO5A6A2sYzfPgjsqQxWcc4Z0YW9-sENW21KumO_XkN3WBYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ARM errata 814220
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Hui Liu <jason.hui.liu@nxp.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 1:21 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
>
>
> On 2/14/19 9:31 AM, Benjamin Gaignard wrote:
> > Implement ARM errata 814220 for Cortex A7.
> >
> > This patch has been wroten by Jason Liu years ago but never send upstream.
> > I have tried to contact the author on multiple email addresses but I haven't
> > found any valid one...
> > I have keep Jason's sign-off and just rebase the patch on to v5-rc6.

Adding Jason's NXP e-mail address.

Thanks
