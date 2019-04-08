Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0C5C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CE520870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554682489;
	bh=6Sr2mevbTKMTTOKntVyqe/dBPWEGEd2/3rjNg5PJUDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KZucz9KrUQUxhL1DUNIcCX7dWnIiRMpu1rTU28cDAjFHPSOXwkxo4g8gY3qP9/XyQ
	 Te+wxLe3w+B8k4V2a4Ad/Eb2q7esyuOi5lXOnwM74KOr4XXneephfPzvxG6oMwOzMz
	 QB6TyDOZQy39VtxObwlKHZGWg4F0Yyf8VnN7uwhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfDHAOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 20:14:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36972 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfDHAOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 20:14:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id o19so8094278lfl.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 17:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BN2Scp1e2tj+s310EsYx4nmWm8XPI663CLXS9nm4Fjk=;
        b=HZnZyLpq5Th0WmzMbrpumSBRGrDptmt2gGvTI/FlGFJOVt6sgggMrKwwqgnPYWdHme
         Te3VCHtrjeVvmoP86TppgRRo53vL4W3i/5YwybVZNf342QEJCsSCoVOoQdCOSFlCAYzk
         VL6X1bAQj8jOCS9whfRQxSfVvc0a9yWPUzL+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BN2Scp1e2tj+s310EsYx4nmWm8XPI663CLXS9nm4Fjk=;
        b=dJcTnLZ7taSwea5VbHxniN6IW5OUHpd5NALoxE4uN8E8M5HcLt7OEUmzX8xKa7uhB7
         fAVvg+D9g0wg+aoYHp/vFepx6eY7JY69MePVaIV0DHG29LbwuCyHBbTZR90WdqtxO33X
         KYTx81kk427+U2DZ+1Rqfe2OCfv3X9wAxkvW/3ZIlpYUZLf1fRU+iBjBqoSM+QqXv8hb
         txBsucnIBc+XDvQGwyTvUXme3NPhQNDLbeDBKS/2Bc3AV8qw1deeLGmETBzn9ylTZA96
         mQsNdT6LeBNoclvbP75R++IXLr6mzyYQBZiq58aYmiI5YPkaKqH9JUK97HHMd7isBoSh
         OKxA==
X-Gm-Message-State: APjAAAVNgZ7yL+u/wn5RjeAbqv3y6XywdNj1vBg2NBroWDGBcgxMkaJH
        NZkNjrEsG0ik7NZJhVhYuZCFU5HPp6o=
X-Google-Smtp-Source: APXvYqw6sJPs0io0eaqBFGX5uaWtV2MhMAqGZT4PinvNCJqIreeV4+Jj4qVfpS6z3F0qJ5e++2HT2g==
X-Received: by 2002:ac2:489b:: with SMTP id x27mr10432789lfc.107.1554682485096;
        Sun, 07 Apr 2019 17:14:45 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id z67sm1001001lfa.90.2019.04.07.17.14.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 17:14:44 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id m13so8101875lfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 17:14:44 -0700 (PDT)
X-Received: by 2002:ac2:5489:: with SMTP id t9mr1689044lfk.62.1554682164762;
 Sun, 07 Apr 2019 17:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <c44fcf87d4c9d417b6cdced787091300fd45a3e4.1553637461.git.kirr@nexedi.com>
 <CAHk-=wgqgN5j1ZWnyVLqqoyU=CCWTYOko3MDyU8L_5e21KvHAg@mail.gmail.com> <20190407200423.GA2829@deco.navytux.spb.ru>
In-Reply-To: <20190407200423.GA2829@deco.navytux.spb.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Apr 2019 14:09:08 -1000
X-Gmail-Original-Message-ID: <CAHk-=whQQdoQsgEx1vO7OkfPDcV5hurPnMRLgzfXAPN63n5Sbg@mail.gmail.com>
Message-ID: <CAHk-=whQQdoQsgEx1vO7OkfPDcV5hurPnMRLgzfXAPN63n5Sbg@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs: stream_open - opener for stream-like files so
 that read and write can run simultaneously without deadlock
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 10:04 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> Fixing regression on FUSE side is my reason to do this whole work -
> that's why I care about it the most and ask.

Yeah, we can do the actual FUSE fix, I think. Preferably through the
FUSE tree. Miklos?

                 Linus
