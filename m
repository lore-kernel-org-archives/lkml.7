Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23BBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7184E217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfCPOtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:49:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:48441 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfCPOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:49:02 -0400
Received: by mail-io1-f72.google.com with SMTP id w19so9492609ioa.15
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/FFaWZSA2YfhUyEx8nHr3wlA+vNq8J4vZ6bnwl4n+5Q=;
        b=LNnYH3kN0oGZNfbS0vuXQb95Vf5dKLVhKV+5tJSUfp9UNoNNy1H1/Jv+D8/XwJiWlG
         24QqpmGPjPH9nl/GrdDJ5D4/VzkXAQpn/Zx0J3uq5TiQXNz5K9tuZrp114m3EwZhgdRA
         RFtU6wBGrEaJNsjQwRAuMvq8No91+JuvYObNwXSeW2kGY6WushV7AeGRwhuVlXhTlwiX
         ynBIXXOXKQLNtwbzALQ4wu3m/AsTsUxhJ9/+Se7Af+cxOobFFEDQK7/VZdW9R1gU2SWi
         /hLxHqA8IRxa5SKJ5AxziNcRhmUvLP3I+rIJLLD9gZ/YPHHaHDMMkMQ9wLaA6lgsBGRB
         oC/w==
X-Gm-Message-State: APjAAAXVD0e8xv5jiHsG+5dkej1Jff+5IH0kZPnSnqIdJnYz+CGTP/lR
        u0Q7KmtvGmVE3s7Jta0U/kvNrug4je0uTAzBH3axmNYgYdgi
X-Google-Smtp-Source: APXvYqzZSxxCbczTFfnFWh/AGNXppAXdTZUNLfOmpwHI/Q1FLc2y6tADXfO/CbpMJtelbR0Zwlju2MeUiXQOgFQ0DFJJ7YUvTrhD
MIME-Version: 1.0
X-Received: by 2002:a5d:9b95:: with SMTP id r21mr5870876iom.38.1552747741521;
 Sat, 16 Mar 2019 07:49:01 -0700 (PDT)
Date:   Sat, 16 Mar 2019 07:49:01 -0700
In-Reply-To: <00000000000016f7d40583d79bd9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f302105843741ad@google.com>
Subject: Re: WARNING: bad usercopy in fanotify_read
From:   syzbot <syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, amir73il@gmail.com, cai@lca.pw,
        crecklin@redhat.com, jack@suse.cz, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit a8b13aa20afb69161b5123b4f1acc7ea0a03d360
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Thu Jan 10 17:04:36 2019 +0000

     fanotify: enable FAN_REPORT_FID init flag

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11e78d6f200000
start commit:   a8b13aa2 fanotify: enable FAN_REPORT_FID init flag
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13e78d6f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15e78d6f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9d91b7192a5e96e
dashboard link: https://syzkaller.appspot.com/bug?extid=2c49971e251e36216d1f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1287516f200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ee410b200000

Reported-by: syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com
Fixes: a8b13aa2 ("fanotify: enable FAN_REPORT_FID init flag")
