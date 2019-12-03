Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0722C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67340206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pensando.io header.i=@pensando.io header.b="WMyT/GO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfLCTrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:47:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44257 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfLCTrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:47:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id az9so2087393plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 11:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VZy3b2sJqOPadE7gaKlbeJchIAlYOyJ+QAzM+KPmmFA=;
        b=WMyT/GO0Y2I2VLICpbCCKvAvQMKRe2JwdmPtPAr8Ow1tNeMvGbkLwOK/7qRLLO3PsF
         xZJKprAjMbYkYEgjBNN81NavUXlKsKpplItcFzJqG49u1Ngr2VLxpZNHZGzGsCRpCuDn
         z9NRV4SIYJ7fziD05cu6ZZddWs8d64FsPo+8dWDS4TRW6PW81NB9EFHXRjXEnOEiwLk+
         lMGcPCRT3iJHiYiwgwMVFBjkX4s0f8w+P4UeqeOuMBBMnhwo2TR790uq/7G4aC4fu68e
         DYnjsrzP/mhK3lThAQJmNkLh/YMVU8/XubH4JXk69xD69JyJbhNd8qY3D/h8Z5+INXGO
         jTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VZy3b2sJqOPadE7gaKlbeJchIAlYOyJ+QAzM+KPmmFA=;
        b=YUArtpvMAn5O2uXjFGX/kIniVz3y/ka24TFwNEkhb1X8FlKPVwHvJi8A2Oqu6JSNhf
         ou1bjuVIjGdqWlEaPledXm2J9JptqZ5gOsP5QiDmBtShacZVc4EetrVvDsnEmJ9/qF7I
         8M12T2bhKW888kf1krEjBThWa0UR7ICsi6GgGBze8DJ0cCQrFfrV/r6oOq5SBYwY3K5f
         Bsmff/KApwGFVbBs8GLWF3AsxzF15I+xfNL9AqIok+QwErrlwhlGCe2j9Wp/VJYJZZwv
         GzZaTkTdO+EJJ23FTZ2rXFOTLSCsH99rIyJunJhAyMQ2G9MjoCRJUL14hG4LNrurJEux
         N9SA==
X-Gm-Message-State: APjAAAW3JZYpp2IfsGqPvMg6G8DAPf2q9Y4zCA5uRgXOzhhdrr1J9P7H
        bFebZlCACtcS2mbd3Zu0J9kWmQ==
X-Google-Smtp-Source: APXvYqyrvjU6wkrEA/C/p5ZheQAoQCPpcKcpzT0BUAICvdAJleVDkG2lQAWcglDPjqG3XnzSUfJBPw==
X-Received: by 2002:a17:90a:2201:: with SMTP id c1mr7247627pje.31.1575402466612;
        Tue, 03 Dec 2019 11:47:46 -0800 (PST)
Received: from Shannons-MacBook-Pro.local (static-50-53-47-17.bvtn.or.frontiernet.net. [50.53.47.17])
        by smtp.gmail.com with ESMTPSA id h7sm5293581pfq.36.2019.12.03.11.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 11:47:45 -0800 (PST)
Subject: Re: [PATCH RFC v7 net-next] netdev: pass the stuck queue to the
 timeout handler
To:     "Michael S. Tsirkin" <mst@redhat.com>, jcfaracco@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, dnmendes76@gmail.com
References: <20191203071101.427592-1-mst@redhat.com>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <80070eaa-84b2-5f41-db72-d8bf594924fd@pensando.io>
Date:   Tue, 3 Dec 2019 11:47:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191203071101.427592-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/19 11:12 PM, Michael S. Tsirkin wrote:
> This allows incrementing the correct timeout statistic without any mess.
> Down the road, devices can learn to reset just the specific queue.
>
[...]
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 20faa8d24c9f..f7beb1b9e9d6 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -1268,7 +1268,7 @@ static void ionic_tx_timeout_work(struct work_struct *ws)
>   	rtnl_unlock();
>   }
>   
> -static void ionic_tx_timeout(struct net_device *netdev)
> +static void ionic_tx_timeout(struct net_device *netdev, unsigned int txqueue)
>   {
>   	struct ionic_lif *lif = netdev_priv(netdev);
>   
>
[...]


For drivers/net/ethernet/pensando/ionic:
Acked-by: Shannon Nelson <snelson@pensando.io>


