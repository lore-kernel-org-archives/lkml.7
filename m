Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6DAC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B1B214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566413429;
	bh=vehFxqub2ZaELyoMFC3BtYjbbuEw1d13k6RMEZDO2kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZYi4zuUxJvcuj/LgTNFr34b4pRn6JJQmyKhmiEdpnKjDrYBpVG7gH/jzqxwZAvnZV
	 yYNJuXBItnurvIgceDLX6+RdhRlE1xv5ngNxyzMaBKkcu7Uql5308fQgZ0NTWF42/b
	 K+S+2Y+Fot7DMTDam1zZFgqDyu/xwGdZWHW8yxvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfHUSu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:50:28 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35974 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfHUSu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:50:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id n1so2414821oic.3;
        Wed, 21 Aug 2019 11:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=75tYGq2XrByjJlPCQ5rRvEjYYw5HsWA3W1b4A6YisAI=;
        b=FUVb8X0pr6kfkPi5uiLIytHIQ5LXBacTCiTp3UDtjvjLG3azwuBUSpiTEBQ6mKlpb6
         j1Z78ZqWRjQRZGFHYUmgIDZTTrtm6+6xTKyjnXk7ZUxPEhlMW/qC4xAX1PU+ms0Xl//G
         Tyip964e7RImcmrjvUCynWgFj/8Dar7PbBQBHmOGRRtviC1rX3Shnf+nbT1OS1Vq/CnM
         i3TjH1i90iNOdy0yH34vLBg0uXN9XgqrjtmhG9slgMJOrZ+c+buu7bzfFfyHBlslIbFM
         oNMBJxb4MzroEQAV33R2HYNWGQ9mtvoQ35PmcdaElgVbjidj7OzbjDzg89Wb3W8RY8vw
         YDMQ==
X-Gm-Message-State: APjAAAVLfDRgMPaBBJeDuZKRIDayAVbqJf+BsfCYlmW4BQcI27TadCxE
        qSJcbCMeG1qK6l2VR5Ma1Q==
X-Google-Smtp-Source: APXvYqysc72bbOfLeYkR0WFQ+GexfuCxG/CQGQ6YNhCh2IAPEbKVPiDCUf/3re0fLc39lGLwK4aaYg==
X-Received: by 2002:aca:b70b:: with SMTP id h11mr1136628oif.107.1566413426876;
        Wed, 21 Aug 2019 11:50:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d66sm7037232otb.47.2019.08.21.11.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:50:26 -0700 (PDT)
Date:   Wed, 21 Aug 2019 13:50:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        Wendell Lin <wendell.lin@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        Andy Teng <andy.teng@mediatek.com>
Subject: Re: [PATCH 04/11] pinctrl: mediatek: update pinmux defintions for
 mt6779
Message-ID: <20190821185025.GA18525@bogus>
References: <1564996320-10897-1-git-send-email-mars.cheng@mediatek.com>
 <1564996320-10897-5-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564996320-10897-5-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 05:11:53PM +0800, Mars Cheng wrote:
> Add devicetree bindings for Mediatek mt6779 SoC Pin Controller.

checkpatch.pl reports typo in subject.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Andy Teng <andy.teng@mediatek.com>
> ---
>  include/dt-bindings/pinctrl/mt6779-pinfunc.h | 1242 ++++++++++++++++++++++++++
>  1 file changed, 1242 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/mt6779-pinfunc.h
