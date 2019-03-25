Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6179EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D7E205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553478839;
	bh=ZpJL5OTRgMLyrCVyssmdgn+psPQ8+NDODlsawdHzhzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qSbrwYvMARp3eIY/2e3S5xEFo3W80clvLTF5Z/ESF4Wrz+LBIv9e0y3Ge0gbgzO2y
	 6S1Y7c1S7E9N7VOhqj0eQHrgIVpaQS5hY4eR8XXwwP3tmrn20POD6d52sp/2he0n7R
	 fub7+7bXIfnzALaWLLErDAvP81jnKT8ps5UmUlRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfCYBx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 21:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbfCYBx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 21:53:57 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A838520896;
        Mon, 25 Mar 2019 01:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553478837;
        bh=ZpJL5OTRgMLyrCVyssmdgn+psPQ8+NDODlsawdHzhzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R9hmWk5GP22W7oDNIRT8Yqu8gEXctb8i9y5Brv41Ofhl1a3AtoiNNMkUrLEoRDQP/
         vPdDDafOERwXUWrdQonKBd1R7MB/FmDh2VfUlmiA7YjJCCZBk1ek2SUjlrIBhssVu6
         qWWJSqLxcamJXVFNlBAirOoON5deepkVVzt8/+pk=
Date:   Mon, 25 Mar 2019 10:53:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] x86/kprobes: Make trampoline_handler global and
 visible
Message-Id: <20190325105353.66ed097a64bdc2c83fb73f35@kernel.org>
In-Reply-To: <20190323143518.GB18020@tassilo.jf.intel.com>
References: <20190321220009.29334-1-andi@firstfloor.org>
        <20190321220009.29334-12-andi@firstfloor.org>
        <20190323184521.a443cc741997cb0d3ed26395@kernel.org>
        <20190323143518.GB18020@tassilo.jf.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2019 07:35:18 -0700
Andi Kleen <ak@linux.intel.com> wrote:

> On Sat, Mar 23, 2019 at 06:45:21PM +0900, Masami Hiramatsu wrote:
> > On Thu, 21 Mar 2019 15:00:03 -0700
> > Andi Kleen <andi@firstfloor.org> wrote:
> > 
> > > From: Andi Kleen <ak@linux.intel.com>
> > > 
> > > This function is referenced from assembler, so in LTO
> > > it needs to be global and visible to not be optimized away.
> > > 
> > 
> > I got it.
> > 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Andi, out of curiousity, that is not only for x86, but
> > does all arch have to care it?
> 
> Yes all architectures need it for LTO, but I currently
> only test x86. There are some other people who made it work
> on ARM / MIPS / PowerPC before.

That's good to know! I worried that similar mistake I made
on another arch :)

Thank you,

> 
> -Andi


-- 
Masami Hiramatsu <mhiramat@kernel.org>
