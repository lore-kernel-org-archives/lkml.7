Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49777C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139FA22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566416304;
	bh=g/ai2LU0yCALPUZy2ioj2qinjUjoYknJwL32reSPQvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KQECPYLtGjnC4JSpnpgB8iS2LOjYGKpm3rKre3QiK4rYOnKtF+WgNRm7/TLWr4Lyy
	 uVNIaUCviH6bn47rvFZq0dRKJa32dUdU4IoVEaJ51yieolrUjNkxB1NI8K7pOi7xxw
	 v7OWWzc83XIMVTx9FjuUGbrc23fPf9EjOR5gMSvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfHUTiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:38:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45101 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfHUTiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:38:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id m24so3156089otp.12;
        Wed, 21 Aug 2019 12:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B2sqhe5AqKLmtT/yMr5qqKwsIEPV2ZNCc+XrnOTsRE0=;
        b=j6kJIDQZu1xNjukYu4+3IVb8Wr6rxpAKkziFzsN7j9FoHzna3YTu6PhdyHKu20OJ6d
         wXVKRFrcPZA9rHs4SDOa0BjVkWmWtv/Cj6sIjEvAqZmT6x2BMmrnnKGmdqDTBy0/SQdz
         ymkkCPuMKVz7cREfCslrgVEWN39zLZXIRZuM7xRcwbFLo0f28SG3hrH9PnCzDjZeVAD0
         wdMgTm71KTWzVB3JPV6JjUQPA7K5PLVweDB9SOVVuWpKVxTzh6rho+cA0IXP//OQMEgC
         ORSbMY+Yaq7zUIqaIFGjrqbWUON6sobLHry9T+xakBXpksQthA+EsjA19UNTjcouf2o+
         HlBg==
X-Gm-Message-State: APjAAAX/dbWTy1W5dTgDHU8pQBoWH5WEQm1Vq5qxhTOLAuZTIU5ZRljG
        FTvgaG/ajmMJlqDZwri28g==
X-Google-Smtp-Source: APXvYqw2pp7F48FA5m6NYn4/91MENgUj8UbJg9RKHbzyTb9uIdL1dUtTNZaIWw4JQQzhz5WH5IUT5Q==
X-Received: by 2002:a9d:7a3:: with SMTP id 32mr11626210oto.238.1566416302436;
        Wed, 21 Aug 2019 12:38:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k16sm7127926otj.58.2019.08.21.12.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 12:38:21 -0700 (PDT)
Date:   Wed, 21 Aug 2019 14:38:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org, vkoul@kernel.org,
        aneela@codeaurora.org, mark.rutland@arm.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        clew@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: firmware: scm: re-order compatible
 list
Message-ID: <20190821193821.GA11238@bogus>
References: <20190807070957.30655-1-sibis@codeaurora.org>
 <20190807070957.30655-3-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807070957.30655-3-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Aug 2019 12:39:52 +0530, Sibi Sankar wrote:
> re-order compatible list to maintain sort order.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
