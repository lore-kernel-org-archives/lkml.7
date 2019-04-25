Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD55C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C593E20811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DKgiDi3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbfDYMN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:13:26 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:44457 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfDYMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:13:25 -0400
Received: by mail-ed1-f41.google.com with SMTP id i13so18912267edf.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foAQPSiaJ6nLuCsQKxDbWQfUxSEGXBBBNHAGTvNtyMY=;
        b=DKgiDi3u4eI2fP3emRJbnaZ3P0mbzQ8Qh7Sw0XP4Aa2485GLJ6udSUCC8GIm82EaCH
         U6Eo3duxZef3vLLivmwPLont9bUml8P0++L8qq8sy+fJkEj5sJDMzoqFh3PgkZ+gLqe+
         N1iLg4nxZfBZBvBt3+DHTuui/3Oydg0zcraYGgaYJ90KOnSlWvmZrGwH+/w1ZGhSKsNP
         1lx/xTvMSlEPu8fxlnY1cd7nMK1xTzlsNf+O4wQX/NA8oCyHPpQamNefLSID+LcQ0Pma
         WunSg6ycjPECtg8tvDsfUzxWyBEFNWGqgFskEfLUcZsjUA4QG532vIThkJlQhskgfDvj
         ndEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foAQPSiaJ6nLuCsQKxDbWQfUxSEGXBBBNHAGTvNtyMY=;
        b=R9EEknBXdUl5tXYPp8Vyw332lOPjRo2Ume9cr7q/vK3sIxOXp+s5XCW54A3fF10uZX
         MrS+kyyz/7yCOs3cqDd5y2/z1mOwLOdyc8Vy5BZ9NK1pSXst01daar2tSQiRID6r09uq
         NQ0/iFzzxkyKqbr+pE8P2gTut778J3yAWMIDqKcEZM8bUZiqN0G3w6F8MgQX9uynZk3X
         hJDptLhj2+SgvZXSWoc9QAd3FvDL3oh9CHd8AFoVYNv6OkBoBEzuLWfoR6RHoYn1qHZN
         MKAJSb2E1uW4ngZpTiBaJg/SKRoNiVcVzWpvzmsh5qEI/0oc2luRPlbN+YWT9bFMzEid
         BDmw==
X-Gm-Message-State: APjAAAU1E/0UQwZAnAvBS1V7a8gFVUu44zGegON/xtM/aoq81qnUpoUP
        sZyL30WUWf8wUVxZU3Oique3JYcSeevt678KHF9Wdw==
X-Google-Smtp-Source: APXvYqzp04JFQyBZ7aQfw2/8LVY72Kt2s0yv2BIXMfjgrZwacD2J4uSQxQXnFVwBjxekcReI5HZaCrbfrfjvrIs6h30=
X-Received: by 2002:a17:906:2583:: with SMTP id m3mr11723023ejb.74.1556194404084;
 Thu, 25 Apr 2019 05:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190423204154.3085-1-pasha.tatashin@soleen.com> <20190425091019.4oqhaxfr6lug5zbo@verge.net.au>
In-Reply-To: <20190425091019.4oqhaxfr6lug5zbo@verge.net.au>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 25 Apr 2019 08:13:12 -0400
Message-ID: <CA+CK2bCrAMjRVG0RGbLwnD1ng7tH+u0EHoxHiJf-=KjqFigKKg@mail.gmail.com>
Subject: Re: [PATCH] kexec: quiet down kexec reboot
To:     Simon Horman <horms@verge.net.au>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Machines that have slow console baud rate benefit from less output.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>
> Reviewed-by: Simon Horman <horms@verge.net.au>
>

Thank you for reviewing.

Pasha
