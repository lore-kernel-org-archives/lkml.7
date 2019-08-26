Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6265C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FC7217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbfHZPzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:55:43 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41044 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730379AbfHZPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:55:43 -0400
Received: (qmail 4673 invoked by uid 2102); 26 Aug 2019 11:55:42 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Aug 2019 11:55:42 -0400
Date:   Mon, 26 Aug 2019 11:55:42 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     gregkh@linuxfoundation.org, <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] USB: storage: ums-realtek: Make auto-delink
 support optionally
In-Reply-To: <20190826054216.31468-2-kai.heng.feng@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1908261141110.1662-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019, Kai-Heng Feng wrote:

> Auto-delink requires writing special registers to ums-realtek device.
> Unconditionally enable auto-delink may break newer devices.
> 
> So only enable auto-delink by default for the original three IDs,
> 0x0138, 0x0158 and 0x0159.
> 
> Realtek is working on a patch to properly support auto-delink for other
> IDs.
> 
> BugLink: https://bugs.launchpad.net/bugs/1838886
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Use auto_delink_support instead of auto_delink_enable.
> 
> drivers/usb/storage/realtek_cr.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
> index beaffac805af..b304cca7c4fa 100644
> --- a/drivers/usb/storage/realtek_cr.c
> +++ b/drivers/usb/storage/realtek_cr.c
> @@ -40,6 +40,10 @@ static int auto_delink_en = 1;
>  module_param(auto_delink_en, int, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(auto_delink_en, "auto delink mode (0=firmware, 1=software [default])");
>  
> +static int auto_delink_support = -1;
> +module_param(auto_delink_support, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(auto_delink_support, "enable auto delink (-1=auto [default], 0=disable, 1=enable)");
> +
>  #ifdef CONFIG_REALTEK_AUTOPM
>  static int ss_en = 1;
>  module_param(ss_en, int, S_IRUGO | S_IWUSR);
> @@ -996,12 +1000,22 @@ static int init_realtek_cr(struct us_data *us)
>  			goto INIT_FAIL;
>  	}
>  
> -	if (CHECK_FW_VER(chip, 0x5888) || CHECK_FW_VER(chip, 0x5889) ||
> -	    CHECK_FW_VER(chip, 0x5901))
> -		SET_AUTO_DELINK(chip);
> -	if (STATUS_LEN(chip) == 16) {
> -		if (SUPPORT_AUTO_DELINK(chip))
> +	if (auto_delink_support == -1) {
> +		if (CHECK_PID(chip, 0x0138) || CHECK_PID(chip, 0x0158) ||
> +		    CHECK_PID(chip, 0x0159))
> +			auto_delink_support = 1;
> +		else
> +			auto_delink_support = 0;
> +	}

What will happen if somebody has two Realtek devices plugged in, where
one of them has an old product ID and the other has a new one?  You
shouldn't change the value of the module parameter like this.

> +
> +	if (auto_delink_support) {
> +		if (CHECK_FW_VER(chip, 0x5888) || CHECK_FW_VER(chip, 0x5889) ||
> +				CHECK_FW_VER(chip, 0x5901))
>  			SET_AUTO_DELINK(chip);
> +		if (STATUS_LEN(chip) == 16) {
> +			if (SUPPORT_AUTO_DELINK(chip))
> +				SET_AUTO_DELINK(chip);
> +		}
>  	}
>  #ifdef CONFIG_REALTEK_AUTOPM
>  	if (ss_en)

Instead of adding a new module parameter, how about just changing the 
driver's behavior?  If a chip doesn't have the right product ID, don't 
enable auto_delink regardless of what the module parameter is set to.

Alan Stern

