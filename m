Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC89CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA6E208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbfJ1Ju4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:50:56 -0400
Received: from gofer.mess.org ([88.97.38.141]:38529 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730038AbfJ1Ju4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:50:56 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 63C7CC6394; Mon, 28 Oct 2019 09:50:54 +0000 (GMT)
Date:   Mon, 28 Oct 2019 09:50:54 +0000
From:   Sean Young <sean@mess.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dvb: Fix memory leak in af9005_identify_state
Message-ID: <20191028095054.GB25747@gofer.mess.org>
References: <20191027222438.16208-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027222438.16208-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 05:24:35PM -0500, Navid Emamdoost wrote:
> In the implementation of af9005_identify_state() there is a memory leak
> when checking the reply of af9005_boot_packet(). Go to error path to
> release buf.
> 
> Fixes: af4e067e1dcf ("V4L/DVB (5625): Add support for the AF9005 demodulator from Afatech")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Thank you for the patch.

Unfortunately a similar patch is already merged:

https://git.linuxtv.org/media_tree.git/commit/?id=2289adbfa559050d2a38bcd9caac1c18b800e928

Sean

> ---
>  drivers/media/usb/dvb-usb/af9005.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/dvb-usb/af9005.c b/drivers/media/usb/dvb-usb/af9005.c
> index 02697d86e8c1..cfaf630be4d8 100644
> --- a/drivers/media/usb/dvb-usb/af9005.c
> +++ b/drivers/media/usb/dvb-usb/af9005.c
> @@ -975,8 +975,10 @@ static int af9005_identify_state(struct usb_device *udev,
>  		*cold = 1;
>  	else if (reply == 0x02)
>  		*cold = 0;
> -	else
> -		return -EIO;
> +	else {
> +		ret = -EIO;
> +		goto err;
> +	}
>  	deb_info("Identify state cold = %d\n", *cold);
>  
>  err:
> -- 
> 2.17.1
