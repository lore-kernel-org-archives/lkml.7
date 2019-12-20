Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF45C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A05E206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576868148;
	bh=IHewiafZP6O9c1Wi2X5HdbeCK4jiwo8/eMpUfBGFAj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ndi6MSD4yxKlGaauC6yau6LzrUDbm7oB3gkaAQ+dYwF/CYkiZ1JlkCBc1UWzFhg85
	 LvOFOwJSAiQCMvYr7sd5rZx1YA1On6SW029oQm2+TPRzIgMcPHk4t9LDHWYQBsfoUl
	 VGB2447BZgCfZCtEgLE46JnzrjFmF8cOFw9s5htA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfLTSzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:55:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbfLTSzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:55:47 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30FCB206D8;
        Fri, 20 Dec 2019 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576868146;
        bh=IHewiafZP6O9c1Wi2X5HdbeCK4jiwo8/eMpUfBGFAj8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U+hwi9xhbzx5Cthi3fBq4U/+DZfatJ3jgwzF339RzFOZ65b3fWHMYhjqCFAB67xuM
         7zM8MMO7HAthc9iOA2KF6PfhOFXtg1jiRtFAa3iBuvjovZb3EkTvxvSiopP/Ep/WgQ
         DzFVRo3YerxAzmEVVhnu+O/2WdxoXYppPX9RBdcY=
Date:   Sat, 21 Dec 2019 03:55:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip V2 0/2] kprobes: Fix RCU warning and cleanup
Message-Id: <20191221035541.69fc05613351b8dabd6e1a44@kernel.org>
In-Reply-To: <157535316659.16485.11817291759382261088.stgit@devnote2>
References: <157535316659.16485.11817291759382261088.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Could you pick this series to fix the false-positive RCU-list warnings?

Thank you,

On Tue,  3 Dec 2019 15:06:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is a couple of patches which fix suspicious RCU
> usage warnings in kprobes.
> 
> Anders reported the first warning in kprobe smoke test
> with CONFIG_PROVE_RCU_LIST=y. While fixing this issue,
> I found similar issues and cleanups in kprobes.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (2):
>       kprobes: Suppress the suspicious RCU warning on kprobes
>       kprobes: Use non RCU traversal APIs on kprobe_tables if possible
> 
> 
>  kernel/kprobes.c |   32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
