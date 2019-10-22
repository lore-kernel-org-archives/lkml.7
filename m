Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7FCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE102084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="nm43MeZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbfJVJmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:42:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34723 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731506AbfJVJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:42:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so16447696lja.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 02:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6PngoIqd3Df1CdJuHFWIWAR+3vA7GwvMHjLnoNZAyhA=;
        b=nm43MeZUUI6GQpkNT6A0YrESS4a/Z0DJ3o9zbifdiIHtP+9Q2tT5ZcCHuHFQxVKZWs
         3gIcAXIfvHGdVkydGFosRyRjeK+YQ3NgZ4t8Eqq/3w5XjBlr5Ph08jgW7VWWPzcgSPdG
         qJmUdAL/72WUiByqgPOv+SdbkyZV+NMSEfZZpMfqhotrGSNfPYr71tIf3/x82dfNsHZo
         KP6IsKcmUpKy2SQyNWrDhtglHdSbCAEZn1DJPQWzn9DLtcDYxcYJhIB7Z6enotA6m5IZ
         UmPnyUHWTTllkD4Eh9VvC+ZNdYsrFdds6j+/LwFcuoXCmqYlP2ePOZEiQxYrHbxy4dnp
         RYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6PngoIqd3Df1CdJuHFWIWAR+3vA7GwvMHjLnoNZAyhA=;
        b=iApTKt6NznpJbkHVxH8TAafi+r1DOw8eCMzzrmcIZ9d43v8dVlQCsvwbKHpl4YkN9E
         yWASSqaxWc5/nkzs4fStT79bBvGHFcE6xVw18VUt2V+64A3MuyYOiFgmhMm7fei2ieXX
         nBFivg5g7e53eOruontskfpIErqTQaI7jntCdbAQSGCGKMneyVu+9r9pxhgMtbOda41/
         BrvYttO4XWEs+TnSfUDwvgvSsReERpZ0r/Xp+psit15fd5ZfhKlbPFLJoHJSra6M5L25
         xxOmA8ksGiLbWbYz3GJoeogfZ8XGiIDKnBQPRk4gKWKy8EmoCv8c/8uU53A0r33hdWkr
         2UDg==
X-Gm-Message-State: APjAAAXLkGGpvG2jQwsxPOGC+FyqDrpJNONbRRAV3zd3PBPdNm6qxvpA
        1Uwj+lFFM0i5IJ4SmOrszxrta/UrK1Yvow==
X-Google-Smtp-Source: APXvYqxzOPJiicnhU2xU73dS4Ka5ImWerivhccwctOI/IfMg9cJRh20c9txgdneMOboGeKD12wD1dg==
X-Received: by 2002:a2e:880e:: with SMTP id x14mr17555702ljh.42.1571737340767;
        Tue, 22 Oct 2019 02:42:20 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:6f4:f4ee:fd19:4aa8:e73f:e22a? ([2a00:1fa0:6f4:f4ee:fd19:4aa8:e73f:e22a])
        by smtp.gmail.com with ESMTPSA id q124sm9966339ljb.28.2019.10.22.02.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 02:42:19 -0700 (PDT)
Subject: Re: [PATCH] 802.11n IBSS: wlan0 stops receiving packets due to
 aggregation after sender reboot
To:     =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <m34l02mh71.fsf@t19.piap.pl> <m3v9shl6jz.fsf@t19.piap.pl>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <628ec530-1f68-e34b-39a5-b3d994d9376c@cogentembedded.com>
Date:   Tue, 22 Oct 2019 12:42:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <m3v9shl6jz.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 21.10.2019 15:18, Krzysztof Hałasa wrote:

> Fix a bug where the mac80211 RX aggregation code sets a new aggregation
> "session" at the remote station's request, but the head_seq_num
> (the sequence number the receiver expects to receive) isn't reset.
> 
> Spotted on a pair of AR9580 in IBSS mode.
> 
> Signed-off-by: Krzysztof Halasa <khalasa@piap.pl>
> 
> diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
> index 4d1c335e06e5..775a51cc51c9 100644
> --- a/net/mac80211/agg-rx.c
> +++ b/net/mac80211/agg-rx.c
> @@ -354,9 +354,11 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
>   			 */
>   			rcu_read_lock();
>   			tid_rx = rcu_dereference(sta->ampdu_mlme.tid_rx[tid]);
> -			if (tid_rx && tid_rx->timeout == timeout)
> +			if (tid_rx && tid_rx->timeout == timeout) {
> +				tid_rx->ssn = start_seq_num;
> +				tid_rx->head_seq_num = start_seq_num;
>   				status = WLAN_STATUS_SUCCESS;
> -			else
> +			} else

    If you add {} on one branch of *if*, you also need to add {} to all other 
branches, says CodingStyle...

[...]

MBR, Sergei
