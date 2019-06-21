Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285CFC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20B72084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kjFTZ8Ai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfFUT31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 15:29:27 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:42176 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUT31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:29:27 -0400
Received: by mail-io1-f49.google.com with SMTP id u19so1199976ior.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJl5y4V8VgS7JZxlv11fQ6wHrOa/T1ru3Q+ysKKp/3w=;
        b=kjFTZ8AiEb8WRwbQHtL2VjEfY4qz+tHy2NO/qwJ2qerHZehrPZZKALXI+/JDQlMAFH
         zvM6lqyG26h0Mjmj8pE3lcIPPeqWSRks8nK/hAQGyaiZsdXeDq8egvGZZE0AzNmyfGnb
         xv4W3G1tCKbUC/KlrtmWVxx/jFipAx5geNspxTUXuTVJjkZCi/+0+0dL9sjN78ydhiHs
         gxGHy2ZEVlznzm+YBKesFBZOv8q9uh9prCQt82ejjEUxddEb62inj9bzMDfeMLYf105c
         JnAZfNAEyu2Un6JYvvZ5N0gHwqW1RI6dVz6mbHAGE4zKfxPHYYJwLbYfDtGastjNfnhY
         WZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJl5y4V8VgS7JZxlv11fQ6wHrOa/T1ru3Q+ysKKp/3w=;
        b=rJXriCydXICy+vyuUfuhCOFOUh7e1i8iNa4X7Wc95wl9kbCg1IxTcRJw/D98sqthPe
         e6gXgniCUM4zPKvcnek+gjv8+KqLEgZb9yeOz7FYr5XMCl5Bohh0D6E/1LntSA29Wxcl
         HFPh0nLkp0XQo/FdxjQCVD5Jg43JORxYoCM++FwUyYjlRWQjYEQbSaOnrzrQzp0j8rx+
         Aa8XHTK5gLrNkyvTWZQp7PP37QMbT/zVtiEY+h8zxt/mMOrGFVahPteu6gWroykE2kKw
         4CbrfbjeN1V1bDu2nk0dcw8l73Juzz9BM80NvgBV6ZOKAUygD2bGabaWwBUXmyCU1djs
         DcuQ==
X-Gm-Message-State: APjAAAX9kBeJ927MsDXzRQCgGFZ5Za8BcvZ9l9mI8yff83PR7CAL1uv8
        3uNbvrfTsnG49RfeUcC9ireYacWHRH4gb/Hl+44UmQ==
X-Google-Smtp-Source: APXvYqyFzcKFaF7lHxsc9+q4k6Wy/9j/XZgbZz717HW3IU1H7lLU8ohZMo7FLQ6SmQ/NPOXWZuQxwnEp1PKw44GzTUQ=
X-Received: by 2002:a02:914c:: with SMTP id b12mr27661552jag.105.1561145365939;
 Fri, 21 Jun 2019 12:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-3-matthewgarrett@google.com> <201906202022.B09ED6E0@keescook>
In-Reply-To: <201906202022.B09ED6E0@keescook>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 12:29:15 -0700
Message-ID: <CACdnJuusHEWFMfZmCvyaK=c40Z=4HM7sk1y0BaFs1OMbjKc-jQ@mail.gmail.com>
Subject: Re: [PATCH V33 02/30] security: Add a "locked down" LSM hook
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 8:23 PM Kees Cook <keescook@chromium.org> wrote:

> bikeshed: can this just be called "security_locked_down" without the
> "is"?

Sure.
