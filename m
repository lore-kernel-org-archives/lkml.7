Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2416AC5B578
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD972070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R4Vr7ccV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfF1D6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:58:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37764 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfF1D6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:58:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id g15so67230pgi.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 20:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mXwJm7C4Bxy/Sv7wGhhaSYnzKT+9Q8/gprDQ0GpyEoM=;
        b=R4Vr7ccV/e1171byUgh5Kfv/1rdelvNkuDHGd3eT+Mww172KgRTQlH4qYQaxGS+tRv
         y5TQXtuuqJ1r+Xj2cM3l348GkZ42eGn8ajIHUlNVURzW6IXKqz24pKlYuOMxr3KZQEVY
         hLmxgaESVaFp+wxI/2iZnnuDiUNDzXfV5qHCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mXwJm7C4Bxy/Sv7wGhhaSYnzKT+9Q8/gprDQ0GpyEoM=;
        b=QX5emm1iAdDusdsWfacunj/CXxFb5Tlo0o+rja7T7iZMr1rvPzkpTEjLUhcttMP0Qb
         AsE4v+olF+ChpgQJ3N59ZdjT7g2Qgu0zCv4LIu5sMNDKiP73NL+jbjVZr8iWGbq91TJi
         o8SKqlP+f83kNGx88vMz02/KUJOcWV1DmNVwEebr2pqyJmq1/uwnwMIQovVb50Vm1aTx
         zsa68L+gkWcSwoGgsSDtJU8NVdNSdWb84q1o6uM94uiab/G2ft25WS9fTuEuV/hmiumw
         E8SGI9618OWR1uQabMYmlBg35595YQ1OMAElhm9DnkwGc7yShc7TjihNb5yDk+OJQZGp
         orkw==
X-Gm-Message-State: APjAAAW9F/AGIPXHphHeRE6cof0gqFaf6mGcax33xzVO2mynTx8UYtdm
        +9jXIBhdSdUNLdtPZm5sSknnpQ==
X-Google-Smtp-Source: APXvYqy5mHFgwFzk60SOp52Qo8hDrI239nlNz5YOdEYGFrJ3eYVzOxhLdYMv6cBeHyvq/KH0pIUXVg==
X-Received: by 2002:a63:130f:: with SMTP id i15mr3486154pgl.158.1561694304743;
        Thu, 27 Jun 2019 20:58:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b126sm647423pfa.126.2019.06.27.20.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 20:58:23 -0700 (PDT)
Date:   Thu, 27 Jun 2019 20:58:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <201906272054.6954C08FA@keescook>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
 <1561042275-12723-9-git-send-email-bfields@redhat.com>
 <20190621174544.GC25590@fieldses.org>
 <201906211431.E6552108@keescook>
 <20190622190058.GD5343@fieldses.org>
 <201906221320.5BFC134713@keescook>
 <20190624210512.GA20331@fieldses.org>
 <20190626162149.GB4144@fieldses.org>
 <20190627202124.GC16388@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627202124.GC16388@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 04:21:24PM -0400, J. Bruce Fields wrote:
> No, I was confused: "\n" is non-printable according to isprint(), so
> ESCAPE_ANY_NP *will* escape it.  So this isn't quite so bad.  SSIDs are
> usually printed as '%*pE', so arguably we should be escaping the single
> quote character too, but at least we're not allowing line breaks
> through.  I don't know about non-ascii.

Okay, cool. Given that most things are just trying to log, it seems like
it should be safe to have %pE escape non-ascii, non-printable, \, ', and "?

And if we changing that, we're likely changing
string_escape_mem(). Looking at callers of string_escape_mem() makes my
head spin...

Anyway, I don't want to block you needlessly. What would like to have
be next steps here?

-- 
Kees Cook
