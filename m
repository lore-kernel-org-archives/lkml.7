Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4189AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E622064A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553798475;
	bh=x82wg/MlahALnwc16SCyfgtTOda99hucNaGejIn2Fcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g29FsW/7lJW0Dg0hYzZ2Sfxl9jrt9qRohg+eyGDkBShVxwMjg7grRKnwbWno1Xd5B
	 7gNmHVSNQOxcR48BjpuBNySCC24DmkjTV3qjPb8xbrk9Y1E2ivXq1ES8yiEKVvYSDy
	 6XWhAoxqXU3ypp8fInID1zNbp/EtciHJA4Vu3nj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfC1SlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:41:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45450 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfC1SlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:41:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id y84so16577525oia.12;
        Thu, 28 Mar 2019 11:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=liwJXytgfq5xMHOJXAQ8AmXZcTsod3k4Er7cu/QvgyI=;
        b=sdy+SCKfqZRJ8oHCd6hTHcRhMRUvggB989fxFWMnagFNc5n9O7rihCx1WYvjTv9amg
         F+JLRLAgM0mjmbR85c76dibVy/pwFpf59k7eDhBbL9ujz3wBJq8vbOj4OGe7cMKx8SFg
         TrLsVSvZXaLZDnbkSdbCedbuoOrHdHh9YybRab0pGoErQ04COqexsU8mgyi4GL0zV0rG
         bbeJ0I5aFtXJj7KuNlZNgrcQlbhbxgfbeC1HrY59fCG5Nn120QZfQQmAJKRjDLyC+XUJ
         bGc/trnYlEAL6+NFWuuiwqQbqQaia5mGMSwnOOWxqt33taSmD9TvZy4zqEgau+awczaz
         9/Xg==
X-Gm-Message-State: APjAAAXB8ZnAZxiZB14jKmut7GPRgBhQbbjbRsLK2546Q3Xm3qMVTsG5
        7+KATvk0yROpM9LPctk2mg==
X-Google-Smtp-Source: APXvYqx2uKBvlXBn8AxVOaLzo0mDyThc9NotCpqp1GxkCQySDuKeqiFcWziotCbArnQnP7X/RuCWbw==
X-Received: by 2002:aca:c483:: with SMTP id u125mr1018651oif.148.1553798472383;
        Thu, 28 Mar 2019 11:41:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n16sm1516277oic.7.2019.03.28.11.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:41:11 -0700 (PDT)
Date:   Thu, 28 Mar 2019 13:41:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK HU <ck.hu@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        ginny.chen@mediatek.com, kendrick.hsu@mediatek.com,
        Frederic Chen <Frederic.Chen@mediatek.com>
Subject: Re: [PATCH v3 01/12] dt-binding: gce: remove thread-num property
Message-ID: <20190328184111.GA21455@bogus>
References: <1553739573-19708-1-git-send-email-bibby.hsieh@mediatek.com>
 <1553739573-19708-2-git-send-email-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553739573-19708-2-git-send-email-bibby.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 10:19:22 +0800, Bibby Hsieh wrote:
> "thread-num" is an unused property so we remove it from example.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
