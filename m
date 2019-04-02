Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE70C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5F62064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfDBFEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:04:02 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:39404 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbfDBFEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:04:02 -0400
Received: by mail-it1-f199.google.com with SMTP id e124so1738684ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 22:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pruVix1qMc6LUErjuVnRHaxLcTZ1UI/JrJbrr+UUKJk=;
        b=uPFpzTIrnOaCAYWPVfq3iHSWBim6RGA4l18oqfE8h5Nj1DCEOTshi8nSdbHCkdJZ/K
         5Z5iiNjz0+3cNbCr8YQmva0kemDQgq5m2HnhIqPHQTv47JLHiIzd96LtKVVqbncCIWqF
         Rm1agDq52CR0hp+ooW41ohCBPxrJeNVqG7QB11LOuL6/Rcq7uHA4QcjTgpI3Jj5hkA8Y
         AdJZMl1r0hdzVQv5iquZP6W2ELFOCHZjmjuYzRki/QrKBGOvzLpb/bKuiJZKEtDQxek8
         l/gSZN1ch2ZXoeICQIVZbKVilr7Gq4xeGddhNOcmvITOfWqAIHeWkqP1X94UK3QAMvUL
         gd/Q==
X-Gm-Message-State: APjAAAUNfbbzT0oshx23mWewV0A0nqfU4l/jy6jT0CVnlhHtB1IgPPNX
        LBqUJy4RzWEdt23yEpc47zqC7EbIJzql6obIfhrYxbh//tZB
X-Google-Smtp-Source: APXvYqx48gLwtQiyhZp+77nFmi2740gYio3WSjUyXHMlIUPxjhLZKCefbtg91PSwBnj9bwNKOvqpoz+nnlSzaKnYBraAIrvCAmpd
MIME-Version: 1.0
X-Received: by 2002:a02:aa07:: with SMTP id r7mr5254387jam.24.1554181441527;
 Mon, 01 Apr 2019 22:04:01 -0700 (PDT)
Date:   Mon, 01 Apr 2019 22:04:01 -0700
In-Reply-To: <001a1143e62eb6a9510565640e76@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd253c058585101e@google.com>
Subject: Re: WARNING: ODEBUG bug in __do_softirq
From:   syzbot <syzbot+51c9bdfa559769d2f897@syzkaller.appspotmail.com>
To:     anna.schumaker@netapp.com, bfields@fieldses.org, bp@alien8.de,
        davem@davemloft.net, douly.fnst@cn.fujitsu.com, hpa@zytor.com,
        jlayton@kernel.org, konrad.wilk@oracle.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org, puwen@hygon.cn,
        rafael.j.wysocki@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, trond.myklebust@hammerspace.com,
        trond.myklebust@primarydata.com, vbabka@suse.cz, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 5b317cbf2bcb85a1e96ce87717cb991ecab1dd4d
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Fri Feb 22 09:17:11 2019 +0000

     Merge branch 'pm-cpufreq-fixes'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=171ead5d200000
start commit:   e60b5f79 Merge tag 'powerpc-5.0-6' of git://git.kernel.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=149ead5d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=109ead5d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
dashboard link: https://syzkaller.appspot.com/bug?extid=51c9bdfa559769d2f897
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16591514c00000

Reported-by: syzbot+51c9bdfa559769d2f897@syzkaller.appspotmail.com
Fixes: 5b317cbf2bcb ("Merge branch 'pm-cpufreq-fixes'")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
