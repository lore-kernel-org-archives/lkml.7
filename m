Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F18C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504F5208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgFwNm7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfE1HK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:10:58 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37469 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfE1HK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:10:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id m15so13077460lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 00:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ynfWVZAT+alkdWSrFWfQ62Goqe/tGGfT3VrMNKjpjqY=;
        b=bgFwNm7+1pgd6JqolEUxQRByPRGN1vZxI8M//me9z3DiO93l9obuCt9o9GNZt7fv/f
         KZZBISaE1EYLUBbY17g0G44R1JSWxKalm6wc/iT92mPbAEv9hMuuCp5+JCzzV/5o+jOo
         WkZsn4T3jrdXkz63dXltEv7Q4Xrou1+FWZ9r10qPAhZoDa2DAuoK/aR87PWRn9Fyqwui
         2ZzSBuGhMxKw3KPHAmwlcMa2Oqfyd9H3ihUgFZl3m9kevk7eSgul1tteN4tQRoY5+NH3
         eEIbMS1zZM2uJGm+YpVp17dXI3zMv2TpEwoSoMGwad74anaGMznDM7GyiZVXI/BxqMaG
         A8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ynfWVZAT+alkdWSrFWfQ62Goqe/tGGfT3VrMNKjpjqY=;
        b=VaPJJIgTtdROtanXbID2myrBIFX1jk6Ht3k8niuroHAWvKQ0t44TUfqA0ZVY9hng8H
         DivszlwJm4cynjyLOC3DPmBCSSAltkQoVSfpB63vBqQesCX1Unkfe/vSCm3x7McJuIhl
         1MOHXniK1seyaxwgW/HsTB0WE7888mcoxNmmLRCfrmv6YNMfZBz6BGhRCqYefUPOhaZa
         hwJJ1zYPoUP2NpbbRTaDKrN2ETY4w2Z95rBa//3XGKIiqzEYoTV6ksmYa9fE2TVn66F6
         cMYOK8GubazhU0PhZ8tQIADf8CIGxrZ/TcU50DHvasVAIGzOD5G8HG/j4hOdoseVJbO5
         4Ttw==
X-Gm-Message-State: APjAAAXUjPFYxScBYJhAiuXDsau1NHXIfAzi0ssKEozxeIlLqC+WWdCI
        nFIZOQXQlIQAm0FVu253Nvk9TL1teqg=
X-Google-Smtp-Source: APXvYqwIUjaetPcnQQPDn1Uq4N5rBWMVjAQhEJAxhYN9Tz/SMKkEI6VcqT0euSVA8ouuKKzM/LiPUQ==
X-Received: by 2002:ac2:42c8:: with SMTP id n8mr14725619lfl.28.1559027454638;
        Tue, 28 May 2019 00:10:54 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id z6sm2718712ljh.61.2019.05.28.00.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 00:10:53 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 3D45946010A; Tue, 28 May 2019 10:10:53 +0300 (MSK)
Date:   Tue, 28 May 2019 10:10:53 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dianzhang Chen <dianzhangchen0@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/sys.c: fix possible spectre-v1 in do_prlimit()
Message-ID: <20190528071053.GL11013@uranus>
References: <CAFbcbMATqCCpCR596FTaSdUV50nQSxDgXMd1ASgXu1CE+DJqTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFbcbMATqCCpCR596FTaSdUV50nQSxDgXMd1ASgXu1CE+DJqTw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 10:37:10AM +0800, Dianzhang Chen wrote:
> Hi,
> Because when i reply your email，i always get 'Message rejected' from
> gmail(get this rejection from all the recipients). I still don't know
> how to deal with it, so i reply your email here:

Hi! This is weird. Next time simply reply to LKML (I CC'ed it back).

> Because of speculative execution, the attacker can bypass the bound
> check `if (resource >= RLIM_NLIMITS)`.

And then misprediction get detected and execution is dropped. So I
still don't see a problem here, since we don't leak info even in
such case.

That said I don't mind for this patch but rather in a sake of
code clarity, not because of spectre issue since it has
nothing to do here.

> as for array_index_nospec(index, size), it will clamp the index within
> the range of [0, size), and attacker can't exploit speculative
> execution to make the index out of range [0, size).
> 
> 
> For more detail, please check the link below:
> 
> https://github.com/torvalds/linux/commit/f3804203306e098dae9ca51540fcd5eb700d7f40
