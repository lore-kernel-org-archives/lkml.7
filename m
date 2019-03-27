Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348B4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A9620700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oAFwjt7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfC0TmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:42:08 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44913 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfC0TmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:42:08 -0400
Received: by mail-vk1-f193.google.com with SMTP id q189so3962081vkq.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXTvW1BnWGPiEMTFxGgyvNnFdmU+KXr/Meh9i2Hrysw=;
        b=oAFwjt7WQ4C/YIEWPmCRIoySCwSe64HzJdmCCWzS78KHJhMRPCOt4DKt0gm341JwTN
         xqbOBnlz7NAnoNb+duOp2A2hnRMO7VAnmovmG3tf0i2dIl2uxHqHm4FanVfmu5L8GwHx
         w98E/XCy6yQ2e80LXFvXRLrUY73Qh8q+DNYyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXTvW1BnWGPiEMTFxGgyvNnFdmU+KXr/Meh9i2Hrysw=;
        b=dDbkR/Dg+Bq/sP54yGT9cN98W2eWVEOOA9p7o75kpIDF6/fzJr9gPIC2VBbpO8n3H5
         eTWocOH2hwL/iQeU5SoqVwzJcktJzCYhLltb8vIfPLyMJh8mQ9Xi+QepUd9pzVxVwsYw
         kwKepSdTw1FEnnPY647I80WI7eCAjSHfE3iTU6YFlL3b0AtKKFDoEeQCHYczTGocvZEW
         p1Iz4Fm4mTiHFtCkbzu8SLMAbS/TMSztI+tVWC3rySMgDrYeIAxuHJWrF2UROA2JAH6G
         sLlWiwQOmgdABGb2xmPgFV45w4KSW09vA85rtTE7/Erq+yEX4sZhupLgJgaB0XLVGqls
         i1WQ==
X-Gm-Message-State: APjAAAVDLdukgvp32a9DekW8n0P2qMZOQTPGxQOkK1EVLsNjh+V1RZKn
        3gGRJdI2e3DOHE/bE+3ina/BZpGs9RU=
X-Google-Smtp-Source: APXvYqxpYc7RJit1yk8zUKXxIPglBZ+UJq+YopN3ZmzfHWpyi9Zj3iExo/0iPmuoQvoGb08zSEq/Uw==
X-Received: by 2002:a1f:992:: with SMTP id 140mr22871656vkj.48.1553715726762;
        Wed, 27 Mar 2019 12:42:06 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id x2sm2113761vkx.3.2019.03.27.12.42.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 12:42:06 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id s26so6024686uao.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 12:42:06 -0700 (PDT)
X-Received: by 2002:ab0:1ec6:: with SMTP id p6mr8004656uak.2.1553715417890;
 Wed, 27 Mar 2019 12:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190327162147.23198-1-christian@brauner.io> <20190327162147.23198-5-christian@brauner.io>
In-Reply-To: <20190327162147.23198-5-christian@brauner.io>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Mar 2019 12:36:46 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL-3XbFzT-1qzEiXE+DTPi_xi7dEtyAMTwBJU0BqrFeKQ@mail.gmail.com>
Message-ID: <CAGXu5jL-3XbFzT-1qzEiXE+DTPi_xi7dEtyAMTwBJU0BqrFeKQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] tests: add pidfd_open() tests
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>, bl0pbl33p@gmail.com,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        nagarathnam.muthusamy@oracle.com, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 9:22 AM Christian Brauner <christian@brauner.io> wrote:
>
> This adds a simple test case for pidfd_open().

Thank you for the tests. :) It might be nice to see more extensive
negative testing -- making sure pids aren't reachable from mismatched
pid namespaces, etc, but this gets us basic regression testing. Also,
you might save some copy/paste code using kselftest_harness.h's
interfaces.

-- 
Kees Cook
