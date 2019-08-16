Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1FAC3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 00:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB832089E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 00:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfHPAKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 20:10:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:38238 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfHPAKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 20:10:02 -0400
Received: by mail-io1-f71.google.com with SMTP id h4so1436931iol.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 17:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Z+/LdDMDpi7lCJAGstTSfTIJspkV8FAjlsJ+Y9XME1o=;
        b=RmiImedn2i6XYqWYwzgeOvruHxGf0Z5BNUUcO+RoDLwubXC+zdu/FnOopNZSwCUOYw
         0w+3A16g7L0gq16E+/AsnPKU5LwWhQTK3K/Y/OFc3zZkiy5yAMPg6VdKuy8AWgT8qx/t
         lg06AtPgOKplbAm6HE4UEFj72/xi0EIXCkSoWhuM9vns8hrvF8tzGstNW7hJxUgwSnlv
         MWcmXbnhdps5kt6UgSQM8f/6OE9A0J3mLtduH/K9tE9x/BuWcm2+PtvCPc5wDZpgOMP4
         7HP+YcbNPsBQn01xDQBhcH60E3WvRy/jpuPoPlViTYsPxVFupxPmCtlEWs7T+RAv+kto
         rd7Q==
X-Gm-Message-State: APjAAAUy3HJDappG4V5ItE9GkUhVOiJq8o412+miCRYRhb/BUd/2ecpR
        BOjoxX328DdwCZHvUfzSpQfXPLoepWNYY4N/BaaDLsQm3iiM
X-Google-Smtp-Source: APXvYqxLnHH6gUm2XRj2MsMlZpnv5+xeMGHnuOZMWTpWzPIrEbk6j67Nc+FVcbqQceXFkseKHbtoCfntpPYzq5cIpvyhqD0pFMOp
MIME-Version: 1.0
X-Received: by 2002:a6b:cd07:: with SMTP id d7mr7926143iog.150.1565914201066;
 Thu, 15 Aug 2019 17:10:01 -0700 (PDT)
Date:   Thu, 15 Aug 2019 17:10:01 -0700
In-Reply-To: <000000000000d3c7e0058f605a53@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4126c059030cfb6@google.com>
Subject: Re: INFO: rcu detected stall in __do_softirq
From:   syzbot <syzbot+6593c6b8c8b66a07cd98@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, bp@alien8.de,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, nstange@suse.de,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        srinivas.kandagatla@linaro.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkoul@kernel.org, x86@kernel.org,
        yakui.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 2aeac95d1a4cc85aae57ab842d5c3340df0f817f
Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date:   Tue Jun 11 10:40:41 2019 +0000

     soundwire: add module_sdw_driver helper macro

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114b45ee600000
start commit:   882e8691 Add linux-next specific files for 20190801
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=134b45ee600000
console output: https://syzkaller.appspot.com/x/log.txt?x=154b45ee600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=466b331af3f34e94
dashboard link: https://syzkaller.appspot.com/bug?extid=6593c6b8c8b66a07cd98
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b216b2600000

Reported-by: syzbot+6593c6b8c8b66a07cd98@syzkaller.appspotmail.com
Fixes: 2aeac95d1a4c ("soundwire: add module_sdw_driver helper macro")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
