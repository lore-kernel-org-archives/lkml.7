Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DE2C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6954121849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfGSL4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:56:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40102 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfGSL4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:56:01 -0400
Received: by mail-io1-f69.google.com with SMTP id v11so34359172iop.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 04:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dOaMMRNUwOpnO5Eysa44CTptPt5oL3VmnBhbF84fcE0=;
        b=s6yMIRmvANOTblTlHnktJ8EwZlqmZKMseRxnN1I+YOpju65apaMBMj0c8aFw1YvXo1
         ZtBl5xrNc3hQvt4ijQ7AeAoL/8/mUsHiqC1gvp60K7ffrpniRPA428DiLM7X3UdE6zp7
         J3wS8tIQZPT4qSh/oM7Ae8NWc3fh+tp9kaMYBkCcrItl2bUt1WxgfA2VOxnQrPUIKNmQ
         26o2C5OHU2D4Ydxl5GnJ4lpB1JcQo/95CcOz9uWJlvobU0x9BxHh/8Iai4Qe3hPsJrbG
         A2usCK0MWXk8axpQnWNTYI5dOruA+Ardh18B2uZyC3khgiokIV6dIpIO0wkMZRy0CZZC
         v6wQ==
X-Gm-Message-State: APjAAAUpKO8epI8j1NayBwIqV/kWpWBjjORM6mSRbWU+t5fkAxQVSCBy
        TCIIZYbzdWPPelMAy8/X1WaFe3ZC24+Pef9J8H+hYZJulZUD
X-Google-Smtp-Source: APXvYqzkybw6Wn+Li7jpXIwPEu6DrrvHCNxZ0RdTQuikJ9CC9uXJlEMhd5vO6oTUXbRLRUh+jGq2W7vI11/mWSSm4gb3GnXjFk6h
MIME-Version: 1.0
X-Received: by 2002:a5d:9643:: with SMTP id d3mr51164262ios.227.1563537360868;
 Fri, 19 Jul 2019 04:56:00 -0700 (PDT)
Date:   Fri, 19 Jul 2019 04:56:00 -0700
In-Reply-To: <000000000000d8b010058e03aaf8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcdf6c058e076819@google.com>
Subject: Re: BUG: unable to handle kernel paging request in corrupted (2)
From:   syzbot <syzbot+08b7a2c58acdfa12c82d@syzkaller.appspotmail.com>
To:     dave.stevenson@raspberrypi.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        unglinuxdriver@microchip.com, woojung.huh@microchip.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 9343ac87f2a4e09bf6e27b5f31e72e9e3a82abff
Author: Dave Stevenson <dave.stevenson@raspberrypi.org>
Date:   Mon Jun 25 14:07:15 2018 +0000

     net: lan78xx: Use s/w csum check on VLANs without tag stripping

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102feb84600000
start commit:   49d05fe2 ipv6: rt6_check should return NULL if 'from' is N..
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=122feb84600000
console output: https://syzkaller.appspot.com/x/log.txt?x=142feb84600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87305c3ca9c25c70
dashboard link: https://syzkaller.appspot.com/bug?extid=08b7a2c58acdfa12c82d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143a78f4600000

Reported-by: syzbot+08b7a2c58acdfa12c82d@syzkaller.appspotmail.com
Fixes: 9343ac87f2a4 ("net: lan78xx: Use s/w csum check on VLANs without tag  
stripping")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
