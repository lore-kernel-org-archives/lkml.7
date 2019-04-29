Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944C0C04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6158A21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kG4T7EV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfD2Xbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 19:31:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38196 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD2Xbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:31:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so5912981pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 16:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H/8nUrKqYhVvsKSvJfp49NgjiOXeZImy/7R2bR3oOro=;
        b=kG4T7EV+0TKHsY8LFhY7laXzNVpT0laZWCGunrzU600ADcg9356S9Vct9He7b52Wn9
         YhVGSldgp9FI6H2hqlCMdYNcS6E5bXRrvlfJvGlc3zzJG1fIBXkAb2AhGGISUA2s2h0Z
         yiSO7pU8TC6rNK+A2kqVH6S5nXChptllG3eN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H/8nUrKqYhVvsKSvJfp49NgjiOXeZImy/7R2bR3oOro=;
        b=Ej+89cL5WjzL7JGbeYOSFwjLl3h56v5PTlik7jsmgxObiFHRuxj6fuW4F8MhC513GI
         +osXLNunMBHwxSvu/feFe68XCgKJMRDKTjZ9bQnbAWiLpCxbVLoIi6tl4QXpz5mIXljy
         jHAhp9YK8nYgqzYQWO1R3pR58jbtlcF0+6HOxjJko28GF4Bnm+XC4wN0s/hM5OU1LCRS
         Nhn1BCQ2pCJF0JIElzq0qol1sP5b4AEBfFUMVxQBxEHAQ0caP7Ip3B+6cPomFeQ8s9ae
         MhhDW2wAdeUnTB5TA3vE+6RVUICKcv1TSfipgJNlfMAwEPet3m0oMrmDbgS6gkKQWwmI
         eZ2Q==
X-Gm-Message-State: APjAAAUCWQvroGpuXEhAMPaH5/d5Vf/nuo4QtFXieY9WbYZ8aGgQnByp
        EhaTYGsdEuuT7ayiWnZ1V/+k4g==
X-Google-Smtp-Source: APXvYqzsLabqgWSkFI38RP/GY33aTWaJgZGkHyYPTVVVAFvodvnMh5vWxvEzCnJHkwradeYsirLSfQ==
X-Received: by 2002:a63:2c4a:: with SMTP id s71mr61911037pgs.373.1556580693472;
        Mon, 29 Apr 2019 16:31:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p8sm9266838pfq.28.2019.04.29.16.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 16:31:33 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:31:32 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Subject: Re: [PATCH v3 2/2] Bluetooth: hci_qca: wcn3990: Drop baudrate change
 vendor event
Message-ID: <20190429233132.GH112750@google.com>
References: <20190429232131.183049-1-mka@chromium.org>
 <20190429232131.183049-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190429232131.183049-2-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 04:21:31PM -0700, Matthias Kaehlcke wrote:
