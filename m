Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB3FC04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12BC2182B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PprLsQDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfEJEPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 00:15:15 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35214 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfEJEPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 00:15:14 -0400
Received: by mail-ua1-f66.google.com with SMTP id g16so1664574uad.2;
        Thu, 09 May 2019 21:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Xvqcrj5SgkCbFCtqWQX/awrlM8MfFP4QXrUFPXwrzA=;
        b=PprLsQDU7rzO8P+EkqmV3FCtak5wPwqAVhGfgxWfk2ePDXUJAMHOUPrRq2vFrvAnsR
         MiUDvbld6r0P3oLeJA8ECKZp70vIgmLgTtJLmL6Dn0c+HO3p2dPs9go2wze0ZfmkNlu/
         GQmEN6SkLiTQU/L5z1kGD1y10Ze5sTjkVjJnmiOVaN2duRwFbZPgTpib12XVGGGx7aNl
         tdY847J2KSVKusH4VDbcxighPzbLtH5HgMRIHKscOSh/ZvujLRN4CF7izcPU3+zbZDeG
         BfUnnuvSuXljfNB+a3sYOZGC3VXpSGlCi4zLacCZ4wnAqYGWBeyU/G/Q2ZO0kuOyIm2a
         ybXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Xvqcrj5SgkCbFCtqWQX/awrlM8MfFP4QXrUFPXwrzA=;
        b=F+sRLT3hsYZg8pro8uZzu7J37Bz7F7VJWQkUBZPPPlVSddU8vQQTikOyuYiXXJAhPK
         /638OJS3ca6HEHpBYNQxbNbGnmeQcbQBCml3/R5hPfsCrqGSnsoS40g8vYmqr0DFsOsY
         RNsw0iH4xee3gM+k4xqmn3UgXUY8uyVQ7O3yt5bZI86TlFQ0yhysG6qmlGokp14yx/C/
         bU+7lb3/7h9x9jZAXIZ4l7Uqzx8aQ7xpWVH2HCTBOCEkli5B606WEkkFjAEaP2xGnTGS
         aiinKu8+dYyMDkw2Qo3IHrtraKVxNzglR/XSsopUXBVJraKuEkdxKoi6p68NA+YPP8GG
         mMTg==
X-Gm-Message-State: APjAAAUmkWz67U9id/BX/IYu85t3Ck4JtXtRmDkN0tIWyOpdd3OTjQvH
        zPcUtDEeWejWM3lZEa7GZ9LsuWKY2ZwR5P1gDG8=
X-Google-Smtp-Source: APXvYqyEFeSOTeZGWyIi9inJ6PjDmzLg5/nfjAmtYBZbqK7DwVOLTzM7y0PfTRNO0avhlYnM32N/VDndoiQLbfmWN/U=
X-Received: by 2002:ab0:7212:: with SMTP id u18mr4114201uao.32.1557461712968;
 Thu, 09 May 2019 21:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190219074500.16454-1-vichy.kuo@gmail.com> <20190410135648.GA25739@bogus>
In-Reply-To: <20190410135648.GA25739@bogus>
From:   pierre kuo <vichy.kuo@gmail.com>
Date:   Fri, 10 May 2019 12:15:01 +0800
Message-ID: <CAOVJa8GLOy3PXTY-bwgswQRyqpUUUymjBFHD7Ahr_5JAv71JNA@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: reserved_mem: fix reserve memory leak
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Rob:
> As no one else seems to have any comments, I've applied it.

Sorry for bothering you.
Since I haven't see this patch on below up stream repository,
"git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
if there is anything wrong about the patch, please let me know.

Appreciate ur kind help,
