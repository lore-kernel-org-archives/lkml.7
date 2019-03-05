Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A29C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E21820663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qt7PIo7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfCEWwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:52:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34781 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbfCEWwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:52:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so6685687pgd.1;
        Tue, 05 Mar 2019 14:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3ZFhDdkXvEBDA501mHcdgdRllGMUc6/ZIZ6B0dhu9Zk=;
        b=qt7PIo7Pada4mn+Vto1uBL9w7rq5ELGTavDYUbMkLTFbBiDrdkOkr/xbaO4cxQgK6u
         AU0Awsk2xsEIO3AQAkh4XW5UhraTmUHbQQSNAJ/L9wtIc9PLmY36KngAnpgblkBX9y8s
         X3a752pOm2Ed2k1S9c6vGtzI109ZXLh+SZRKU0s46A5f9cVJTOCXLl86IiSZJtbEN6S0
         k+rhQTT+IHNtxMCJY+g+5CP29L6+U+ilj8sDiAv4fNS6QS5UFwyS13Ema36frOSJWZpj
         JZovKjZVzDPnYi+HmIiq1fgu+PCl0XSQh/mvFWlNlx5cJZdIQHz6AiCEY5HWo3VOybYd
         Zbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3ZFhDdkXvEBDA501mHcdgdRllGMUc6/ZIZ6B0dhu9Zk=;
        b=rLEBMJS5WKbcv7kRkWqv8UdbxIAU0tH7xJuK0cTcptZXpZpFeyCrrad51ncVwzWca8
         UWW984IC0fzewKrmlsJqCDo6KnfQzMs3CfqAA1Xa2XSAhOqqo9nM4u4QwH07HZtrc9Ou
         8DKOEEWyiuq/ItsXH8AghiEYW1kdUogZzyO8kRNVcx3ZWi/GK8kAw7grWmVgI6EY+sKz
         m6EvJLZejb9bMfqlHUfLJCMG3FuiNDJy735tqqy1fUi1hAuLnEi69HvQXeCDAnfNMp71
         ThOELWcoovsuKhILYcDzt1tf348XvzcsdVGxAdyXXui+T/+7wyx92BP4dXflJFnVTJyf
         rYJg==
X-Gm-Message-State: APjAAAXJizynrz3o4iUrZqnkoBKtPXk+ChdO8AuM25BrhgEZ2csrvigf
        7lvBETZu8see59NeI33NZ74=
X-Google-Smtp-Source: APXvYqz+AsuY1RY+l6d2prl3sPCflCv0v39HFHps5Mp0nDua0y4fjPOC6Oj3J0Jr7ACfOCCIrFwvTg==
X-Received: by 2002:a63:6b47:: with SMTP id g68mr3397089pgc.220.1551826351884;
        Tue, 05 Mar 2019 14:52:31 -0800 (PST)
Received: from [192.168.0.16] (97-115-123-245.ptld.qwest.net. [97.115.123.245])
        by smtp.gmail.com with ESMTPSA id h184sm66207pfc.78.2019.03.05.14.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 14:52:31 -0800 (PST)
Subject: Re: [ovs-dev] openvswitch crash on i386
To:     Joe Stringer <joe@ovn.org>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc:     "<dev@openvswitch.org>" <dev@openvswitch.org>,
        James Page <james.page@canonical.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        David Miller <davem@davemloft.net>
References: <20190305104010.6342e9b9@gollum>
 <CAATJJ0KgvC-j2egtq6G5M0jK5O04-xATEu_yDLvr53tJdFEzrQ@mail.gmail.com>
 <CAOftzPjJnBdHWgArGRhkSnQrqmUKvhxkO_eLth61-HEfZiAHUw@mail.gmail.com>
From:   Gregory Rose <gvrose8192@gmail.com>
Message-ID: <06cf4f57-e7ca-5ead-ed37-fb88255df78b@gmail.com>
Date:   Tue, 5 Mar 2019 14:52:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <CAOftzPjJnBdHWgArGRhkSnQrqmUKvhxkO_eLth61-HEfZiAHUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/5/2019 11:58 AM, Joe Stringer wrote:
> On Tue, Mar 5, 2019 at 2:12 AM Christian Ehrhardt
> <christian.ehrhardt@canonical.com> wrote:
>> On Tue, Mar 5, 2019 at 10:58 AM Juerg Haefliger
>> <juerg.haefliger@canonical.com> wrote:
>>> Hi,
>>>
>>> Running the following commands in a loop will crash an i386 5.0 kernel
>>> typically within a few iterations:
>>>
>>> ovs-vsctl add-br test
>>> ovs-vsctl del-br test

I have an i386 Ubuntu 18 VM to test this on.  I'll investigate and see 
what I can find.

- Greg

