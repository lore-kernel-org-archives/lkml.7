Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C60C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E441206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfL3CLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 21:11:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:21642 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfL3CLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 21:11:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Dec 2019 18:11:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,373,1571727600"; 
   d="scan'208";a="213198292"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga008.jf.intel.com with ESMTP; 29 Dec 2019 18:11:46 -0800
Date:   Mon, 30 Dec 2019 09:51:40 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     yu kuai <yukuai3@huawei.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawe.com,
        zhengbin13@huawei.com
Subject: Re: [PATCH] fpga: dfl: fme: remove set but not used variable 'fme'
Message-ID: <20191230015140.GA6839@hao-dev>
References: <20191226121638.10507-1-yukuai3@huawei.com>
 <20191227225726.GA1643@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191227225726.GA1643@archbook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 02:57:26PM -0800, Moritz Fischer wrote:
> On Thu, Dec 26, 2019 at 08:16:38PM +0800, yu kuai wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> > 
> > drivers/fpga/dfl-fme-main.c: In function ‘fme_dev_destroy’:
> > drivers/fpga/dfl-fme-main.c:678:18: warning: variable ‘fme’ set but not
> > used [-Wunused-but-set-variable]
> > 
> > It is never used and so can be removed.
> > 
> > Signed-off-by: yu kuai <yukuai3@huawei.com>
> > ---
> >  drivers/fpga/dfl-fme-main.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > index 7c930e6b314d..1d4690c99268 100644
> > --- a/drivers/fpga/dfl-fme-main.c
> > +++ b/drivers/fpga/dfl-fme-main.c
> > @@ -675,10 +675,8 @@ static int fme_dev_init(struct platform_device *pdev)
> >  static void fme_dev_destroy(struct platform_device *pdev)
> >  {
> >  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > -	struct dfl_fme *fme;
> >  
> >  	mutex_lock(&pdata->lock);
> > -	fme = dfl_fpga_pdata_get_private(pdata);
> >  	dfl_fpga_pdata_set_private(pdata, NULL);
> >  	mutex_unlock(&pdata->lock);
> >  }
> > -- 
> > 2.17.2
> > 
> Acked-by: Moritz Fischer <mdf@kernel.org>

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

> 
> Thanks,
> Moritz
