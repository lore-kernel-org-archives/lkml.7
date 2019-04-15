Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34E3C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669052064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cO67aSDH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cO67aSDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfDOM6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:58:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57054 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfDOM6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:58:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7E37A6155E; Mon, 15 Apr 2019 12:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555333110;
        bh=agln/OUqOYAxaGAnB9UBlUR029eFopQS7xCI98I8qmE=;
        h=To:Cc:From:Subject:Date:From;
        b=cO67aSDHpLlsJEy9Coa1f7MZzl2HWAT0V0yvA6UZMJpXaIUq8kBrlOdhvw563x0pX
         +9hzFn3TmJl3UWUfpA58UYKcidAteNBVkZHGrjzGpftKG3YR3bPLIPUXBah8cYsQ7Y
         iVKx52AHhdgky9W1fP/+2eYf2c4QFtCFILxJg4cY=
Received: from [10.204.82.67] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: shajit@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27E996119F;
        Mon, 15 Apr 2019 12:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555333110;
        bh=agln/OUqOYAxaGAnB9UBlUR029eFopQS7xCI98I8qmE=;
        h=To:Cc:From:Subject:Date:From;
        b=cO67aSDHpLlsJEy9Coa1f7MZzl2HWAT0V0yvA6UZMJpXaIUq8kBrlOdhvw563x0pX
         +9hzFn3TmJl3UWUfpA58UYKcidAteNBVkZHGrjzGpftKG3YR3bPLIPUXBah8cYsQ7Y
         iVKx52AHhdgky9W1fP/+2eYf2c4QFtCFILxJg4cY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27E996119F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shajit@codeaurora.org
To:     keescook@chromium.org, mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
From:   Jitendra Sharma <shajit@codeaurora.org>
Subject: fs/proc: Crash observed in next_tgid (fs/proc/base.c)
Message-ID: <b5b9df7b-324c-8286-3a7c-e7812511772d@codeaurora.org>
Date:   Mon, 15 Apr 2019 18:28:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees Cook/Luis,

We are observing one kernel crash in next_tgid function through 
getdents64 path. Call stack is as shown below:

-000|has_group_leader_pid(inline)
-000|next_tgid(
| [X20] ns = 0xFFFFFF87CABB1AC0,
| [locdesc] iter = (
| [locdesc] tgid = 424,
| [locdesc] task = ?))
| [X21] p = 0xFFFFFFD0FFFFF948
| [X21] task = 0xFFFFFFD0FFFFF948
-001|proc_pid_readdir(
| [X20] file = 0xFFFFFFD1AC60FC40,
| [X19] ctx = 0xFFFFFF8027363E40)
| [X21] ns = 0xFFFFFF87CABB1AC0
-002|proc_root_readdir(
| [X20] file = 0xFFFFFFD1AC60FC40,
| [X19] ctx = 0xFFFFFF8027363E40)
-003|iterate_dir(
| [X19] file = 0xFFFFFFD1AC60FC40,
| [X22] ctx = 0xFFFFFF8027363E40)
| [X23] inode = 0xFFFFFFD1F20246D0
-004|SYSC_getdents64(inline)
-004|sys_getdents64(
| ?,
| ?,
| [X19] count = 4200)
| [X19] count = 4200
| [X20] f = ([X20] file = 0xAC60FC43AC60FC40, [X20] flags = 1207898624)
| [X0] error = -1720
-005|el0_svc_naked(asm)
-->|exception
-006|NUX:0x78C5AD7D38(asm)
---|end of frame


 From this call stack,task: 0xFFFFFFD0FFFFF948, seems to be invalid. 
As(from ramdumps) it doesn't have any valid fields. And while trying to 
access the fields of this task struct in has_group_leader_pid, abort is 
happening.

 From the dumps, its not clear why the task struct is coming to be some 
invalid (Possibly task has already exited).  This issue is observed 
during normal monkey testing for long hours.

Could you please provide some pointers which could help in debugging 
this issue further.


Thanks,

Jitendra

-- 

QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
