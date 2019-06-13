Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EF4C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D562A2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbfFMPjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:39:23 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:40986 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbfFMJy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:54:57 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id DE70225BE4A;
        Thu, 13 Jun 2019 19:54:54 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id E2695940483; Thu, 13 Jun 2019 11:54:52 +0200 (CEST)
Date:   Thu, 13 Jun 2019 11:54:52 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/34] usb: typec: tcpm: fusb302: simplify getting the
 adapter of a client
Message-ID: <20190613095452.qim3khiqcz2iwkbr@verge.net.au>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
 <20190608105619.593-35-wsa+renesas@sang-engineering.com>
 <bb8439e5-f56a-c848-180f-1feddbb198fe@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb8439e5-f56a-c848-180f-1feddbb198fe@roeck-us.net>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 05:59:17AM -0700, Guenter Roeck wrote:
> On 6/8/19 3:56 AM, Wolfram Sang wrote:
> > We have a dedicated pointer for that, so use it. Much easier to read and
> > less computation involved.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> 
> > ---
> > 
> > Please apply to your subsystem tree.
> > 
> >   drivers/usb/typec/tcpm/fusb302.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> > index 7302f7501ec9..c524088246ee 100644
> > --- a/drivers/usb/typec/tcpm/fusb302.c
> > +++ b/drivers/usb/typec/tcpm/fusb302.c
> > @@ -1697,13 +1697,12 @@ static int fusb302_probe(struct i2c_client *client,
> >   			 const struct i2c_device_id *id)
> >   {
> >   	struct fusb302_chip *chip;
> > -	struct i2c_adapter *adapter;
> > +	struct i2c_adapter *adapter = client->adapter;
> >   	struct device *dev = &client->dev;
> >   	const char *name;
> >   	int ret = 0;
> >   	u32 v;
> > -	adapter = to_i2c_adapter(client->dev.parent);
> >   	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK)) {
> >   		dev_err(&client->dev,
> >   			"I2C/SMBus block functionality not supported!\n");
> > 
> 
