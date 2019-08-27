Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D864C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549A322CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566924452;
	bh=Hu3NbfCSUL0IcW/aR74ATHtSjZUb3n0FIU9R1tFjilI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Op9eNMNNCuBZDP84S9goCmh2knlHgLDus47/Q4LrhNkjEX78AyFobo5uhLFQuN6/y
	 Li1n8nqz7FGLxi42rJj+spHrYGYls/Thn34mkUz09zbyS3zTgJdtsWa4iTX8mnhgA1
	 aERTyQQBJ96o7hHIBE7VEXAf0O9MR1B1kn2T4H4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfH0Qrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:47:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42181 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfH0Qrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:47:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id j7so19300835ota.9;
        Tue, 27 Aug 2019 09:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W55p1J3dXo2eoSv3z8HYRfWnL+jUM+FXYgRcg9cAPuM=;
        b=Hkn355Nh8XtNLNOPlpflXT2eVuIEvR9pXX7kqKQBOP0KbQiEy0eAgjy0b3TJZG9nSk
         RHh7HdhYjxnppqoT1CrYXelkraI67G+DnJY62hMUEi1VwZpVzO3BXRWoFhf9E8C413/5
         eu391KS7FjsEABTYEfqaD2w8MGBN91ac1buGnxgpekGtOUWvht3DFooOLK2cvx/zvoTu
         IY+wEx4FQi/vsmq0SzmA9fpAYqAnw1BECw2M251ztbrevSSiF2slFYmAVZXpAMzP0wSE
         mxbJ29HFraRjRyZL+qwGEexjumS2Dwr6U2rBLXrS9RzP7KLISMxRA4+z7DKanwOqn/a0
         B23Q==
X-Gm-Message-State: APjAAAU7j+XPn92epYdBrjbk72lTC9orw9D+R4/XQ+3DXxoJxKZ/uRH1
        kfi5QvrCgQAaUxTVikjHUQ==
X-Google-Smtp-Source: APXvYqyR/GUWnMaTE26vhIdo9g05lr8gX2pzwKUsW3nwuf/nPgB6R/qe9oG9nKlAZyYTrjefTWlNKg==
X-Received: by 2002:a9d:7c94:: with SMTP id q20mr3535892otn.353.1566924450127;
        Tue, 27 Aug 2019 09:47:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c5sm5297702otl.29.2019.08.27.09.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:47:29 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:47:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org,
        "linux-arm-kernel @ lists . infradead . org Alessandro Zummo" 
        <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [PATCH v6 04/13] dt-bindings: rtc: mediatek: add missing mt6397
 rtc
Message-ID: <20190827164728.GA20645@bogus>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-5-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818135611.7776-5-frank-w@public-files.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Aug 2019 15:56:02 +0200, Frank Wunderlich wrote:
> From: Josef Friedl <josef.friedl@speed.at>
> 
> add missing devicetree-binding document for mt6397 rtc
> in later patch driver is extended with mt6323 chip
> 
> Suggested-By: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes since v5: none
> changes since v4: use relative path
> changes since v3: moved SOB
> changes since v2: splitted rtc-mt6397.txt from first patch
> ---
>  .../devicetree/bindings/rtc/rtc-mt6397.txt    | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
