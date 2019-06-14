Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88D0C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75D721773
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZkFaZwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfFNJ7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:59:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33688 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfFNJ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:59:19 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so4560902iop.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v08nuKUfobTwd9D7NtlanDgmE4+9veHqDzK9gkjWjHE=;
        b=MZkFaZwAToCoJEP3nJq0oa9mk36X9an2xiMkrPu8xw6Rz2dyJe45mmOVeT18XSJypO
         dwiNzTPJByz5UDj/uc2jri8E6L+pqvBDRAOQHgI3x5upjWRJuJsA0CzezYmvIh/30XSz
         JARV0ZhDnfIBuyy7INNRJZdvvy2UmiUQF2eXnrzirjFXs6kBoNX44vM2u04kdFUeStMZ
         o+9fkcYpBhXMciQwMCDfRsZA6EyjPeeQdSru7sNhaiLjAHckp6osYMxd8c+BwCBwg0Ba
         wzHPpGaKPv+h+qHNzfFJNxFFPn32tCQkHqxei+ewy4bTiTcqYMrSEeb5zoil3uPioSRh
         su3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v08nuKUfobTwd9D7NtlanDgmE4+9veHqDzK9gkjWjHE=;
        b=CReYmpBWCCfv0FtXEnbnaAVF97QReaDdX88Uj4iX81XAcSwBB8Zho1JZsAM6kncAnf
         yYDts+uR5htNfB/fRkOSVSqPprw5dnBLwu0Z1Lf50p67KQDK2Oim5PSearcU13WQv882
         gDu9wxZiwA6ClLggMbQArzx2Kf7FvdP51dntdbqRFzClv4iyFM9dVwiTUStSfTG+mNvM
         kANR53iM413l1N7lSScZqJMee5cZlRc8HMA5xBdN8zTaNTq/Vj5BXtgq/5Ie9xk4LdKW
         q+hXJ3qRu2OJ/n47adyF7Nj5OXXzFqw1uMxBxcZdWvtUSRYRbYugkq3bCMWO3I6GiECh
         wRig==
X-Gm-Message-State: APjAAAVFZO5ui/zIn3kO+TqKHF+dwtSUP3YoLA0v2R0JuOuZA7J+Ufk4
        pTWdyH6/pMJv/7wvo25BCQc0/EDopFC1d46OvyGnEU9wjWmX4w==
X-Google-Smtp-Source: APXvYqw9qxqlAhjSCVYTqc0xE1/aiBP2Qv62atE/WzzptsuybOA1c8mBygpoIWXNnFCKzrTzRaLDoAjAyO8SBTfpvww=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr11341347ior.231.1560506358552;
 Fri, 14 Jun 2019 02:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190612094503.120f699a@lwn.net>
In-Reply-To: <20190612094503.120f699a@lwn.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 14 Jun 2019 11:59:03 +0200
Message-ID: <CACT4Y+avfTeZTmhti=7nEadthZZpTnOCTdEuG2S7PovmAMkhZQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add a document on rebasing and merging
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Rientjes <rientjes@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 5:45 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Every merge window seems to involve at least one episode where subsystem
> maintainers don't manage their trees as Linus would like.  Document the
> expectations so that at least he has something to point people to.
>
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
> I intend to apply this version unless somebody really screams.
>
> Changes in v3
>   - Fill out discussion on back merges and topic branches as suggested by
>     Jani.
>
> Changes in v2:
>   - Try to clear up "reparenting" v. "history modification"
>   - Make the "don't rebase public branches" rule into more of a guideline
>   - Fix typos noted by Geert
>   - Rename the document to better reflect its contents
>
>  Documentation/maintainer/index.rst            |   1 +
>  .../maintainer/rebasing-and-merging.rst       | 226 ++++++++++++++++++
>  2 files changed, 227 insertions(+)
>  create mode 100644 Documentation/maintainer/rebasing-and-merging.rst
>
> diff --git a/Documentation/maintainer/index.rst b/Documentation/maintainer/index.rst
> index 2a14916930cb..56e2c09dfa39 100644
> --- a/Documentation/maintainer/index.rst
> +++ b/Documentation/maintainer/index.rst
> @@ -10,5 +10,6 @@ additions to this manual.
>     :maxdepth: 2
>
>     configure-git
> +   rebasing-and-merging
>     pull-requests
>
> diff --git a/Documentation/maintainer/rebasing-and-merging.rst b/Documentation/maintainer/rebasing-and-merging.rst
> new file mode 100644
> index 000000000000..5da9da7a2c51
> --- /dev/null
> +++ b/Documentation/maintainer/rebasing-and-merging.rst
> @@ -0,0 +1,226 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================
> +Rebasing and merging
> +====================
> +
> +Maintaining a subsystem, as a general rule, requires a familiarity with the
> +Git source-code management system.  Git is a powerful tool with a lot of
> +features; as is often the case with such tools, there are right and wrong
> +ways to use those features.  This document looks in particular at the use
> +of rebasing and merging.  Maintainers often get in trouble when they use
> +those tools incorrectly, but avoiding problems is not actually all that
> +hard.
> +
> +One thing to be aware of in general is that, unlike many other projects,
> +the kernel community is not scared by seeing merge commits in its
> +development history.  Indeed, given the scale of the project, avoiding
> +merges would be nearly impossible.

Hi Jonathan,

I will appreciate if you elaborate a bit on this "scale of the
project". I wondered about reasons for having the current hierarchy of
trees and complex merging for a while, but wasn't able to find any
rationale. What exactly scale do you mean? I know a number of projects
that are comparable to Linux kernel, with the largest being 2 orders
of magnitude larger than kernel both in terms of code size and rate of
change, that use single tree and linear history. So these scales do
not seem to inherently require multiple trees and non-linear history.
Maybe this is already documented somewhere?

Thanks
