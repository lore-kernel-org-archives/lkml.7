Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9D5C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79310206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKUPAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:00:02 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:56248 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfKUPAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:00:01 -0500
Received: by mail-io1-f69.google.com with SMTP id c67so2396745iof.22
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 07:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ss8b6/361E3xQgXhoZEYKHN2dErL3lbrsVOt2HQ4G28=;
        b=JtVZ63rVXtbyQwmtBkiGZQ/+WBdktiLdfbrb08SwfmnmOsGXwMbc+7uT4MLVL2zMeu
         iDRy6B7N/ReQ2H5F0JPuWvMwZzI9ZXkWKMNPCvGpfj3Q0jF/GViBySIR10BMV+37igTI
         kk3Z7SaI/EHz4zh/7AizCgbMh0RWcxfrIvV7iYjKPk7viQG3F0pt6BIQ4CAjK5UOf6Yh
         rtagIm8cbj9EaHjXroyUrK36kA4zQcdk++cxia6Y4Au+/cRCq2TDJgTo6o37PLjWH8nK
         /p9+SD0JEaQgtPBxSQ797sjMOlL5yZhNumXQ5hGs/koZg5lI5Rv+nwjQyrzDuvnPT/RC
         hOzQ==
X-Gm-Message-State: APjAAAW76vecsiAFSX22MPXo+vDstkaZRbz1Sf+dFTMcdtJgHRinFItC
        7vSpqNRvdrSNGUJ4DQU3stJWTO0XTwp6hIuz0AjuG8gz0DlB
X-Google-Smtp-Source: APXvYqyCE3fIAS/eC3JiBF7ln0rcJKb0Mpnhw+NSQWlfaE9hNZqCT8kSX8wwCB901bHXK9fjJCwPCRFDQaQ+fjGMJaNsn83Bb8+C
MIME-Version: 1.0
X-Received: by 2002:a02:282:: with SMTP id 124mr9334489jau.6.1574348400631;
 Thu, 21 Nov 2019 07:00:00 -0800 (PST)
Date:   Thu, 21 Nov 2019 07:00:00 -0800
In-Reply-To: <000000000000de3c7705746dcbb7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c243a0597dc8d9d@google.com>
Subject: Re: KASAN: use-after-free Read in ccid_hc_tx_delete
From:   syzbot <syzbot+3967c1caf256f4d5aefe@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, dan.carpenter@oracle.com,
        davem@davemloft.net, dccp@vger.kernel.org, gerrit@erg.abdn.ac.uk,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit f04684b4d85d6371126f476d3268ebf6a0bd57cf
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Thu Jun 21 08:07:21 2018 +0000

     ALSA: lx6464es: Missing error code in snd_lx6464es_create()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10dd11cae00000
start commit:   eb6cf9f8 Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12dd11cae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14dd11cae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=3967c1caf256f4d5aefe
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11022ccd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124581db400000

Reported-by: syzbot+3967c1caf256f4d5aefe@syzkaller.appspotmail.com
Fixes: f04684b4d85d ("ALSA: lx6464es: Missing error code in  
snd_lx6464es_create()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
