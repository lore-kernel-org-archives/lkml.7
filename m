Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A029ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066FE20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfJGOP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:15:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38866 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbfJGOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:15:25 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x97E6oWc045266
        for <linux-kernel@vger.kernel.org>; Mon, 7 Oct 2019 10:15:23 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vf98gcvq4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 10:15:22 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jwi@linux.ibm.com>;
        Mon, 7 Oct 2019 15:15:15 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Oct 2019 15:15:11 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x97EEe9s32178436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Oct 2019 14:14:40 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CA8642054;
        Mon,  7 Oct 2019 14:15:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDDFC42049;
        Mon,  7 Oct 2019 14:15:09 +0000 (GMT)
Received: from [9.152.222.62] (unknown [9.152.222.62])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Oct 2019 14:15:09 +0000 (GMT)
Subject: Re: [PATCH RFC net-next 1/2] drivers: net: virtio_net: Add tx_timeout
 stats field
To:     jcfaracco@gmail.com, netdev@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dnmendes76@gmail.com
References: <20191006184515.23048-1-jcfaracco@gmail.com>
 <20191006184515.23048-2-jcfaracco@gmail.com>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Date:   Mon, 7 Oct 2019 16:15:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191006184515.23048-2-jcfaracco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100714-0016-0000-0000-000002B4DB47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100714-0017-0000-0000-00003315F338
Message-Id: <52efa170-722c-334d-627e-30931fba7a7e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-07_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910070140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.19 20:45, jcfaracco@gmail.com wrote:
> From: Julio Faracco <jcfaracco@gmail.com>
> 
> For debug purpose of TX timeout events, a tx_timeout entry was added to
> monitor this special case: when dev_watchdog identifies a tx_timeout and
> throw an exception. We can both consider this event as an error, but
> driver should report as a tx_timeout statistic.
> 

Hi Julio,
dev_watchdog() updates txq->trans_timeout, why isn't that sufficient?


> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> Signed-off-by: Daiane Mendes <dnmendes76@gmail.com>
> Cc: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4f3de0ac8b0b..27f9b212c9f5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -75,6 +75,7 @@ struct virtnet_sq_stats {
>  	u64 xdp_tx;
>  	u64 xdp_tx_drops;
>  	u64 kicks;
> +	u64 tx_timeouts;
>  };
>  
>  struct virtnet_rq_stats {
> @@ -98,6 +99,7 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
>  	{ "xdp_tx",		VIRTNET_SQ_STAT(xdp_tx) },
>  	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
>  	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
> +	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
>  };
>  
>  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
> @@ -1721,7 +1723,7 @@ static void virtnet_stats(struct net_device *dev,
>  	int i;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		u64 tpackets, tbytes, rpackets, rbytes, rdrops;
> +		u64 tpackets, tbytes, terrors, rpackets, rbytes, rdrops;
>  		struct receive_queue *rq = &vi->rq[i];
>  		struct send_queue *sq = &vi->sq[i];
>  
> @@ -1729,6 +1731,7 @@ static void virtnet_stats(struct net_device *dev,
>  			start = u64_stats_fetch_begin_irq(&sq->stats.syncp);
>  			tpackets = sq->stats.packets;
>  			tbytes   = sq->stats.bytes;
> +			terrors  = sq->stats.tx_timeouts;
>  		} while (u64_stats_fetch_retry_irq(&sq->stats.syncp, start));
>  
>  		do {
> @@ -1743,6 +1746,7 @@ static void virtnet_stats(struct net_device *dev,
>  		tot->rx_bytes   += rbytes;
>  		tot->tx_bytes   += tbytes;
>  		tot->rx_dropped += rdrops;
> +		tot->tx_errors  += terrors;
>  	}
>  
>  	tot->tx_dropped = dev->stats.tx_dropped;
> 

