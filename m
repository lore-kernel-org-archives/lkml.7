Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC2BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01742230C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574171170;
	bh=lzxb0TiKfSd/5E+wz7B88gCyEetdbyhN3xNVFBDXFZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pC5wSQpjptRXPDbK9jCwLWr/pHqiN7Quo1Des4mN+6JaoXcP/gwCJCTwyNlxJ7VmJ
	 Cgx4cpTE5WpdGi1WmNmtWmr/GzrrmyxB2af8YuERAB9Sh4eWo1FKs7sEhiOZtqYROP
	 XykPMWWSxVDpmMSPfEDdHXb3rULV8izgO3EDDB8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfKSNqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfKSNqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:46:09 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D885E206B6;
        Tue, 19 Nov 2019 13:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574171168;
        bh=lzxb0TiKfSd/5E+wz7B88gCyEetdbyhN3xNVFBDXFZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zNJUvgDQs5CWizobw9HfPeLiXfuS3T4ViH7VGxb785fC/4Td+zpY6GTVaegSJ+JNY
         utkkIvYw/O14dcvQ5HOj1556YiXhnq/LXy39AFqqBgUxxDKyMQksiwFoeyFedVV/5G
         k+4bYN7NDpHerDy+f5qmFnKuaL1bXVVUSU09sGn0=
Date:   Tue, 19 Nov 2019 22:46:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 0/7] perf/probe: Support multiprobe and immediates
 with fixes
Message-Id: <20191119224604.1d3665b8e8dfdcfcc2a8f31e@kernel.org>
In-Reply-To: <20191118221104.GF20465@kernel.org>
References: <157406469983.24476.13195800716161845227.stgit@devnote2>
        <20191118221104.GF20465@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 19:11:04 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Nov 18, 2019 at 05:11:40PM +0900, Masami Hiramatsu escreveu:
> > Hi Arnaldo,
> > 
> > This is the 3rd version of the multiprobe support on perf probe
> > including some fixes about "representive lines"
> > 
> > The previous thread is here:
> > 
> > https://lkml.kernel.org/r/157314406866.4063.16995747442215702109.stgit@devnote2
> > 
> > On the previous thread, we discussed some issues about incorrect line
> > information shown by perf probe. I finally fixed those by introducing
> > an idea of "representive line" -- a line which has a unique address
> > (no other lines shares the same address) or a line which has the least
> > line number among lines sharing same address. Now perf probe only shows
> > such representive lines can be probed([1/7][3/7]), and if user tries to
> > probe other non representive lines, it shows which line user should
> > probe ([2/7]). The rest of patches in the series are same as v2 (except
> > for [4/7], example output is updated)
> > 
> > This can be applied on top of perf/core.
> 
> Thanks, applied everything, only the two last patches I didn't test, the
> kernel in this machine doesn't have the features it needs, we can fix
> things if some problem lurks there.

Thank you Arnaldo! OK, if anything happens, I'll fix it soon.

Best Regards,
-- 
Masami Hiramatsu <mhiramat@kernel.org>
