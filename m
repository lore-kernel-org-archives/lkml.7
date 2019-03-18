Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AB7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7AC20872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=azazel.net header.i=@azazel.net header.b="pAox5CVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfCRVdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:33:14 -0400
Received: from kadath.azazel.net ([81.187.231.250]:56336 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCRVdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gu9lrwC4X4qFR6DH0zCqAorDtzq4j5PlDYWNR/n9g9A=; b=pAox5CVy/W4bG4uut+9SNePj8b
        Vy4yJSm0dK3RxtPnqnepUdH/ko0qDu34qWv4KsdglITCNpNM9KTM1mhhhpLQYgXzsZL+wy9ePChdf
        SBcZumcu0/kljQrojuW8yXqBudh0WZddcXo/b1jXzX2UbENlnY39mnjoX5OtkiemA5DIgmqriz4xR
        DnW4q+MuqyuhELb6jHm+6H7+t/Rl3+GiWk/QmXS7Jpfyv1zr5EbbRgUFpD9pqMKu1jd1/sa8qBgKS
        +puIFZZkhQPlXneBNZza4mDr7Tun2R/5gGHguujUSDcNQyNZwCz9bjTOCaKk6oSnlKiYxr7oFaBuU
        AgUVki5Q==;
Received: from celephais.dreamlands ([192.168.96.3] helo=azazel.net)
        by kadath.azazel.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jeremy@azazel.net>)
        id 1h5zsS-0001CZ-IW; Mon, 18 Mar 2019 21:33:00 +0000
Date:   Mon, 18 Mar 2019 21:32:59 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ks7010: remove redundant auth_type check
Message-ID: <20190318213259.GC5362@azazel.net>
References: <20190318105749.20098-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318105749.20098-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 192.168.96.3
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-18, at 10:57:49 +0000, Colin King wrote:
> The range check on auth_type is redundant as there is a prior
> check on the auth_type values and the only way the block is entered
> is if auth_type is one of TYPE_PMK1, TYPE_GMK1 and TYPE_GMK1.

"... and TYPE_GMK2."

> Hence the auth_type check can be removed.
>
> Detected by static analysis with cppcheck.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/staging/ks7010/ks_hostif.c
> b/drivers/staging/ks7010/ks_hostif.c
> index 06ebea0be118..31a536791d5c 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -362,6 +362,8 @@ int hostif_data_indication_wpa(struct
> ks_wlan_private *priv,
>  	     (auth_type == TYPE_GMK2 &&
>  	      priv->wpa.group_suite == IW_AUTH_CIPHER_TKIP)) &&
>  	    key->key_len) {
> +		int ret;
> +
>  		netdev_dbg(priv->net_dev, "TKIP: protocol=%04X: size=%u\n",
>  			   eth_proto, priv->rx_size);
>  		/* MIC save */
> @@ -369,15 +371,11 @@ int hostif_data_indication_wpa(struct
> ks_wlan_private *priv,
>  		       (priv->rxp) + ((priv->rx_size) - sizeof(recv_mic)),
>  		       sizeof(recv_mic));
>  		priv->rx_size = priv->rx_size - sizeof(recv_mic);
> -		if (auth_type > 0 && auth_type < 4) {	/* auth_type check */
> -			int ret;
> -
> -			ret = michael_mic(key->rx_mic_key,
> -					  priv->rxp, priv->rx_size,
> -					  0, mic);
> -			if (ret < 0)
> -				return ret;
> -		}
> +
> +		ret = michael_mic(key->rx_mic_key, priv->rxp, priv->rx_size,
> +				  0, mic);
> +		if (ret < 0)
> +			return ret;
>  		if (memcmp(mic, recv_mic, sizeof(mic)) != 0) {
>  			now = jiffies;
>  			mic_failure = &priv->wpa.mic_failure;

Acked-by: Jeremy Sowden <jeremy@azazel.net>
