Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799CBC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4297520675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="abjlvVk6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jJEnscKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfCFFof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 00:44:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44396 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbfCFFof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 00:44:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 663F760907; Wed,  6 Mar 2019 05:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551851074;
        bh=QYEoEfQWLg9VOKb02GCibb5Wx3tTrXw1n183tcCzV2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=abjlvVk6Wp0YXUlKEff6ygIdHBbU50vivEdZ0EvvkTqG4qqF0PkiAy0tDRp9sdxME
         eVYzl3V0Nt3sIYbthVAW/nfGztNqAWoExVZ6jUq6Ca1jUG6ypm4njQlahMJqWVe0L+
         AXkFTEgao4k6C/Y+XNqAdY75NF4N1HuQ6t+OR8hU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A818360397;
        Wed,  6 Mar 2019 05:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551851073;
        bh=QYEoEfQWLg9VOKb02GCibb5Wx3tTrXw1n183tcCzV2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jJEnscKCDUrRKECbiYOJSwvmqWsx1JwtrFUkxBoOQ6myWkhuVThZroEpxRl1IQAkn
         wjXo7DJmKGtrjn3A/Yj1NW0IiH7+LQXi2j6ex4rdUMxW3+fuBSvhHAUJOmO5F+dlFS
         S9RNxMiii+SwIPq6J2AzlHAO7XNS9eqUm33NYm+w=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Mar 2019 11:14:33 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH] Bluetooth: hci_qca: Remove redundant initializations to
 zero
In-Reply-To: <20190305210412.98323-1-mka@chromium.org>
References: <20190305210412.98323-1-mka@chromium.org>
Message-ID: <64c92d9b653786e4e35952c1c37e0718@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-06 02:34, Matthias Kaehlcke wrote:
> The qca_data structure is allocated with kzalloc() and hence
> zero-initialized. Remove a bunch of unnecessary explicit
> initializations of struct members to zero.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/bluetooth/hci_qca.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 237aea34b69f1..8dccbb934e384 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -480,26 +480,7 @@ static int qca_open(struct hci_uart *hu)
>  	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
>  	qca->rx_ibs_state = HCI_IBS_RX_ASLEEP;
> 
> -	/* clocks actually on, but we start votes off */
> -	qca->tx_vote = false;
> -	qca->rx_vote = false;
> -	qca->flags = 0;
> -
> -	qca->ibs_sent_wacks = 0;
> -	qca->ibs_sent_slps = 0;
> -	qca->ibs_sent_wakes = 0;
> -	qca->ibs_recv_wacks = 0;
> -	qca->ibs_recv_slps = 0;
> -	qca->ibs_recv_wakes = 0;
>  	qca->vote_last_jif = jiffies;
> -	qca->vote_on_ms = 0;
> -	qca->vote_off_ms = 0;
> -	qca->votes_on = 0;
> -	qca->votes_off = 0;
> -	qca->tx_votes_on = 0;
> -	qca->tx_votes_off = 0;
> -	qca->rx_votes_on = 0;
> -	qca->rx_votes_off = 0;
> 
>  	hu->priv = qca;

Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

-- 
Regards
Balakrishna.
