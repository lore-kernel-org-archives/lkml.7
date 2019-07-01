Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57C5C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852172183F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfGAPSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:18:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:6226 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfGAPSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:18:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 08:18:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,439,1557212400"; 
   d="scan'208";a="174254068"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga002.jf.intel.com with ESMTP; 01 Jul 2019 08:18:52 -0700
Message-ID: <b2cbda587c72bba045ef47412e348ed4e7fb07f2.camel@linux.intel.com>
Subject: Re: [UPDATE][PATCH 10/10] tools/power/x86: A tool to validate Intel
 Speed Select commands
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alan Cox <alan@linux.intel.com>, Len Brown <lenb@kernel.org>,
        prarit@redhat.com, darcari@redhat.com,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Date:   Mon, 01 Jul 2019 08:18:52 -0700
In-Reply-To: <CAHp75Vf-p3O10_Ns_NY4JoWBS1S34z-NW0jVJdCdqszdGVmoQw@mail.gmail.com>
References: <20190630171408.8673-1-srinivas.pandruvada@linux.intel.com>
         <CAHp75Vf-p3O10_Ns_NY4JoWBS1S34z-NW0jVJdCdqszdGVmoQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-01 at 14:32 +0300, Andy Shevchenko wrote:
> On Sun, Jun 30, 2019 at 8:14 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > The Intel(R) Speed select technologies contains four features.
> > 
> > Performance profile:An non architectural mechanism that allows
> > multiple
> > optimized performance profiles per system via static and/or dynamic
> > adjustment of core count, workload, Tjmax, and TDP, etc. aka ISS
> > in the documentation.
> > 
> > Base Frequency: Enables users to increase guaranteed base frequency
> > on
> > certain cores (high priority cores) in exchange for lower base
> > frequency
> > on remaining cores (low priority cores). aka PBF in the
> > documenation.
> > 
> > Turbo frequency: Enables the ability to set different turbo ratio
> > limits
> > to cores based on priority. aka FACT in the documentation.
> > 
> > Core power: An Interface that allows user to define per core/tile
> > priority.
> > 
> > There is a multi level help for commands and options. This can be
> > used
> > to check required arguments for each feature and commands for the
> > feature.
> > 
> > To start navigating the features start with
> > 
> > $sudo intel-speed-select --help
> > 
> > For help on a specific feature for example
> > $sudo intel-speed-select perf-profile --help
> > 
> > To get help for a command for a feature for example
> > $sudo intel-speed-select perf-profile get-lock-status --help
> > 
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> > Updates:
> > - Copied Makefile from tools/gpio and moified the Makefile here
> > - Added entry to tools/build/Makefile
> > - Rename directory to match the executable name
> > - Fix one error message
> 
> Thanks!
> I pushed to my review and testing queue, while still waiting for some
> ACKs.
> 
> It seems I can promote the driver itself now,w/o tools, if you want
> me to do so.
I am fine with driver only push if we don't get ACK by your deadline
for the next kernel.

Thanks,
Srinivas


