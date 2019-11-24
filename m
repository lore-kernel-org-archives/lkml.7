Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1F2C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 00:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DAA20679
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 00:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="QzZsZCqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKXA2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 19:28:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45910 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfKXA2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 19:28:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id w7so4791704plz.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 16:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=E9LgB+cbP3yiKvoDqnvc9VhE2eLE3V415vmR/C02fGI=;
        b=QzZsZCqGlfEFFpYNxQh0y02ZEDTjl7FGXXMLgRqbrVSa3ycBCKz6ABF75crhD+JrGp
         ve9X2kideA0myXqxeOF3sJNeqRToYb1elFJ2phDiefwCvxk/zaQBvd8w4fZQjH2oua8w
         h/oxI+1QXIanIzcZIcm+5CeTHXvPt5r4fwzPOV2+NoobiEnohPnkSzijdToSCHn50EAm
         1OLJ9I5e6+aKM1gerLHZzYT4Y5pEJ9WoC8L2l43Tq9KNlWQrAWGJDcVyPuUhu/2w/ztY
         t0mPRR0INY8Q+k7iJDSMmAPfLlUtMR99rksTaTtd6SVU3Hmt3i4o6UK6d+pfBtmPlWd7
         PDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=E9LgB+cbP3yiKvoDqnvc9VhE2eLE3V415vmR/C02fGI=;
        b=BzxNdfb8uYH4A1ao2C6as/dAfBNYBeeG0MfkFftoUw047cKU+87EM1olLfZiDSbllE
         eoQQx7QEALgjxbhlSgIKV6Du+Gl/NV76EPiWgjbdHhj2rXNfqW7d0268DzVe8CnI3ldW
         FaxEBgoYlTGMQNlG4wVCJH8UxJ2qd4BDgCNyYQNSXhyC4wwne9Qtx3DozZAcIlhYKpp+
         I8gTpGXb0/xZEuNuJhFDtcDG54LzGrlazGGG5rVWzyo/VBkRfPrfSEuXk5AgCChMMNgQ
         AGoNUdNIiaRNbDkWrhwun4a0pGjPOgdZEs2qWtzBluN+Xvy0YBFvaG3IiLGe8rdf/OsR
         Gg3A==
X-Gm-Message-State: APjAAAVvZtjHRWO5NevZ1fz0onI9yLzGDv1Vqc7tEh8clRZw4Tfq5n6u
        snnR0sEyMIvphZxsNy46KweZsw==
X-Google-Smtp-Source: APXvYqz1+BHl5MazeKxRuyImMXZhVqpDUwUXlUJEGEZvg4Un97OLCuYbUeXyG7vUu+LWKuC6qp+PSA==
X-Received: by 2002:a17:90a:1a8a:: with SMTP id p10mr6764829pjp.6.1574555323151;
        Sat, 23 Nov 2019 16:28:43 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id w69sm2838928pfc.164.2019.11.23.16.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 16:28:42 -0800 (PST)
Date:   Sat, 23 Nov 2019 16:28:38 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Kalesh A P <kalesh-anakkur.purayil@broadcom.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] be2net: gather more debug info and display on
 a tx-timeout
Message-ID: <20191123162838.372e49db@cakuba.netronome.com>
In-Reply-To: <20191122104719.3943-1-kalesh-anakkur.purayil@broadcom.com>
References: <20191122104719.3943-1-kalesh-anakkur.purayil@broadcom.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 16:17:19 +0530, Kalesh A P wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> In order to start recording the last few tx wqes and
> tx completions, user has to set the msg level to non-zero
> value using "ethtool -s ethX msglvl 1"
> 
> This patch does the following things:
> 1. record last 200 WQE information
> 2. record first 128 bytes of last 200 TX packets
> 3. record last 200 TX completion info
> 4. On TX timeout, log these information for debugging
> 
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>

Please consider more modern infrastructure for these sort of dumps,
like devlink health API.

