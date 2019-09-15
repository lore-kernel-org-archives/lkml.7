Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A33C4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF3521479
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="IaBIg9Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfIONbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 09:31:14 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:2937 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfIONbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 09:31:13 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 0C70620361;
        Sun, 15 Sep 2019 15:31:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1568554268; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbHUZffN/lv6bdaRhbcUqjUt4bMuEhtD9udAascLPZw=;
        b=IaBIg9JfnouBoriu06F8wwAe5gcahbjtfIzFWPeZL8bS2KirdhrbD0Mgrj4oge4c7fL1bW
        jC9UAYIXMwtRh50ynleEOBwypVMxkWVsyqRfSOr4/7YnKd/LdxKvRquv9rTsyumOaMoNN3
        fxKUZXHYR5dFhTKFw1Amt7ubRoBSxGFJqvz8puS9JBSuREjppJA7dTBij/rN6fsbuL6qx9
        kEnvrWeoBg4UU+mvnV2P/VKX1P0o4lMKWN5jkEbjEZu7lrd/pm1a5JejuC9OvzAbggWMTL
        KJ5+278kPc+kiYqtJRhPKSX0vdxMLtbuchJYbQGKNYO58V+7OrZ+Zzx/OQ1wNA==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id C3BD5BEEBD;
        Sun, 15 Sep 2019 15:31:07 +0200 (CEST)
Message-ID: <5D7E3D1A.5070906@bfs.de>
Date:   Sun, 15 Sep 2019 15:31:06 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Mao Wenan <maowenan@huawei.com>
CC:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usbip: vhci_hcd indicate failed message
References: <20190915034332.21168-1-maowenan@huawei.com>
In-Reply-To: <20190915034332.21168-1-maowenan@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.999,0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[gmail.com];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         RCVD_COUNT_TWO(0.00)[2]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 15.09.2019 05:43, schrieb Mao Wenan:
> If the return value of vhci_init_attr_group and
> sysfs_create_group is non-zero, which mean they failed
> to init attr_group and create sysfs group, so it would
> better add 'failed' message to indicate that.
> 
> Fixes: 0775a9cbc694 ("usbip: vhci extension: modifications to vhci driver")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/usb/usbip/vhci_hcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 000ab7225717..dd54c95d2498 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -1185,12 +1185,12 @@ static int vhci_start(struct usb_hcd *hcd)
>  	if (id == 0 && usb_hcd_is_primary_hcd(hcd)) {
>  		err = vhci_init_attr_group();
>  		if (err) {
> -			pr_err("init attr group\n");
> +			pr_err("init attr group failed\n");
>  			return err;
>  		}
>  		err = sysfs_create_group(&hcd_dev(hcd)->kobj, &vhci_attr_group);
>  		if (err) {
> -			pr_err("create sysfs files\n");
> +			pr_err("create sysfs failed\n");

I guess "sysfs files" is here intended ?

re,
 wh

>  			vhci_finish_attr_group();
>  			return err;
>  		}
