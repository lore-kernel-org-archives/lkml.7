Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1680C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C886B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfCTMzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:55:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:34902 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTMzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:55:01 -0400
Received: by mail-io1-f70.google.com with SMTP id k2so1955757ioj.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 05:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=smvzSB3T+mnGKo+uKlNF4p2seEbKwW6qQs9JTl0ogoM=;
        b=A5ugdrOYW+oRNSLWAc0rqoGLw6AIsBgpIpJTd/nRYIOO1K9fNG9WwKIOv+JIgQECnA
         DNVMi3kVuIHFk1HKU2Bir+RVGmbHjqzHx0fFX6mO7OeS06rgiB2AI+/nDijauTvvXDGe
         Iq7r2dWELnqRqbOILYR4jJJw+hzQGM9KNPqZ5iHXaMHqJHRH8cGDqPUwY4s8wX+SsB2c
         f2VC7SRyj/AecNhaop9X8ykm2GPhiFT+xBKqTznSko80+YkW3uEbJ4ph85AQcSZBlXzd
         5xXRn/uEDEkgEc3pwcDHDF6M5hFHK8Y0kXB6HUaHeuUeCMC6D5F96/yGTAtrk62wG8WG
         XLeg==
X-Gm-Message-State: APjAAAUmB+yCQWfm97HPUdtmCV0TBVkT1712S2XbP4VNGsUugim4Zhit
        eWl7b8xGCOWkg5uvjN7rKJ6nT10DmVf5iCl/dxyVUzAdA9ug
X-Google-Smtp-Source: APXvYqz27NpEzXwpWTZ9z6cmTUr5f2p2P6Yxv5IHTHyuEY3waZm3h+6TSsTRXXi8OSTIWSmTUmO5gZn0owurRIJS5Q9jak2l8Daf
MIME-Version: 1.0
X-Received: by 2002:a24:5c5:: with SMTP id 188mr4806509itl.3.1553086500812;
 Wed, 20 Mar 2019 05:55:00 -0700 (PDT)
Date:   Wed, 20 Mar 2019 05:55:00 -0700
In-Reply-To: <0000000000009ce9ee057b0be7f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fbe8d0584862154@google.com>
Subject: Re: WARNING in update_load_avg
From:   syzbot <syzbot+20fddccabc274e99398e@syzkaller.appspotmail.com>
To:     andy.shevchenko@gmail.com, bp@alien8.de, davem@davemloft.net,
        douly.fnst@cn.fujitsu.com, hpa@zytor.com, konrad.wilk@oracle.com,
        kuznet@ms2.inr.ac.ru, len.brown@intel.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, puwen@hygon.cn, rppt@linux.vnet.ibm.com,
        sbrivio@redhat.com, sd@queasysnail.net,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        ville.syrjala@linux.intel.com, x86@kernel.org,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
Author: Stefano Brivio <sbrivio@redhat.com>
Date:   Thu Nov 8 11:19:23 2018 +0000

     fou, fou6: ICMP error handlers for FoU and GUE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a48993200000
start commit:   b8a51b38 fou, fou6: ICMP error handlers for FoU and GUE
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16a48993200000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a48993200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=20fddccabc274e99398e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10272c5d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157bd093400000

Reported-by: syzbot+20fddccabc274e99398e@syzkaller.appspotmail.com
Fixes: b8a51b38 ("fou, fou6: ICMP error handlers for FoU and GUE")
