Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F95BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5572082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgJELu8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfCEEwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 23:52:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39488 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfCEEwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 23:52:00 -0500
Received: by mail-lf1-f67.google.com with SMTP id r123so5191857lff.6;
        Mon, 04 Mar 2019 20:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frYHgw3IZ1LsO57/C9zS4Gz46LeSjqxsEU0ROaeCfzw=;
        b=YgJELu8R6fxgzPU3x5TdXGg5zgeBNtAeK0hLoqWioFFyW50fF1h0wDSaPmzUsdO47z
         JsxGf48ElpwWG9LtTdV6DZ2lTnKzh1jysnBRv3fcb2AUYlKr0J+QdV4EY5EfRwRZmc4/
         qahOc26xLT8bd2Jt2kPhG+W+Kd72t53Bk4Jl6kT02EaSX25ZDiI0p7+5H1ks1h3EoAv3
         kryvWBEL53vamx2v+r1nnrnYFrl+y3huDdKUn6x5mI1P8d8C5oYGUyQyRQS6L9qCZRpH
         EwN516dFUD/1R+TGhpUf4M1PrYsFYYEV9DVAXx2jFX3LKPPeEYhiSM+XGb74U+KnS8BL
         X8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frYHgw3IZ1LsO57/C9zS4Gz46LeSjqxsEU0ROaeCfzw=;
        b=dI1O6Ll3kCqtMcTbasyZ1FUYdzlEUuTX8yWlpMgHnHKkB6Tq1uI6LxRvODAUCXoj18
         jhklFQKsU0CX1VRp26bAwJJmLE0QcKL4dw/BO997uxamopslciijOD27tFh1zTLWtMXP
         JrRPEvCG8LWWVFsyvdcEiUumQfn7jekpJwf0aj/XWdPb+Y8cy3R5oV7qDyNvcNu5O3uC
         T5EVhMB7hNN+u+g25K7Q4hlqrXWZIy8nfpg5t6ce/2kmvuVhwVzstptOAOYdyKudY9PC
         2UbDKBfnWdUtGnVCojZ2YTOg45rm/lJ9mglPAJNWZ2QLLJKmMVeSh9Z5WsyFL0QFMVRt
         U5oA==
X-Gm-Message-State: APjAAAXYLmyS7VhZr/dfIKuIkO2NqlO5axMHXKqBxEMhaUoO7lg6I73H
        q+ZRvQFn+qw1M+dIR8/yj4heb00RDX+8g2MNZ8A=
X-Google-Smtp-Source: APXvYqyS7xDdfX5QcavfFKmNCiXjhyC2Nxu85nMNDsfQK8Eol4g1rtx1nTWsTZ6suvdQLjxmEo2jEc+dJLjCkNY4ErY=
X-Received: by 2002:a19:2d44:: with SMTP id t4mr11772719lft.90.1551761517629;
 Mon, 04 Mar 2019 20:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20190304182719.GA6606@jordon-HP-15-Notebook-PC> <20190304163739.fbd2e5a508cfcf087a117620@linux-foundation.org>
In-Reply-To: <20190304163739.fbd2e5a508cfcf087a117620@linux-foundation.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 5 Mar 2019 10:21:46 +0530
Message-ID: <CAFqt6zYX4TEv7wT3iYB6gbzHmTEg6ap09EU1CmpSP7xwDOQVFw@mail.gmail.com>
Subject: Re: [PATCH] selftest/proc: Remove duplicate header
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, shuah@kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 6:07 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 4 Mar 2019 23:57:19 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> > Remove duplicate header which is included twice.
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> This signoff order makes me suspect that Sabyasachi was the author.  If
> so, the patch should have had Sabyasachi's From: line at the start of
> the changelog.
>
> Please clafify?

yes, sabyasachi was the author, but due to some email client issue
I am posting on behalf of him.
Ok, I will add Sabyasachi's From: line and post v2.
