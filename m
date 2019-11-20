Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A3BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D38920885
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfKTPPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:15:11 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39024 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfKTPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:15:10 -0500
Received: by mail-ot1-f51.google.com with SMTP id w24so21023714otk.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 07:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mWNRwQmWLmAZvnpZuQkggOMIUTp3+MxTnTap7iRQstg=;
        b=DR53V1F9anLMe0LXo2Q7heIOJNSkD0s0wkZWnXEk6vAiI+uPqn15tmxqmRmb2bwz/s
         b2/H6oQ46mlauHjfd84qVnwZq08EtLfVTVJQ/CM3HiOmUXUxp+bb/e2Mc+RuT4vUkas9
         kh4zwxOGrxrQhbl0Lz+JFOhJZ6UWlM1JmvlpuRSG7v6JPlX/pBzCXlrO9F8jNm7twBDU
         4gcTJVrfrQPDMUXj85o+ZamVYlD4SIKf2iqkl1DlwNnWm5CzGccHEM1DrTKfUPQYwGNr
         AkqgwvkIfhi809XqQWkL+SyxIrgT2kOSBCObLjeo9qX+f8tTYW1/lIftbdUiYZt+DGPh
         BBmQ==
X-Gm-Message-State: APjAAAVeqBoP2TsBfAfgTbcdNMmqOLDEvd1P1ha8AtNsKX5BlQ1Zp0hv
        wWUYJcmXPXQCaCBH6uURAm1oZ34YXaPm3miBNvNMQnLr
X-Google-Smtp-Source: APXvYqzPSRIlrOzN9FRvFNs7rEpql6C5YLguOaXqefLCtBS/AXVBEFraL4u+CjXMCmOhP5V/IGARBFcXg/nqA+Hf49U=
X-Received: by 2002:a9d:7642:: with SMTP id o2mr2271579otl.177.1574262910006;
 Wed, 20 Nov 2019 07:15:10 -0800 (PST)
MIME-Version: 1.0
From:   Alan Bartlett <ajb@elrepo.org>
Date:   Wed, 20 Nov 2019 15:14:58 +0000
Message-ID: <CA+_WhHxudcxs2zN-ykUx9jaRUbHBSpyxmu-p8NRMHHBD2GUv8A@mail.gmail.com>
Subject: Build of 5.4-rc8 - Objtool: Unreachable Instruction Warnings
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me, as I am not subscribed to the list.]

A build of linux-5.4-rc8 (on RHEL8.1, using gcc (GCC) 8.3.1 20190507
(Red Hat 8.3.1-4)) shows a number of objtool unreachable instruction
warnings.

arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_panic()+0x10f:
unreachable instruction
net/core/skbuff.o: warning: objtool: skb_push.cold.95()+0x14:
unreachable instruction
kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14:
unreachable instruction
fs/btrfs/extent_io.o: warning: objtool:
__set_extent_bit.cold.61()+0xd: unreachable instruction
fs/btrfs/relocation.o: warning: objtool:
add_tree_block.isra.43.cold.54()+0xc: unreachable instruction
drivers/message/fusion/mptbase.o: warning: objtool:
mpt_HardResetHandler()+0x1ec: unreachable instruction
drivers/gpu/drm/ttm/ttm_bo.o: warning: objtool:
ttm_bo_del_from_lru()+0xe8: unreachable instruction
drivers/scsi/aic7xxx/aic79xx_core.o: warning: objtool:
ahd_handle_seqint.isra.49()+0x6ea: unreachable instruction

I am currently unable to perform a bisection but can provide a little
more context around those warnings, if it would be of help.

Alan.
