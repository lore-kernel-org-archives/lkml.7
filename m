Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C583C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFBC21874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbfHHLVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:21:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:64335 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731312AbfHHLVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:21:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 04:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="374820094"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2019 04:20:57 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hvgTY-0001uN-8N; Thu, 08 Aug 2019 14:20:56 +0300
Date:   Thu, 8 Aug 2019 14:20:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jslaby@suse.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com
Subject: Re: [PATCH v2 1/3] serial: lantiq: Use proper DT compatible string
Message-ID: <20190808112056.GK30120@smile.fi.intel.com>
References: <cover.1565257887.git.rahul.tanwar@linux.intel.com>
 <57e2b69e9fbd93328a477b4c7dd2dcc78784ecb1.1565257887.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e2b69e9fbd93328a477b4c7dd2dcc78784ecb1.1565257887.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 06:02:06PM +0800, Rahul Tanwar wrote:
> Use explicit string instead of a macro for devicetree compatible string.
> 
> This series of patches is to add support for multiple SoCs which reuse the same
> serial controller IP. The following patches will add another compatible string
> to support new Lightning Mountain(LGM) SoC. So it makes sense to have the
> compatible strings explicitly mentioned instead of a fixed macro.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  drivers/tty/serial/lantiq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 42e27b48e9cc..660d21db57dc 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -693,7 +693,7 @@ lqasc_serial_early_console_setup(struct earlycon_device *device,
>  	device->con->write = lqasc_serial_early_console_write;
>  	return 0;
>  }
> -OF_EARLYCON_DECLARE(lantiq, DRVNAME, lqasc_serial_early_console_setup);
> +OF_EARLYCON_DECLARE(lantiq, "lantiq,asc", lqasc_serial_early_console_setup);
>  
>  static struct uart_driver lqasc_reg = {
>  	.owner =	THIS_MODULE,
> @@ -792,7 +792,7 @@ lqasc_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id ltq_asc_match[] = {
> -	{ .compatible = DRVNAME },
> +	{ .compatible = "lantiq,asc" },
>  	{},
>  };
>  
> -- 
> 2.11.0
> 

-- 
With Best Regards,
Andy Shevchenko


