Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADA3C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C916B206E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGE1sAI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKMVri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:47:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38520 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMVri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:47:38 -0500
Received: by mail-oi1-f193.google.com with SMTP id a14so3275956oid.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Pc7cQHv8eKuylt4BamVYue24j7XUatjlDeaalEngXsI=;
        b=ZGE1sAI1FX/0817aF8CL0cOgRiiuy79SHphe7PDD6X619//0CimbipWKjj9OxHourt
         50kArF0uxa5fpyvxkc7WSr6sgRAODjMcvNMOAoCeVLbMZUQvjA4GmU+c9FTN91MOve7e
         dfpVyrSTAsxtcaR1FNfGB6y2ddpHtRJ3dX9vjiAJWsq9t+8ENSgITp2CjoiSwaR/0ufJ
         JXLcyy+F82/xbdX/0jIYxHWwlQLk3rIp6iYkbtVh/SX0PgsjBK6k/WdopKnyLdBcQ3te
         k3jGg57bcdeHlAe+A3cTEQkbBsxlpqFxyEjzr2mMw7kjDO7j6wvQ9IBysUlBBEhsvwMm
         ICFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Pc7cQHv8eKuylt4BamVYue24j7XUatjlDeaalEngXsI=;
        b=KC0gijl0DF8nmqOGQHUOHwX4hcquAZHEz39tgt7eqtFFmyit89MqVWpOzjh0TSk95D
         rWfK8xu1HWY+0zRDrN2Ka111Vi34QgjFF+JKrHvpqpALf4ZAHj8ymb2Cl877LIf7s6EB
         EPVxmsZ4gsZrBYumcYmbGWIp60P2yuP9EvCx2mbMyd5T3wbnoFT0sU/bRmSrDP78E7+/
         nSDQ5OVuSguVBr+KJRm4qQfIr6EA5AKM7K3TPvwD1bL6syGTr9cM+gn4ibSp9mQHImnC
         F6tojwEMeX34Gyjir+iTLqXP7BFDPmyhLR/4SKOvFcNWt+WITniLZkQ10348LKj1FU4b
         NdcQ==
X-Gm-Message-State: APjAAAW+clG3rs5oGngU10ttdYM+iJGj2kZgsKNx/Q55lWKQrM8eAaZ0
        +vlQO6/ryiMHwwID4hTFkQ==
X-Google-Smtp-Source: APXvYqx/I0MG+m8QXEYTbGrRDCwsZsePNxEluLbGTyay3HgyRFUDS13Sfo9kWINqSu4vuRC9aHbZvA==
X-Received: by 2002:aca:da02:: with SMTP id r2mr740190oig.172.1573681655999;
        Wed, 13 Nov 2019 13:47:35 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id d205sm1122028oig.28.2019.11.13.13.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:47:35 -0800 (PST)
