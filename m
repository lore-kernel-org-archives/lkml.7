Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A471C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471B3207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfLDRSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:18:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:36334 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfLDRS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:18:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 09:18:28 -0800
X-IronPort-AV: E=Sophos;i="5.69,278,1571727600"; 
   d="scan'208";a="361634696"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 09:18:28 -0800
Message-ID: <f82041432512481569071a83e727cfb9f128126d.camel@linux.intel.com>
Subject: Re: [PATCH] driver core: Fix test_async_driver_probe if NUMA is
 disabled
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Dec 2019 09:18:28 -0800
In-Reply-To: <dfc50096-d95f-8e57-4ba2-3fc122626af8@roeck-us.net>
References: <20191127202453.28087-1-linux@roeck-us.net>
         <4a2aa8554933c2d004761d5f3e8132018be5ea27.camel@linux.intel.com>
         <377feb00-9288-e03c-b8a7-26ba87e24927@roeck-us.net>
         <b5826338cd4479b724835ea5469c5a8318e88e2c.camel@linux.intel.com>
         <dfc50096-d95f-8e57-4ba2-3fc122626af8@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-27 at 16:33 -0800, Guenter Roeck wrote:
> On 11/27/19 3:13 PM, Alexander Duyck wrote:
> > On Wed, 2019-11-27 at 14:42 -0800, Guenter Roeck wrote:
> > > On 11/27/19 1:24 PM, Alexander Duyck wrote:
> > > > On Wed, 2019-11-27 at 12:24 -0800, Guenter Roeck wrote:
> > > > > Since commit 57ea974fb871 ("driver core: Rewrite test_async_driver_probe
> > > > > to cover serialization and NUMA affinity"), running the test with NUMA
> > > > > disabled results in warning messages similar to the following.
> > > > > 
> > > > > test_async_driver test_async_driver.12: NUMA node mismatch -1 != 0
> > > > > 
> > > > > If CONFIG_NUMA=n, dev_to_node(dev) returns -1, and numa_node_id()
> > > > > returns 0. Both are widely used, so it appears risky to change return
> > > > > values. Augment the check with IS_ENABLED(CONFIG_NUMA) instead
> > > > > to fix the problem.
> > > > > 
> > > > > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > > > Fixes: 57ea974fb871 ("driver core: Rewrite test_async_driver_probe to cover serialization and NUMA affinity")
> > > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > > > ---
> > > > >    drivers/base/test/test_async_driver_probe.c | 3 ++-
> > > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
> > > > > index f4b1d8e54daf..3bb7beb127a9 100644
> > > > > --- a/drivers/base/test/test_async_driver_probe.c
> > > > > +++ b/drivers/base/test/test_async_driver_probe.c
> > > > > @@ -44,7 +44,8 @@ static int test_probe(struct platform_device *pdev)
> > > > >    	 * performing an async init on that node.
> > > > >    	 */
> > > > >    	if (dev->driver->probe_type == PROBE_PREFER_ASYNCHRONOUS) {
> > > > > -		if (dev_to_node(dev) != numa_node_id()) {
> > > > > +		if (IS_ENABLED(CONFIG_NUMA) &&
> > > > > +		    dev_to_node(dev) != numa_node_id()) {
> > > > >    			dev_warn(dev, "NUMA node mismatch %d != %d\n",
> > > > >    				 dev_to_node(dev), numa_node_id());
> > > > >    			atomic_inc(&warnings);
> > > > 
> > > > I'm not sure that is really the correct fix. It might be better to test it
> > > > against NUMA_NO_NODE and then if it is not that make sure that it matches
> > > > the node ID. Adding the check against NUMA_NO_NODE would resolve the issue
> > > > for cases where the device might be assigned to multiple NUMA nodes.
> > > > 
> > > I think you are suggesting that dev_to_node(dev) might return NUMA_NO_NODE
> > > even on systems with CONFIG_NUMA enabled. I have no idea if that can happen.
> > > The code in test_async_probe_init() seems to suggest that the node is set
> > > to a valid node id for all asynchronous nodes, so I don't immediately see
> > > how that could be the case. I may be missing something, of course.
> > 
> > Well thinking back to the Nehalem architecture I seem to recall that there
> > were devices that were connected to a shared IOH that was accessible
> > across both nodes. I thought that they might have a node ID of
> > NUMA_NO_NODE since they didn't really belong to either of the two nodes in
> > the sytem.
> > 
> > It would effectively work out the same as your patch compiler wise since
> > dev_to_node would be NUMA_NO_NODE in the non-NUMA case so it would compile
> > out the warning since it would fail the first check, and in the NUMA case
> > it would add an extra check to make sure that dev_to_node is actually
> > indicating the device needs a specific node in the NUMA enabled case.
> > 
> 
> I thought the code is specifically checking devices which it previously
> created, which are well defined and understood test devices. After all,
> the check is in the test driver's probe function. Guess I really don't
> understand the code. Please take my patch as bug report, and submit
> whatever fix you think is correct.

Sorry I had overlooked that this is the test code.

I suppose it should be fine since we specify the node ID for all instances
where we register an asychronous test device.

Thanks.

- Alex

