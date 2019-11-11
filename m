Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FBC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED99214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKKXpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:45:02 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:35020 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKKXpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:45:02 -0500
Received: by mail-io1-f70.google.com with SMTP id h7so7225663ioh.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 15:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=upaZmQpBla0D2GJufrH+1eVVJ7+lAzflwX+ckLKLrsg=;
        b=l7Q4JZKw5HiWCsc+aHYswTcHeyXcob7/qOueaAoath/w5FqowG+h2VRaRC35DuAWp2
         c9r7PZ+gyF/vyoF5hgE+phmIVWv/H8zxpeBuKG93daBJBRzr+lRCkE61HlD5v+UwO6BY
         P9DOqi79HbX/3snxbhXL9lTzuEOZIhvViVMSg4ag/xDGtgrtcxh3u9Jd8JlYCXqWve48
         G8has+BE16ezqjkJ/vln1myV1TCOG+ZoXN3+32azpaPYFpuY7acuDwm1wRUta/yCSjED
         e/9k5v/YC2Aq+hqBGRzpT3WVhZrzofwpPnV9KsWYtDbltnYaEuaR8+NtCCXxY2z5dqY+
         D0QQ==
X-Gm-Message-State: APjAAAUOtlSWufVdaW3AXvgJU5DrYwJwXtRFz+RVjprqbt6BQx9QVELv
        idi1Bzd78eGqW/aSCkR7FsFeCDQObUMyGA26ByYomVPru2l7
X-Google-Smtp-Source: APXvYqxq9lv/VmQ8ezGOcmCF95BVBz118ALVK0je34s/k1S1HcLJ9P5+EYXmjYbL1lVyXHvAoXlRLBYt7xYeZz2aTy9+bxdsRhud
MIME-Version: 1.0
X-Received: by 2002:a6b:660b:: with SMTP id a11mr15664068ioc.283.1573515901287;
 Mon, 11 Nov 2019 15:45:01 -0800 (PST)
Date:   Mon, 11 Nov 2019 15:45:01 -0800
In-Reply-To: <0000000000007f69a2059714b34d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058443705971ab84d@google.com>
Subject: Re: KASAN: use-after-free Read in snd_timer_open
From:   syzbot <syzbot+4476917c053f60112c99@syzkaller.appspotmail.com>
To:     alexandre.belloni@bootlin.com, allison@lohutok.net,
        alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        bhelgaas@google.com, enric.balletbo@collabora.com,
        gregkh@linuxfoundation.org, kirr@nexedi.com,
        linux-kernel@vger.kernel.org, lkundrak@v3.sk, logang@deltatee.com,
        perex@perex.cz, rfontana@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 6a34367e52caea1413eb0a0dcbb524f0c9b67e82
Author: Takashi Iwai <tiwai@suse.de>
Date:   Thu Nov 7 19:20:08 2019 +0000

     ALSA: timer: Fix possible race at assigning a timer instance

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b5dde6e00000
start commit:   6980b7f6 Add linux-next specific files for 20191111
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15b5dde6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11b5dde6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2af7db1972ec750e
dashboard link: https://syzkaller.appspot.com/bug?extid=4476917c053f60112c99
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108fbfece00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1055d5aae00000

Reported-by: syzbot+4476917c053f60112c99@syzkaller.appspotmail.com
Fixes: 6a34367e52ca ("ALSA: timer: Fix possible race at assigning a timer  
instance")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
