Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651CAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40123206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbfETKWG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:22:06 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:37607 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbfETKWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:22:06 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x4KALhFs013250
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 May 2019 19:21:43 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4KALhLU009626;
        Mon, 20 May 2019 19:21:43 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x4KAJuFw020474;
        Mon, 20 May 2019 19:21:43 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-5209311; Mon, 20 May 2019 19:21:06 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0319.002; Mon,
 20 May 2019 19:21:06 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     Jane Chu <jane.chu@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH] mm, memory-failure: clarify error message
Thread-Topic: [PATCH] mm, memory-failure: clarify error message
Thread-Index: AQHVDGYtMbmPk2oO9EWAkFfiZXN9haZuJ74AgAUUDQA=
Date:   Mon, 20 May 2019 10:21:05 +0000
Message-ID: <20190520102106.GA12721@hori.linux.bs1.fc.nec.co.jp>
References: <1558066095-9495-1-git-send-email-jane.chu@oracle.com>
 <512532de-4c09-626d-380f-58cef519166b@arm.com>
In-Reply-To: <512532de-4c09-626d-380f-58cef519166b@arm.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <CEE34CE09A73174D91E6FF4DEC23B445@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 10:18:02AM +0530, Anshuman Khandual wrote:
> 
> 
> On 05/17/2019 09:38 AM, Jane Chu wrote:
> > Some user who install SIGBUS handler that does longjmp out
> 
> What the longjmp about ? Are you referring to the mechanism of catching the
> signal which was registered ?

AFAIK, longjmp() might be useful for signal-based retrying, so highly
optimized applications like Oracle DB might want to utilize it to handle
memory errors in application level, I guess.

> 
> > therefore keeping the process alive is confused by the error
> > message
> >   "[188988.765862] Memory failure: 0x1840200: Killing
> >    cellsrv:33395 due to hardware memory corruption"
> 
> Its a valid point because those are two distinct actions.
> 
> > Slightly modify the error message to improve clarity.
> > 
> > Signed-off-by: Jane Chu <jane.chu@oracle.com>
> > ---
> >  mm/memory-failure.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index fc8b517..14de5e2 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -216,10 +216,9 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
> >  	short addr_lsb = tk->size_shift;
> >  	int ret;
> >  
> > -	pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory corruption\n",
> > -		pfn, t->comm, t->pid);
> > -
> >  	if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
> > +		pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory "
> > +			"corruption\n", pfn, t->comm, t->pid);
> >  		ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)tk->addr,
> >  				       addr_lsb, current);
> >  	} else {
> > @@ -229,6 +228,8 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
> >  		 * This could cause a loop when the user sets SIGBUS
> >  		 * to SIG_IGN, but hopefully no one will do that?
> >  		 */
> > +		pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware "
> > +			"memory corruption\n", pfn, t->comm, t->pid);
> >  		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
> >  				      addr_lsb, t);  /* synchronous? */
> 
> As both the pr_err() messages are very similar, could not we just switch between "Killing"
> and "Sending SIGBUS to" based on a variable e.g action_[kill|sigbus] evaluated previously
> with ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm).

That might need additional if sentence, which I'm not sure worth doing.
I think that the simplest fix for the reported problem (a confusing message)
is like below:

	-	pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory corruption\n",
	+	pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
			pfn, t->comm, t->pid);

Or, if we have a good reason to separate the message for MF_ACTION_REQUIRED and
MF_ACTION_OPTIONAL, that might be OK.

Thanks,
Naoya Horiguchi
