Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F53C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D09C24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781561;
	bh=46JjSE0TqUQT6M8wsAsINHvBobmcHCyu6Ha24Tve1ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B+nZSFdQQbCxPK838VIh+ryHHpzEsQ43MGEtcKiIrifzS8BdogEf5J8rZMwzE+lCz
	 M9uaKZ7K4n90i904NepWVXI5Ftm9D3MJkDU0o6CbLBvWOXllXgUSbofOvZN53LwVMa
	 wMoGoIGnFp6JBu8anUcy6rbaqFoSda/eDKsnlTVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbfLSSwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:52:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44332 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbfLSSwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:52:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so5813963otj.11;
        Thu, 19 Dec 2019 10:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mIqFeu8O9eY39QwBv57QNH/NMiJEQE200I7/+vun34w=;
        b=pOxz9xQ05aKRaue236tLhbk7uEaufzoa03CxO6U5mW6ktnO5pwcqc32FAf1MY8IYph
         mBGBf0D5e8WrICffCliW83cc2c2rlUbI74ClSk9dLs0LWVNzspSXg9dgG1tRswqa7qqX
         0fE7dWdE0tlX/zkY4zqL9RBuajHZ3LY2TJsG3SB2FLBfeh/UhdbjkWp/U6Gp0hGL4I0j
         JfrWrabj6/9cJL/WYtMBU2obhyp9PWkbE3QfQ1LxHmREWORy4BQf+TiZb7eN3hG+pVtO
         /lK9FkXhbw9OLq8n85GJhw8lUcHJUhrRuGPnyFV/kW7UPHJ8j8NWyx/ooNgeQOQjfzVO
         Kxog==
X-Gm-Message-State: APjAAAUDVPuJG86Te2fiOI0zKVd17flJGnXEDqJJVgg/YZdYSq4Estzg
        0nTPvLFpb46PLgsMb7D68g==
X-Google-Smtp-Source: APXvYqyt22PLuxSNwzWF6VKaHrtiX5AuQMISU1O6yYYzhVCKQ814h8IA6WNyeX95p2do8NixhzWh6g==
X-Received: by 2002:a05:6830:1bd5:: with SMTP id v21mr10899479ota.154.1576781553463;
        Thu, 19 Dec 2019 10:52:33 -0800 (PST)
Received: from localhost ([2607:fb90:bdf:98e:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id k17sm2238501oic.45.2019.12.19.10.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 10:52:32 -0800 (PST)
Date:   Thu, 19 Dec 2019 12:52:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, tsahee@annapurnalabs.com,
        antoine.tenart@bootlin.com, hhhawa@amazon.com,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        tglx@linutronix.de, khilman@baylibre.com, chanho.min@lge.com,
        heiko@sntech.de, nm@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        barakw@amazon.com
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: amazon: rename al,alpine DT
 binding to amazon,al
Message-ID: <20191219185231.GA32332@bogus>
References: <20191209161341.29607-1-hhhawa@amazon.com>
 <20191209161341.29607-2-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209161341.29607-2-hhhawa@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2019 16:13:36 +0000, Hanna Hawa wrote:
> As preparation to add device tree binding for Amazon's Annapurna Labs
> Alpine v3 support. Rename al,alpine DT binding to amazon,al.
> 
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  .../bindings/arm/{al,alpine.yaml => amazon,al.yaml}           | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/arm/{al,alpine.yaml => amazon,al.yaml} (74%)
> 

Acked-by: Rob Herring <robh@kernel.org>
