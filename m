Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AAAC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D997621850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574095818;
	bh=E5sHJhDJdLwFFcwz2rZtBR5zpGdH7iYE/jUQURsGWTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cz/vDw8MSe6mfKnfSF+RC30rokxC/eiG3eJjTyxLk6SJiysxl5cbt+S5OUwtL8w+r
	 9IoXC29N+8nL4ldIOwmOlI3VSKko3hsnuQ08YOB9r0oHWP4zcyOcVQdlTeKQAfednw
	 usVHFJP4WwcoSoL4gNlLaQxMrz1w/4DN1lG8xxZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKRQuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:50:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44448 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfKRQuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:50:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id c19so15073396otr.11;
        Mon, 18 Nov 2019 08:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5NYQIVzszlovCzGCoyf9SHkjEAYAPxgYWsdxQCoKIq4=;
        b=qetaDa4Txc0EdHqZu/KXPh05PyhaIiMT9tnrxo8A5qEzuGnIXeoRnxl4KHD7+eHUWh
         5xcidHZPQAYvwCv6Di3ct5r0F+uYvj1PzYTtHGALgBp17UtUZfQGa+QyRc8ljMz1fQ9H
         yPmZ1BESoE32zgkJgDzwrDXJ4b/be8eTPVoTDh8moLqQjit3BrmAhe4CJZ9LsfPRIAph
         sSwxKqUdTpmlp0iSK42WOcyK6PWfHsDXp7vMNkSwk+ocESXChDuZqKnr+r+M/Ii9pMCV
         NY3FZbm4lwN9EHiPeIfy4DRSDGPVPiiXsjz97E4vJQKP7WaH6ldH6prJPoBuONQM3Nvb
         BlvA==
X-Gm-Message-State: APjAAAUy/4YuQeyTeHLvAKjZC8zppITuXUXzWrAeHHwW2+hebCS1Z85W
        Y74HZWknrTuBTN4zRnZLXA==
X-Google-Smtp-Source: APXvYqy5fyTYkoXXqqwQ0H9dOLJstLheW2bjF5U1SrvtNLNVH/MBfBQlyKUyfzD0Wr2bOMi5c0zc1g==
X-Received: by 2002:a05:6830:1e4c:: with SMTP id e12mr162673otj.358.1574095815692;
        Mon, 18 Nov 2019 08:50:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s133sm6229914oia.58.2019.11.18.08.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 08:50:15 -0800 (PST)
Date:   Mon, 18 Nov 2019 10:50:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 01/11] dt-bindings: phy-mtk-tphy: add two optional
 properties for u2phy
Message-ID: <20191118165014.GA3621@bogus>
References: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 16:36:26 +0800, Chunfeng Yun wrote:
> Add two optional properties, one for tuning J-K voltage by INTR,
> another for disconnect threshold, both of them are related with
> connect detection
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v4: no changes
> 
> v3: change commit log
> 
> v2: change description
> ---
>  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
