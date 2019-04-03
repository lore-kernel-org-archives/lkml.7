Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7B7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374172082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfDCL30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:29:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:62966 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfDCL3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:29:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 04:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,304,1549958400"; 
   d="scan'208";a="157832705"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 03 Apr 2019 04:29:24 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hBe55-0001gv-Gl; Wed, 03 Apr 2019 14:29:23 +0300
Date:   Wed, 3 Apr 2019 14:29:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] driver core: platform: Propagate error from
 insert_resource()
Message-ID: <20190403112923.GV9224@smile.fi.intel.com>
References: <20190402155914.78166-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0hCrpyxJzMOQXthHkqLBaYBH44f_XsHy-YUfxxUU_o41w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hCrpyxJzMOQXthHkqLBaYBH44f_XsHy-YUfxxUU_o41w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 06:02:40PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 2, 2019 at 5:59 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Since insert_resource() might return an error we don't need
> > to shadow its error code and would safely propagate to the user.

> > -               if (p && insert_resource(p, r)) {
> > +               if (p && (ret = insert_resource(p, r))) {
> 
> I would put the assignment here.
> 
> >                         dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
> > -                       ret = -EBUSY;
> >                         goto failed;
> >                 }

Something like this?

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index dab0a5abc391..9cf9e2af9efd 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -438,10 +438,12 @@ int platform_device_add(struct platform_device *pdev)
                                p = &ioport_resource;
                }

-               if (p && insert_resource(p, r)) {
-                       dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
-                       ret = -EBUSY;
-                       goto failed;
+               if (p) {
+                       ret = insert_resource(p, r);
+                       if (ret) {
+                               dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
+                               goto failed;
+                       }
                }
        }


-- 
With Best Regards,
Andy Shevchenko


