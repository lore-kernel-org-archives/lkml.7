Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86087C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F6E20828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfLJOPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:15:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:15820 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbfLJOPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:15:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 06:15:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,299,1571727600"; 
   d="scan'208";a="215453366"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by orsmga006.jf.intel.com with ESMTP; 10 Dec 2019 06:15:31 -0800
Date:   Tue, 10 Dec 2019 22:15:02 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [pipe] 3c0edea9b2: lmbench3.PIPE.bandwidth.MB/sec -17.0%
 regression
Message-ID: <20191210141502.GQ32275@shao2-debian>
References: <20191208153949.GJ32275@shao2-debian>
 <20191209085559.GA5868@dhcp22.suse.cz>
 <CAHk-=whF0mbvWC=sYKWTrpymmjWkGZcX9hnHgnm1t1M++W66zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whF0mbvWC=sYKWTrpymmjWkGZcX9hnHgnm1t1M++W66zA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 10:35:35AM -0800, Linus Torvalds wrote:
> On Mon, Dec 9, 2019 at 12:56 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > Huh. How can something like that can even can get merged? No changelog,
> > no s-o-b?
> 
> Yeah, I missed that when pulling.
> 
> I wish that had been the only problem we had with that code, but it wasn't.
> 
> Anyway, I'm fairly certain the current git head should fix this
> lmbench3 performance regression too.
> 
>                    Linus

Hi Linus,

Sorry for the inconvenience, indeed, the regression has been fixed.

commit:
  cefa80ced5 ("pipe: Increase the writer-wakeup threshold to reduce context-switch count")
  3c0edea9b2 ("pipe: Remove sync on wake_ups")
  6794862a16 ("Merge tag 'for-5.5-rc1-kconfig-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux")

cefa80ced57a2917  3c0edea9b29f9be6c093f236f7  6794862a16ef41f753abd75c03  testcase/testparams/testbox
----------------  --------------------------  --------------------------  ---------------------------
         %stddev      change         %stddev      change         %stddev
             \          |                \          |                \  
     21204             -17%      17604              23%      26123 ±  3%  lmbench3/performance-development-100%-PIPE-50%-ucode=0x7000019/lkp-bdw-de1
     21204             -17%      17604              23%      26123        GEO-MEAN lmbench3.PIPE.bandwidth.MB/sec

Best Regards,
Rong Chen
