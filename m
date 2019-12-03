Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF56C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11859207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L21DOgkX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="mqHtIiKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfLCVd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 16:33:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61588 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfLCVd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:33:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD5C02A49B;
        Tue,  3 Dec 2019 16:33:27 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=DIeAmrGnxgL2ql/EXn5pBWDpzrY=; b=L21DOg
        kXhqScbrIlXFhm6YkSvgI7la2TWbux4tGPChi4DMRtmaqnQMGgBa/z8Kfg2pgSr+
        6iuov7hHndXq3uFlj+LT766WeCOq7IYBSQBzcMqwIiaaZhZOduLLUmDfh4o9HsTj
        TW7b0VcYigcM9SbQaGGy+98MWEvY33M9NrNwY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D10912A499;
        Tue,  3 Dec 2019 16:33:27 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=1kRoGilfDSKgEsEm14aYoe/uL5r/TgsvJgKIqlQ3HNs=; b=mqHtIiKnrf6EQHvPU1qcVrU9Y17S4yO5vFSsl9nkLnQaQdHBlJO+JZmUmi9NFCeAKbqPNExrRyyJu9lTD0lbPHbHVgLI17jaKbptOARDSTchDs5NP1c9wmoQuljdlqhV7Bdaq5g/8BJ9WJ4q9t9Eoq1loZq771BFMNXGirLY2sg=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2AAAC2A498;
        Tue,  3 Dec 2019 16:33:27 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 3C2C22DA01A3;
        Tue,  3 Dec 2019 16:33:26 -0500 (EST)
Date:   Tue, 3 Dec 2019 16:33:26 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     syzbot <syzbot+7d027845265d531ba506@syzkaller.appspotmail.com>
cc:     daniel.vetter@ffwll.ch, Dave Mielke <dave@mielke.cc>,
        ghalat@redhat.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        kilobyte@angband.pl, linux-kernel@vger.kernel.org,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com,
        textshell@uchuujin.de, tomli@tomli.me
Subject: Re: KASAN: slab-out-of-bounds Read in vcs_scr_readw
In-Reply-To: <0000000000005f7f920598d25a5f@google.com>
Message-ID: <nycvar.YSQ.7.76.1912031622320.17114@knanqh.ubzr>
References: <0000000000005f7f920598d25a5f@google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 8ACC51BE-1614-11EA-8060-D1361DBA3BAF-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    596cf45c Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14c1d196e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8eb54eee6e6ca4a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=7d027845265d531ba506
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c6090ee00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13821b7ae00000
> 
> The bug was bisected to:
> 
> commit d21b0be246bf3bbf569e6e239f56abb529c7154e
> Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date:   Wed Jun 27 03:56:41 2018 +0000
> 
>    vt: introduce unicode mode for /dev/vcs
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1292fbf2e00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1192fbf2e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1692fbf2e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7d027845265d531ba506@syzkaller.appspotmail.com
> Fixes: d21b0be246bf ("vt: introduce unicode mode for /dev/vcs")

This is most likely the same issue that was fixed and queued for 
mainline already. The fix is accessible as commit 0c9acb1af77a in the 
linux-next tree.


Nicolas
