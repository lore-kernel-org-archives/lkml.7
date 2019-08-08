Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDEBC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB97C208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbfHHSBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:01:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:61844 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbfHHSBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:01:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 11:01:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="scan'208";a="179914658"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga006.jf.intel.com with ESMTP; 08 Aug 2019 11:01:30 -0700
Date:   Thu, 8 Aug 2019 11:01:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     'Christoph Hellwig' <hch@lst.de>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        'Arnd Bergmann' <arnd@arndb.de>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'linux-ia64@vger.kernel.org'" <linux-ia64@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: remove sn2, hpsim and ia64 machvecs
Message-ID: <20190808180129.GA18553@agluck-desk2.amr.corp.intel.com>
References: <20190807133049.20893-1-hch@lst.de>
 <3908561D78D1C84285E8C5FCA982C28F7F41388B@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4143CB@ORSMSX115.amr.corp.intel.com>
 <20190807230737.GA11458@agluck-desk2.amr.corp.intel.com>
 <20190808065123.GA29146@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808065123.GA29146@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 08:51:23AM +0200, 'Christoph Hellwig' wrote:
> On Wed, Aug 07, 2019 at 04:07:37PM -0700, Luck, Tony wrote:
> > On Wed, Aug 07, 2019 at 01:26:17PM -0700, Luck, Tony wrote:
> > > Ugh! The rule to do the compression was in arch/ia64/hp/sim/boot/Makefile
> > > which went away as part of the deletion of hpsim.
> > 
> > This fixes it ... should fold into the patch that dropped the
> > arch/ia64/hp/sim/boot/Makefile
> > 
> > I just cut/pasted in those cmd_gzip and cmd_objcopy definitions
> > from elsewhere in the tree. It might be possible to simplify them.
> 
> Lets keep it simple.  I've picked this up for the hpsim removal patch.

So most configs now build, and the generic one boots on my Tukwila system.

But a config based on arch/ia64/configs/zx1_defconfig gets a bunch
of build errors from different files complaining about 'max_mapnr'

arch/ia64/mm/init.c:198:8: error: 'max_mapnr' undeclared (first use in this function) 
./include/linux/dma-mapping.h:359:6: error: 'max_mapnr' undeclared (first use in this function)
kernel/dma/mapping.c:126:8: error: 'max_mapnr' undeclared (first use in this function)
kernel/dma/mapping.c:181:8: error: 'max_mapnr' undeclared (first use in this function)
mm/internal.h:393:8: error: 'max_mapnr' undeclared (first use in this function)

-Tony
