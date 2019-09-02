Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633C1C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDB12190F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567431529;
	bh=QMhneOHgKSOgJ/YFFZlICwACHTVgIzH8alGy/R2fVzk=;
	h=Date:From:Subject:References:In-Reply-To:CC:To:List-ID:From;
	b=oc7VtwOCE+C5rkDER71fW2B4ZkahhSk/sELzr3jNuJfMEl87SWFMr/L9+Xc1kqSHQ
	 azB2Xf2gKewjZzddDuh0Y9u6ZBQGcPJVQS02g94JcgfwrwxUej/9sj0rCy2xxVpwU1
	 JGbX6tmbNNOZ3yg/HTemoDVP3I8Dojh0AufxO9XM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbfIBNis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:38:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35950 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbfIBNiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:38:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so14082589wrd.3;
        Mon, 02 Sep 2019 06:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=09FoypwgmyRAmmFg+Htl5lGcxB/1mAqQuM9bRNLvNts=;
        b=q7ncOCFAJYh0m+SMKLhmTB+Tgw2GWzcVEzxd2y/B1+gAUsZABomavJiyOFqz45obgs
         zgm4GGAYe5b/15u+26xisl7LBXQGjchLQqdt8wMAXPwqNMPW8gEzYNRtbEtI0kWEL67u
         AgM5v1dW9UnjJoftj5Sb1A8ZuedD5h0s92Ohyvfb9p9ud1JE8nJ+Cd5z4Bg+MZdG14su
         HCiBMaSSWP5wffVmE5CakYA3bFoaHZ1GtRnWFqJXBwwdC+5Uw4pn8m3p5oz/zjCHm9Tw
         YvYnZHmtHts68OhrHpQsmTgcCAOelh+HByENaHeINXo+YLVaQykfITByrUdJTE9GUeS4
         /7cw==
X-Gm-Message-State: APjAAAU2usIOvvz4M+jWuULj2TDhjRxxMSrI7EKFZQ068ba4HNOkE4QN
        wgXWxi57wsIfru/SYciAzw==
X-Google-Smtp-Source: APXvYqzUIDBa+LF4N8gaqJYa3KSq6v85Fgr8KXNSFW+T9D5h8aoLxSoonU1EHXuOx23Z15V/h+Jqug==
X-Received: by 2002:a05:6000:128d:: with SMTP id f13mr37181235wrx.241.1567431523763;
        Mon, 02 Sep 2019 06:38:43 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id a13sm1559920wrf.73.2019.09.02.06.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:38:43 -0700 (PDT)
Message-ID: <5d6d1b63.1c69fb81.1cab3.5ef8@mx.google.com>
Date:   Mon, 02 Sep 2019 14:38:42 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] clk: mediatek: add pericfg clocks for MT8183
References: <1566980533-28282-1-git-send-email-chunfeng.yun@mediatek.com> <1566980533-28282-2-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1566980533-28282-2-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain
CC:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 16:22:13 +0800, Chunfeng Yun wrote:
> Add pericfg clocks for MT8183, it's used when support USB
> remote wakeup
> 
> Cc: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2:
>    use GATE_MTK to define GATE_PERI suggested by Weiyi
> ---
>  drivers/clk/mediatek/clk-mt8183.c      | 30 ++++++++++++++++++++++++++
>  include/dt-bindings/clock/mt8183-clk.h |  4 ++++
>  2 files changed, 34 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

