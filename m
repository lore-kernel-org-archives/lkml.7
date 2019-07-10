Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36397C73C66
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A4A2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562726773;
	bh=jzS0lWGubRhHz6e7Xx7OxsahUS3AdhKlhXd4MJKB7us=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=y08Uz0TFPJF36HVrOLZGZPf/U2K00iPTiLYFps8AyUMfVcvNjrH13lKrYZ/TiMDzr
	 GWTUPwDvtbqG33qnvwOwboa88eZoB8BGEAG6mKcuoNPfU/VD4htf7/65g32fwMYGHc
	 ZMXuPNvPDfi7KBwIzWbsuJolzBQ6HuDrP+6F+aYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfGJCqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfGJCqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:46:11 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C77F2080C;
        Wed, 10 Jul 2019 02:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562726770;
        bh=jzS0lWGubRhHz6e7Xx7OxsahUS3AdhKlhXd4MJKB7us=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ch1ucHt0/BU44a0NIoj8vKCczzUNhMuM6VJPjqbrpNUcFEjvZHa2pGeouyVvqUN7P
         8YSJhi/BDBMoOlQJEbuQujnEWSr0eHFovYYtsrltNncNCEiYVbkgTTeM6+kNX6G/Db
         i+Nvpln/2E6HiKPBjliaDDum/g3nPqI3VQRwgzho=
Date:   Wed, 10 Jul 2019 11:46:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        James Morse <james.morse@arm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kprobes sanity test fails on next-20190708
Message-Id: <20190710114604.8e753774a93ece9d3e753646@kernel.org>
In-Reply-To: <20190709114045.091c94f3@gandalf.local.home>
References: <20190708141136.GA3239@localhost.localdomain>
        <a19faa89-d318-fe21-9952-b0f842240ba5@arm.com>
        <CADYN=9LBQ4NYFe8BPguJmxJFMiAJ405AZNU7W6gHXLSrZOSgTA@mail.gmail.com>
        <20190709213657.1447f508bd6b72495ec225d9@gmail.com>
        <20190709112548.25edc9a7@gandalf.local.home>
        <20190709153755.GB10123@lakrids.cambridge.arm.com>
        <20190709114045.091c94f3@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 11:40:45 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 9 Jul 2019 16:37:55 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > > I agree. I pushed to my repo in the for-next branch. Care to test that?
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git  
> > 
> > I've just given that a spin with KPROBES and KPROBES_SANITY_TEST
> > selected, and it boots cleanly for me. FWIW:
> > 
> > Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks, then I'm guessing no more changes need to be made.
> 
> I usually don't rebase my for-next branch for tags, but since I just
> pushed it, I guess I can add this one ;-)

Thanks Steve!



-- 
Masami Hiramatsu <mhiramat@kernel.org>
