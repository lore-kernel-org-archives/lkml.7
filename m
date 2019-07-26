Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49B7C41514
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FF022BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfGZX0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:26:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46823 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfGZX0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:26:01 -0400
Received: by mail-io1-f70.google.com with SMTP id s83so60364289iod.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 16:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jU9fP+7H8MVZejaHdG74+bs1E1cZqrGALTWcbghPSM4=;
        b=KuCvdjMF7VmLhs0tN8Ok4PTiN/G5Z3WFi/nGNRljSROIXvV9xMD+pWjBpx6L2D+4Zj
         NluVKwNmPCvpRz67fx8LfuUkjCiTwov4GOigW/uLzqmDp2zGqZvfF0S2VLOXKomD6Qbc
         +P7n+J9Cdn8BBI5B+JDiLRSWOPV+2OjntucE87BQLeLDEPlQNV365cA09qF9LJoqnNEK
         elBeTYqIbj2snsFgaeAXw17Wkfh5FOHjBMmZxy/I415TqgNyxugxMYq8jQWVYM/aOUZj
         TT+dLA37ZnAexNDi7W9yhumEfjLakdDSA9adH5UkY2i1K0/PB8zlxJLE7oz4emg2GXQD
         R6vw==
X-Gm-Message-State: APjAAAXQpNoiPKheyaOI5diG28n/+eEjb8mq63Quw6ZJwr6NQcNofKZV
        MGUxytAM/ESvjmLOd1evi4TnX+O02rN2ZKFa62C0G2ASabUg
X-Google-Smtp-Source: APXvYqxovLmXIv75laVrMtZvlr79yeQWRntZAt1hwL6RBmKRhi84q3dBc8vJmpG72hkv1CJ8iH3NYbDZi9CnPAFhes4c6TPcq2Lv
MIME-Version: 1.0
X-Received: by 2002:a5e:d611:: with SMTP id w17mr24902658iom.63.1564183560976;
 Fri, 26 Jul 2019 16:26:00 -0700 (PDT)
Date:   Fri, 26 Jul 2019 16:26:00 -0700
In-Reply-To: <000000000000edcb3c058e6143d5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083ffc4058e9dddf0@google.com>
Subject: Re: memory leak in kobject_set_name_vargs (2)
From:   syzbot <syzbot+ad8ca40ecd77896d51e2@syzkaller.appspotmail.com>
To:     catalin.marinas@arm.com, davem@davemloft.net, dvyukov@google.com,
        herbert@gondor.apana.org.au, kuznet@ms2.inr.ac.ru,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luciano.coelho@intel.com,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 0e034f5c4bc408c943f9c4a06244415d75d7108c
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed May 18 18:51:25 2016 +0000

     iwlwifi: fix mis-merge that breaks the driver

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f955f0600000
start commit:   3bfe1fc4 Merge tag 'for-5.3/dm-changes-2' of git://git.ker..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12f955f0600000
console output: https://syzkaller.appspot.com/x/log.txt?x=14f955f0600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcfc65ee492509c6
dashboard link: https://syzkaller.appspot.com/bug?extid=ad8ca40ecd77896d51e2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135cbed0600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14dd4e34600000

Reported-by: syzbot+ad8ca40ecd77896d51e2@syzkaller.appspotmail.com
Fixes: 0e034f5c4bc4 ("iwlwifi: fix mis-merge that breaks the driver")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
