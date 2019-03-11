Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A44EC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E802084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T4n27hZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfCKQUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:20:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38210 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:20:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id n125so4054063pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=GUbJ6a4YWCnXI1lu5AXSGN1EPdoNE69oEyeV4fxW80E=;
        b=T4n27hZI8Gc7IBx5Mm0mxyj3Sfx3Iy+C87ezvMsTiFPDR2Qkse2Kx5SIXcMWMi59T4
         sIy78OTumY11BaAlMFX4PS9XPc61vFBKKK7UOEaeSzRvNrH9Mjyolg9KSLtsAd3T/3df
         pi3WqQw1BvM+2Up7DIJQwQA7mJyGL6uulRAA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GUbJ6a4YWCnXI1lu5AXSGN1EPdoNE69oEyeV4fxW80E=;
        b=i+TEU8vjXD7hnsnIW02wBroLB6EZ2F+93axw7aPIhV756o7mUl7MDP05Yj0fLWHCc+
         VXGp00XkRSXXUKg8YZ+fxqpjiOZzdpN/DwBoV5ARBpVKQuqJX6Vponwvlaq9ZWGg4P9R
         VWqY2H2s9aKkALp7RLNQw27T2LK+AKYPpOlqsdRoKEJrwRTSygD5ijrYOqFwGGVx3Xsj
         T9QualwujWlRVXoo7w+rgEoqAUOA3M1OsD6n6kDPMg97cZFErYONg15zFUrUTBz60C/1
         65lF2UjLbbN/GIeySmBOZipr3GqtJCweDcVnNA9M25L7WkGEeGElFb87dVmrLs0/jwZg
         icZg==
X-Gm-Message-State: APjAAAWwD8XK/GHde2MehBabL0FA5KjCbVzvpcScZxXM8aY/7JRG7aBu
        C9YmUSFAdTngouHB/fdq5V+xGQ==
X-Google-Smtp-Source: APXvYqy44AsYYWqyxSJ038OsOcxaJ/+q/wJad4B4APzO6+Hifrv1Hhoa4iIOcoubmuWXf0RqjkvQ+Q==
X-Received: by 2002:a17:902:4c08:: with SMTP id a8mr35036621ple.294.1552321239946;
        Mon, 11 Mar 2019 09:20:39 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b15sm13519306pfj.167.2019.03.11.09.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 09:20:38 -0700 (PDT)
Subject: Re: general protection fault in skb_put
To:     syzbot <syzbot+65788f9af9d54844389e@syzkaller.appspotmail.com>,
        axboe@fb.com, hch@lst.de, johan.hedberg@gmail.com,
        jsmart2021@gmail.com, keith.busch@intel.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, marcel@holtmann.org,
        sagi@grimberg.me, syzkaller-bugs@googlegroups.com
References: <000000000000032b7f0583d16e0e@google.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <b17bcabf-5f2c-083a-91a9-6d99f5111a3f@broadcom.com>
Date:   Mon, 11 Mar 2019 09:20:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <000000000000032b7f0583d16e0e@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/2019 6:20 AM, syzbot wrote:
> syzbot has bisected this bug to:
>
> commit 97faec531460c949d7120672b8c77e2f41f8d6d7
> Author: James Smart <jsmart2021@gmail.com>
> Date:   Thu Sep 13 23:17:38 2018 +0000
>
>     nvme_fc: add 'nvme_discovery' sysfs attribute to fc transport device
>
> bisection log: 
> https://syzkaller.appspot.com/x/bisect.txt?x=121f55db200000
> start commit:   97faec53 nvme_fc: add 'nvme_discovery' sysfs attribute 
> to ..
> git tree:       linux-next
> final crash: https://syzkaller.appspot.com/x/report.txt?x=111f55db200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=161f55db200000
> kernel config: https://syzkaller.appspot.com/x/.config?x=59aefae07c771af6
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=65788f9af9d54844389e
> userspace arch: amd64
> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=178e0798c00000
> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=11b4f0b0c00000
>
> Reported-by: syzbot+65788f9af9d54844389e@syzkaller.appspotmail.com
> Fixes: 97faec53 ("nvme_fc: add 'nvme_discovery' sysfs attribute to fc 
> transport device")

can someone contact me as to what this thing is doing and how to 
interpret all the logs.  nvme_fc isn't remotely in any of the logs and 
doesn't use skb's unless the underlying udev_uevents are using them.

-- james
