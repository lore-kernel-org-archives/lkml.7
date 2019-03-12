Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4982C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC112054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfCLQCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:02:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:34116 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfCLQCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:02:35 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 82A909AC;
        Tue, 12 Mar 2019 16:02:34 +0000 (UTC)
Date:   Tue, 12 Mar 2019 10:02:33 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hid: logitech: check the return value of
 create_singlethread_workqueue
Message-ID: <20190312100233.106098c8@lwn.net>
In-Reply-To: <20190312061628.13869-1-kjlu@umn.edu>
References: <CAO-hwJLwvZvhPPKU7r74xtKsp_P5VBZ2964iQhgBR5zF-ZM7wg@mail.gmail.com>
        <20190312061628.13869-1-kjlu@umn.edu>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 01:16:28 -0500
Kangjie Lu <kjlu@umn.edu> wrote:

> create_singlethread_workqueue may fail and return NULL. The fix
> checks if it is NULL to avoid NULL pointer dereference.
> Also, the fix moves the call of create_singlethread_workqueue
> earlier to avoid resource-release issues.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

So I don't know this code at all, but...

>  drivers/hid/hid-logitech-hidpp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 15ed6177a7a3..1b7c336cae6d 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2106,6 +2106,12 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> +
> +	/* init the hardware command queue */
> +	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
> +	if (!data->wq)
> +		return -ENOMEM;

It's clear just from the diff that this return will leak 'data'.  You also
break the error handling just below:

>  	data->effect_ids = kcalloc(num_slots, sizeof(int), GFP_KERNEL);
>  	if (!data->effect_ids) {
>  		kfree(data);

It's also worth asking: how are you testing these error path changes?

Thanks,

jon
