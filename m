Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E949C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0729121721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560444001;
	bh=TSrEDnX7Ga+OT/0BXEKx34O47oo4LLPfMWp6E0aFb3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=L8czdBvBa+l1pDmfFbKjFz5C+4m5hJulIXV3VXXjFWcOGhrDnoUyq/E1Qu5fYbbvZ
	 HnM+T4vKD3RsaEGScIVYvPdK0qhtXunryVnqZUcqwnzAvi/VK38pdQ9dzSgXkoSH7y
	 w1X6TheMM22tXlWt5uW6gYDZX9hxuZaVRa0GDPeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfFMQkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbfFMHJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:09:02 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC3192084D;
        Thu, 13 Jun 2019 07:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560409741;
        bh=TSrEDnX7Ga+OT/0BXEKx34O47oo4LLPfMWp6E0aFb3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OJXhLljb1L/cW2VX/Ik35Ba7g2+83Db325bkvBGIZQ2eR9wJHabo6wF2PTU/NsKh+
         ZtrhhtVTSv8f2pR1zJWNPdAr2syS+UAQ2RZnJt/E3Ucgo3njwDgZcig/7ASmgg+bOF
         A3cFXOFkxxKxolFbE1pEHSk1ThdbsG1FmoUKvL0Y=
Date:   Thu, 13 Jun 2019 16:08:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Fix to init kprobes in subsys_initcall
Message-Id: <20190613160857.9db38d1cb32996b8c4e0ddc3@kernel.org>
In-Reply-To: <20190612094729.40106a28@gandalf.local.home>
References: <20190603214105.715a4072472ef4946123dc20@kernel.org>
        <155956708268.12228.10363800793132214198.stgit@devnote2>
        <20190612165947.ba696696dac0faa3aa35a501@kernel.org>
        <20190612094729.40106a28@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 09:47:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 12 Jun 2019 16:59:47 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > Could you pick this to your ftrace/core branch?
> 
> "core" or should this go to "urgent"? The difference is that core is
> scheduled for the next merge window, and urgent is for the rc releases
> (ie. bug fixes).

If the previous one (b5f8b32c93b2) has already gone to rc, yes
this should be in urgent, since this always crashes arm64 kernel
if we enables CONFIG_KPROBES_SANITY_TEST.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
