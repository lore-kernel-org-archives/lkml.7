Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5253DC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2B820848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWoh7npV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgAFHdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:33:42 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:56711 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgAFHdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:33:42 -0500
Received: by mail-pj1-f73.google.com with SMTP id n89so10430554pji.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 23:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DVTZeHtWLkUT+7QBPvqsFl2b+xU5ylPDczrCjXvkopY=;
        b=lWoh7npVSUr5q9DKj2L4rWvZLI3HQOJ8cs+WkhVPBFoFYMpBeAqLnc5yYqH1Pq5Pqm
         iEIKRH3A+hlfCjezT7yiHkLuLV0OeK4oDzecWzdFOtihUCkPd/oAjLNFy9/hr+l3+hAx
         8ip7Q18hSPoJsW/apfj/+cNXdRSUneFDDH0KDH2bj2ZL7A3dk5jvAndqODKX/i1YFGiw
         IEf5+JxC0/T2n/nY+TBXPdrJ5ChV1isRM9cJsAlMACRrAQ0W2CHmsvbgcprjziEQh+WF
         xF24HyyYGTgSpw++bwJarPpsCXeeo/jl6r6v6nZkVR7xpDAWMjuf5YGQn38FakawkUbs
         Uo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DVTZeHtWLkUT+7QBPvqsFl2b+xU5ylPDczrCjXvkopY=;
        b=U1Gk0jQ+PteGaMqmM1b4HvYnhQO7c3f/mVKeFd/bexvvoougv3iCK1+7fOMehDnFpl
         owVkdXpzUtmEV3Nhg0F86uYLGQFFHTUGcIlYqe+LUnZXOQI6T4F17yKVGFpSLhgpQThS
         fLL2xZTaoW6OUo0VlIhVMD909yPyhLYgz66mgTW75breWlLZemwH2FrKiTsA6s8b0vDj
         jnTkS/bWLoGEFaIKz/9SLLUoXaKmYXB8e0LH4YfcXIzLzrW1HNU2Iz9uCnCazTfdO1uz
         UBP4ZY/IHzl5mjk4oTJfASp4MJsQycp2WU0Y3SYBkYT9KSIbZAMQXK7Kx3RdyihsSFPw
         o12Q==
X-Gm-Message-State: APjAAAWe6Gx5UkU5EhvQxXO4b19nU2m0BTZwTYxDkqgltvkwhmrypTOt
        eDLlFm5zPpVhwJZQTVgOiU0anzJ/Zrds
X-Google-Smtp-Source: APXvYqw9Jv5F45+lib3Sum5lOclNDhenY5qhh9P8ScD9+q9tQaBGrRkGdkh4pWnkdd9UrSnV4Ok99heNZwY7
X-Received: by 2002:a63:a508:: with SMTP id n8mr105954525pgf.278.1578296021583;
 Sun, 05 Jan 2020 23:33:41 -0800 (PST)
Date:   Sun, 05 Jan 2020 23:33:39 -0800
In-Reply-To: <20200104150238.19834-2-masahiroy@kernel.org>
Message-Id: <xr93pnfx6nu4.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20200104150238.19834-1-masahiroy@kernel.org> <20200104150238.19834-2-masahiroy@kernel.org>
Subject: Re: [PATCH v2 01/13] initramfs: replace klibcdirs in Makefile with FORCE
From:   Greg Thelen <gthelen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> wrote:

> 'klibcdirs' was added by commit d39a206bc35d ("kbuild: rebuild initramfs
> if content of initramfs changes"). If this is just a matter of forcing
> execution of the recipe line, we can replace it with FORCE.
>
> I do not understand the purpose of
>
>    $(deps_initramfs): klibcdirs
>
> Remove it.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Greg Thelen <gthelen@google.com>
