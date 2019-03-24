Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436C3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BFC2147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfCXSvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:51:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:45939 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCXSvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:51:02 -0400
Received: by mail-io1-f72.google.com with SMTP id r21so6173929iod.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 11:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TaangaKNWHHNGJoroNhagOABp65E/ZLZreVI8iJPwSY=;
        b=JRaTPU5NObNT/N2rII4DWHvkaYz+/EeNwj5JVDfE9Co9gIsEhMZRT4ElNOckaOaMWS
         Mhw60Ct+juvCnQc7AI0MsDs431BiKq9o4xTBkLc4bIr4jwpPtpynT+nY4BjypUI7hrR2
         M3O0fph6eOi4gVwFTAjkhMbSRFnfH2Vxca/vPUwGhdXMwv2Fs9hAE7GTCMisMVzLbAqE
         s3w8Bo8ndHyCgns8HMnzBoIlkMFnyk9JP/NOAtIY/0MhF0RVdeQRIyKxazsEl4scl481
         WZSSne7ukJHiZmle00DxJKowjtI4/lFqcgA7zcdE4MbJly7HzjT6lSwsGOVQf+4cHuag
         QW2w==
X-Gm-Message-State: APjAAAWvW3yzBlF9GcNHOn337kwWKuQBh9pvZ67a/qx9rRd6+LTjKMvm
        jBMa85Mvl0arBwdDR6BSjFbCzubRTNKMQcMGd4PECElLzj6a
X-Google-Smtp-Source: APXvYqzc9e/z98OxuXRxxQ50Lz2rJE46NLiCvVxUfI9UU2qdGoDiv0mpmd4hG8DBq3QJHc8JyrfvzfUlI2scySlli5ilYbQx95Sw
MIME-Version: 1.0
X-Received: by 2002:a6b:d913:: with SMTP id r19mr6437307ioc.76.1553453461289;
 Sun, 24 Mar 2019 11:51:01 -0700 (PDT)
Date:   Sun, 24 Mar 2019 11:51:01 -0700
In-Reply-To: <0000000000000e2b4e057c80822f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc42080584db9121@google.com>
Subject: Re: general protection fault in freeary
From:   syzbot <syzbot+9d8b6fa6ee7636f350c1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arnd@arndb.de, dave@stgolabs.net,
        dvyukov@google.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@dominikbrodowski.net,
        manfred@colorfullife.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 86f690e8bfd124c38940e7ad58875ef383003348
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu Mar 29 12:15:13 2018 +0000

     Merge tag 'stm-intel_th-for-greg-20180329' of  
git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm into char-misc-next

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d653a3200000
start commit:   74c4a24d Add linux-next specific files for 20181207
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=143653a3200000
console output: https://syzkaller.appspot.com/x/log.txt?x=103653a3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e9413388bf37bed
dashboard link: https://syzkaller.appspot.com/bug?extid=9d8b6fa6ee7636f350c1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e19da3400000

Reported-by: syzbot+9d8b6fa6ee7636f350c1@syzkaller.appspotmail.com
Fixes: 86f690e8bfd1 ("Merge tag 'stm-intel_th-for-greg-20180329' of  
git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm into char-misc-next")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
