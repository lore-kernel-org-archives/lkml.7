Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D306FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95642189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfH1T6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:58:37 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:57564 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbfH1T6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:58:37 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7SJwaxY009304
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:58:36 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7SJwVWw027467
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:58:36 -0400
Received: by mail-qt1-f199.google.com with SMTP id z4so956077qts.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 12:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=2oEueiPtAGEIwX138tAMJxM5R33PCmQ8frI6jFVAikg=;
        b=YzNOxBJIC1ICgH2uFgAXyW+cJR/vCILiVjzZUwgEWjBXYFR1axPmqfIg5WOPJrbXN9
         tNKcfpfjpi6YbGJD2AcFEAQ9Gctl6rGY9hhqMb6EJ92Gg11WPZohZI/Keig6eV3krgEh
         qHwkwl1w0v8tLd03wZqYGvVq+7LhWCKVQoWkMtXm++BtAPgrUL38Ywjsgq/iSXswUoiq
         0cVQZ14ruXkkD97J/Qb66zNv4bAEFV16hrNR/6lsDoYF7vcK/zjKlt3z16HtneWCXnNc
         Nej5AYucLCB2JyMt93s9FfJxjkXbFnXW1UsFlqvj3UQODPmdBouo2QFO26RTxQOGp7B1
         jMfw==
X-Gm-Message-State: APjAAAU2tSRyhnCupozI0EwpRlWspDfHdg3m2sVLTEyewrkYMV3vvScM
        pn3SqKmn7h2tBGmG6Ke4GUpnQsiu6CzmgxqfE8AjeNwhZny/3z9G1cLgZ/fBeoPUyQuhJhLYWmq
        ax+LC5zSsGqnED3M18TGf++YzW/e4h4ZjOTg=
X-Received: by 2002:ac8:289b:: with SMTP id i27mr6323163qti.67.1567022310662;
        Wed, 28 Aug 2019 12:58:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzq7womxX1JpDFcG7rDj9pzOHlJvJ91wtZFZ1bqvUhKAgbIMxVUMlQ/MLtJ+cKBQpfTvWohew==
X-Received: by 2002:ac8:289b:: with SMTP id i27mr6323147qti.67.1567022310422;
        Wed, 28 Aug 2019 12:58:30 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id k16sm63596qki.119.2019.08.28.12.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 12:58:29 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: next-20190826 - objtool fails to build.
In-reply-to: <20190828195100.tbkvphzhjtflrp66@treble>
References: <133250.1566965715@turing-police> <20190828151003.3px5plk4tp2s5s5c@treble> <23345.1567020600@turing-police>
 <20190828195100.tbkvphzhjtflrp66@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 28 Aug 2019 15:58:28 -0400
Message-ID: <25813.1567022308@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 14:51:00 -0500, Josh Poimboeuf said:

> > The real question then becomes - should the Makefile sanitize CFLAGS or just
> > append to whatever the user supplied as it does currently? The rest of the tree
> > sanitizes CFLAG, because I don't get deluged in -Wsign-compare warnings all
> > over the place...
>
> Agreed.  I assume this fixes it?
>
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index 88158239622b..20f67fcf378d 100644

> -CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
> +CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)

Yep, thanks.  Feel free to stick these on the final version:

Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Tested-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
