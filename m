Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC06DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5A82054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfEFNTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 09:19:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:46398 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfEFNTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:19:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 06:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="155548586"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by FMSMGA003.fm.intel.com with ESMTP; 06 May 2019 06:19:18 -0700
Subject: Re: [PATCH 1/2] usb: xhci: Make it possible to not have a secondary
 HCD (3.0)
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Hoan Tran <hoan@os.amperecomputing.com>
References: <20190502045631.229386-1-drinkcat@chromium.org>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <6844539f-3d5e-e3ff-b498-390cdc731880@linux.intel.com>
Date:   Mon, 6 May 2019 16:21:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190502045631.229386-1-drinkcat@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.5.2019 7.56, Nicolas Boichat wrote:
> Some XHCI controllers may not have any USB 3.0 port, in this case, it
> is not useful to create add hcd->shared_hcd, which has 2 main
> downsides:
>   - A useless USB 3.0 root hub is created.
>   - A warning is thrown on boot:
> hub 2-0:1.0: config failed, hub doesn't have any ports! (err -19)
> 
> The change is mostly about checking if hcd->shared_hcd is NULL before
> accessing it. The one special case is in xhci_run, where we need to
> call xhci_run_finished immediately, if there is no secondary hcd.

To me it looks like this creates an controller starting issue for
xHC hardware that have both usb2 and usb3 ports.

When we have usb3 ports xhci->shared_hcd is not set yet when xhci_run is called
the first time. We will end up starting the xHC before properly setting up the secondary hcd.

See further down for details

> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> This is a respin of https://lore.kernel.org/patchwork/patch/863993/,
> hopefully addressing the comments there. Note that I dropped the change
> in xhci-plat.c, as I do not have a device to test it, but made a
> similar change in xhci-mtk.c, in the next patch.
> 
> (the @apm.com addresses seem to bounce, so I added some
> @amperecomputing.com instead, if somebody there can track back the
> original issue, I'm happy to provide a patch for xhci-plat.c as well)
> 
> drivers/usb/host/xhci-hub.c |  7 ++++--
>   drivers/usb/host/xhci.c     | 45 +++++++++++++++++++++++++++----------
>   2 files changed, 38 insertions(+), 14 deletions(-)
> 

...

> @@ -698,6 +703,10 @@ int xhci_run(struct usb_hcd *hcd)
>   
>   	xhci_debugfs_init(xhci);
>   
> +	/* There is no secondary HCD, start the host controller immediately. */
> +	if (!xhci->shared_hcd)
> +		return xhci_run_finished(xhci);
> +

PCI xHC controllers with both usb2 and usb3 ports will be started before usb3 parts are properly set up.

xhci_pci_probe()
   usb_hcd_pci_probe()
     usb_add_hcd()
       hcd->driver->start(hcd)  // .start = xhci_run
         xhci_run()
           if (!xhci->shared_hcd)  // TRUE as xhci->shared_hcd is not yet set,
	    return xhci_run_finished(xhci)  // starting controller too early here
   xhci->shared_hcd = usb_create_shared_hcd()   // now xhci->shared_hcd is set.

-Mathias