> Firmware download to the WCN3990 often fails with a 'TLV response size
> mismatch' error:
> 
> [  133.064659] Bluetooth: hci0: setting up wcn3990
> [  133.489150] Bluetooth: hci0: QCA controller version 0x02140201
> [  133.495245] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> [  133.507214] Bluetooth: hci0: QCA TLV response size mismatch
> [  133.513265] Bluetooth: hci0: QCA Failed to download patch (-84)
> 
> This is caused by a vendor event that corresponds to an earlier command
> to change the baudrate. The event is not processed in the context of the
> baudrate change and is later interpreted as response to the firmware
> download command (which is also a vendor command), but the driver detects
> that the event doesn't have the expected amount of associated data.
> 
> More details:
> 
> For the WCN3990 the vendor command for a baudrate change isn't sent as
> synchronous HCI command, because the controller sends the corresponding
> vendor event with the new baudrate. The event is received and decoded
> after the baudrate change of the host port.
> 
> Identify the 'unused' event when it is received and don't add it to
> the queue of RX frames.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v3:
> - rebased on latest bluetooth-next/master
> - removed barrier calls again, bit routines include barriers
> 
> Changes in v2:
> - make QCA_DROP_VENDOR_EVENT an enum value and don't use BIT()
> - free skb in qca_recv_event()
> - add barriers to ensure qca_recv_event() sees updated flags
> - return -ETIMEDOUT instead of -EPROTO if the vendor event isn't
>   received in time
> ---
>  drivers/bluetooth/hci_qca.c | 56 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 57322c42bb2d..5b57d897d8b5 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -30,6 +30,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/clk.h>
> +#include <linux/completion.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -66,6 +67,7 @@
>  
>  enum qca_flags {
>  	QCA_IBS_ENABLED,
> +	QCA_DROP_VENDOR_EVENT,
>  };
>  
>  /* HCI_IBS transmit side sleep protocol states */
> @@ -110,6 +112,7 @@ struct qca_data {
>  	struct work_struct ws_rx_vote_off;
>  	struct work_struct ws_tx_vote_off;
>  	unsigned long flags;
> +	struct completion drop_ev_comp;
>  
>  	/* For debugging purpose */
>  	u64 ibs_sent_wacks;
> @@ -491,6 +494,7 @@ static int qca_open(struct hci_uart *hu)
>  	INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
>  
>  	qca->hu = hu;
> +	init_completion(&qca->drop_ev_comp);
>  
>  	/* Assume we start with both sides asleep -- extra wakes OK */
>  	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
> @@ -885,6 +889,35 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
>  	return hci_recv_frame(hdev, skb);
>  }
>  
> +static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct qca_data *qca = hu->priv;
> +
> +	if (test_bit(QCA_DROP_VENDOR_EVENT, &qca->flags)) {
> +		struct hci_event_hdr *hdr = (void *)skb->data;
> +
> +		/* For the WCN3990 the vendor command for a baudrate change
> +		 * isn't sent as synchronous HCI command, because the
> +		 * controller sends the corresponding vendor event with the
> +		 * new baudrate. The event is received and properly decoded
> +		 * after changing the baudrate of the host port. It needs to
> +		 * be dropped, otherwise it can be misinterpreted as
> +		 * response to a later firmware download command (also a
> +		 * vendor command).
> +		 */
> +
> +		if (hdr->evt == HCI_EV_VENDOR)
> +			complete(&qca->drop_ev_comp);
> +
> +		kfree(skb);
> +
> +		return 0;
> +	}
> +
> +	return hci_recv_frame(hdev, skb);
> +}
> +
>  #define QCA_IBS_SLEEP_IND_EVENT \
>  	.type = HCI_IBS_SLEEP_IND, \
>  	.hlen = 0, \
> @@ -909,7 +942,7 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
>  static const struct h4_recv_pkt qca_recv_pkts[] = {
>  	{ H4_RECV_ACL,             .recv = qca_recv_acl_data },
>  	{ H4_RECV_SCO,             .recv = hci_recv_frame    },
> -	{ H4_RECV_EVENT,           .recv = hci_recv_frame    },
> +	{ H4_RECV_EVENT,           .recv = qca_recv_event    },
>  	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind  },
>  	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack  },
>  	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_sleep_ind },
> @@ -1104,6 +1137,7 @@ static int qca_check_speeds(struct hci_uart *hu)
>  static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  {
>  	unsigned int speed, qca_baudrate;
> +	struct qca_data *qca = hu->priv;
>  	int ret = 0;
>  
>  	if (speed_type == QCA_INIT_SPEED) {
> @@ -1120,8 +1154,11 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		/* Disable flow control for wcn3990 to deassert RTS while
>  		 * changing the baudrate of chip and host.
>  		 */
> -		if (qca_is_wcn399x(soc_type))
> +		if (qca_is_wcn399x(soc_type)) {
>  			hci_uart_set_flow_control(hu, true);
> +			reinit_completion(&qca->drop_ev_comp);
> +			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
> +		}
>  
>  		qca_baudrate = qca_get_baudrate_value(speed);
>  		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
> @@ -1132,8 +1169,21 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		host_set_baudrate(hu, speed);
>  
>  error:
> -		if (qca_is_wcn399x(soc_type))
> +		if (qca_is_wcn399x(soc_type)) {
>  			hci_uart_set_flow_control(hu, false);
> +
> +			/* Wait for the controller to send the vendor event
> +			 * for the baudrate change command.
> +			 */
> +			if (!wait_for_completion_timeout(&qca->drop_ev_comp,
> +						 msecs_to_jiffies(100))) {
> +				bt_dev_err(hu->hdev,
> +					   "Failed to change controller baudrate\n");
> +				ret = -ETIMEDOUT;
> +			}
> +
> +			clear_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
> +		}
>  	}
>  
>  	return ret;

The alternative to this patch could be a short delay in the right
place, as commented on v2
(https://lore.kernel.org/patchwork/patch/1048463/#1252739).

This series has been floating around for two months and hasn't
received any maintainer attention (or at least no replies). I don't
pretend it's a pretty solution, if maintainers prefer we can go for
the simpler option to add a delay plus a comment explaining why it is
needed. In any case let's do something, firmware download has been
broken since forever even though possible fixes are available :(

Thanks

Matthias
