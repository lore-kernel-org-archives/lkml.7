Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAA6C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F40020828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbfH0S4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:56:38 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40400 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730486AbfH0S4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:56:38 -0400
Received: (qmail 1525 invoked by uid 2102); 27 Aug 2019 14:56:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Aug 2019 14:56:36 -0400
Date:   Tue, 27 Aug 2019 14:56:36 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     gregkh@linuxfoundation.org, <bauer.chen@realtek.com>,
        <ricky_wu@realtek.com>, <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] USB: storage: ums-realtek: Whitelist auto-delink
 support
In-Reply-To: <20190827173450.13572-2-kai.heng.feng@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1908271454110.1545-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019, Kai-Heng Feng wrote:

> Auto-delink requires writing special registers to ums-realtek devices.
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
> v3:
> - Whitelisting instead of adding new module parameter.
> v2:
> - Use auto_delink_support instead of auto_delink_enable.
> 
>  drivers/usb/storage/realtek_cr.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
> index beaffac805af..1d9ce9cbc831 100644
> --- a/drivers/usb/storage/realtek_cr.c
> +++ b/drivers/usb/storage/realtek_cr.c
> @@ -996,12 +996,15 @@ static int init_realtek_cr(struct us_data *us)
>  			goto INIT_FAIL;
>  	}
>  
> -	if (CHECK_FW_VER(chip, 0x5888) || CHECK_FW_VER(chip, 0x5889) ||
> -	    CHECK_FW_VER(chip, 0x5901))
> -		SET_AUTO_DELINK(chip);
> -	if (STATUS_LEN(chip) == 16) {
> -		if (SUPPORT_AUTO_DELINK(chip))
> +	if (CHECK_PID(chip, 0x0138) || CHECK_PID(chip, 0x0158) ||
> +	    CHECK_PID(chip, 0x0159)) {
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

For both patches in this series:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Shouldn't this patch go into the -stable kernels as well?

Alan Stern

