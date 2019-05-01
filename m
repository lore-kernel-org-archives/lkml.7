Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6471BC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207E020866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556742395;
	bh=azSVKToEujbPDdCNWohzfZkxH/lU+DfvtLLO/SjmPF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1AupqilWyK+k7us8ATP3pi8Z+4XNnc6DowVK8b8oLMREz8inHJpdThHu2PcYE1okZ
	 gk4J4IewDKY0nJzVwrz3knziyhVXlW3RihvcANUWYhwOBJZFgMLHY0+DGC7Yyqezq1
	 l1Yp0t3C+ssq5OUb+n1xvtZo+CIBI/WKEuEe/MEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfEAU0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:26:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40047 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEAU0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:26:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id w6so115522otl.7;
        Wed, 01 May 2019 13:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i4BcmLTt3qSO7ebRuLnsFYshyO5n3Uthw1CjDsmT+WQ=;
        b=NkLw7wG1S4B5F50ogDFhkA1C6jD6Cp8nzmrZazSC78Yp9xMrHuc19HETGhfAlKWO3P
         mt/yvwwT+Ga1KlhBjMeNIV8F2mw/Bshf5PA3TOl+ntvwB3kT01ClwSQ2H3B3R6rh3hg5
         iJu9rwViPRg2ZICX5MwObBoie9htiOcVdnAfpccOyC9F6JiopYqRq2WvxBlN66r4qsw/
         a64njSlJQjXUQS/HjekyJ5a6Mj0Wz/lDgzC2Dp/ekCPgK4MAEYEjfvEmGl13TYXqCAq9
         OBfbl7wQylSFk2uQ4TvwMwkwLy3sKv3HFBjx5I1sVgQHd3Osk9VJfzH7JFDJ0rNQKish
         3QtA==
X-Gm-Message-State: APjAAAWkcOh3nxAzeEj2RSVJSQmVwryzc4vkMzezwGGMPK96KBYR68bi
        s88OMYOroIwVEem4ga9xJA==
X-Google-Smtp-Source: APXvYqyvGU61UGP21sWZd1plEHAvhFnejz8U8UyYK+r4AbW/b/4XFJAPlAw38GlaTScboSWrdAblAg==
X-Received: by 2002:a9d:6f0f:: with SMTP id n15mr12164732otq.194.1556742392971;
        Wed, 01 May 2019 13:26:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r25sm15928842otk.37.2019.05.01.13.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:26:31 -0700 (PDT)
Date:   Wed, 1 May 2019 15:26:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Henry Chen <henryc.chen@mediatek.com>
Subject: Re: [RFC V2 02/11] dt-bindings: soc: Add opp table on scpsys bindings
Message-ID: <20190501202631.GA2677@bogus>
References: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
 <1556614265-12745-3-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556614265-12745-3-git-send-email-henryc.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019 16:50:56 +0800, Henry Chen wrote:
> Add opp table on scpsys dt-bindings for Mediatek SoC.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
