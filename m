Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D72C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFD62075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbfC0GCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:02:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:12891 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfC0GCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:02:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 23:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="137595271"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga003.jf.intel.com with ESMTP; 26 Mar 2019 23:02:02 -0700
Date:   Wed, 27 Mar 2019 13:46:37 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Scott Wood <swood@redhat.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 03/17] fpga: dfl: fme: support 512bit data width PR
Message-ID: <20190327054637.GC20968@hao-dev>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-4-git-send-email-hao.wu@intel.com>
 <127a9356a7bf597d35dd361f2b16bf80460f0370.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <127a9356a7bf597d35dd361f2b16bf80460f0370.camel@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 05:53:50PM -0500, Scott Wood wrote:
> On Mon, 2019-03-25 at 11:07 +0800, Wu Hao wrote:
> > @@ -200,21 +228,32 @@ static int fme_mgr_write(struct fpga_manager *mgr,
> >  			pr_credit = FIELD_GET(FME_PR_STS_PR_CREDIT,
> > pr_status);
> >  		}
> >  
> > -		if (count < 4) {
> > +		if (count < priv->pr_datawidth) {
> >  			dev_err(dev, "Invalid PR bitstream size\n");
> >  			return -EINVAL;
> 
> Shouldn't this have become a WARN_ON in patch 2 given that the kernel
> already pads the buffer?

Thanks a lot for the review and comments.

I agree. it's better to use WARN_ON this place.

> 
> >  		}
> >  
> > -		pr_data = 0;
> > -		pr_data |= FIELD_PREP(FME_PR_DATA_PR_DATA_RAW,
> > -				      *(((u32 *)buf) + i));
> > -		writeq(pr_data, fme_pr + FME_PR_DATA);
> > -		count -= 4;
> > +		switch (priv->pr_datawidth) {
> > +		case 4:
> > +			pr_data = 0;
> > +			pr_data |= FIELD_PREP(FME_PR_DATA_PR_DATA_RAW,
> > +					*((u32 *)buf));
> 
> I know it's not new, but why not just "pr_data = FIELD..."?  Const should
> also be preserved in the cast, and you can drop one set of parentheses.

Yes, agree, will fix this.

> 
> > +			writeq(pr_data, fme_pr + FME_PR_DATA);
> > +			break;
> > +		case 64:
> > +			copy512((void *)buf, fme_pr + FME_PR_512_DATA);
> > +			break;
> 
> Unnecessary cast.

Will fix this.

> 
> > +		default:
> > +			ret = -EFAULT;
> > +			goto done;
> 
> How is it EFAULT?  Any other value for pr_datawidth should be WARN_ON
> since it's set by kernel code.

Agree, will fix this in the next version.

> 
> > @@ -159,13 +161,10 @@ static int fme_pr(struct platform_device *pdev,
> > unsigned long arg)
> >  		fpga_bridges_put(&region->bridge_list);
> >  
> >  	put_device(&region->dev);
> > -unlock_exit:
> > -	mutex_unlock(&pdata->lock);
> >  free_exit:
> >  	vfree(buf);
> > -	if (copy_to_user((void __user *)arg, &port_pr, minsz))
> > -		return -EFAULT;
> > -
> 
> Why is the copy_to_user being removed?

This code is not needed at all but added by mistake i think.

Sorry, i should move these code into a separated patch with proper comments
to avoid confusion.

Thanks
Hao

> 
> -Scott
