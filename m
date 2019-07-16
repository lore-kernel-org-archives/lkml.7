Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E49C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD00C20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3NBUMs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbfGPMf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 08:35:28 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:36519 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPMf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:35:28 -0400
Received: by mail-pl1-f173.google.com with SMTP id k8so10063221plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=eyqYLRq+bWlYMtTFicSRsCe2VqbCN5lHQyGJZGq5tU8=;
        b=o3NBUMs90oOPUnvNKalVMbQD+Jj/weFrBuOwBcxn4RSo5pwJ8qkNCYyfO+W0KsT1IG
         nov8zkBfObbxTI5eehPftVgbUcGMCmCTmEM9/oldLy/KF96NQEmFZNSxrLxCGMD1M1wV
         QRP8vDzijeavB90PkTbYJAzl5r1fD2gbpQBCR2KO4TELPqsD7zbH8RvWEs9FmlauLguU
         Usi95gHeDFoL8LwVi6o3Vrz7pCV5Ql3+0Hth5DDM1BgL4vFoK7g/ujfNs8orT85yI63H
         9LLRLc/rVd5OnJgcmCmSypbwZULwB/tagq/Cbk3uEsGuof6Kpg4WEl+JfmZD/4a1zwpu
         +f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=eyqYLRq+bWlYMtTFicSRsCe2VqbCN5lHQyGJZGq5tU8=;
        b=eC+EtOMuvxqu499kr5YfTldJbQUXDNqP5dcBwWTYHR83Bcr+hvNyPeG5G9avdtf2rl
         WxDoEzSAT4kWL+5TnKoCJBxoF/exefEWIUroJKdPYFVIrpLtK2Awbwgivc+jr2r1OT7R
         LIRSCEeukoCo34XTnKh/D9u6K8OluNrvLyPohavlWmahY++eHiqRc4bGVkd7MULQ8/MU
         c4nBlQmFJ25+zs3tp2H8xgAloQwd9u3UsTeswiupjZKdAN1G3NF7SXiL8B/ZeLdgAVyr
         Qw7HgMsBPDe7zVOiWPd3t5bJoPRPcQPbcd+9Gb/Gvo0tCyxWmT+KwC4GlhLWgz5Lakm/
         yQXg==
X-Gm-Message-State: APjAAAU5BG9Y7YD0BUr+Ol55RaNy4hkIgbFgG/MKkH6EzF2Shm8bUAB2
        CSgotGC81rMVr2H9UQ0n1U+4mhvCdtc=
X-Google-Smtp-Source: APXvYqwIyAn+jliL56vZ7qikS2ZZrLmpS3mAdcYjC8i6GJ/5UDxHDNZ2ao9wHnqn8zsrrrY0iNsTAQ==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr35648709pla.5.1563280526934;
        Tue, 16 Jul 2019 05:35:26 -0700 (PDT)
Received: from [192.168.0.108] ([49.205.216.54])
        by smtp.googlemail.com with ESMTPSA id p68sm30208850pfb.80.2019.07.16.05.35.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 05:35:26 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Subject: cgroups v2: issues faced attempting to setup cpu limiting
Message-ID: <55434cbd-7672-3a09-446c-57b37c5c48a5@gmail.com>
Date:   Tue, 16 Jul 2019 18:05:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am facing some issues getting CPU limiting working with cgroups v2. Pl read on for the details;
a solution is much appreciated!


Env: custom 5.0.0 Linux kernel on x86_64 Fedora 29

When attempting to setup CPU limiting using cgroups v2, I effectively disabled cgroups v1 by passing

cgroup_no_v1=all

as a kernel cmdline option. That seems fine and now various controllers (cpu, io, memory, ...)
show up under /sys/fs/cgroup/unified/cgroup.controllers.

However, doing:

# mkdir /sys/fs/cgroup/unified/test1
# echo "+cpu " > /sys/fs/cgroup/unified/test1/cgroup.subtree_control
bash: echo: write error: No such file or directory
#

I understand that this is expected, as the man page on cgroups(7) mentions:

"... As at Linux 4.15, the cgroups v2 cpu controller does not support
control of realtime processes, and the controller can be enabled in the
root cgroup only if all realtime threads are in the root cgroup. (If there
are realtime processes in nonroot cgroups, then a write(2) of the string
"+cpu" to the cgroup.subtree_control file fails with the error EINVAL.
However, on some systems, systemd(1) places certain realtime processes in
nonroot cgroups in the v2 hierarchy. On such systems, these processes must
first be moved to the root cgroup before the cpu controller can be
enabled. ..."

My questions are: how exactly does one 'move realtime processes to the root cgroup'?
What are the commands?

Next, how does one identify which processes? The ones that have sched policy SCHED_FIFO
or SCHED_RR? Would using a utility wrapper make this simpler? (libcgroup, cgmanager,
etc) - do they play well with cgroups2?

TIA!

Regards,
Kaiwan.

amazon author page: https://www.amazon.com/-/e/B07KNJSRJX

