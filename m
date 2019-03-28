Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56A0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEF421773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfC1K2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:28:04 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44657 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC1K2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:28:04 -0400
Received: from 79.184.253.239.ipv4.supernova.orange.pl (79.184.253.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id eacf11ca285716ea; Thu, 28 Mar 2019 11:28:01 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Shaunak Saha <shaunak.saha@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - signal wakeup from atkbd/psmouse
Date:   Thu, 28 Mar 2019 11:26:02 +0100
Message-ID: <2013760.MOPEFL89cj@aspire.rjw.lan>
In-Reply-To: <20190327002800.GA187083@dtor-ws>
References: <20190327002800.GA187083@dtor-ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 27, 2019 1:28:00 AM CET Dmitry Torokhov wrote:
> Instead of signalling wakeup directly from i8042, let psmouse and atkbd
> drivers execute basic protocol handling and only then signal wakeup
> condition. This solves the issue where we increment wakeup counter
> simply because we are getting responses from keyboard/mouse to the
> commands we ourselves send to them as part of suspend transition.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

LGTM:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/input/keyboard/atkbd.c     | 2 ++
>  drivers/input/mouse/psmouse-base.c | 2 ++
>  drivers/input/serio/i8042.c        | 3 ---
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index 850bb259c20e..3ad93e3e2f4c 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -401,6 +401,8 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
>  		if  (ps2_handle_response(&atkbd->ps2dev, data))
>  			goto out;
>  
> +	pm_wakeup_event(&serio->dev, 0);
> +
>  	if (!atkbd->enabled)
>  		goto out;
>  
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index d3ff1fc09af7..94f7ca5ad077 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -373,6 +373,8 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
>  		if  (ps2_handle_response(&psmouse->ps2dev, data))
>  			goto out;
>  
> +	pm_wakeup_event(&serio->dev, 0);
> +
>  	if (psmouse->state <= PSMOUSE_RESYNCING)
>  		goto out;
>  
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 95a78ccbd847..6462f1798fbb 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -573,9 +573,6 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
>  	port = &i8042_ports[port_no];
>  	serio = port->exists ? port->serio : NULL;
>  
> -	if (irq && serio)
> -		pm_wakeup_event(&serio->dev, 0);
> -
>  	filter_dbg(port->driver_bound, data, "<- i8042 (interrupt, %d, %d%s%s)\n",
>  		   port_no, irq,
>  		   dfl & SERIO_PARITY ? ", bad parity" : "",
> 


