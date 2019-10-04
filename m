Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A54C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0580C20862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Ji0Vq67R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mj9KMh+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbfJDMAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:00:04 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38261 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728219AbfJDMAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:00:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E079C2134B;
        Fri,  4 Oct 2019 07:59:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 04 Oct 2019 07:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=frl/vm4h86LNbeoJ/taoBPTtQ1g
        C7KmqOyW9f93NFGg=; b=Ji0Vq67Rh4PJLGXNIzPkvLzWK3KsedwzhH644ARAXEd
        x3Xc97KIHq7K/epUyYQNE0d8v7V7+BauvUFAwPRt5VGC9cE7q5tamJmpZ7pQ/qod
        hdI+yW/WhAgwk2RCcGmT6RqKtYcq+UlVK4eUlYfIVu+dXZ3HlQJzDG9Kf5gedTbx
        w+DLQpX0Sl4XiKtwStpDmVzo6AuLyc3EWnoJL1aqzvOjkMEJgQbNQi8jkXdwdC6h
        w+4c5yYBMdeP7tEZEFqKdKPHY/fy2nY2fwTU1lXIs0Oh9rIJzYHwE6bEvHoDZm72
        XjrxNYWhYoMfTK1dvIkrad39pxSLeJs6ox/sgY6DY0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=frl/vm
        4h86LNbeoJ/taoBPTtQ1gC7KmqOyW9f93NFGg=; b=Mj9KMh+Z7dxpMwNcKJKrkd
        jiamMqKL8SX73UuQWQIPBICWILoZ5kCRicJQEPxEpIOUwqt6b9bH/6gm6PE/VwT4
        AvUHvbgsVOyTnljOeZJJbrkgeg2qcus3216eAOdIAluRqWyspyxDfEBAwWx+W+uq
        nsDpT76nfn14ad+WYUc6PmHwEL50wEOGcX8nI7isyzzTMdNUzAkPo6erOAHshzfL
        j8cYUIftSoZuO835BXOX6N4OKorG39r+KgsPcp0FXK/44pAj45QMLJ8bZWIzhHZT
        ywGtYxKPcVaVQLk8Z7stVa5KE5jCr5o85S67Vs+PqjITxnqwp3wz0gtHiV4m1n8Q
        ==
X-ME-Sender: <xms:PzSXXWuB9XR8Z8lFUXlARaHIfS0sV1l7W4pUaETA9oNl04pPARh1vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrhedugdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:PzSXXc_YUzrXFVphGL--waTrHDXg94GG1MlxHI78KdSQvVVjwl7rFg>
    <xmx:PzSXXfYi962AqYgRwzGmzGZzE17HpKUF6c0to7FR2b7GsXOePzl6zg>
    <xmx:PzSXXYqZKrdw4xuI5atx_qvmq4zzH7bWgP3rUMOi5VdU4ojilhlxsA>
    <xmx:PzSXXU9mevn65kDGdVcvjvzIMNvKNI6bjmKAB6V5VoMKOcIJq6r62w>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 27D6680064;
        Fri,  4 Oct 2019 07:59:59 -0400 (EDT)
Date:   Fri, 4 Oct 2019 13:59:57 +0200
From:   Greg KH <greg@kroah.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
        dianders@chromium.org, Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: btusb: Reset realtek devices on user
 suspend
Message-ID: <20191004115957.GB339043@kroah.com>
References: <20190917212702.35747-1-abhishekpandit@chromium.org>
 <20190917212702.35747-3-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917212702.35747-3-abhishekpandit@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 02:27:02PM -0700, Abhishek Pandit-Subedi wrote:
> Reset realtek devices on user suspend if not configured as a wakeup source.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
>  drivers/bluetooth/btusb.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a9c35ebb30f8..ce3a10642f4e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -493,6 +493,8 @@ struct btusb_data {
>  
>  	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
>  	unsigned cmd_timeout_cnt;
> +
> +	bool reset_on_suspend; /* reset on suspend if not a wakeup source */
>  };
>  
>  
> @@ -3818,6 +3820,8 @@ static int btusb_probe(struct usb_interface *intf,
>  		 * (DEVICE_REMOTE_WAKEUP)
>  		 */
>  		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
> +		/* We'll explicitly reset the device around user suspend too. */
> +		data->reset_on_suspend = true;
>  	}
>  #endif
>  
> @@ -4007,6 +4011,22 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>  	return 0;
>  }
>  
> +static int btusb_suspend_noirq(struct usb_interface *intf, pm_message_t message)
> +{
> +	struct btusb_data *data = usb_get_intfdata(intf);
> +
> +	BT_DBG("suspend_noirq %p", intf);
> +
> +	/* Only reset if not configured for wakeup */
> +	if (!device_may_wakeup(&data->udev->dev) &&
> +	    data->reset_on_suspend && data->reset_gpio) {
> +		BT_DBG("resetting in suspend_noirq\n");
> +		gpiod_set_value_cansleep(data->reset_gpio, 1);

That's a totally out-of-band message for a USB driver to do.  Why can it
suddenly set a GPIO pin and not talk to the USB device here?

If this is a GPIO driver, then why not get the suspend message from that
subsystem?


greg k-h
