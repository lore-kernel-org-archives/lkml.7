Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE86C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D0820640
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfJAL5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:57:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:51834 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfJAL5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:57:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="366307307"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 01 Oct 2019 04:57:07 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iFGm9-0008Lf-SJ; Tue, 01 Oct 2019 14:57:05 +0300
Date:   Tue, 1 Oct 2019 14:57:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v1 3/4] [media] usb: pulse8-cec: Switch to use %ptT
Message-ID: <20191001115705.GK32742@smile.fi.intel.com>
References: <20190104193009.30907-1-andriy.shevchenko@linux.intel.com>
 <20190104193009.30907-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104193009.30907-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 09:30:08PM +0200, Andy Shevchenko wrote:
> Use %ptT instead of open coded variant to print content of
> time64_t type in human readable format.

Hans, any objections on this?

> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/usb/pulse8-cec/pulse8-cec.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/media/usb/pulse8-cec/pulse8-cec.c b/drivers/media/usb/pulse8-cec/pulse8-cec.c
> index b085b14f3f87..05f997e9ce28 100644
> --- a/drivers/media/usb/pulse8-cec/pulse8-cec.c
> +++ b/drivers/media/usb/pulse8-cec/pulse8-cec.c
> @@ -328,7 +328,6 @@ static int pulse8_setup(struct pulse8 *pulse8, struct serio *serio,
>  	u8 *data = pulse8->data + 1;
>  	u8 cmd[2];
>  	int err;
> -	struct tm tm;
>  	time64_t date;
>  
>  	pulse8->vers = 0;
> @@ -349,10 +348,7 @@ static int pulse8_setup(struct pulse8 *pulse8, struct serio *serio,
>  	if (err)
>  		return err;
>  	date = (data[0] << 24) | (data[1] << 16) | (data[2] << 8) | data[3];
> -	time64_to_tm(date, 0, &tm);
> -	dev_info(pulse8->dev, "Firmware build date %04ld.%02d.%02d %02d:%02d:%02d\n",
> -		 tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> -		 tm.tm_hour, tm.tm_min, tm.tm_sec);
> +	dev_info(pulse8->dev, "Firmware build date %ptT\n", &date);
>  
>  	dev_dbg(pulse8->dev, "Persistent config:\n");
>  	cmd[0] = MSGCODE_GET_AUTO_ENABLED;
> -- 
> 2.19.2
> 

-- 
With Best Regards,
Andy Shevchenko


