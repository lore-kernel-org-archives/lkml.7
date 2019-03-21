Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6DCC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F0A21873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfCUJdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:33:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:47383 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfCUJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:33:01 -0400
Received: by mail-io1-f69.google.com with SMTP id b199so4596784iof.14
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 02:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TuDBZo0Ap4z0sFNIWNGdd2OQTbiabZRy7bSt+kBkq+Q=;
        b=oPb0+7MxONUuDau8k4v3zedd4KeCG166hDgaKAPcyNgiIhsm/RZTTzT1APupvZJYV+
         KZWZBIoon0LndpsAGvPxwBwckt5+IJBnAriez2olwZS4t/eoYtaTSHBhhTq7ZwN01Jsp
         RPk/w0Y2cXSnP5/cm/nOA8PyfWT3a7CQAL/algNqAV5OyUcsqxTvfBn3g4isct8PmKc7
         wb7vVMtHIOvVo6qBhp2MJD1Bsf+1cA2EidKXtFosAfcl5xFcc6cVrrO0ODCKmQSwUDIx
         9BjkAokrfoZ2IM5uNOPyBupDm0uKAJj1ZgvM9dzZvoXRf6Y2kiF7nKGvGNIf9HqcxWsm
         siHA==
X-Gm-Message-State: APjAAAV8D527Qhacu1Z9n8gbHe6AoxvSRArKmQOAaLKB+Ly1CUk6bBiu
        XMJiwzwkPzUNJ4910ezcHgsH/iiFjEiOj2S8D6GdcoToD8fO
X-Google-Smtp-Source: APXvYqyCEi0BKrfB3OYazWRi98aqpa9wXzzZMxLDO9M2SHr13w30LPhSHbfliXMYh+j3HAyVlZqqdJ5RS2B512ATprTHJJK5NagU
MIME-Version: 1.0
X-Received: by 2002:a24:6e8d:: with SMTP id w135mr1867149itc.143.1553160780810;
 Thu, 21 Mar 2019 02:33:00 -0700 (PDT)
Date:   Thu, 21 Mar 2019 02:33:00 -0700
In-Reply-To: <00000000000060e0ae057a092be8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e8ef30584976ca9@google.com>
Subject: Re: KASAN: use-after-free Read in crypto_gcm_init_common
From:   syzbot <syzbot+e736399a2c4054612307@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, ard.biesheuvel@linaro.org, aviadye@mellanox.com,
        borisp@mellanox.com, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, dhowells@redhat.com, ebiggers3@gmail.com,
        herbert@gondor.apana.org.au, jason@zx2c4.com,
        john.fastabend@gmail.com, k.marinushkin@gmail.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, security@kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 428490e38b2e352812e0b765d8bceafab0ec441d
Author: Jason A. Donenfeld <Jason@zx2c4.com>
Date:   Wed Sep 20 14:58:39 2017 +0000

     security/keys: rewrite all of big_key crypto

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=160eabcf200000
start commit:   428490e3 security/keys: rewrite all of big_key crypto
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=150eabcf200000
console output: https://syzkaller.appspot.com/x/log.txt?x=110eabcf200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9384ecb1c973baed
dashboard link: https://syzkaller.appspot.com/bug?extid=e736399a2c4054612307
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17902f5b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111377e5400000

Reported-by: syzbot+e736399a2c4054612307@syzkaller.appspotmail.com
Fixes: 428490e38b2e ("security/keys: rewrite all of big_key crypto")
