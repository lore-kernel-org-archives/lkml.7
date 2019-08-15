Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF889C32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 01:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6BA2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 01:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfHOB0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 21:26:02 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70]:52454 "EHLO
        mail-ot1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfHOB0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 21:26:01 -0400
Received: by mail-ot1-f70.google.com with SMTP id 88so740079otc.19
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 18:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ttLtpKYMG7TZIiRY6rerl+aSlij3EK8LczMw+lIahls=;
        b=pzZ7qr3+2Wba/0N0GhHHhBKdIDbieqbsgN38+dNzHzSNpXeGWm2FE3J2xTaSgMqm5K
         lu8ZZTPPgozFP4wtcWI2tgy/6EDMoPpNJAqnTJ30NowjPdIeUii0ag9vgnkr95/XDrDA
         TOTLNgdN0zQKK375uvA5ik+NrY98G71xfq2G6RxWVNz8Ti79jkC2KUnsgYRGMoNZ4jvK
         c28y7HjHwT3Cn2vC8FRkTyjNlrmeQ7G7iXLjPQuWTvLM1HsHqVer+0cSDeD6qpESQVvB
         BLusaf32oUVbIZpC0XBqd5rd6aXoRG3dbuX3XgXsVPx4MnfXi4zV6aJi7dNaVjCrMSpN
         g5Rw==
X-Gm-Message-State: APjAAAXc30dJwNmoQzEhBKbKLkiL/jylDnXSBMTiKt6Msd2KbIiQwBpD
        gZXIK7nG0iKhoXAUocoAV1WTFWbmfyBA8KtxbH6LT0vQn6Oa
X-Google-Smtp-Source: APXvYqytQ/ELGP5+AJ2kRvyfVtkrEdnSzCYc+HmAHVK4EP5we3PzXTOJnMwkWDWnNNMXNALxzIO9aa+V7C7O9SGIfcOtTSnNTuWC
MIME-Version: 1.0
X-Received: by 2002:a6b:dd18:: with SMTP id f24mr2888565ioc.97.1565832361042;
 Wed, 14 Aug 2019 18:26:01 -0700 (PDT)
Date:   Wed, 14 Aug 2019 18:26:01 -0700
In-Reply-To: <000000000000b851cb058f7e637f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a86cf005901dc156@google.com>
Subject: Re: WARNING in cgroup_rstat_updated
From:   syzbot <syzbot+370e4739fa489334a4ef@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, hdanton@sina.com,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=143286e2600000
start commit:   31cc088a Merge tag 'drm-next-2019-07-19' of git://anongit...
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=163286e2600000
console output: https://syzkaller.appspot.com/x/log.txt?x=123286e2600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4dba67bf8b8c9ad7
dashboard link: https://syzkaller.appspot.com/bug?extid=370e4739fa489334a4ef
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dd57dc600000

Reported-by: syzbot+370e4739fa489334a4ef@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