> +/* Store latest 200 occurrences */
> +#define BE_TXQ_INFO_LEN		200
> +#define PKT_DUMP_SIZE		128
> +
> +struct be_tx_pktinfo {
> +	u16 head;
> +	u16 tail;
> +	u16 used;
> +	struct be_wrb_params wqe_hdr;
> +	u8 skb_data[PKT_DUMP_SIZE];
> +	u32 len;
> +	u32 skb_len;
> +	bool valid;

nit: you could save 4B per entry if the 'valid' was after 'used'

> +};
> +
> +struct be_tx_dump_cmpl {
> +	u32 info[32];
> +	bool valid;
> +};
> +
>  /* Structure to hold some data of interest obtained from a TX CQE */
>  struct be_tx_compl_info {
>  	u8 status;		/* Completion status */

> +void be_record_tx_cmpl(struct be_tx_obj *txo,
> +		       struct be_eth_tx_compl *cmpl)
> +{
> +	u32 offset = txo->tx_cmpl_idx;
> +	struct be_tx_dump_cmpl *cmpl_dump = &txo->cmpl_info[offset];

nit: reverse xmas tree variable is generally prefered in the networking
code, meaning the cmpl_dump should be declared first, and inited in the
code rather than in place

> +	memset(cmpl_dump, 0, sizeof(*cmpl_dump));
> +
> +	memcpy(&cmpl_dump->info, cmpl, sizeof(cmpl_dump->info));
> +	cmpl_dump->valid = 1;
> +
> +	txo->tx_cmpl_idx = ((txo->tx_cmpl_idx + 1) % BE_TXQ_INFO_LEN);

outer parens unnecesary

> +}
> +
> +void be_record_tx_wqes(struct be_tx_obj *txo,
> +		       struct be_wrb_params *wrb_params,
> +		       struct sk_buff *skb)
> +{
> +	u32 offset = txo->tx_wqe_offset;
> +	struct be_tx_pktinfo *pkt_info = &txo->tx_pktinfo[offset];
> +
> +	memset(pkt_info, 0, sizeof(*pkt_info));
> +
> +	pkt_info->tail = txo->q.tail;
> +	pkt_info->head = txo->q.head;
> +	pkt_info->used = atomic_read(&txo->q.used);
> +	pkt_info->valid = 1;

> @@ -1417,6 +1458,75 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
>  	return NETDEV_TX_OK;
>  }
>  
> +void
> +be_print_tx_wqes(struct be_adapter *adapter, struct be_tx_obj *txo)
> +{
> +	struct device *dev = &adapter->pdev->dev;
> +	struct be_tx_pktinfo *pkt_info;
> +	u8 *data;
> +	int i, j;
> +
> +	dev_info(dev, "Dumping WQES of TXQ id %d\n", txo->q.id);
> +
> +	for (i = 0; i < BE_TXQ_INFO_LEN; i++) {
> +		pkt_info = &txo->tx_pktinfo[i];
> +		if (!pkt_info->valid)
> +			continue;
> +
> +		dev_info(dev, "TXQ head %d tail %d used %d\n",
> +			 pkt_info->head, pkt_info->tail, pkt_info->used);
> +
> +		dev_info(dev, "WRB params: feature:0x%x vlan_tag:0x%x lso_mss:0x%x\n",
> +			 pkt_info->wqe_hdr.features, pkt_info->wqe_hdr.vlan_tag,
> +			 pkt_info->wqe_hdr.lso_mss);
> +
> +		dev_info(dev, "SKB len: %d\n", pkt_info->skb_len);
> +		data = pkt_info->skb_data;
> +		for (j = 0 ; j < pkt_info->len; j++) {
> +			printk("%02x ", data[j]);

Please use something like print_hex_dump().

> +			if (j % 8 == 7)
> +				printk(KERN_INFO "\n");
> +		}
> +	}
> +}
> +
> +void
> +be_print_tx_cmpls(struct be_adapter *adapter, struct be_tx_obj *txo)
> +{
> +	struct device *dev = &adapter->pdev->dev;
> +	struct be_tx_dump_cmpl *cmpl_info;
> +	int i;
> +
> +	dev_info(dev, "TX CQ id %d head %d tail %d used %d\n",
> +		 txo->cq.id, txo->cq.head, txo->cq.tail,
> +		 atomic_read(&txo->cq.used));
> +
> +	for (i = 0; i < BE_TXQ_INFO_LEN; i++) {
> +		cmpl_info = &txo->cmpl_info[i];
> +		if (!cmpl_info->valid)
> +			continue;
> +
> +		printk(KERN_INFO "0x%x 0x%x 0x%x 0x%x\n",
> +		       cmpl_info->info[0], cmpl_info->info[1],
> +		       cmpl_info->info[2], cmpl_info->info[3]);

Some functions use printk() some dev_info(), can is there a well
thought out reason for this?

> +	}
> +}
> +
> +/* be_dump_info - Print tx-wqes, tx-cmpls and skb-data */
> +void be_dump_info(struct be_adapter *adapter)

Most if not all functions you add need to be static. Please make sure
your code builds cleanly with W=1 C=1.

> +{
> +	struct be_tx_obj *txo;
> +	int i;
> +
> +	if (!adapter->msg_enable)
> +		return;

nit: you're a little inconsistent with whether the caller or the callee
checks the msg_enable.

> +	for_all_tx_queues(adapter, txo, i) {
> +		be_print_tx_wqes(adapter, txo);
> +		be_print_tx_cmpls(adapter, txo);
> +	}
> +}
> +
>  static void be_tx_timeout(struct net_device *netdev)
>  {
>  	struct be_adapter *adapter = netdev_priv(netdev);
> @@ -1429,6 +1539,8 @@ static void be_tx_timeout(struct net_device *netdev)
>  	int status;
>  	int i, j;
>  
> +	be_dump_info(adapter);
> +
>  	for_all_tx_queues(adapter, txo, i) {
>  		dev_info(dev, "TXQ Dump: %d H: %d T: %d used: %d, qid: 0x%x\n",
>  			 i, txo->q.head, txo->q.tail,
> @@ -2719,6 +2831,10 @@ static struct be_tx_compl_info *be_tx_compl_get(struct be_adapter *adapter,
>  	rmb();
>  	be_dws_le_to_cpu(compl, sizeof(*compl));
>  
> +	/* Dump completion info */
> +	if (adapter->msg_enable)
> +		be_record_tx_cmpl(txo, compl);
> +
>  	txcp->status = GET_TX_COMPL_BITS(status, compl);
>  	txcp->end_index = GET_TX_COMPL_BITS(wrb_index, compl);
>  

