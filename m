Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DF7C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 01:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6698A20818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 01:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563325371;
	bh=0j/PDfjbKZ8HyyLM7MX7MpepDKqr0Mh2uqMNu9KnuCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EO3oBIGH7qiNof4jCm5+AySSmMpaSpvSX6n/NjhAT4Xn+yppEiDdE9FOGPfBxXlaP
	 rN2trRXIX1VRyztgGmjkb9Og05gsvm+Hh2VNeyDbdaujwrNY/fgsn8IQqR7uY8NXDX
	 T/txpU3GjgG+bEM6jDruIbE51No9lxgDuinv7WHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbfGQBCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 21:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbfGQBCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 21:02:49 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24DAC20818
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 01:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563325368;
        bh=0j/PDfjbKZ8HyyLM7MX7MpepDKqr0Mh2uqMNu9KnuCE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ko/VaNYYHCdQQwJnHtw6rI17uOwG3BSR/bPh7y2Tgk5uYruB3vdPtIZSeEmibnks+
         K+LhhnJpOlpDPthQ95kiDChUJdhFce8uVwqwNdT1w96vKkUW8RQLgst9NtkBehPK2o
         W3CXugnNdOhFQa8VfNw8PZKxnwLFNIvzfE5cxaiQ=
Received: by mail-wm1-f47.google.com with SMTP id l2so20378798wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 18:02:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWDij8FE8MwqOMa5hsm9jWvBU9VMFYEPw3HWSfLx1RdMORDopKa
        vJy9DUWqpkOxrkPdmYuLda1zidkzLVkB+N+tfExzlA==
X-Google-Smtp-Source: APXvYqzJXl8DjEYeWzcicHDPjgF2x/4ykUesXghSvFSCWmtctaVJ6Gik3EwgLChxSFs7Z53lKkrj+cQbb706XM2bxA0=
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr32901183wmk.79.1563325366760;
 Tue, 16 Jul 2019 18:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190711114054.406765395@infradead.org> <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
 <97cdd0af-95cc-2583-dc19-129b20809110@oracle.com>
In-Reply-To: <97cdd0af-95cc-2583-dc19-129b20809110@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 16 Jul 2019 18:02:33 -0700
X-Gmail-Original-Message-ID: <CALCETrVisJsLk10WY6hgkqAJ7UsJCr4hHcdtrcUkMaPNOGNYLg@mail.gmail.com>
Message-ID: <CALCETrVisJsLk10WY6hgkqAJ7UsJCr4hHcdtrcUkMaPNOGNYLg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Tracing vs CR2
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux_lkml_grp@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 2:53 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
>
> On 7/16/19 9:33 PM, Vegard Nossum wrote:
> >
> > On 7/11/19 1:40 PM, Peter Zijlstra wrote:
> >> Hi,
> >>
> >> Here's the latest (and hopefully final) set of tracing vs CR2 patches.
> >>
> >> They are basically the same as v2, with only minor edits and tags
> >> collected
> >> from the last review.
> >>
> >> Please consider.
> >>
> >
> > Hi,
> >
> > I ran my own battery of tests on your patch set on top of
> > 5ad18b2e60b75c7297a998dea702451d33a052ed and ran into this:
> >

On a different thread, Peter and I decided that the last patch in this
series (the one that removes the _DEBUG stuff) is wrong.  Can you see
if these are reproducible with that patch removed?

--Andy
