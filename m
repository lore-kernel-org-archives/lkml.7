Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ED2C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB872146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576680876;
	bh=hF6onFKCi6fvT9Sa1rvQf17WOvCUhbvDZsz/AQw1OgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xq6M1MFi2qcD6Dy3+B4gsYMXPhVRkgJRsLZhN1PFFRZKIRJ/RUR+kylWEBVzA/rWK
	 sr1DFSfkr+a/W/MOfsLbPY/DdoK430lnl7aB/WgHmszkn7GNyttteZdwDh9uLwfT0x
	 7PW2c0fmKk9SElBgug9u7vQrVPrUvI0bRZhbtkLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfLROyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:54:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36562 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfLROyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:54:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id w1so2827101otg.3;
        Wed, 18 Dec 2019 06:54:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iY4uXq1SaKZgzob1+2qQOKNlu24qtS6FnzwURWp1h9Q=;
        b=LyZ6qOu7WjDjt2GGD0Tf848fnrm/8ldqJXRA+Vi7Ugr6Vka4WJdmPCqCPD/YrNSsix
         UFRWrW3Txj3sKfbdLnmjL3qh0Zbxs8pAxh0c6RpoY95BdDWfQ2OrThr2fr7wqGKflIUu
         NlYESQfGu+sOLQ3a6gohxvUs99TVP1zwWCoXzGFIqZMkcEsiE0+lV6zJF8fWUuuBiqGu
         /ofqrkocLJHnDYYe/tGcNf6pH0KDtRNLhA3kE9GTNre3WcrhMJ3tqV1c38Mjf8ljxJ44
         z9e4MipZJCi7WHcvQETFk/+GM0w2r6euhPUAWOwRLvcMciXc/Rr24mcBqG1jX2iwuxKh
         ZvZA==
X-Gm-Message-State: APjAAAWCfUFhw/lgD4VsEugIbRx/cbnFNpWNEy4mj2GqR1X4/fZoFQ2W
        OW/02cSLYDJIXrF+x2KN4g==
X-Google-Smtp-Source: APXvYqx9qabUxfrhOzpRQ5TYWNuN1bOUhzm7eE9y9M5Ce9bqK0nKPPoliIG8Vj+5bq2+vHKimuFUig==
X-Received: by 2002:a05:6830:1c85:: with SMTP id v5mr3183032otf.35.1576680874215;
        Wed, 18 Dec 2019 06:54:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w6sm857669oih.19.2019.12.18.06.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:54:33 -0800 (PST)
Date:   Wed, 18 Dec 2019 08:54:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, paulburton@kernel.org, jhogan@kernel.org,
        mripard@kernel.org, shawnguo@kernel.org, mark.rutland@arm.com,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        heiko@sntech.de, icenowy@aosc.io, ak@linux.intel.com,
        laurent.pinchart@ideasonboard.com, krzk@kernel.org,
        geert+renesas@glider.be, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, keescook@chromium.org,
        ebiederm@xmission.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, 772753199@qq.com
Subject: Re: [PATCH v8 2/4] dt-bindings: Document yna vendor-prefix.
Message-ID: <20191218145432.GA11183@bogus>
References: <1575979363-25956-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1575979363-25956-3-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1575979363-25956-3-git-send-email-zhouyanjie@wanyeetech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 20:02:41 +0800, =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?=          wrote:
> The "yna" is an acronym of the "YSH & ATIL".
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
> 
> Notes:
>     v1->v2:
>     No change.
>     
>     v2->v3:
>     No change.
>     
>     v3->v4:
>     No change.
>     
>     v4->v5:
>     No change.
>     
>     v5->v6:
>     No change.
>     
>     v6->v7:
>     Change my Signed-off-by from "Zhou Yanjie <zhouyanjie@zoho.com>"
>     to "周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>" because
>     the old mailbox is in an unstable state.
>     
>     v7->v8:
>     No change.
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
