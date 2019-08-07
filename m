Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B733CC31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CF3216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfHGDCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 23:02:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:3663 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfHGDCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 23:02:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 20:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,356,1559545200"; 
   d="scan'208";a="374258437"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2019 20:02:29 -0700
Date:   Wed, 7 Aug 2019 10:45:22 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Luwei Kang <luwei.kang@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v4 11/12] fpga: dfl: fme: add global error reporting
 support
Message-ID: <20190807024521.GD24158@hao-dev>
References: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
 <1564914022-3710-12-git-send-email-hao.wu@intel.com>
 <20190805155626.GD8107@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805155626.GD8107@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 05:56:26PM +0200, Greg KH wrote:
> On Sun, Aug 04, 2019 at 06:20:21PM +0800, Wu Hao wrote:
> > +static int fme_global_err_init(struct platform_device *pdev,
> > +			       struct dfl_feature *feature)
> > +{
> > +	struct device *dev;
> > +	int ret = 0;
> > +
> > +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> > +	if (!dev)
> > +		return -ENOMEM;
> > +
> > +	dev->parent = &pdev->dev;
> > +	dev->release = err_dev_release;
> > +	dev_set_name(dev, "errors");
> > +
> > +	fme_error_enable(feature);
> > +
> > +	ret = device_register(dev);
> > +	if (ret) {
> > +		put_device(dev);
> > +		return ret;
> > +	}
> > +
> > +	ret = device_add_groups(dev, error_groups);
> 
> cute, but no, you do not create a whole struct device for a subdir.  Use
> the attribute group name like you did on earlier patches.

Sure, let me fix it in the next version.

> 
> And again, you raced userspace and lost :(

Same here, could you please give some more hints here?

Thanks in advance.
Hao

> 
> thanks,
> 
> greg k-h
