Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C078C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECE72085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfF0K6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 06:58:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:57062 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0K6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:58:01 -0400
Received: by mail-io1-f70.google.com with SMTP id u25so2120330iol.23
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 03:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Qd5yz8D6nzHy8/WHIsu0XvDmoEeh/tbWUaUPsfPoLfU=;
        b=kGJtkk52FaGYbfp4MGxiA3SB+qdDqWLu1ANFm2lWIYSDdf1bNWEFun3wLkSD/6C6ui
         0d/vIeK9GNgsLVBC0jBnAbTAD3ienI7E0so/AFk3O41wMk1fRZZV0vsdfmv5ehU6O0Vr
         s09lax4U01P7RREGUbUTe6e47zGJ1bZ6I2l902crUCqhYxw9OKJbivRUFwyC/Dc4bSdE
         R4+uJcVEntlwPAeh6hg0mXYzqO11irY93581k2c67SduBovYYtV3M59LYPkZs5f6Fh2h
         Uz2G9F3RbWP2xqHbW8PNHq8ZrVhpW6MzZzmsmnnixzAQ1C/S8dlNHR0nngijo3z/yBqD
         6PXA==
X-Gm-Message-State: APjAAAUqXj7icN1/q1mRk3oeaOffodU2DNhTECB4PnaxMLg8XGndhwfO
        IL4atepafBFf8eemu0hBQ0cTGTL2iVVM25tyFdt9K5Ou2T8Q
X-Google-Smtp-Source: APXvYqyFMB8ZqB5Hvwd/r6Qq21rENIAh6D36I89aMJ9OWo9sekU/qTEYVyqcJaSJdsoL2uLgqaaGvev7HQgFP9ZgljJSrVVi095A
MIME-Version: 1.0
X-Received: by 2002:a6b:bec7:: with SMTP id o190mr3664415iof.158.1561633080591;
 Thu, 27 Jun 2019 03:58:00 -0700 (PDT)
Date:   Thu, 27 Jun 2019 03:58:00 -0700
In-Reply-To: <00000000000008f38a058bd500b9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009ccbc058c4c09bf@google.com>
Subject: Re: BUG: unable to handle kernel paging request in cpuacct_account_field
From:   syzbot <syzbot+a952f743523593b39174@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, fweisbec@gmail.com,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13dd1b79a00000
start commit:   abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=103d1b79a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17dd1b79a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c77f8090a3b96b
dashboard link: https://syzkaller.appspot.com/bug?extid=a952f743523593b39174
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1372abc6a00000

Reported-by: syzbot+a952f743523593b39174@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
