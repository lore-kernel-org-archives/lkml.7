Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E63C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEE32082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557176157;
	bh=MJGQtbr3SVPwPzhwzTF6faNs/xQmywKrZ8DDLfalMME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FJOU7GgzGaa8xW7JE8vFiDzNi+Ub2zbqtkzvm7FaADOaj4TMyTcZzz+RhQWWnPTaM
	 I2sLF6miS4L313kT+HIqzUOqKekzQ8GYu2anOfa239P0qg8yBNAGfOdlfggGT0Se6V
	 6opTEpHXg9Ar/uGBJCQEeTmkz0G4JtzeoPBiWaK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfEFUz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 16:55:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38393 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfEFUzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 16:55:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id u21so3214287lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 13:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+wx15rGm9cDQexehyk/mRiQiqjaNR8eRgC+cNivLYI=;
        b=TmbcnqXU9pQk+YWlxnUQotMwmX2uY4bDvF54qfvao07i2ySRBjA1Xm6gX4V6q8U/SF
         Bv2Gj3i8iN0eCrWXDT4PoXf8poPp86x2tqTXhp1jUfZ5kmZdIvwoks7l84Ew9c3yo+1T
         QGwBQi8xjgpe1QWco+n9pgphWcu2SrUq/8EmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+wx15rGm9cDQexehyk/mRiQiqjaNR8eRgC+cNivLYI=;
        b=EsOknWu6KuJf2xSBIxNjG4tK7UBg5q49cGOLeV0S0lyxereJfgycv1FHVk3T9yp/ic
         AyJZCQvYXB9Kf/Pplf9GPU3yWPpoju0Yu/tdVX5Ual75GdYgrbAIuoFguLXdy5SVqk1w
         2tavp494CJkWv/eW8ofGRUVaCSAXw9VTU0/mx+RSa/u66FHWIDGGfHzhdKL4dLoxXf+t
         J/YrcViGmiEGwrSmRiBpra7IYVYnQi127TbRiXEilOsJ6/q9CWFt6PROihelG8rsPFXj
         au3OszyzYLwO6mqzgaYFfW0b3sqovp2h1XqrT8upIkCtwkJZk2wzFUlbEC3IBI49+cmA
         H3Tg==
X-Gm-Message-State: APjAAAUydDWKvS71aG12fnwi+kxuuna+JU1xSodvzm2Ot183nlGNh6VL
        UP+GLIjRfc5VFkAeHy0uqF/7orVVpBo=
X-Google-Smtp-Source: APXvYqwzfrXLrwEgHBSMjIwdkq69eiteI5TfdB6rplXVh28UGk5zMMArI1inqVcma+UR0uOc96zctw==
X-Received: by 2002:a2e:9216:: with SMTP id k22mr220288ljg.179.1557176153429;
        Mon, 06 May 2019 13:55:53 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id r136sm2715552lff.50.2019.05.06.13.55.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 13:55:52 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id o16so10163618lfl.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 13:55:52 -0700 (PDT)
X-Received: by 2002:a19:2952:: with SMTP id p79mr5408053lfp.166.1557176150977;
 Mon, 06 May 2019 13:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190506085014.GA130963@gmail.com> <a5ee37fe-bdcf-2da7-4f02-6d64b4dcd2d3@gmail.com>
 <20190506194339.GA20938@gmail.com>
In-Reply-To: <20190506194339.GA20938@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 13:55:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifHYK-NKCTbT3_iHpy3QeK7H+=RLbFUaFpPziPn3O8Ng@mail.gmail.com>
Message-ID: <CAHk-=wifHYK-NKCTbT3_iHpy3QeK7H+=RLbFUaFpPziPn3O8Ng@mail.gmail.com>
Subject: Re: [GIT PULL] locking changes for v5.2
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Waiman Long <longman9394@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 12:43 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> Sure - how close is this to a straight:
>
>         git revert 70800c3c0cc5

It's not really a revert. The code is different (and better) from the
straight revert, but perhaps equally importantly it also ends up with
a big comment about what's going on that made the original commit
wrong.

So I'd suggest just taking the patch as-is, and not calling it a
revert. It may revert to the original _model_ of wakup list traversal,
but it does so differently enough that the patch itself is not a
revert.

                 Linus
