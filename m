Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF654C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A409A20828
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQdaE3SS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfCKSKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:10:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44901 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfCKSK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:10:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id a3so4256296pff.11;
        Mon, 11 Mar 2019 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3J6aRGS8TRn4JCgRnhJL5XlZcsFJ1KpSHVbtqp+zT7Q=;
        b=gQdaE3SS9MslyaO3z5jcJrtVBT6Vjvgw+IWQDpx68QqPJP2HaJPNjj2s2Wb2LVdsIF
         NFQN9DkVocIvEiSIuNlzZiKzm/FmLyJjkV1W8wi2GleWhyTCyKKkWY8ewUUUmCW5eHce
         lfnSLbDGz4w3r0cD3+YdhaP5gKZ1TxW6XbuLvGl2Iyz4y56lYYSkMWjF9xfyGogV2h4t
         fWACQ5Ttg335usF+N0HgOPGeZ4iBxkjm+sNSE/HNkF71r/F/kX8FrvDePP0/fLernG1c
         kvmwNxvZcMBNz5V3v+e86VQ+gZ/qKXxvnzsIrk1S42BNFsAqx+MOaPcQYp72yDWtnuXw
         yQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3J6aRGS8TRn4JCgRnhJL5XlZcsFJ1KpSHVbtqp+zT7Q=;
        b=qeZp5zUawqdG785BqvAbVkWnks94fH0pQ/I2Jtp+bubFoksX+/m4HHTPBRm2E/zAiR
         twik41qZATyWY4Q09hgdEdKgJFdAI5BKEmuIdlSWujpDWMFKLKag+n1BEi0ZvDQF9A5D
         VD7XwRjopkyWKoxAVVIyFg5XmWeRiLevyHoZbdrpwDU1Pp5I9bMbWQUkF+qjgulR7jlN
         Nv3r/bqOlcJ53Gw39Tvlpg+3lAv+Y9gm4Qme0sNzsuhq2ESEpJTsIk3IY1ZHOIjniViG
         IKqTznQJOYSyCUcDLdqyqNSde+bomk/oMV9P2SjG+hgslHhT5OHBBUIGQoeFIct599NW
         an4A==
X-Gm-Message-State: APjAAAW6iOF9wDeYV14IuaZ3RxNxqKYAwLe7MEMbwfQ6ZbFRNRiP/Qbn
        d2I3NrBYtJ1KpDOsXr4t4qY=
X-Google-Smtp-Source: APXvYqydHZSKHBnGliDGzibIRVTsvuddg8OJFURFfqbb933ISPAJXkqWvG6RfeVAzNHFLLKhDZiEBg==
X-Received: by 2002:a17:902:76c7:: with SMTP id j7mr34481486plt.121.1552327829007;
        Mon, 11 Mar 2019 11:10:29 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id l64sm11518070pfj.179.2019.03.11.11.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 11:10:28 -0700 (PDT)
Subject: Re: general protection fault in skb_put
To:     Dmitry Vyukov <dvyukov@google.com>,
        James Smart <james.smart@broadcom.com>
Cc:     syzbot <syzbot+65788f9af9d54844389e@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Johan Hedberg <johan.hedberg@gmail.com>, keith.busch@intel.com,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000032b7f0583d16e0e@google.com>
 <b17bcabf-5f2c-083a-91a9-6d99f5111a3f@broadcom.com>
 <CACT4Y+aT_oeWK5UWy9N76noDEfPTC8q2d8vd+KugE2UXgxpJcQ@mail.gmail.com>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <a68b264c-d573-87ef-13fb-883c6b0a710c@gmail.com>
Date:   Mon, 11 Mar 2019 11:10:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aT_oeWK5UWy9N76noDEfPTC8q2d8vd+KugE2UXgxpJcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/2019 9:40 AM, Dmitry Vyukov wrote:
> On Mon, Mar 11, 2019 at 5:20 PM 'James Smart' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
>>
>> On 3/11/2019 6:20 AM, syzbot wrote:
>>> syzbot has bisected this bug to:
>>>
>>> commit 97faec531460c949d7120672b8c77e2f41f8d6d7
>>> Author: James Smart <jsmart2021@gmail.com>
>>> Date:   Thu Sep 13 23:17:38 2018 +0000
>>>
>>>      nvme_fc: add 'nvme_discovery' sysfs attribute to fc transport device
>>>
>>> bisection log:
>>> https://syzkaller.appspot.com/x/bisect.txt?x=121f55db200000
>>> start commit:   97faec53 nvme_fc: add 'nvme_discovery' sysfs attribute
>>> to ..
>>> git tree:       linux-next
>>> final crash: https://syzkaller.appspot.com/x/report.txt?x=111f55db200000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=161f55db200000
>>> kernel config: https://syzkaller.appspot.com/x/.config?x=59aefae07c771af6
>>> dashboard link:
>>> https://syzkaller.appspot.com/bug?extid=65788f9af9d54844389e
>>> userspace arch: amd64
>>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=178e0798c00000
>>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=11b4f0b0c00000
>>>
>>> Reported-by: syzbot+65788f9af9d54844389e@syzkaller.appspotmail.com
>>> Fixes: 97faec53 ("nvme_fc: add 'nvme_discovery' sysfs attribute to fc
>>> transport device")
>>
>> can someone contact me as to what this thing is doing and how to
>> interpret all the logs.  nvme_fc isn't remotely in any of the logs and
>> doesn't use skb's unless the underlying udev_uevents are using them.
> 
> Hi James,
> 
> What exactly is unclear/needs interpretation? syzbot did what is
> commonly known as kernel/git bisection process. This is a new feature
> so there can be some rough edges. Hopefully we can improve the
> representation together.
> 
> Thanks
> 
Everything is unclear. You're telling me that an error occurred and that 
you reduced it to the git submit where the error starts appearing.

Usually there would be something in the base crash, which I'm looking at 
in https://syzkaller.appspot.com/x/report.txt?x=111f55db200000 which 
would point back at something in the patch or related to it. There are 
no relationships.  I can't quite figure out what the base test actually 
did that generated the failure to see if there's any possible relationship.

Everything in the base crash stacktrace points to an issue in the 
bluetooth uart driver doing all the logging - not the patch called out. 
So this looks like a failure of your infrastructure.

-- james

