Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A173EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725272089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128407;
	bh=tKj2nqZUmccPz/ExjPm+btVawzEdjfJGDbvCyifUutY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jAJutb0vPTzkk11g1tVlyhaiY6xrHKFLeD+Q07c+HiKA2dLAJq/h8ydK1+Z8AJtTF
	 vZM1DTVD+xAiKwJ+IFLeY1rY7LA0AmKHgZrtDihlLPQAO9Cx+OiGTZFhEiDjqMHbr0
	 riM00N4FZ8i6qhOcI63d4MJOhWB3q8gxe+l8alPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390430AbfDXR1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:27:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34403 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390415AbfDXR1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:27:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id y16so6854659ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUvwogsceCvulZa2xUlZzqWaS6JtW/Sna7ItlzMrws8=;
        b=YN4Jo9uXoB3q60AtYKnyHSTtEc6TsAfwzhF/zJX/PQx6VjRJ3PvkcCtPFVilfeX6Xf
         HOEFjQJGN/mLaqgt8SNN2OQbDk0YXQYyaPSqiY8aYj5y6xPtIolLn67PhB974h2zN3oy
         ZHSPvlpVICdbdrny1N3WILo9pswyAjKPTsNLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUvwogsceCvulZa2xUlZzqWaS6JtW/Sna7ItlzMrws8=;
        b=uelgksCqm4W3q/KlSFPiHmnKhbEJS+nQw8cYo1SKEJCePdbTGAsXBcgJ87V2Q5jomF
         n6JBw/d+Qz2GBAM6XODcy1ifBqDqHe7VYlNpKut/e1ejfDQCQUV5bcZSYZcRvpu9l8lg
         P1tKdFXVfwee/CwHww1vnin/BsvNCZ29X+ONxbVTgRFHrBLrWP/6/rAl4eSLSIxBPqje
         sPSy8trugajyiU/QyL5w4r+pkuTkS8K8QJyT9vlfvWAiqMeG/WEOQuCI59wsjjuzxWk7
         NY+SrQA4VzmrFFRFmkCVswhp64uEThU5Ndk+9U8733Ty/jO4k2XNoixrTzPaSkEs1m7e
         0t2g==
X-Gm-Message-State: APjAAAWfT0UM/ZZJc9pIEZIqzqWv5I83siGoUFM8kyApJKs/p38btk3i
        RL9I/kCPumlGZY4T3yrf/SrKBg3BLhg=
X-Google-Smtp-Source: APXvYqxDq17UeGsznbitqY3HPGXU2TYKPBoffypSTPakgxHGvtdoGim1C26Oi8P0K/JxDIWbdzXWJQ==
X-Received: by 2002:a2e:93c7:: with SMTP id p7mr18205443ljh.32.1556126834458;
        Wed, 24 Apr 2019 10:27:14 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id r136sm4472846lff.65.2019.04.24.10.27.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:27:12 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id j20so15321303lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 10:27:12 -0700 (PDT)
X-Received: by 2002:ac2:4567:: with SMTP id k7mr18527580lfm.166.1556126832009;
 Wed, 24 Apr 2019 10:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190424143341.27665-1-sashal@kernel.org> <20190424143341.27665-59-sashal@kernel.org>
 <20190424163415.GB21413@kroah.com> <CAHk-=wjEOyba5As1PEMk6RitNVOJH9oJ_Jbg4y=5B0fcX1iKGw@mail.gmail.com>
 <20190424171926.GA17719@sasha-vm>
In-Reply-To: <20190424171926.GA17719@sasha-vm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Apr 2019 10:26:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgh234SyBG810=vB360PCzVkAhQRqGg8aFdATZd+daCFw@mail.gmail.com>
Message-ID: <CAHk-=wgh234SyBG810=vB360PCzVkAhQRqGg8aFdATZd+daCFw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.0 59/66] fs: stream_open - opener for
 stream-like files so that read and write can run simultaneously without deadlock
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:19 AM Sasha Levin <sashal@kernel.org> wrote:
>
> Hm, I might be confusing something here but I see a bunch of patches
> that convert existing callers mentioned in this patch to use
> stream_open() which was introduced here.

The only use of stream_open() upstream right now is the xenbus
conversion, and that isn't actually a bugfix, because xenbus used to
manually do that

        filp->f_mode &= ~FMODE_ATOMIC_POS; /* cdev-style semantics */

that stream_open() does.

So no, there isn't "a bunch of patches" anywhere.

There are *future* cleanups for 5.2 that will happen, and that might
have hit linux-next. And there is at least one FUSE patch (again -
pending, not upstream) that may get marked for stable.

But I see nothing right now that makes it stable material yet.

                Linus
