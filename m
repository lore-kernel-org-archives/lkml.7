Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE79C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B3E207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578348449;
	bh=52I/ytr8y9cirx8LrY22EFRDoW9M0a1IhsQ6eg6oJeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QPphGr0xFs94dNp/xs/ZCJvHyPo7iekvcWR/LfWthP1bFyXshp2W62JgCY4ixNGST
	 bFq9Rp3YE7Ipa+IGrKzZFJYmgJ5fZGJBBhVavjRLsaQi+iDNnpd1RtpqB+J93lAKTw
	 mrL83JtpNKMwV6CbYad4IiwxWwS8hamSU6VH1yo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgAFWH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:07:28 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46955 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgAFWH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:07:27 -0500
Received: by mail-oi1-f196.google.com with SMTP id p67so16948915oib.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mX8Apg3ZN6eJo68XMUgHBKoUIUkBElk8pz2rAOhoL5k=;
        b=buQMvRwPkOJLOkqWGfsH37yT0YVKjNewsLRwTfVz1RQctVniCEZqT6R7YXGBgUdQ4v
         eFlfuBrCP7GiYTCGG0xaQT8t73e1JM6hFdjT3m7Vy5SaBrQItTdRckbuTYVd5FqO2h1V
         K0DHT7Olnw4JCHXwtc+qCNypxE94DN3zFc7sNaygBPNlGr4AX8mXNBIj2jj6E1tY4bJE
         4PKmVu5zmP4SUfM4UNr0O7U2ThbYTU6/nv8OsqLD/r6PqKScCRWXrNVaLsO2LOkRNgEV
         nHKBP6nOq2V0Mq15HAP5aH20MRNchw1n3vb0LeFZA+Rdk9yV3rHsmxvgF5iNPCz5gkkj
         r07A==
X-Gm-Message-State: APjAAAVNZ2M7oBKJ2/JoAwiJMSlp6OJZBpfCZpogVVHer+wsGhID3uDm
        npjI0pzcdkoOfQRIL1NoygoiYNo=
X-Google-Smtp-Source: APXvYqy0eYsc/C4F4HE06Fh+akPOiwqYYb8O40TqD0B4s6rFhZs983FmxkYhZ2MztH31WjJgAREQFA==
X-Received: by 2002:a05:6808:8cd:: with SMTP id k13mr6564271oij.4.1578348446644;
        Mon, 06 Jan 2020 14:07:26 -0800 (PST)
Received: from rob-hp-laptop (ip-70-5-121-225.ftwttx.spcsdns.net. [70.5.121.225])
        by smtp.gmail.com with ESMTPSA id 101sm24777173otj.55.2020.01.06.14.07.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:07:26 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2207cd
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 16:07:25 -0600
Date:   Mon, 6 Jan 2020 16:07:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v4 09/12] dt-bindings: media: venus: Add sdm845v2 DT
 schema
Message-ID: <20200106220724.GA15963@bogus>
References: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
 <20200106154929.4331-10-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106154929.4331-10-stanimir.varbanov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jan 2020 17:49:26 +0200, Stanimir Varbanov wrote:
> Add new qcom,sdm845-venus-v2 DT binding schema.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../bindings/media/qcom,sdm845-venus-v2.yaml  | 140 ++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
