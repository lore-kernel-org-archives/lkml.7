Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E2EC742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 18:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8024F205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562955743;
	bh=f8AT/rZ9ZAeMUo7CRul4mRv2601d4vNll2rOjqYHoH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GNxtUNlWArtC+Bn/DcaWHd0f1gw93obVB1LZQwfrdLvcjhBguF99b3RKJM9ri9Erp
	 yIHeCSPYLuNSZN0xvXp36DAJ7AE5BZgRgIg8JNU/CwKBlhNpnGHmBD+orkt/d7VUwE
	 KsIeg5f6uULaKKqBUZe3cevcCmbnKl7ua9m5O2HE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfGLSVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 14:21:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37279 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLSVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 14:21:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id z28so10255812ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJlFNg881h9Ys6wiTciFQcwCR4f7RlXmfB/1hsUlk54=;
        b=dAHRp0QliccZJI+YLfiCRSw1GP2BCLYb7zcrr+Rfw0KnZeAJHGgI25Kg1ovwcH++FV
         E4eZIRbCNzprY2ByS5S670n+yOXig8AjG2SUBvzWWWDxtiT67lbMIujtYAe0WoxtkmLv
         YwADroFYE/+xyKW86iT3KVVSaBo3oZJZUY558=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJlFNg881h9Ys6wiTciFQcwCR4f7RlXmfB/1hsUlk54=;
        b=iNlA2LdY18Y1g2F1cpgCeW1sX7uA1m8meCrVixbaV6nXyTA+Yd5zPqGQkCuIZ2UzLd
         MmrIZa15x9iyWDeBCeLflvJC02ZAwEYkreXefamlZcxZa8fLArnJy8ziRb0/hTXerW6g
         I7n0fdtNjIYgH7rVD/OYfx9s2jIhbpTVMXOxYZShFSaURRZpKpNMG1CRilkAn6XqCDGa
         IKlqM68y3whOa2RCLWG3myGXdqZnc/YB9sbz8aw7jPrOIgXzQMVkqGK+Id1tYZ0ug4H2
         CRlESvlrD177ZAUmGBoRea1ZjB0rXxiDFVTM4zfVuKw+K2+PTvTP894Fi5CL/bkuetua
         1pNg==
X-Gm-Message-State: APjAAAXGun+KSu+naXIS8n+eKez5Gwcg75A6SdtVn2XuPystKcS6HQdm
        /94ih7s3LEdRqFhqhPiN9qRlF4eM0sc=
X-Google-Smtp-Source: APXvYqxmlCX/d6X/Akefb7MljTrwqCtTmRIX1h1J2UnhPnM1lIEDx/KLOOs/N0YemTIg+r+hC6duRg==
X-Received: by 2002:a2e:2b57:: with SMTP id q84mr6722848lje.105.1562955672619;
        Fri, 12 Jul 2019 11:21:12 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z26sm1562909ljz.64.2019.07.12.11.21.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 11:21:12 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id r9so10227534ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 11:21:12 -0700 (PDT)
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr6477919lji.84.1562955671686;
 Fri, 12 Jul 2019 11:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190712035802.eeH5anzpz%akpm@linux-foundation.org> <1562935747.8510.26.camel@lca.pw>
In-Reply-To: <1562935747.8510.26.camel@lca.pw>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jul 2019 11:20:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBYYjNj-Mn861p3uPjOx3oRpJA3CJnU1nEg++QOGDCBA@mail.gmail.com>
Message-ID: <CAHk-=wjBYYjNj-Mn861p3uPjOx3oRpJA3CJnU1nEg++QOGDCBA@mail.gmail.com>
Subject: Re: [patch 105/147] arm64: switch to generic version of pte allocation
To:     Qian Cai <cai@lca.pw>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        anshuman.khandual@arm.com,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>, deanbo422@gmail.com,
        deller@gmx.de, Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ley Foon Tan <lftan@altera.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Hocko <mhocko@suse.com>, mm-commits@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>, ralf@linux-mips.org,
        Guo Ren <ren_guo@c-sky.com>,
        Richard Weinberger <richard@nod.at>,
        Richard Kuo <rkuo@codeaurora.org>, rppt@linux.ibm.com,
        sammy@sammy.net, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 5:49 AM Qian Cai <cai@lca.pw> wrote:
>
> Actually, this patch is slightly off. There is one delta need to apply (ignore
> the part in pgtable.h which has already in mainline via the commit 615c48ad8f42
> "arm64/mm: don't initialize pgd_cache twice") in.
>
> https://lore.kernel.org/linux-mm/20190617151252.GF16810@rapoport-lnx/

I fixed it up, hopefully correctly.

                Linus
