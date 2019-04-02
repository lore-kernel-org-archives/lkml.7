Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273CCC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18562082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfDBEyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:54:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:57641 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfDBEyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:54:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 21:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,298,1549958400"; 
   d="scan'208";a="157900878"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 01 Apr 2019 21:54:17 -0700
Date:   Tue, 2 Apr 2019 12:38:45 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     atull@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 01/17] fpga: dfl-fme-mgr: fix FME_PR_INTFC_ID register
 address.
Message-ID: <20190402043845.GA24012@hao-dev>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-2-git-send-email-hao.wu@intel.com>
 <20190401195447.GA1910@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401195447.GA1910@archbook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 12:54:47PM -0700, Moritz Fischer wrote:
> Hi Wu,
> 
> On Mon, Mar 25, 2019 at 11:07:28AM +0800, Wu Hao wrote:
> > FME_PR_INTFC_ID is used as compat_id for fpga manager and region,
> > but high 64 bits and low 64 bits of the compat_id are swapped by
> > mistake. This patch fixes this problem by fixing register address.
> > 
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > ---
> >  drivers/fpga/dfl-fme-mgr.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> > index 76f3770..b3f7eee 100644
> > --- a/drivers/fpga/dfl-fme-mgr.c
> > +++ b/drivers/fpga/dfl-fme-mgr.c
> > @@ -30,8 +30,8 @@
> >  #define FME_PR_STS		0x10
> >  #define FME_PR_DATA		0x18
> >  #define FME_PR_ERR		0x20
> > -#define FME_PR_INTFC_ID_H	0xA8
> > -#define FME_PR_INTFC_ID_L	0xB0
> > +#define FME_PR_INTFC_ID_L	0xA8
> > +#define FME_PR_INTFC_ID_H	0xB0
> 
> Does this handle endianess correct?

Hi Moritz,

This is just a bug fixing for wrong offsets given to these 2 registers
according to spec. I think this is not endianess related, and per my
understanding we don't need more code on endianess handling as that
should be done inside the readq function already. :)

Thanks
Hao