>>>
>>> [  106.215748] BUG: unable to handle kernel paging request at e8a35f3b
>>> [  106.216733] #PF error: [normal kernel read fault]
>>> [  106.217464] *pdpt = 0000000019a76001 *pde = 0000000000000000
>>> [  106.218346] Oops: 0000 [#1] SMP PTI
>>> [  106.218911] CPU: 0 PID: 2050 Comm: systemd-udevd Tainted: G            E     5.0.0 #25
>>> [  106.220103] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1ubuntu1 04/01/2014
>>> [  106.221447] EIP: kmem_cache_alloc_trace+0x7a/0x1b0
>>> [  106.222178] Code: 01 00 00 8b 07 64 8b 50 04 64 03 05 28 61 e8 d2 8b 08 89 4d ec 85 c9 0f 84 03 01 00 00 8b 45 ec 8b 5f 14 8d 4a 01 8b 37 01 c3 <33> 1b 33 9f b4 00 00 00 64 0f c7 0e 75 cb 8b 75 ec 8b 47 14 0f 18
>>> [  106.224752] EAX: e8a35f3b EBX: e8a35f3b ECX: 0000869f EDX: 0000869e
>>> [  106.225683] ESI: d2e96ef0 EDI: da401a00 EBP: d9b85dd0 ESP: d9b85db0
>>> [  106.226662] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010282
>>> [  106.227710] CR0: 80050033 CR2: e8a35f3b CR3: 185b8000 CR4: 000006f0
>>> [  106.228703] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
>>> [  106.229604] DR6: fffe0ff0 DR7: 00000400
>>> [  106.230114] Call Trace:
>>> [  106.230525]  ? kernfs_fop_open+0xb4/0x390
>>> [  106.231176]  kernfs_fop_open+0xb4/0x390
>>> [  106.231856]  ? security_file_open+0x7c/0xc0
>>> [  106.232562]  do_dentry_open+0x131/0x370
>>> [  106.233229]  ? kernfs_fop_write+0x180/0x180
>>> [  106.233905]  vfs_open+0x25/0x30
>>> [  106.234432]  path_openat+0x2fd/0x1450
>>> [  106.235084]  ? cp_new_stat64+0x115/0x140
>>> [  106.235754]  ? cp_new_stat64+0x115/0x140
>>> [  106.236427]  do_filp_open+0x6a/0xd0
>>> [  106.237026]  ? cp_new_stat64+0x115/0x140
>>> [  106.237748]  ? strncpy_from_user+0x3d/0x180
>>> [  106.238539]  ? __alloc_fd+0x36/0x120
>>> [  106.239256]  do_sys_open+0x175/0x210
>>> [  106.239955]  sys_openat+0x1b/0x20
>>> [  106.240596]  do_fast_syscall_32+0x7f/0x1e0
>>> [  106.241313]  entry_SYSENTER_32+0x6b/0xbe
>>> [  106.242017] EIP: 0xb7fae871
>>> [  106.242559] Code: 8b 98 58 cd ff ff 89 c8 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
>>> [  106.245551] EAX: ffffffda EBX: ffffff9c ECX: bffdcb60 EDX: 00088000
>>> [  106.246651] ESI: 00000000 EDI: b7f9e000 EBP: 00088000 ESP: bffdc970
>>> [  106.247706] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
>>> [  106.248851] Modules linked in: openvswitch(E)
>>> [  106.249621] CR2: 00000000e8a35f3b
>>> [  106.250218] ---[ end trace 6a8d05679a59cda7 ]---
>>>
>>> I've bisected this down to the following commit that seems to have introduced
>>> the issue:
>>>
>>> commit 120645513f55a4ac5543120d9e79925d30a0156f (refs/bisect/bad)
>>> Author: Jarno Rajahalme <jarno@ovn.org>
>>> Date:   Fri Apr 21 16:48:06 2017 -0700
>>>
>>>      openvswitch: Add eventmask support to CT action.
>>>
>>>      Add a new optional conntrack action attribute OVS_CT_ATTR_EVENTMASK,
>>>      which can be used in conjunction with the commit flag
>>>      (OVS_CT_ATTR_COMMIT) to set the mask of bits specifying which
>>>      conntrack events (IPCT_*) should be delivered via the Netfilter
>>>      netlink multicast groups.  Default behavior depends on the system
>>>      configuration, but typically a lot of events are delivered.  This can be
>>>      very chatty for the NFNLGRP_CONNTRACK_UPDATE group, even if only some
>>>      types of events are of interest.
>>>
>>>      Netfilter core init_conntrack() adds the event cache extension, so we
>>>      only need to set the ctmask value.  However, if the system is
>>>      configured without support for events, the setting will be skipped due
>>>      to extension not being found.
>>>
>>>      Signed-off-by: Jarno Rajahalme <jarno@ovn.org>
>>>      Reviewed-by: Greg Rose <gvrose8192@gmail.com>
>>>      Acked-by: Joe Stringer <joe@ovn.org>
>>>      Signed-off-by: David S. Miller <davem@davemloft.net>
>> Hi Juerg,
>> the symptom, the identified breaking commit and actually all of it
>> seems to be [1] which James, Joseph and I worked on already.
>> I wanted to make you aware of the past context that already exists.
>>
>> Back then we already reverted the change, found it to be working then.
>> Afterwards Joseph brought it up with Jarno [2] and got some patch it
>> seems, but that (whatever change it was - I have never seen it) wasn't
>> enough and still crashing.
>> Then we lost traction on the case and now you had to re-debug it I'm afraid :-/
>>
>> [1]: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1736390
>> [2]: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1736390/comments/55
>>
>>> Reverting that commit from 5.0 makes the problem go away. I'm not able to
>>> reproduce the crash on x86_64.
>>>
>>> ...Juerg
>>> _______________________________________________
>>> dev mailing list
>>> dev@openvswitch.org
>>> https://mail.openvswitch.org/mailman/listinfo/ovs-dev
>>
>>
>> --
>> Christian Ehrhardt
>> Software Engineer, Ubuntu Server
>> Canonical Ltd
> Somehow the patch was shared on three different open source lists (the
> bug, linux-kernel, and ovs-dev), yet only one of the three actually
> retained the message:
>
> https://mail.openvswitch.org/pipermail/ovs-dev/2018-September/352395.html
> _______________________________________________
> dev mailing list
> dev@openvswitch.org
> https://mail.openvswitch.org/mailman/listinfo/ovs-dev

