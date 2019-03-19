Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B744C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26287213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCSU7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:59:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:34220 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfCSU7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:59:01 -0400
Received: by mail-io1-f72.google.com with SMTP id y13so52964iol.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 13:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=m0aq4As75vm5tiDtlM4tAlAfFHMaZoYC4KZFVQM0p2o=;
        b=lPbRNe+9T68pJCPWDtrqXEUDnEYXBlmXanCxgqIroWTOekD1zsKGNYUh4+UXX6F5k1
         /DgF44y49nJ+lOQvB5DrTUw9AxmsbdcAt4g04/vR4tDiVCzLuZxVbSsFihBoeJC9Oe9Q
         c7SfquZC1qgSKckT5e5GAP1Jb5onL15u6QdvV7e69xbeLusSfx2nH22YH1FoGesnZITt
         YPRgbog1l45+cizsDnngrr0b6lxM5lnyPyncp7gfB8jf4hq3AN+Sye/+w0xyyuj1G+/l
         nGWAktTmjQ6tZaOmYpp+uo0yPEfwlp6EwxNW7WEN0u+FfOgPYJAWVbRMfcJtISF3QNfy
         2kOA==
X-Gm-Message-State: APjAAAV0CFgX4mJRZfoY+CcLRZEdm1bqwl/bZn3mLp7dTmGVOdzEaj9p
        Ff+LCtjRZXZjGt3w2lhXZWZ6Wus4tq0nRuoNQ22XgTOxiGQi
X-Google-Smtp-Source: APXvYqwXkLFHWGZ8QVHzSvWHwOoE9Tn9Mt3aA+MDPW54EQEGCKIWMOOEMZEAWXiEaRMYHn8SVi72lZ0xIObu/LM0iSFwq1su/Ctg
MIME-Version: 1.0
X-Received: by 2002:a6b:7115:: with SMTP id q21mr67424iog.25.1553029140573;
 Tue, 19 Mar 2019 13:59:00 -0700 (PDT)
Date:   Tue, 19 Mar 2019 13:59:00 -0700
In-Reply-To: <0000000000007783a2058474a0b9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ff5a5058478c6c4@google.com>
Subject: Re: WARNING: suspicious RCU usage in xfrm_alloc_userspi
From:   syzbot <syzbot+59752237f7ab21c3f3c3@syzkaller.appspotmail.com>
To:     davem@davemloft.net, eric.dumazet@gmail.com, fw@strlen.de,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        suyj.fnst@cn.fujitsu.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f10e0010fae8174dc20bdc872bcaa85baa925cb7
Author: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Date:   Thu Mar 7 01:54:08 2019 +0000

     net: xfrm: Add '_rcu' tag for rcu protected pointer in netns_xfrm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1644ec8b200000
start commit:   f10e0010 net: xfrm: Add '_rcu' tag for rcu protected point..
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1544ec8b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1144ec8b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59cd5d43b5df6955
dashboard link: https://syzkaller.appspot.com/bug?extid=59752237f7ab21c3f3c3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e70cb3200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17292127200000

Reported-by: syzbot+59752237f7ab21c3f3c3@syzkaller.appspotmail.com
Fixes: f10e0010 ("net: xfrm: Add '_rcu' tag for rcu protected pointer in  
netns_xfrm")
