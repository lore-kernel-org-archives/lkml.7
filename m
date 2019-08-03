Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D25EC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 16:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6EC2075C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564849077;
	bh=7LuoxuTmgxKLJEUZnRn7hNP2L5TkeUXj0Gxbss1n3Y8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dsH665UYIWt5NeYmjUO5iX0JwGcSl9ZSdbBWnr4xFB634utjUOwFOvjV6+MFtAvtb
	 bVEPc3OP56XgqCTI6zYyxmQ2DU5uZ2tpWLLrNGJJWsvyT8W9b8EmonoPsmbxP4YcWL
	 zaEHztX/5IVc4fcq/xiux1PCOXIEoi7YRFRPkIkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbfHCQR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 12:17:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387958AbfHCQRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 12:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gu8G8y6Ne0ryjTmF9kVNzse2VVG5LtflJsXjD47kfSE=; b=jXX1dtoyVtUHxbYohmvnyEjxf
        M5gRSf7KQbRDdCt1G2xrGgvnfzeGaUODS73jlHhuEQ+xeIu8nGV7fxTj1zAvjWc2/saKM+EV/msqc
        5ME2bZ5WJnFe4pPUZZyNyDBiP+IPqwVCzKSYPP+swO6xyt5g5FeinAejTBl32oLx1JiCHxNExUHfh
        0Piel9GlHhmG0h2esCM7M25c6G1dThsWOeXoFwEbWCfyiRJ8chZuKcHuDGJKWlp/iS4iTmnUzsi1Z
        8HSDL0HfhUewmzZkdy7O+9OOghZDpuzoDN95i2wZYCgGDMLk8NYLlZvwEfK8VriDMWMgm25VIqXfk
        Y7vqHlUjw==;
Received: from [191.33.150.100] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htwjB-0007VE-PE; Sat, 03 Aug 2019 16:17:54 +0000
Date:   Sat, 3 Aug 2019 13:17:49 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Sean Young <sean@mess.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] media: ir-kbd-i2c: convert to
 i2c_new_dummy_device()
Message-ID: <20190803131749.4d6517ab@coco.lan>
In-Reply-To: <20190730175555.14098-2-wsa+renesas@sang-engineering.com>
References: <20190730175555.14098-1-wsa+renesas@sang-engineering.com>
        <20190730175555.14098-2-wsa+renesas@sang-engineering.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 30 Jul 2019 19:55:54 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> escreveu:

> Convert this driver to use the new i2c_new_dummy_device() call and bail
> out if the dummy device cannot be registered to make failure more
> visible to the user.
> 

Please don't do that.

At first glance, devm_* sounds a good idea, but we had enough issues
using it on media system.

I don't mind mind much if some SoC specific would use it, but doing
it on generic drivers is a very bad idea. We have removed almost all
devm_* calls from the media system.

The problem with devm is that it the de-allocation routines aren't
called during device unbind. They happen a way later, only when the
device itself is physically removed, or the driver is removed.

That caused lots of headaches to debug memory lifetime issues on
media.

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Change since v1:
> 
> * reworded commit message because there was no NULL ptr access
> 
>  drivers/media/i2c/ir-kbd-i2c.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/i2c/ir-kbd-i2c.c b/drivers/media/i2c/ir-kbd-i2c.c
> index 876d7587a1da..f46717052efc 100644
> --- a/drivers/media/i2c/ir-kbd-i2c.c
> +++ b/drivers/media/i2c/ir-kbd-i2c.c
> @@ -885,9 +885,12 @@ static int ir_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	INIT_DELAYED_WORK(&ir->work, ir_work);
>  
>  	if (probe_tx) {
> -		ir->tx_c = i2c_new_dummy(client->adapter, 0x70);
> -		if (!ir->tx_c) {
> +		ir->tx_c = devm_i2c_new_dummy_device(&client->dev,
> +						     client->adapter, 0x70);
> +		if (IS_ERR(ir->tx_c)) {
>  			dev_err(&client->dev, "failed to setup tx i2c address");
> +			err = PTR_ERR(ir->tx_c);
> +			goto err_out_free;
>  		} else if (!zilog_init(ir)) {
>  			ir->carrier = 38000;
>  			ir->duty_cycle = 40;
> @@ -904,9 +907,6 @@ static int ir_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	return 0;
>  
>   err_out_free:
> -	if (ir->tx_c)
> -		i2c_unregister_device(ir->tx_c);
> -
>  	/* Only frees rc if it were allocated internally */
>  	rc_free_device(rc);
>  	return err;
> @@ -919,9 +919,6 @@ static int ir_remove(struct i2c_client *client)
>  	/* kill outstanding polls */
>  	cancel_delayed_work_sync(&ir->work);
>  
> -	if (ir->tx_c)
> -		i2c_unregister_device(ir->tx_c);
> -
>  	/* unregister device */
>  	rc_unregister_device(ir->rc);
>  



Thanks,
Mauro
