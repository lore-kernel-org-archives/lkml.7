Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DD3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C626213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbfDAGmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:42:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39022 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDAGmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:42:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so9850295wmk.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 23:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R2dwsEXJpe+ePQvKT4N+lP1t3+ZzfzBs9BAuUJxE/t4=;
        b=d0EiO/hce2iOnlRZWnhum4Lg17OIl33oK1M7A3J9UZjZsVlOsE18vCM8y2AgSlUJe/
         SYNuR//DqR2ITvKK65eOXZc7HJ3ZJikJIUC7Z2KyIEMU8qv3ID2dO5/1esJKm67gg6kE
         AMtKtmdvMeYafYLN9rdIub5xV7STGztkM5nbguLG7maSve+fPgQiY36XJTU+Oq7nvM37
         IPoA45upasRhcwu6I+kMLCxjZh2OaT/srg71TB6VTOYkJccvISyM6p5LaEi6ETL+tEAK
         sTwl204mxhUcNQF3zWbDayZK+8cBYUY8Lc9ptKvdoHJy/9vCjFN5Uz/cW09luoSw1vKP
         gUqg==
X-Gm-Message-State: APjAAAXbqktrL90ap+WDB60oItxNJXAA2fB/nNsE7Qv5/TyW+M28kV8p
        95PzF3Wv0eHauklvcwGi/XraDA==
X-Google-Smtp-Source: APXvYqwmQ7JS3qfRxQ4UZSyjWyfNBLkswP0YF1vBIHdNIFCORYIDqhTFznsabIodpJW3LyCYwTbGQg==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr11389348wmj.0.1554100931823;
        Sun, 31 Mar 2019 23:42:11 -0700 (PDT)
Received: from localhost.localdomain ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id q16sm7777411wmc.39.2019.03.31.23.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 23:42:11 -0700 (PDT)
Date:   Mon, 1 Apr 2019 08:42:08 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+65cecdd27b726c261799@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: INFO: rcu detected stall in corrupted (3)
Message-ID: <20190401064208.GH29508@localhost.localdomain>
References: <000000000000b08190058543449f@google.com>
 <8ecb5bc9-5761-64d0-64b2-1310300a64ec@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1903300843230.2476@nanos.tec.linutronix.de>
 <daec0343-b905-f483-602b-9c0b9e9b1379@i-love.sakura.ne.jp>
 <20190330104529.GB5935@zn.tnic>
 <77650d72-e2ec-e084-c929-210b16b8afb9@i-love.sakura.ne.jp>
 <20190330110933.GC5935@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330110933.GC5935@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/03/19 12:09, Borislav Petkov wrote:
> On Sat, Mar 30, 2019 at 07:57:50PM +0900, Tetsuo Handa wrote:
> > Yes. But what such threshold be? 0.1 second? 1 second? 10 seconds?
> > Can we find a threshold where everyone can agree on?
> 
> This is what we do all day on lkml: discussing changes so that (almost)
> everyone is happy with them.

Looks like this is the same problem we discussed a while ago [1], but
couldn't reach an agreement on what's best to do about it.

I'll need to go back and refresh memory.

Thanks,

- Juri

1 - https://lore.kernel.org/lkml/000000000000a4ee200578172fde@google.com/
