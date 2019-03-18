Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB8FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75E82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YBwIea3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfCRPPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:15:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58048 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfCRPPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mUzQztixUaL5Z4slN1bY3zTE9JHBDdO/8J2GDqOGk/k=; b=YBwIea3BEe1WeRICVkJVYW+Wr
        p21tyFVCHdLIV7YAFD3s83HnnVIycyFLIA2IFvTPAG9Z9SHy2xx5JiLs3qmws6RGsGVebR+L1eDDM
        H1YvdGuSo7tI9jJeFpnPs4FkNWOrzZ3HkrdpjLq3umhmT8y1qY6MuXos+W4ExfcxD06hNkEzrjSmV
        iMv8lOu8NR/QHZStDpwLDmyBPvt/XQt2DpR/zxM7BSGhyd69nObshbwkvYa0gjMi+hb5GX0d12X9e
        pwkTmWDhoJxP+3fVCz2XmQlXSJNVcBsl3UzelzZDlTFcDkE/Oh6bEXng6oSdmixnLfTOv5jgpfaZl
        EQh0YuNZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5tz8-0004hQ-M2; Mon, 18 Mar 2019 15:15:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E7002021950E; Mon, 18 Mar 2019 16:15:29 +0100 (CET)
Date:   Mon, 18 Mar 2019 16:15:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Prateek Sood <prsood@codeaurora.org>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf: extend total_ref_count usage to protect
 perf_trace_buf access
Message-ID: <20190318151529.GT6058@hirez.programming.kicks-ass.net>
References: <1552906065-24137-1-git-send-email-prsood@codeaurora.org>
 <20190318110250.7214cfa7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318110250.7214cfa7@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:02:50AM -0400, Steven Rostedt wrote:
> On Mon, 18 Mar 2019 16:17:45 +0530
> Prateek Sood <prsood@codeaurora.org> wrote:
> 
> > A potential race exists between access of perf_trace_buf[i] from
> > perf_trace_buf_alloc() and perf_trace_event_unreg(). This can
> > result in perf_trace_buf[i] being NULL during access from memset()
> > in perf_trace_buf_alloc().

Can you expound?
