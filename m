Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7478C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73627206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfCKN0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:26:10 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:37088 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfCKN0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:26:02 -0400
Received: by mail-it1-f199.google.com with SMTP id q141so5052529itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EGIr4lqcEZLUAsfOrgb/r4R/5KORODNRavbN/G81ud0=;
        b=U7jE0jC3wE2vjIs+aPiCNzw3kmsbn8sw50MJzhGwezNEMZthtaHK/0cM6ZST8FpW0b
         aGfaIcosLvPFSZLzron/SNRYwZMUCrCVxE5FbjOGBO9JRW1R8aEfcRNWOhqTyvspiTr/
         O2J22nNWg4/cOFejRRY5Cn/935/3s5jufbofy5R16PJ+xFLejYbZABrueAS/Oio7bepI
         TZOv9pmdyFF9/j7CAKNRVPyue4OvnCiRXHgrf+ZCkwyHf7qliasPAWUsMqpglGrv5cmb
         GIxIc6gwF9sYgOna9ECwpElexSq5T0OOdZQCMlROwjVMab2/e034Is8bKA24uiQjH/7+
         UA0w==
X-Gm-Message-State: APjAAAVK6XpASIb4jAIryAlFdN9IGOCN3D4pFFmTJvYUocIEup/TnUx6
        PdP9NSqgwRM5fuf6u93H9V9rijVSVfBHuT0AUlKXtBAqDmU+
X-Google-Smtp-Source: APXvYqyMLLnD257FKSm8f2pqEXgKrcruJ6lLf6qOLtxgF04q+irKSwldJ4vrXv5O2Djjaimry2xUTQyJnXLjJMXR34nmgnN7lLan
MIME-Version: 1.0
X-Received: by 2002:a24:4d8e:: with SMTP id l136mr20861032itb.5.1552310761421;
 Mon, 11 Mar 2019 06:26:01 -0700 (PDT)
Date:   Mon, 11 Mar 2019 06:26:01 -0700
In-Reply-To: <000000000000f7d1840582f4df63@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008407390583d18381@google.com>
Subject: Re: kernel panic: MAC Initialization failed. (3)
From:   syzbot <syzbot+2ee3f8974c2e7dc69feb@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, james.morris@microsoft.com,
        jmorris@namei.org, john.johansen@canonical.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 89a9684ea158dd7eef1728be9f0aed9a7d41cf19
Author: Kees Cook <keescook@chromium.org>
Date:   Tue Feb 12 18:23:18 2019 +0000

     LSM: Ignore "security=" when "lsm=" is specified

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11572723200000
start commit:   89a9684e LSM: Ignore "security=" when "lsm=" is specified
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13572723200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15572723200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0f38652d28b522f
dashboard link: https://syzkaller.appspot.com/bug?extid=2ee3f8974c2e7dc69feb
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c68242c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17190c8ac00000

Reported-by: syzbot+2ee3f8974c2e7dc69feb@syzkaller.appspotmail.com
Fixes: 89a9684e ("LSM: Ignore "security=" when "lsm=" is specified")
