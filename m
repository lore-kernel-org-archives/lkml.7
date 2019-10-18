Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C09CA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896DA21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571412821;
	bh=XLdYo2quDhAHpbJrdY0Trkoz6Amh1Xhfkl7bkfYd1wI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gHWkRqZfoenqg1dzCFx3j8JQ1TJ+YNHBHd3AqQO4YwbeBczVG8X4avlxr3if0un+7
	 XHVcPFql56lgo1VnTjCdOhMkcGOw1aOkvVKDrEmfrxrl6/H5jC140+5XSL/8Fa2YCL
	 EjEnAVNKmkB1RUnIiBl+5576sNP7T1oH3jhAbz+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410749AbfJRPdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:33:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42888 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410604AbfJRPcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:32:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id z12so5033538lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htc6+DktT7Y3uD3auBmpX964Gqpp3eQIkOXe0EMRrEM=;
        b=XjWIVFjSz6ga1WAc15MNwGtRsqjuAizeRbLBR+qDU/JmNQalIxeb15P2p6wblxHGiJ
         okv1b5kgGfawN2eTdxq8f/H3KlmOYczAKpLMUGd/da232vCAUcVkSyubf9sHK9JzewVk
         lfeh8fR+XTd8y8oNj8qkk5nI6khRxbHTVmkGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htc6+DktT7Y3uD3auBmpX964Gqpp3eQIkOXe0EMRrEM=;
        b=GP8wwtJF/y0rQ54nXHjHg2cNGVCzs27Vt773IjiA8/Fjl9jNP2OH9iN2Ke+echRhPy
         /QKcN9BeaKZNm9IoskcANiNcGh18xQ2XOlj06ErSUZumqT7r2LecvgQ1pSf/De5ohWPa
         OD2BMy2BpiV7Z5dz3iytmxoQgFKOlzz16W5jMUhN4JAzyzABO1Aj09xYNFIE/sZi09KT
         DX9r1ha7uHwOQxpyMyCjssPndur8cm5pY1Vt33gmtSBQkrKhUtdjLe+uSzXgCKxsfezy
         c71XYo7R6qaifUdAmMgmkIM5bByj+ge78Lg0FKSaXFlJKix1NykhjpB4/Q1eJhpFjEPg
         vWqw==
X-Gm-Message-State: APjAAAWc1b1HIo9fuj9AJeCGt8Y2YNI4vhFc2OfZpkxho/Z5rZHFlwqL
        urqxw5NrjGtkQRYuIRSDEE1fnLqXrXg=
X-Google-Smtp-Source: APXvYqxSjTswujt+buTpFLZ14CnagcjYKB4y8fagkcQ4kn/CY2ksXVGmiE4wVEhI8+E1ED6Gs+x0oA==
X-Received: by 2002:ac2:52b1:: with SMTP id r17mr6447069lfm.25.1571412725923;
        Fri, 18 Oct 2019 08:32:05 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p86sm2890963lja.100.2019.10.18.08.32.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 08:32:05 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id r2so5043596lfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:32:04 -0700 (PDT)
X-Received: by 2002:a19:f709:: with SMTP id z9mr6504716lfe.170.1571412724682;
 Fri, 18 Oct 2019 08:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <09d824ac-5371-830e-466d-7f78ccdae065@codethink.co.uk>
In-Reply-To: <09d824ac-5371-830e-466d-7f78ccdae065@codethink.co.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Oct 2019 08:31:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYQ=F5H-uwQvj4eMS3xREmqE6tPuDVVLVML02xaThqVQ@mail.gmail.com>
Message-ID: <CAHk-=wiYQ=F5H-uwQvj4eMS3xREmqE6tPuDVVLVML02xaThqVQ@mail.gmail.com>
Subject: Re: sparse: __pure declaration only
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 4:15 AM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> is this a valid warning? if not, should sparse be ignoring these.

It's technically valid, but maybe it's not useful.

If we make sure that any pure bits from a declaration always make it
into the definition, then I suspect that the "was not declared"
warning (if the definition is non-static and seen without a
declaration) is sufficient.

Of course, sparse doesn't actually _care_ about "pure" in the
definition, only in the use, so right now it doesn't even make any
difference to sparse whether the definition has the "pure" or not.
It's only when the function is used that the "pure" matters (it makes
the call instruction be CSE'd like any other random instruction).

               Linus
