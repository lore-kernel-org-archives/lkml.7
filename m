Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7EEC76196
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD78A206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 10:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfGTKIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 06:08:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48927 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfGTKIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 06:08:01 -0400
Received: by mail-io1-f71.google.com with SMTP id z19so37495516ioi.15
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 03:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aIptGodPgqjQ+OCeW9XKeJdzrs6DHyh1FKeEsnaxVbM=;
        b=Auwlc+2P0DZGrG9j93l/jQ3jmDjhtvzb/cdAWfniq6+8CczLt2OBvI1SwWvQkk4wN1
         SjL2lliJBCmeuk0AV1zgrLZPagRMIsF290OgUDgJNJD/GJaW8ujH3txKeTgb/hEjbrc3
         iG9ekX2TDIpI36HjBw5Je1DbJUY41tj4TdbYmAyH+/5h5628JTZZTpBVSZWj+vN6TB1A
         mfEkgGRDshJFtzsSIt76hrB+5HVj0fe4Zkkhfv5p/9s3mU8Rbmw/vpJry7QIYvwpBbwO
         yIfP8HAt+jUOHNPUoC+QxycgrZYpqco/pcTbudy27sqHwCIXuAHDh7KCrfeCjMaqeXAP
         HtuQ==
X-Gm-Message-State: APjAAAXE5zUmypy+nhDAIVShjkqjhRV2IX+uADxnQtFszp4tGivBdKXC
        boJShjmxc4R8hKzEdqk40MP1ub0fZYXUtOs0ppmqnzaiKoG5
X-Google-Smtp-Source: APXvYqxejQK5TJXgPG7zDzFOcVKgb6JtNNiEgaZkAwUZNQxIY+uT88/YtfjAsG3qEv0NnxidVHOC8aWEo8R9Py88FYjmq9+IoaCH
MIME-Version: 1.0
X-Received: by 2002:a6b:f90f:: with SMTP id j15mr48006883iog.43.1563617280803;
 Sat, 20 Jul 2019 03:08:00 -0700 (PDT)
Date:   Sat, 20 Jul 2019 03:08:00 -0700
In-Reply-To: <0000000000008dd6bb058e006938@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000964b0d058e1a0483@google.com>
Subject: Re: WARNING in __mmdrop
From:   syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jasowang@redhat.com,
        jglisse@redhat.com, keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        mst@redhat.com, namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7f466032dc9e5a61217f22ea34b2df932786bbfc
Author: Jason Wang <jasowang@redhat.com>
Date:   Fri May 24 08:12:18 2019 +0000

     vhost: access vq metadata through kernel virtual address

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149a8a20600000
start commit:   6d21a41b Add linux-next specific files for 20190718
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=169a8a20600000
console output: https://syzkaller.appspot.com/x/log.txt?x=129a8a20600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
dashboard link: https://syzkaller.appspot.com/bug?extid=e58112d71f77113ddb7b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10139e68600000

Reported-by: syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com
Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual  
address")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
