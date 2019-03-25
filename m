Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CFCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6C520863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WEYD6Zdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfCYQug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:50:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41736 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCYQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:50:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so2730924pgs.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nadQGsFlPo0dAmGfeBTeXv+SjXP7o5AtY3vKCDX5dYQ=;
        b=WEYD6ZdmMGeQXEGILPikyJGf+yPITWTovAtDaNoddW+t3m/Qit59gDFkt8cu0Zge9C
         DTRn9xFJQhQiJdlRNTYmLNlT8oeD+n2TRrCUBz01/PCKUj8qrgwhlkAkPtZ6sMQeTAs5
         CdZpuWar6aB/TOp+Wh9qqMvTTcMsIzrDtW1JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nadQGsFlPo0dAmGfeBTeXv+SjXP7o5AtY3vKCDX5dYQ=;
        b=RIHBZQqwtwrXxgJG9SBjMmsx/oNEjE49V8O7R2urGXTSonfgBQVGiQPJwhY+gLEjUc
         ktpw0x+BKnGXNsY789O7Cz6yZtPMeO7zieT8ihdzzZrqlvaPCIzPNIdqFDTo44t6l92E
         wl9ZkHPS0HcHapKd84yjYKoskmu+/rR1HhR2I5FZEIm/0DoNRvl/zUPu+4nT4dCTslxI
         qvkuslAQe3jD+os5Df1g7/+deoek6Mx4uBhYe1zH9DxKpwyU2lTwfonz8nXh4qVbGL3b
         MeBj0tajzh5G8NMrYxnVyzcYavRYFbP4vzDOssHGYmcqe+81YcOPcA4xe5BTRYJby3qQ
         T0og==
X-Gm-Message-State: APjAAAXDrzfxR6WJ9bd5dgd3TdfXSOMaYtffPbg/p7kzBZD0Fh7fCXEV
        r32ThOWDD0F+se1sUpy8k6pf4tHGOfg=
X-Google-Smtp-Source: APXvYqzGWxm8tWILuY5Gcc4RFKZbWh1e3Gs6LI11MVFs4DBA8lEv5ZZyT4Wn94Nn9Fcl08IKmwlzwQ==
X-Received: by 2002:a63:c505:: with SMTP id f5mr21173745pgd.87.1553532635397;
        Mon, 25 Mar 2019 09:50:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d5sm18063943pgv.20.2019.03.25.09.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 09:50:34 -0700 (PDT)
Date:   Mon, 25 Mar 2019 09:50:34 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH 2/2] Bluetooth: hci_qca: wcn3990: Drop baudrate change
 vendor event
Message-ID: <20190325165034.GX112750@google.com>
References: <20190307004041.38059-1-mka@chromium.org>
 <20190307004041.38059-3-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307004041.38059-3-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

do you have any comments on this change?

Without this firmware download on wcn3990 (and probably also wcn3998)
is broken, unfortunately fixing the ROM firmware is not an option :(

Thanks

Matthias

On Wed, Mar 06, 2019 at 04:40:41PM -0800, Matthias Kaehlcke wrote:
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
> baudrate change and later interpreted as response to the firmware
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
>  drivers/bluetooth/hci_qca.c | 54 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index ab8e59419dbc4..565681a6a1167 100644
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
> @@ -55,6 +56,7 @@
>  #define HCI_MAX_IBS_SIZE	10
>  
>  #define QCA_IN_BAND_SLEEP_ENABLED	BIT(0)
> +#define QCA_DROP_VENDOR_EVENT		BIT(1)
>  
>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
> @@ -108,6 +110,7 @@ struct qca_data {
>  	struct work_struct ws_rx_vote_off;
>  	struct work_struct ws_tx_vote_off;
>  	unsigned long flags;
> +	struct completion drop_ev_comp;
>  
>  	/* For debugging purpose */
>  	u64 ibs_sent_wacks;
> @@ -474,6 +477,7 @@ static int qca_open(struct hci_uart *hu)
>  	INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
>  
>  	qca->hu = hu;
> +	init_completion(&qca->drop_ev_comp);
>  
>  	/* Assume we start with both sides asleep -- extra wakes OK */
>  	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
> @@ -866,6 +870,33 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
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
> +		 * be dropped, otherwise it can be mis-interpreted as
> +		 * response to a later firmware download command (also a
> +		 * vendor command).
> +		 */
> +
> +		if (hdr->evt == HCI_EV_VENDOR)
> +			complete(&qca->drop_ev_comp);
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
> @@ -890,7 +921,7 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
>  static const struct h4_recv_pkt qca_recv_pkts[] = {
>  	{ H4_RECV_ACL,             .recv = qca_recv_acl_data },
>  	{ H4_RECV_SCO,             .recv = hci_recv_frame    },
> -	{ H4_RECV_EVENT,           .recv = hci_recv_frame    },
> +	{ H4_RECV_EVENT,           .recv = qca_recv_event    },
>  	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind  },
>  	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack  },
>  	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_sleep_ind },
> @@ -1091,6 +1122,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  {
>  	unsigned int speed, qca_baudrate;
>  	struct qca_serdev *qcadev;
> +	struct qca_data *qca = hu->priv;
>  	int ret = 0;
>  
>  	if (speed_type == QCA_INIT_SPEED) {
> @@ -1106,8 +1138,11 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		 * changing the baudrate of chip and host.
>  		 */
>  		qcadev = serdev_device_get_drvdata(hu->serdev);
> -		if (qcadev->btsoc_type == QCA_WCN3990)
> +		if (qcadev->btsoc_type == QCA_WCN3990) {
>  			hci_uart_set_flow_control(hu, true);
> +			reinit_completion(&qca->drop_ev_comp);
> +			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
> +		}
>  
>  		qca_baudrate = qca_get_baudrate_value(speed);
>  		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
> @@ -1118,8 +1153,21 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		host_set_baudrate(hu, speed);
>  
>  error:
> -		if (qcadev->btsoc_type == QCA_WCN3990)
> +		if (qcadev->btsoc_type == QCA_WCN3990) {
>  			hci_uart_set_flow_control(hu, false);
> +
> +			/* Wait for the controller to send the vendor event
> +			 * for the baudrate change command.
> +			 */
> +			if (!wait_for_completion_timeout(&qca->drop_ev_comp,
> +						 msecs_to_jiffies(100))) {
> +				bt_dev_err(hu->hdev,
> +					   "Failed to change controller baudrate\n");
> +				ret = -EPROTO;
> +			}
> +
> +			clear_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
> +		}
>  	}
>  
>  	return ret;
