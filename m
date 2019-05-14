Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8E7C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E794320879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557857867;
	bh=QJiFJdWzjoqMml8dxtla34rMhAiIoQzJgDCE5OYsv5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Vt0CXkBzI4jS04wLfeUJ+A1HJp+X9um05q/OhldRSPMI3GWPjW9D7/CHO7VfQOvJ
	 aMOhhXKuJIudl/PBtmTgYoYfdk5sJB7wvG5Z/yw4A0ESzEM3A4yldAiEbKB6Etu6U6
	 AwfrLYpUiEVuFc2gE3QS/AS+QlfdKbwC6gZv42BU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfENSRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:17:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42240 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfENSRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:17:45 -0400
Received: by mail-ot1-f68.google.com with SMTP id f23so16145141otl.9;
        Tue, 14 May 2019 11:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j6KYSa7mFmT8IdJQKzPSI3WBRVrEj+tTk4TrQEJlJp8=;
        b=TX/6g4d0YEvldhYYnPULVTG85SzqY8fw5AW6hp0/ta7i2TM/Lj5Pj86MY4piFyrS3n
         xEDW5LWVpD++4YXMBMy+JNs9hqMMsQPnPN8JGZwpGTm277na1V9ct8T/DSMYCHEB9x7g
         uc2Fk3z77JJtJ3MQqbIFw0IU8JhMho8JfmfzSDjcR6ixtlO5NhQqNjPydBHTORnpmueO
         jvb/WPZg2UENB5ZuC0zoTaSxBUvcUVCsYHjITE7+mZCFOdDx4PKMPqBaVP5hGaEOufbe
         /WbjbN4vByObxxyQ2JMSNtAdpnsluKJh2roFwDn/Ub3Zn0bAPlpFSpyAKDcSNFU1zSXD
         5uxA==
X-Gm-Message-State: APjAAAVImjiG+flymYzAlGWty1CFAtKkuTQVzxPpUwWTo1LkEF11Q5Rp
        7w8TlbfLAkSnoPLmdgsYRA==
X-Google-Smtp-Source: APXvYqxnIsAes2oxtS3pa7msjo6X0Zei3YQDzQ8HtcaPk4a7Y58c4+nemeuTSKJtzH/2q8RiQazUKw==
X-Received: by 2002:a9d:7c84:: with SMTP id q4mr15400106otn.98.1557857864775;
        Tue, 14 May 2019 11:17:44 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m63sm6408810otc.76.2019.05.14.11.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 11:17:43 -0700 (PDT)
Date:   Tue, 14 May 2019 13:17:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 3/6] dt-bindings: usb: mtu3: add properties about USB
 Role Switch
Message-ID: <20190514181743.GA21612@bogus>
References: <1557823643-8616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1557823643-8616-4-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557823643-8616-4-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 16:47:20 +0800, Chunfeng Yun wrote:
> Now the USB Role Switch is supported, so add properties about it,
> and modify some description related.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v5 changes
>  1. modify decription about extcon and vbus-supply properties
>  2. make this patch depend on [1]
> 
>  [1]: [v3] dt-binding: usb: add usb-role-switch property
>       https://patchwork.kernel.org/patch/10934835/
> 
> v4: no changes
> v3: no changes
> 
> v2 changes:
>   1. fix typo
>   2. refer new binding about connector property
> ---
>  .../devicetree/bindings/usb/mediatek,mtu3.txt          | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
