Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30854C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30F5217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfDWUIV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:08:21 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54342 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfDWUIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:08:21 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 110B7CF2E8;
        Tue, 23 Apr 2019 22:16:30 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [RFC] Bluetooth: Retry configure request if result is
 L2CAP_CONF_UNKNOWN
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190208025828.30901-1-andrew.smirnov@gmail.com>
Date:   Tue, 23 Apr 2019 22:08:19 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Florian Dollinger <dollinger.florian@gmx.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D53F2ED9-E0E6-4290-9E3E-864D2AF43572@holtmann.org>
References: <20190208025828.30901-1-andrew.smirnov@gmail.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

> Due to:
> 
> - current implementation of l2cap_config_rsp() dropping BT
>   connection if sender of configuration response replied with unknown
>   option failure (Result=0x0003/L2CAP_CONF_UNKNOWN)
> 
> - current implementation of l2cap_build_conf_req() adding
>   L2CAP_CONF_RFC(0x04) option to initial configure request sent by
>   the Linux host.
> 
> devices that do no recongninze L2CAP_CONF_RFC, such as Xbox One S
> controllers, will get stuck in endless connect -> configure ->
> disconnect loop, never connect and be generaly unusable.
> 
> To avoid this problem add code to do the following:
> 
> 1. Store a mask of supported conf option types per connection
> 
> 2. Parse the body of response L2CAP_CONF_UNKNOWN and adjust
>    connection's supported conf option types mask
> 
> 3. Retry configuration step the same way it's done for
>    L2CAP_CONF_UNACCEPT
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> Cc: Florian Dollinger <dollinger.florian@gmx.de>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> 
> Everyone:
> 
> I marked this as an RFC, since I don't have a lot of experience with
> Bluetooth subsystem and don't have hight degree of confidence about
> choices made in this patch. I do, however, thins is is good enough to
> start a discussion about the problem.
> 
> Thanks,
> Andrey Smirnov

so it seems that the remote side claims to support Streaming Mode and that is why we are trying to set it up.

> ACL Data RX: Handle 12 flags 0x02 dlen 16
      L2CAP: Information Response (0x0b) ident 1 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x00000010
          Streaming Mode

And that is why we do this.

< ACL Data TX: Handle 12 flags 0x00 dlen 23
      L2CAP: Configure Request (0x04) ident 2 len 15
        Destination CID: 64
        Flags: 0x0000
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Basic (0x00)
          TX window size: 0
          Max transmit: 0
          Retransmission timeout: 0
          Monitor timeout: 0
          Maximum PDU size: 0

> ACL Data RX: Handle 12 flags 0x02 dlen 15
      L2CAP: Configure Response (0x05) ident 2 len 7
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        04

So btmon needs a patch to decide the failed option octet here. We really want do provide a human description of the failed option.

> 
> include/net/bluetooth/l2cap.h |  1 +
> net/bluetooth/l2cap_core.c    | 58 ++++++++++++++++++++++++++++++-----
> 2 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 093aedebdf0c..6898bba5d9a8 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -632,6 +632,7 @@ struct l2cap_conn {
> 	unsigned int		mtu;
> 
> 	__u32			feat_mask;
> +	__u32			known_options;
> 	__u8			remote_fixed_chan;
> 	__u8			local_fixed_chan;
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f17e393b43b4..49be98b6de72 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3243,8 +3243,10 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data
> 		rfc.monitor_timeout = 0;
> 		rfc.max_pdu_size    = 0;
> 
> -		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
> -				   (unsigned long) &rfc, endptr - ptr);
> +		if (chan->conn->known_options & BIT(L2CAP_CONF_RFC)) {
> +			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
> +					   (unsigned long)&rfc, endptr - ptr);
> +		}
> 		break;
> 
> 	case L2CAP_MODE_ERTM:
> @@ -3263,8 +3265,10 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data
> 		rfc.txwin_size = min_t(u16, chan->tx_win,
> 				       L2CAP_DEFAULT_TX_WINDOW);
> 
> -		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
> -				   (unsigned long) &rfc, endptr - ptr);
> +		if (chan->conn->known_options & BIT(L2CAP_CONF_RFC)) {
> +			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
> +					   (unsigned long)&rfc, endptr - ptr);
> +		}
> 
> 		if (test_bit(FLAG_EFS_ENABLE, &chan->flags))
> 			l2cap_add_opt_efs(&ptr, chan, endptr - ptr);
> @@ -3295,8 +3299,10 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data
> 			     L2CAP_FCS_SIZE);
> 		rfc.max_pdu_size = cpu_to_le16(size);
> 
> -		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
> -				   (unsigned long) &rfc, endptr - ptr);
> +		if (chan->conn->known_options & BIT(L2CAP_CONF_RFC)) {
> +			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
> +					   (unsigned long)&rfc, endptr - ptr);
> +		}
> 
> 		if (test_bit(FLAG_EFS_ENABLE, &chan->flags))
> 			l2cap_add_opt_efs(&ptr, chan, endptr - ptr);
> @@ -3550,11 +3556,47 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
> 	void *endptr = data + size;
> 	int type, olen;
> 	unsigned long val;
> +	const bool unknown_options = *result == L2CAP_CONF_UNKNOWN;
> 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
> 	struct l2cap_conf_efs efs;
> 
> 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
> 
> +	/* throw out any old stored conf requests */
> +	*result = L2CAP_CONF_SUCCESS;
> +
> +	if (unknown_options) {
> +		const u8 *option_type = rsp;
> +
> +		if (!len) {
> +			/* If no list of unknown option types is
> +			 * provided there's nothing for us to do
> +			 */
> +			return -ECONNREFUSED;
> +		}
> +
> +		while (len--) {
> +			BT_DBG("chan %p, unknown option type: %u", chan,
> +			       *option_type);
> +			/* "...Hints shall not be included in the
> +			 * Response and shall not be the sole cause
> +			 * for rejecting the Request.."
> +			 */
> +			if (*option_type & L2CAP_CONF_HINT)
> +				return -ECONNREFUSED;
> +			/* Make sure option type is one of the types
> +			 * supported/used in configure requests
> +			 */
> +			if (*option_type < L2CAP_CONF_MTU ||
> +			    *option_type > L2CAP_CONF_EWS)
> +				return -ECONNREFUSED;
> +
> +			chan->conn->known_options &= ~BIT(*option_type++);
> +		}
> +
> +		return l2cap_build_conf_req(chan, data, size);
> +	}
> +
> 	while (len >= L2CAP_CONF_OPT_SIZE) {
> 		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
> 		if (len < 0)
> @@ -4240,6 +4282,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
> 		}
> 		goto done;
> 
> +	case L2CAP_CONF_UNKNOWN:
> 	case L2CAP_CONF_UNACCEPT:
> 		if (chan->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
> 			char req[64];
> @@ -4249,8 +4292,6 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
> 				goto done;
> 			}
> 
> -			/* throw out any old stored conf requests */
> -			result = L2CAP_CONF_SUCCESS;
> 			len = l2cap_parse_conf_rsp(chan, rsp->data, len,
> 						   req, sizeof(req), &result);
> 			if (len < 0) {

So I really wonder if we want to combine CONF_UNKNOWN and CONF_UNACCEPT actually here. It might be better to do them as separate handlers.

Frankly it might be enough if the option code 0x04 is marked as not supported, then just clear

	conn->feat_mask &= ~(L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING);

There is really no point for us known about all unsupported / unknown options. Unless we understand them, then don’t bother. Just keep it simple.

Regards

Marcel

