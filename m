Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8E5C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 23:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CE22053B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 23:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wJreOXHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfLWXDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 18:03:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36216 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfLWXDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 18:03:16 -0500
Received: by mail-lf1-f67.google.com with SMTP id n12so13782765lfe.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 15:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MgW9n/m4gcYISQYozZa4aSF4iNn8BHSm10X5adtcj/E=;
        b=wJreOXHn5uk1YuFvki6L16MpfoJQayaMtM2qOj8R9DNPY2D2xyhOf/Mq5Cbo6fC42g
         1P0hImFFJBWNmY4BfguVj5cp90g/UGfkkaeHzeyL2FXREPewt0aa8b97/kuyGdewG843
         3M+hwTqoe4ctJVhYAXb8k6KTKvaVClDMBQz8jXJnEsirhk5TEYgowxDfcRqxVg2dSf2P
         pYP4FRMBysXfwUOcKhO6a7wH0GE+W28O+DI+lmxsLjeDPLQ0daJ3pzKgefgmKiiF70Wa
         2PcWj55+lgtMmyFKO4uXOv4nJrWBkmCWFnkdeseGvLHQwzSigRc5V1Sgum9PiVqftioC
         A7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgW9n/m4gcYISQYozZa4aSF4iNn8BHSm10X5adtcj/E=;
        b=qb4Al+ja13puqsQ79Yy7nQiotu3uQdICLqjoUZDm24Hue946bQPPrL89s6sDWhHUwl
         k3rkXplagDswo+XdPS6P50HVE8B7mK8M9WAs9wDtubAwKq7mMTyUSc9Eoj6oftwi6ZOS
         w5rdWYfSsII/dqyba+XryBzkmTwiUsA+c+K9dxIBa2TXKa7H7ICfVoSQB5GNb7eoakRE
         P9PRWSeSNEUnMGbnfajpq9AXsI0lB9NnapSz0kzMnmDXu52bA9uo5EqZ6nFF5jzMB90E
         dNNGQNj4yiJ8JHxTkFr/zpKdL9tFr4CtODSROPDMwC7PPur2E4dGSmI1IU3z8ygZ5gSK
         /U2A==
X-Gm-Message-State: APjAAAVAUSEqL5p9VU2/C9PKNOHOsx6qgzol8QzxR2sHRkaPNPlaE16j
        gjOpI5E23IBQHhpnntc2V86WxmhYNa8Scxc2B2Y7
X-Google-Smtp-Source: APXvYqxSh8JRtgJP3kXsVYH5qFYKVqiSG53d9jEFEN1BvT0WyoHP2+3PXgofkjT5qFzJmOYDEbLXBcIOvkxXz/8PlGg=
X-Received: by 2002:a19:86d7:: with SMTP id i206mr17447598lfd.119.1577142194497;
 Mon, 23 Dec 2019 15:03:14 -0800 (PST)
MIME-Version: 1.0
References: <157714208320.505827.13006028554511851520.stgit@chester>
In-Reply-To: <157714208320.505827.13006028554511851520.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Dec 2019 18:03:03 -0500
Message-ID: <CAHC9VhTdDGehupfYGmuijRw9BZv2eu289t-fbn_qUdTftU_70A@mail.gmail.com>
Subject: Re: [PATCH] selinux: ensure the policy has been loaded before reading
 the sidtab stats
To:     selinux@vger.kernel.org
Cc:     Jeff Vander Stoep <jeffv@google.com>, linux-kernel@vger.kernel.org,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 6:01 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Check to make sure we have loaded a policy before we query the
> sidtab's hash stats.  Failure to do so could result in a kernel
> panic/oops due to a dereferenced NULL pointer.
>
> Fixes: 66f8e2f03c02 ("selinux: sidtab reverse lookup hash table")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/ss/services.c |    6 ++++++
>  1 file changed, 6 insertions(+)

Merged into selinux/next.

-- 
paul moore
www.paul-moore.com