Received: from minyard.net (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id 9C9C1180046;
        Wed, 13 Nov 2019 21:47:34 +0000 (UTC)
Date:   Wed, 13 Nov 2019 15:47:33 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Asmaa Mnebhi <Asmaa@mellanox.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cminyard@mvista.com" <cminyard@mvista.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>
Subject: Re: [PATCH v3] drivers: ipmi: Support raw i2c packet in IPMB
Message-ID: <20191113214733.GO2882@minyard.net>
Reply-To: minyard@acm.org
References: <20191113192325.2821207-1-vijaykhemka@fb.com>
 <DB6PR0501MB2712FAF45EE8CB2D513465A9DA760@DB6PR0501MB2712.eurprd05.prod.outlook.com>
 <AC2A7BB8-52D0-4CAF-9C72-58C9CF5A4F55@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AC2A7BB8-52D0-4CAF-9C72-58C9CF5A4F55@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 09:28:10PM +0000, Vijay Khemka wrote:
> 
> 
> ﻿On 11/13/19, 12:33 PM, "Asmaa Mnebhi" <Asmaa@mellanox.com> wrote:
> 
>     Inline response:
>     
>     -----Original Message-----
>     From: Vijay Khemka <vijaykhemka@fb.com> 
>     Sent: Wednesday, November 13, 2019 2:23 PM
>     To: Corey Minyard <minyard@acm.org>; Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; openipmi-developer@lists.sourceforge.net; linux-kernel@vger.kernel.org
>     Cc: vijaykhemka@fb.com; cminyard@mvista.com; Asmaa Mnebhi <Asmaa@mellanox.com>; joel@jms.id.au; linux-aspeed@lists.ozlabs.org; sdasari@fb.com
>     Subject: [PATCH v3] drivers: ipmi: Support raw i2c packet in IPMB
>     
>     Many IPMB devices doesn't support smbus protocol and current driver support only smbus devices. Added support for raw i2c packets.
>     
>     User can define use-i2c-block in device tree to use i2c raw transfer.
>     
>     Asmaa>> Fix the description: "The ipmb_dev_int driver only supports the smbus protocol at the moment. Add support for the i2c protocol as well. There will be a variable passed by though the device tree or ACPI table which sets the configures the protocol as either i2c or smbus."
>     
>     Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>     ---
>      drivers/char/ipmi/ipmb_dev_int.c | 48 ++++++++++++++++++++++++++++++++
>      1 file changed, 48 insertions(+)
>     
>     diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
>     index ae3bfba27526..16d5d4b636a9 100644
>     --- a/drivers/char/ipmi/ipmb_dev_int.c
>     +++ b/drivers/char/ipmi/ipmb_dev_int.c
>     @@ -63,6 +63,7 @@ struct ipmb_dev {
>      	spinlock_t lock;
>      	wait_queue_head_t wait_queue;
>      	struct mutex file_mutex;
>     +	bool use_i2c;
>      };
>      
>     Asmaa>> rename this variable : is_i2c_protocol
> Done.
>     
>      static inline struct ipmb_dev *to_ipmb_dev(struct file *file) @@ -112,6 +113,39 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
>      	return ret < 0 ? ret : count;
>      }
>      
>     +static int ipmb_i2c_write(struct i2c_client *client, u8 *msg) {
>     +	unsigned char *i2c_buf;
>     +	struct i2c_msg i2c_msg;
>     +	ssize_t ret;
>     +	u8 msg_len;
>     +
>     +	/*
>     +	 * subtract 1 byte (rq_sa) from the length of the msg passed to
>     +	 * raw i2c_transfer
>     +	 */
>     +	msg_len = msg[IPMB_MSG_LEN_IDX] - 1;
>     +
>     +	i2c_buf = kzalloc(msg_len, GFP_KERNEL);
>     
>     Asmaa >> We do not want to use kzalloc every time you execute this write function. It would create so much fragmentation.
>     You don't really need to use kzalloc anyways. 
> We need to allocate memory to pass to i2c_transfer. That's what being done in i2c_smbus_xfer function as well.
>     
>     Also, this code chunk is short, so you can call it directly from the write function. I don't think you need a separate function for it.
> I wanted to keep this change as clean as possible.

I'd agree.  Fragmentation is not a big deal here.

However, why not just pass in msg + 2?  That would be cleaner, faster,
and less wasteful.

>     
>     +	if (!i2c_buf)
>     +		return -EFAULT;

-ENOMEM?  (Assuming you keep the malloc)

>     +
>     +	/* Copy message to buffer except first 2 bytes (length and address) */
>     +	memcpy(i2c_buf, msg+2, msg_len);
>     +
>     +	i2c_msg.addr = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
>     +	i2c_msg.flags = client->flags &
>     +			(I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB);
>     Asmaa>> I don't think ipmb supports 10 bit addresses. The max number of bits in the IPMB address field is 8.
> Done.
>     
>     +	i2c_msg.len = msg_len;
>     +	i2c_msg.buf = i2c_buf;
>     +
>     +	ret = i2c_transfer(client->adapter, &i2c_msg, 1);
>     +	kfree(i2c_buf);
>     +
>     +	return ret;
>     +
>     +}
>     +
>      static ssize_t ipmb_write(struct file *file, const char __user *buf,
>      			size_t count, loff_t *ppos)
>      {
>     @@ -133,6 +167,12 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
>      	rq_sa = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
>      	netf_rq_lun = msg[NETFN_LUN_IDX];
>      
>     +	/* Check i2c block transfer vs smbus */
>     +	if (ipmb_dev->use_i2c) {
>     +		ret = ipmb_i2c_write(ipmb_dev->client, msg);
>     +		return (ret == 1) ? count : ret;
>     +	}
>     +
>      	/*
>      	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
>      	 * i2c_smbus_xfer
>     @@ -277,6 +317,7 @@ static int ipmb_probe(struct i2c_client *client,
>      			const struct i2c_device_id *id)
>      {
>      	struct ipmb_dev *ipmb_dev;
>     +	struct device_node *np;
>      	int ret;
>      
>      	ipmb_dev = devm_kzalloc(&client->dev, sizeof(*ipmb_dev), @@ -302,6 +343,13 @@ static int ipmb_probe(struct i2c_client *client,
>      	if (ret)
>      		return ret;
>      
>     +	/* Check if i2c block xmit needs to use instead of smbus */
>     +	np = client->dev.of_node;
>     +	if (np && of_get_property(np, "use-i2c-block", NULL))
>     Asmaa>> Rename this variable i2c-protocol. And also, apply this to ACPI as well.
> Done.

I don't think ACPI is that important at the moment.  Rename is good.

>     +		ipmb_dev->use_i2c = true;
>     +	else
>     +		ipmb_dev->use_i2c = false;

The above two lines are unnecessary.

-corey

>     +
>      	ipmb_dev->client = client;
>      	i2c_set_clientdata(client, ipmb_dev);
>      	ret = i2c_slave_register(client, ipmb_slave_cb);
>     --
>     2.17.1
>     
>     
> 
