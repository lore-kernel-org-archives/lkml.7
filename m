Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E59C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCE9218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfCUFtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 01:49:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:35459 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfCUFtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 01:49:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 22:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,251,1549958400"; 
   d="scan'208";a="329243769"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga006.fm.intel.com with SMTP; 20 Mar 2019 22:49:34 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 21 Mar 2019 07:49:33 +0200
Date:   Thu, 21 Mar 2019 07:49:33 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thunderbolt: Fix to check return value of
 ida_simple_get
Message-ID: <20190321054933.GC3622@lahna.fi.intel.com>
References: <20190320162446.30500-1-pakki001@umn.edu>
 <20190320162924.GA3622@lahna.fi.intel.com>
 <78aa904a-6b98-9fb3-e2ca-b9994dc04869@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78aa904a-6b98-9fb3-e2ca-b9994dc04869@codeaurora.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 02:09:41AM +0530, Mukesh Ojha wrote:
> 
> On 3/20/2019 9:59 PM, Mika Westerberg wrote:
> > On Wed, Mar 20, 2019 at 11:24:45AM -0500, Aditya Pakki wrote:
> > > In enumerate_services, ida_simple_get on failure can return an error and
> > > leaks memory during device_register failure. The patch ensures that
> > > the dev_set_name is set on non failure cases, and releases memory in
> > > case of failure.
> > > 
> > > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> > > 
> > > ---
> > > v1: Missed cleanup of svc in case of allocation failure and
> > > device_register failure.
> > > ---
> > >   drivers/thunderbolt/xdomain.c | 9 ++++++++-
> > >   1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
> > > index e27dd8beb94b..eb08275185bf 100644
> > > --- a/drivers/thunderbolt/xdomain.c
> > > +++ b/drivers/thunderbolt/xdomain.c
> > > @@ -740,6 +740,7 @@ static void enumerate_services(struct tb_xdomain *xd)
> > >   	struct tb_service *svc;
> > >   	struct tb_property *p;
> > >   	struct device *dev;
> > > +	int id;
> > >   	/*
> > >   	 * First remove all services that are not available anymore in
> > > @@ -768,7 +769,12 @@ static void enumerate_services(struct tb_xdomain *xd)
> > >   			break;
> > >   		}
> > > -		svc->id = ida_simple_get(&xd->service_ids, 0, 0, GFP_KERNEL);
> > > +		id = ida_simple_get(&xd->service_ids, 0, 0, GFP_KERNEL);
> > > +		if (id < 0) {
> > > +			kfree(svc);
> > > +			break;
> > > +		}
> > > +		svc->id = id;
> > >   		svc->dev.bus = &tb_bus_type;
> > >   		svc->dev.type = &tb_service_type;
> > >   		svc->dev.parent = &xd->dev;
> > > @@ -776,6 +782,7 @@ static void enumerate_services(struct tb_xdomain *xd)
> > >   		if (device_register(&svc->dev)) {
> > >   			put_device(&svc->dev);
> > > +			kfree(svc);
> > You can't do this after device_register() is called. The put_device()
> > above is sufficient.
> 
> 
> If  device_register fails, how would svc gets freed? we need  to kfree svc
> here as well.

Please read the comment on top of device_register(). It should explain.

So no kfree here.
