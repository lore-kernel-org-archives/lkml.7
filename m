Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50315C48BE2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297F7208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561015163;
	bh=ditT581I77m/ZbUu7CLuX7DQIEDwZUnG/8oeauPi0io=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rWrIDT5L6COTiiSZ2JuJjsBB/ikTognoZ1iR9kod3s5Ifx26rRIsdGuJhOKmatcM6
	 CghfuMs7ENdrF9Dc/aTZ28p1g3PRiL8/wL7mqVOQzbiXzEcjvAFYgH1ljl27fevCxy
	 jM3InM3W70koRrGh3HeBQGNUy73yfHXVdQ/n+ffY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfFTHTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfFTHTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:19:21 -0400
Received: from devnote2 (113x40x119x170.ap113.ftth.ucom.ne.jp [113.40.119.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81DA02084A;
        Thu, 20 Jun 2019 07:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561015160;
        bh=ditT581I77m/ZbUu7CLuX7DQIEDwZUnG/8oeauPi0io=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fyBYqmEqZeklNLUnmdmPM/4625Mcbao07QGNIYQw5knhEZK8wIHjcm8xUL4RmnX0r
         PMnegxpi1BIQAjhCwgTuEYSEaa/KbTsng4M1dGIJ9/yq3pToiPLhZ1loMNuNQ0OZTt
         fyFz0fNafXWDnlMWBNAdXCvQrux1gSBdpWnS1k4c=
Date:   Thu, 20 Jun 2019 16:19:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>
Subject: Re: [PATCH] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
Message-Id: <20190620161917.a713ea0ff38fa18a2c6f05c2@kernel.org>
In-Reply-To: <8b184218-6880-204e-a9dd-e627c5ca92ca@synopsys.com>
References: <1560420444-25737-1-git-send-email-anshuman.khandual@arm.com>
        <e5f45089-c3aa-4d78-2c8d-ed22f863d9ee@synopsys.com>
        <8b184218-6880-204e-a9dd-e627c5ca92ca@synopsys.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Jun 2019 08:56:33 -0700
Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> +CC Masami San, Eugeniy
> 
> On 6/13/19 10:57 AM, Vineet Gupta wrote:
> 
> 
> > On 6/13/19 3:07 AM, Anshuman Khandual wrote:
> >> Questions:
> >>
> >> AFAICT there is no equivalent of erstwhile notify_page_fault() during page
> >> fault handling in arc and mips archs which can call this generic function.
> >> Please let me know if that is not the case.
> > 
> > For ARC do_page_fault() is entered for MMU exceptions (TLB Miss, access violations
> > r/w/x etc). kprobes uses a combination of UNIMP_S and TRAP_S instructions which
> > don't funnel into do_page_fault().
> > 
> > UINMP_S leads to
> > 
> > instr_service
> >    do_insterror_or_kprobe
> >       notify_die(DIE_IERR)
> >          kprobe_exceptions_notify
> >             arc_kprobe_handler
> > 
> > 
> > TRAP_S 2 leads to
> > 
> > EV_Trap
> >    do_non_swi_trap
> >       trap_is_kprobe
> >          notify_die(DIE_TRAP)
> >             kprobe_exceptions_notify
> >                arc_post_kprobe_handler
> > 
> > But indeed we are *not* calling into kprobe_fault_handler() - from eithet of those
> > paths and not sure if the existing arc*_kprobe_handler() combination does the
> > equivalent in tandem.

Interesting, it seems that the kprobe_fault_handler() has never been called.
Anyway, it is used for handling a page fault in kprobe's user handler or single
stepping. And a page fault in user handler will not hard to fix up. Only a hard
case is a page fault in single stepping. If ARC's kprobes using single-stepping
on copied buffer, it may crashes kernel, since fixup code can not find correct
address without kprobe_fault_handler.

Thank you,

> 
> @Eugeniy can you please investigate this - do we have krpobes bit rot in ARC port.
> 
> -Vineet
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
