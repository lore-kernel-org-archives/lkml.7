Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2559C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AC820693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbfGHQVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:21:34 -0400
Received: from foss.arm.com ([217.140.110.172]:53294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730848AbfGHQVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:21:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23496360;
        Mon,  8 Jul 2019 09:21:32 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CF6A3F246;
        Mon,  8 Jul 2019 09:21:31 -0700 (PDT)
Subject: Re: [PATCH 5/6] firmware: arm_scmi: Use the term 'message' instead of
 'command'
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
References: <20190708154358.16227-1-sudeep.holla@arm.com>
 <20190708154358.16227-6-sudeep.holla@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <a04dfc00-9c7a-8321-859d-7a12e7b84ea6@arm.com>
Date:   Mon, 8 Jul 2019 17:21:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708154358.16227-6-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2019 16:43, Sudeep Holla wrote:
> In preparation to adding support for other two types of messages that
> SCMI specification mentions, let's replace the term 'command' with the
> correct term 'message'.
> 
> As per the specification the messages are of 3 types:
> commands(synchronous or asynchronous), delayed responses and notifications.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/common.h | 10 +++++-----
>  drivers/firmware/arm_scmi/driver.c |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 44fd4f9404a9..4349d836b392 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -48,11 +48,11 @@ struct scmi_msg_resp_prot_version {
>  /**
>   * struct scmi_msg_hdr - Message(Tx/Rx) header
>   *
> - * @id: The identifier of the command being sent
> - * @protocol_id: The identifier of the protocol used to send @id command
> - * @seq: The token to identify the message. when a message/command returns,
> - *	the platform returns the whole message header unmodified including
> - *	the token
> + * @id: The identifier of the message being sent
> + * @protocol_id: The identifier of the protocol used to send @id message
> + * @seq: The token to identify the message. when a message returns, the]

Stray ']' at the end of the line.

Steve

> + *	platform returns the whole message header unmodified including the
> + *	token
>   * @status: Status of the transfer once it's complete
>   * @poll_completion: Indicate if the transfer needs to be polled for
>   *	completion or interrupt mode is used
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index cac255c418b2..69bf85fea967 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -182,7 +182,7 @@ static inline int scmi_to_linux_errno(int errno)
>  static inline void scmi_dump_header_dbg(struct device *dev,
>  					struct scmi_msg_hdr *hdr)
>  {
> -	dev_dbg(dev, "Command ID: %x Sequence ID: %x Protocol: %x\n",
> +	dev_dbg(dev, "Message ID: %x Sequence ID: %x Protocol: %x\n",
>  		hdr->id, hdr->seq, hdr->protocol_id);
>  }
>  
> @@ -241,7 +241,7 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
>   * @hdr: pointer to header containing all the information on message id,
>   *	protocol id and sequence id.
>   *
> - * Return: 32-bit packed command header to be sent to the platform.
> + * Return: 32-bit packed message header to be sent to the platform.
>   */
>  static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
>  {
> @@ -280,7 +280,7 @@ static void scmi_tx_prepare(struct mbox_client *cl, void *m)
>   *
>   * @handle: Pointer to SCMI entity handle
>   *
> - * Helper function which is used by various command functions that are
> + * Helper function which is used by various message functions that are
>   * exposed to clients of this driver for allocating a message traffic event.
>   *
>   * This function can sleep depending on pending requests already in the system
> 

