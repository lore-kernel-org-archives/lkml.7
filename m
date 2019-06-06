Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05EDC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15A1208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfFFOzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:55:01 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:58046 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbfFFOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:55:01 -0400
Received: by mail-it1-f199.google.com with SMTP id s2so143541itl.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 07:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=R8TcDtdRwn0wi82EAl1Zo57LJuPK69T+qkxhIovalQk=;
        b=ebY9aGBhURk9tXebCJtEAcNau+keJBFyu7LMOcXRU32FVhe/9y2L9kGMALwLg0K1F+
         0vknKQaSYll9Ic02628ZZSN6RB3KKNABZIQMcAxrhHvMYECuQQ2E9SncNtdEKnnLlJHd
         zR34GiSmNNYfjsuVc1y4OdB1tpW8Iq6cg8Q9NUNbzS9R/cMc+j2lYGeMhxI4Ch1iSfvi
         0Nbwd0IZjCTywT7xSV/ov2CZTQ5nYbyqXb5xXfnNenXadq9Qy9kccoMzjB0UiyHeAAUd
         0Wz4KZbolWNfKuleHN5FM2/4ZJFdofpLm7b8YbpyqA2EWmymSBT+gD8AlmfMd7MjuQEO
         XDZg==
X-Gm-Message-State: APjAAAUaqHWMnDd5W1mENmnMgu0Q3QblM+ncZBL3dcb/D78yCBekDrjv
        hGTQs+vM8OZIIEDTcbmMzT/aLEVADWv9iyon/yynuFF9j4PO
X-Google-Smtp-Source: APXvYqx6hNO688f1nGb9aDJ5teyR9hvYnxbn79yt4+3zppAhrpmNEdwnM+sH6zml00TrbrVYYjMr1hhagZN6LsUkZFoxkm5OAoeB
MIME-Version: 1.0
X-Received: by 2002:a6b:7a42:: with SMTP id k2mr21307120iop.214.1559832900696;
 Thu, 06 Jun 2019 07:55:00 -0700 (PDT)
Date:   Thu, 06 Jun 2019 07:55:00 -0700
In-Reply-To: <000000000000454279058aa80535@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f48306058aa8e5cb@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in usage_accumulate
From:   syzbot <syzbot+b0d730107e2ca6cb952f@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        dvyukov@google.com, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Sat Jun 30 13:17:47 2018 +0000

     bpf: sockhash fix omitted bucket lock in sock_close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111ccbbaa00000
start commit:   156c0591 Merge tag 'linux-kselftest-5.2-rc4' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=131ccbbaa00000
console output: https://syzkaller.appspot.com/x/log.txt?x=151ccbbaa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60564cb52ab29d5b
dashboard link: https://syzkaller.appspot.com/bug?extid=b0d730107e2ca6cb952f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a8fb61a00000

Reported-by: syzbot+b0d730107e2ca6cb952f@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
