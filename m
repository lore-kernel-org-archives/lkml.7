Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B837AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866B5208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="I+iiAiaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbfISUzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:55:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39151 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbfISUzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:55:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id a15so1747412edt.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oOsPY7dzPYXiWz16EZVCaTHv03LDObuM8JWwXte1DFk=;
        b=I+iiAiaIIT1nzYGWMnmtIf3Q6k+Hv0VaD1K0im3yX9TzkVKsN7MjqK0bhtqBQoluxh
         zPtgCkfNEGABORe8XY+4RWdDCfjGP4b5ZINwVGwiyiM7uKbYzfGbtmNpS2Az7ucR658B
         SZSdFTywaXV9o0GkxZjdWIXycr76F2bwWxO48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oOsPY7dzPYXiWz16EZVCaTHv03LDObuM8JWwXte1DFk=;
        b=SIN6DZka97VzCxNtq2J9FEqV4z1DgrGvH5mpjGqy4FvtUcLEYmNBZU7/MVWZO2CvGJ
         I+PhmlKbbeiY7iS1rpIAKi+thHs9tNs9cuHTRy5KC9fYMYky6IE+XD1YQnyMTgrC1kwY
         /ZdY8IHfxvnq3R6kBoQzYbVA9yk72wSUL5yVFr5CK7854ABXreEM/cmIGBIRJBX7nAPV
         a2vXskDaZsqIfqeNHhR4/hTzzPoGdaR47qzlFPZ63LQZaRP7+yxelKfL16XN/iTPSlnL
         eKzU0kCYgX/5wFKHyGChep9GVSaOFtV6Z5UoogaebLO8Tx6gJDtfBZYms2EkhmPd98H9
         frZA==
X-Gm-Message-State: APjAAAU8ZwXWXYMlGkBgbdTW3EGXSb/vLbf0rD4Br5Cv4iMtP8Ttdft/
        o7lhfJS/6pWcyW9ZKw446w9PVeVTPF5oMMYi
X-Google-Smtp-Source: APXvYqwn4goKlaLZbVdpBFd3OXJN7wo8pexhHo9njJlkZ1lxazLRn6VzU0ezwxdUc5CFnrtbuRI6vQ==
X-Received: by 2002:a17:906:944b:: with SMTP id z11mr15601123ejx.46.1568926546319;
        Thu, 19 Sep 2019 13:55:46 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id fx25sm1148608ejb.19.2019.09.19.13.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 13:55:45 -0700 (PDT)
Subject: Re: INFO: task hung in pipe_write (2)
To:     syzbot <syzbot+3c01db6025f26530cf8d@syzkaller.appspotmail.com>,
        agruenba@redhat.com, darrick.wong@oracle.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <000000000000ac6a360592eb26c1@google.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d9a957b3-9f0a-20b5-588a-64ca4722d433@rasmusvillemoes.dk>
Date:   Thu, 19 Sep 2019 22:55:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <000000000000ac6a360592eb26c1@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2019 19.19, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    288b9117 Add linux-next specific files for 20190918
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17e86645600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f6126e51304ef1c3
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3c01db6025f26530cf8d
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11855769600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143580a1600000
> 
> The bug was bisected to:
> 
> commit cfb864757d8690631aadf1c4b80022c18ae865b3
> Author: Darrick J. Wong <darrick.wong@oracle.com>
> Date:   Tue Sep 17 16:05:22 2019 +0000
> 
>     splice: only read in as much information as there is pipe buffer space

The middle hunk (the one before splice_pipe_to_pipe()) accesses
opipe->{buffers, nrbufs}, but opipe is not locked at that point. So
maybe we end up passing len==0, which seems (once there's room in opipe)
it would put a zero-length pipe_buffer in opipe - and that probably
violates an invariant somewhere.

But does the splice_pipe_to_pipe() case even need that extra logic?
Doesn't it handle short writes correctly already?

Rasmus
