Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54D0C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8408A21841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DfXOAxLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfGXSxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:53:08 -0400
Received: from mail-yw1-f51.google.com ([209.85.161.51]:37242 "EHLO
        mail-yw1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfGXSxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:53:07 -0400
Received: by mail-yw1-f51.google.com with SMTP id u141so18443414ywe.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QkGoST7w43m8q/Esj90wYrBwrvB8U4NUXNoDEdC9zkw=;
        b=DfXOAxLjSWi0qh+6acmkUVxhHaotyiTVOkhsQbMCVCLbFTlR2U1M0ODKowJTZJO6bi
         AY4cPMEmUVjHi/lcQq9q37dCvu2bxLSVO/2Cj8MQSNmWh284hoz1A9kJu5T/rqAxWcA2
         jq1E8odfVy4B94g+1ICGV53JhdfxUUprY27NbVBtrvAexfQf3KrE8GYJRv90j+EI/68F
         Nt3i/MnH39+tuaOwo08OPFbdY9meH5zycXj1mSdL06kJEGcaFb6OBltS1Q3K1ZM+3TgE
         t7kmiIPAvExMNewu7rKRPP8E2uZYbTCErawj37va4v6NHlCBcpqh2cLAXrJiNfJHXoo3
         cZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QkGoST7w43m8q/Esj90wYrBwrvB8U4NUXNoDEdC9zkw=;
        b=FD8yX9dxSfLHymHlf4J0Dapi65wWp+XnTnyHwKR3vMu4Y7UEJa6A+bLykbTNhpQpyx
         Owmftn4s+ZyEDwAv+HP+JtUOry6Vh3iNRHIo0593BI7rZg53EJq2w7k1JI58yoGdJEAr
         02M82AixJsJHXesKJ8iCXZcSLvC+XvcJzVc6n62qQM20os8nyL6zqEAL/6ZgQYuyqBRP
         mxdrBYURyCFsNfDM1bUo7Ku0PI8UD2z0aY2/3+QnGxy7/IYxiseyILeQNUCh7NaBsC2K
         1ApIs85+8dVyT2fqqzvpWj8HqQnv9JPmBIrHDU6TseDETWZibWFsXFVVQn8Gk1CMHHYW
         VPpw==
X-Gm-Message-State: APjAAAUjHW3K/JLoru7WpSf3ITLx92dut5qCJHfdJxHg8HmAiwJpFW7q
        vq/4bkus3yhmQzlXfOGwST+Lplk8HEHSAGkLj0M2ew==
X-Google-Smtp-Source: APXvYqx/tMXLvZEiqYfzJYCs7OOzSaxnEEKNMHX5g5zE3SSvQ73RpFpciwz3aMrVNiSRZv8HDB0OwcO0qWyK+HgZCIU=
X-Received: by 2002:a0d:dfc4:: with SMTP id i187mr48556986ywe.146.1563994386315;
 Wed, 24 Jul 2019 11:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190724013813.GB643@sol.localdomain> <63f12327-dd4b-5210-4de2-705af6bc4ba4@gmail.com>
 <20190724163014.GC673@sol.localdomain> <20190724.111225.2257475150626507655.davem@davemloft.net>
 <20190724183710.GF213255@gmail.com>
In-Reply-To: <20190724183710.GF213255@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 24 Jul 2019 20:52:54 +0200
Message-ID: <CANn89iKZcdk-YfqZ-F1toHDLW3Etf5oPR78bXOq0FbjwWyiSMQ@mail.gmail.com>
Subject: Re: Reminder: 99 open syzbot bugs in net subsystem
To:     David Miller <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        netdev <netdev@vger.kernel.org>, Florian Westphal <fw@strlen.de>,
        i.maximets@samsung.com, Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 8:37 PM Eric Biggers <ebiggers@kernel.org> wrote:

> A huge number of valid open bugs are not being fixed, which is a fact.  We can
> argue about what words to use to describe this situation, but it doesn't change
> the situation itself.
>
> What is your proposed solution?

syzbot sends emails, plenty  of them, with many wrong bisection
results, increasing the noise.

If nobody is interested, I am not sure sending copies of them
repeatedly will be of any help.

Maybe a simple monthly reminder with one URL to go to the list of bugs
would be less intrusive.
