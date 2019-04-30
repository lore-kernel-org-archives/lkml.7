Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5018FC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C0221670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h+UKf1or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfD3AOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:14:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44265 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbfD3AOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:14:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so5949913pgv.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 17:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GDA8JMfknGP5KG93UbG+emkmgs24343xkd/w8E3YJLw=;
        b=h+UKf1ortX1xrnwMUJiBiYOCr3dazOocpvzYYTc6KHUIYfW2hdzO7qqKdLB8HfNXt5
         U4mcrMQ6Nszp7STqkmkdeFTIPTzeketUoYBdn84yWe55jkgOkGZhE/vd3bIAWWHvZ3IH
         DHm0WggJAhN2BSBSy4Z3uq9eyhdFGEdfZVYGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDA8JMfknGP5KG93UbG+emkmgs24343xkd/w8E3YJLw=;
        b=qVxK71d9aJjnbv8fYVjoALjkkhg49TTFyQFqz3+AuXkYMW3jq1Z6KNQnLSVHfXqjWm
         3sGkhinZFEzsfzcSdZ5fsED4rLaSezNEb52aFYItHbhDs5dYBcJ5diW6EPl7kEdaSeWy
         5aT2PQovWhUOspH88oXYZwzKO3dR6rpS6hahC/SeVbaudG+W424557KG4+oKH7CLO492
         Kvjd9htaVczPlGytZUnQhkY2Z4neVCpFbfUGGXSeyNG1A1ykWdhrQImMqYpDkru17t+R
         f23NeHD2nMNnf5OaT3fwDxPUFxwnQOjtTAUALL6Gap38VyD+ou0IzpQS9W3uOMUh7v2n
         fEEw==
X-Gm-Message-State: APjAAAWcfVP9FqAWW8CVErucpQlKYc3mINmrjvKB8wAuPuSPDeOJAYoR
        3ODVo4z0+oi3wlC4eH00LGgzxg==
X-Google-Smtp-Source: APXvYqwJ+AOqteyvwSZtMfTutc2GNkRtgv4UK++fQvpq/07AZP0jWUtejIEUk4aAUnVFNxCmnuYHCg==
X-Received: by 2002:a65:534b:: with SMTP id w11mr3970072pgr.210.1556583281498;
        Mon, 29 Apr 2019 17:14:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 6sm11989984pfd.85.2019.04.29.17.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 17:14:41 -0700 (PDT)
Date:   Mon, 29 Apr 2019 17:14:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Subject: Re: [PATCH v8] Bluetooth: btqca: inject command complete event
 during fw download
Message-ID: <20190430001440.GI112750@google.com>
References: <20190430001024.209688-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190430001024.209688-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 05:10:24PM -0700, Matthias Kaehlcke wrote:
> From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> 
> From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> 
> Latest qualcomm chips are not sending an command complete event for
> every firmware packet sent to chip. They only respond with a vendor
> specific event for the last firmware packet. This optimization will
> decrease the BT ON time. Due to this we are seeing a timeout error
> message logs on the console during firmware download. Now we are
> injecting a command complete event once we receive an vendor specific
> event for the last RAM firmware packet.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v8:
> - renamed QCA_HCI_CC_SUCCESS to QCA_HCI_CC_OPCODE
> - use 0xFC00 as opcode of the injected event instead of 0
> - added Matthias' tags from the v7 review
> ---
>  drivers/bluetooth/btqca.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btqca.h |  3 +++
>  2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index cc12eecd9e4d..ef765ea881b8 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -144,6 +144,7 @@ static void qca_tlv_check_data(struct rome_config *config,
>  		 * In case VSE is skipped, only the last segment is acked.
>  		 */
>  		config->dnld_mode = tlv_patch->download_mode;
> +		config->dnld_type = config->dnld_mode;
>  
>  		BT_DBG("Total Length           : %d bytes",
>  		       le32_to_cpu(tlv_patch->total_size));
> @@ -264,6 +265,31 @@ static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
>  	return err;
>  }
>  
> +static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
> +{
> +	struct hci_event_hdr *hdr;
> +	struct hci_ev_cmd_complete *evt;
> +	struct sk_buff *skb;
> +
> +	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	hdr = skb_put(skb, sizeof(*hdr));
> +	hdr->evt = HCI_EV_CMD_COMPLETE;
> +	hdr->plen = sizeof(*evt) + 1;
> +
> +	evt = skb_put(skb, sizeof(*evt));
> +	evt->ncmd = 1;
> +	evt->opcode = HCI_OP_NOP;
> +
> +	skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
> +
> +	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
> +
> +	return hci_recv_frame(hdev, skb);
> +}
> +
>  static int qca_download_firmware(struct hci_dev *hdev,
>  				  struct rome_config *config)
>  {
> @@ -297,11 +323,22 @@ static int qca_download_firmware(struct hci_dev *hdev,
>  		ret = qca_tlv_send_segment(hdev, segsize, segment,
>  					    config->dnld_mode);
>  		if (ret)
> -			break;
> +			goto out;
>  
>  		segment += segsize;
>  	}
>  
> +	/* Latest qualcomm chipsets are not sending a command complete event
> +	 * for every fw packet sent. They only respond with a vendor specific
> +	 * event for the last packet. This optimization in the chip will
> +	 * decrease the BT in initialization time. Here we will inject a command
> +	 * complete event to avoid a command timeout error message.
> +	 */
> +	if ((config->dnld_type == ROME_SKIP_EVT_VSE_CC ||
> +	    config->dnld_type == ROME_SKIP_EVT_VSE))
> +		return qca_inject_cmd_complete_event(hdev);
> +
> +out:
>  	release_firmware(fw);
>  
>  	return ret;
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 4c4fe2b5b7b7..595abcdaed2d 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -41,6 +41,8 @@
>  #define QCA_WCN3990_POWERON_PULSE	0xFC
>  #define QCA_WCN3990_POWEROFF_PULSE	0xC0
>  
> +#define QCA_HCI_CC_OPCODE		0xFC00
> +
>  enum qca_baudrate {
>  	QCA_BAUDRATE_115200 	= 0,
>  	QCA_BAUDRATE_57600,
> @@ -82,6 +84,7 @@ struct rome_config {
>  	char fwname[64];
>  	uint8_t user_baud_rate;
>  	enum rome_tlv_dnld_mode dnld_mode;
> +	enum rome_tlv_dnld_mode dnld_type;
>  };
>  
>  struct edl_event_hdr {

In the v7 review (https://lore.kernel.org/patchwork/patch/1028118/) 3
months ago Marcel said he isn't convinced that this solution is
needed, but didn't follow up on the discussion, so this is the best we
have at the moment. Let's please drive it towards a solution.

Thanks

Matthias
