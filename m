Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F5CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ED320850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfCVQwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:52:09 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:53987 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727443AbfCVQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:52:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 731BC40F4;
        Fri, 22 Mar 2019 16:52:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: week26_4c650743d8113
X-Filterd-Recvd-Size: 2562
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 Mar 2019 16:52:04 +0000 (UTC)
Message-ID: <aa5e2a093bf1c2d7ef024348065249bb6e4518b2.camel@perches.com>
Subject: Re: [PATCH 1/2] PM / arch: x86: Rework the
 MSR_IA32_ENERGY_PERF_BIAS handling
From:   Joe Perches <joe@perches.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Hannes Reinecke <hare@suse.de>
Date:   Fri, 22 Mar 2019 09:52:03 -0700
In-Reply-To: <alpine.DEB.2.21.1903221712020.1729@nanos.tec.linutronix.de>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
         <1605148.8jT99SsvVP@aspire.rjw.lan> <20190322142828.GA12472@zn.tnic>
         <alpine.DEB.2.21.1903221531080.1729@nanos.tec.linutronix.de>
         <20190322143525.GB12472@zn.tnic>
         <alpine.DEB.2.21.1903221712020.1729@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-22 at 17:12 +0100, Thomas Gleixner wrote:
> On Fri, 22 Mar 2019, Borislav Petkov wrote:
> 
> > On Fri, Mar 22, 2019 at 03:31:54PM +0100, Thomas Gleixner wrote:
> > > We have no proper decision/recommendation about documentation
> > > licensing. That's being worked on.
> > 
> > Ok, I'm ignoring this checkpatch warning from now on.
> 
> Only for Documentation/* files please.

Perhaps
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d0001fd1112d..00c1457fe79b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3058,7 +3058,8 @@ sub process {
 					     "Improper SPDX comment style for '$realfile', please use '$comment' instead\n" . $herecurr);
 				}
 
-				if ($comment !~ /^$/ &&
+				if ($realfile !~ m@^Documentation/@ &&
+				    $comment !~ /^$/ &&
 				    $rawline !~ m@^\+\Q$comment\E SPDX-License-Identifier: @) {
 					WARN("SPDX_LICENSE_TAG",
 					     "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);


