Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD20CC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854A72087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfCYEwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:52:05 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33945 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfCYEwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:52:02 -0400
Received: by mail-io1-f71.google.com with SMTP id y13so7004374iol.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 21:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WcXVUAK+lZFpkdWJr/seSTlJnJy+pQhGCMX6I+mL6ls=;
        b=FcEOJLp37e8VNNtvt+ATyhIzL7oWSVZQEJgnPpl4+RBygnN/CvddOqpGk2o+3nIRqf
         F2jdCLmmgwPjgD9WZXfWNlaXRt0tXk1urBP4lrg0CgwfUNnUefkWnc6q5OuwCkmiJ313
         fWxyk59Lveu+Vy7RLKfXYlEQ1qnPBO+FT3ZCcD8xnR3g7CJOaTNih7hwru+oN5msvgsl
         NDoCQTXJhqvwt0ONgiMxzEQAge1b23KWwHD7WAL6ih/UOM+nA0zMXCKo6b0/bjwyV4ax
         bMK74pd1FuBf91QpaJPfFla4Rl6d1WdmBSNgsHeOOfP0Ml/Xi0HmSXXrM1sR+Tddf9pK
         5pWg==
X-Gm-Message-State: APjAAAWQiVVmkFBWxqS27QelQVSkaN0c2VPxEQpcvNFQG4RSb2HUPpYE
        EprOvkhsisA4PRA9RQzSAnCFfYizuaK9oSSqDYlCChUs0CMG
X-Google-Smtp-Source: APXvYqx9Y9m/MMu7uF4zVR2fBYaG84rNBR13pG7qYtp/8Mf34yY1qlXsI+PS6RDfj2TmfhKwzXmzn43jK4PPH+fQ4csjYPtBFEBC
MIME-Version: 1.0
X-Received: by 2002:a6b:d913:: with SMTP id r19mr7700493ioc.76.1553489521291;
 Sun, 24 Mar 2019 21:52:01 -0700 (PDT)
Date:   Sun, 24 Mar 2019 21:52:01 -0700
In-Reply-To: <000000000000663620057bbd0e9d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000143bcd0584e3f7ea@google.com>
Subject: Re: KASAN: use-after-free Read in link_path_walk
From:   syzbot <syzbot+fb731ca573367b7f6564@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 0f98621bef5d2b7ad41f6595899660af344f5016
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Sat Oct 29 00:30:46 2016 +0000

     bpf, inode: add support for symlinks and fix mtime/ctime

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13c347a3200000
start commit:   ef78e5ec ia64: export node_distance function
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=102347a3200000
console output: https://syzkaller.appspot.com/x/log.txt?x=17c347a3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c94f9f0c0363db4b
dashboard link: https://syzkaller.appspot.com/bug?extid=fb731ca573367b7f6564
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11116225400000

Reported-by: syzbot+fb731ca573367b7f6564@syzkaller.appspotmail.com
Fixes: 0f98621bef5d ("bpf, inode: add support for symlinks and fix  
mtime/ctime")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
