Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D637C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357F5205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfCYReC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:34:02 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:60656 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729548AbfCYReB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:34:01 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2PHXxLZ013684
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:34:00 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2PHXs6l032414
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:33:59 -0400
Received: by mail-qk1-f198.google.com with SMTP id a15so6478222qkl.23
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=WMLZConRHnx6ldf/cno9zlt7rwhXHmyz2T/baU6kol8=;
        b=C2qZWeL0de3kiDjrcVpcTtb2yvOh6Qil2U0x+GPPvycIPFkyQe+Fc+5ZixuuYPVH06
         DgFmNZPsV/U2D4PYBvVH7W/1+gk+nlDHW25OvwgNW/1mul1Kyi0xyOY6TagR16SarjBs
         7PYIyeuecytkHTpssu2vzy1QDpBvr6UZ8UIfoJlPfAXCb8EYCC6ucZUyzuzSned49v64
         4MHLH7Xe2Nvui6D8EkxUBjvXOQQ5TIAiPJqZfKW5eMC3zp64W7snzJKEzpENWRjMn5yc
         DJvQD1jlNYiheWxfg0qyhz7fXjLuHCXUNSNItky3+2rqkrDyawWERaptWsr0a2U8oX0w
         Zk4w==
X-Gm-Message-State: APjAAAX/sHjYs3yXfw197OmQSlf6s9XC6fkEaGEz91WoXuyTZoEtkbRv
        NWcVlhloRaqjYzcgfv9G/f5NOGn9rgjkD3xY0k3qHJa6ofE14Q6V+RKgg0VuRpQphN8554TvxYf
        5jk29VWjIrTcWrMtkHtFpxFUzvVTvWTsVarZNUdUEohl1C6lt9JoCEqx1Uo9EzQ+3bkUrBNEQ2/
        yzlQ==
X-Received: by 2002:aed:2a22:: with SMTP id c31mr22310446qtd.49.1553535234114;
        Mon, 25 Mar 2019 10:33:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwn0COyDnvv5zKe7+VXUhCEKLOqyqSI7+2tndw3byZosddZgAMrIJSDoJbJ0G9u+a7SZLq1/A==
X-Received: by 2002:aed:2a22:: with SMTP id c31mr22310414qtd.49.1553535233757;
        Mon, 25 Mar 2019 10:33:53 -0700 (PDT)
Received: from tongs-mbp.workgroup (linker.cs.vt.edu. [128.173.236.60])
        by smtp.gmail.com with ESMTPSA id c18sm10911516qta.2.2019.03.25.10.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 10:33:52 -0700 (PDT)
From:   TongZhang <ztong@vt.edu>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Repost: Missing security_mmap_file() in remap_file_pages syscall 
Message-Id: <A6FCC3DA-C72C-4B59-A27E-E91F85949608@vt.edu>
Date:   Mon, 25 Mar 2019 13:33:51 -0400
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, rientjes@google.com, aarcange@redhat.com,
        dave@stgolabs.net, kirill.shutemov@linux.intel.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Shen Wenbo <shenwenbosmile@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel Developers,

We’d like to bring this up for a discussion again.

Several months ago we posted an email discussing a case where remap_file_pages() has no security_mmap_file() check.
At that time we were told that do_mmap_pgoff() will base the new VMA permission on the old one.
But somehow we still think the check is needed, for the reason that the advisory could first do a 
mmap() which can pass SELinux check then remap using a completely different file or region of file,
which could possibly pose a risk.

Thanks,
- Tong

The original post is pasted below:

8<—————————————————————————————
[1.] One line summary of the problem:

Possible missing security_mmap_file() in remap_file_pages

[2.] Full description of the problem/report:

We noticed remap_file_pages syscall uses do_mmap_pgoff without LSM check: security_mmap_file().

This system call passed user controllable parameters to do_mmap_pgoff().

We think that this LSM check should be added in order to be consistent with other cases,
for example:
in system call mmap_pgoff(), shmat(), they all have security_mmap_file() check before calling
do_mmap_pgoff().

[3.] Keywords: LSM check
[4.] Kernel information
[4.1] Kernel Version: 4.14.61

8<—————————————————————————————





