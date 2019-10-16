Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D34DC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEF620872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfJPIxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:53:37 -0400
Received: from gofer.mess.org ([88.97.38.141]:44443 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391694AbfJPIxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:53:37 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 6D812C6389; Wed, 16 Oct 2019 09:53:34 +0100 (BST)
Date:   Wed, 16 Oct 2019 09:53:34 +0100
From:   Sean Young <sean@mess.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+98730b985cad4931a552@syzkaller.appspotmail.com
Subject: Re: [PATCH] media: cxusb: fix uninitialized local variable
Message-ID: <20191016085334.GA1345@gofer.mess.org>
References: <20191015200315.28830-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015200315.28830-1-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

Thank you for your patch.

On Tue, Oct 15, 2019 at 10:03:15PM +0200, Valentin Vidic wrote:
> Make sure ircode does not contain random values if the call to
> cxusb_ctrl_msg fails for some reason.
> 
> Reported-by: syzbot+98730b985cad4931a552@syzkaller.appspotmail.com
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
>  drivers/media/usb/dvb-usb/cxusb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/usb/dvb-usb/cxusb.c b/drivers/media/usb/dvb-usb/cxusb.c
> index f02fa0a67aa4..afcd88dd96c0 100644
> --- a/drivers/media/usb/dvb-usb/cxusb.c
> +++ b/drivers/media/usb/dvb-usb/cxusb.c
> @@ -519,7 +519,7 @@ static int cxusb_d680_dmb_streaming_ctrl(struct dvb_usb_adapter *adap,
>  
>  static int cxusb_rc_query(struct dvb_usb_device *d)
>  {
> -	u8 ircode[4];
> +	u8 ircode[4] = { 0 };
>  
>  	cxusb_ctrl_msg(d, CMD_GET_IR_CODE, NULL, 0, ircode, 4);

The correct to do here is check the return value of cxusb_ctrl_msg() and
to not proceed if it failed, rather than assume the value of 0.

Also note that:

	https://patchwork.linuxtv.org/patch/59448/

Is already being merged.

Thanks
Sean

>  
> @@ -531,7 +531,7 @@ static int cxusb_rc_query(struct dvb_usb_device *d)
>  
>  static int cxusb_bluebird2_rc_query(struct dvb_usb_device *d)
>  {
> -	u8 ircode[4];
> +	u8 ircode[4] = { 0 };
>  	struct i2c_msg msg = {
>  		.addr = 0x6b,
>  		.flags = I2C_M_RD,
> @@ -550,7 +550,7 @@ static int cxusb_bluebird2_rc_query(struct dvb_usb_device *d)
>  
>  static int cxusb_d680_dmb_rc_query(struct dvb_usb_device *d)
>  {
> -	u8 ircode[2];
> +	u8 ircode[2] = { 0 };
>  
>  	if (cxusb_ctrl_msg(d, 0x10, NULL, 0, ircode, 2) < 0)
>  		return 0;
> @@ -989,7 +989,7 @@ static int cxusb_dee1601_frontend_attach(struct dvb_usb_adapter *adap)
>  
>  static int cxusb_dualdig4_frontend_attach(struct dvb_usb_adapter *adap)
>  {
> -	u8 ircode[4];
> +	u8 ircode[4] = { 0 };
>  	int i;
>  	struct i2c_msg msg = {
>  		.addr = 0x6b,
> -- 
> 2.20.1
