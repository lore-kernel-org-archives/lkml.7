Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7B8C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106BA20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556742311;
	bh=npHQfjlPoX1pxaHVNG9s8uyZW9rleGFTBhkUqHVyHPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wk0jwzIi+R1iQW8d+KUTstcISZcXWzuKGLK6IHez2OLV7n2FRiFFSsaVPQqO5+NQL
	 wYnr4BWZCAyTb+vj2gCWLLA6E4gsaELxrjNlkYx1gXjVDXRUpi4Ujs/q3MSK/TZwSk
	 807Pu9SvsWXkk0szqZCZdYUwGm4wY87HbWAY9tu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEAUZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:25:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45806 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEAUZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:25:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id a10so85770otl.12;
        Wed, 01 May 2019 13:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NYns9XpnphK6szv5SEMiVX6iTl8gQljiQwlent8Rn9A=;
        b=WQ1Gbxrk12R+S4U7V+0TKf10LuTtJIDuBROIDY5Ni9YKYcS8ONSO5uhp0LLuNKwZLV
         IX6yaUPnoXySc/vFp8urBzorBF/CVXVRCYFTtaz6RmgPTCLfQDajc3Ll291d1j4RpM09
         Wm/sHPMeRK4EBk/D0w62XEvNoRnOYviN15vnvZZQoiTWhQykUa51hvcfa3AkgJ2s8gss
         fepBcbTc9axLL68RlLDFDdbsu4Uljh1rwfL/NS7j3pbJIjqBPIpZrwbrQDH6f/b+TBLu
         wkw1Ja5tmeKzqgZvEHcDB1VE+lcpbpZPQkKd/mfa0YHI5I2tMNXfOcrQnQe7b13xnqXL
         hlOA==
X-Gm-Message-State: APjAAAWNam9bqWieoVp56fczcZJ/Q/AHa1vrIH1vMJ6vPsf4hM0b+wBq
        uILL60jsgfW57NJ4BZyvog==
X-Google-Smtp-Source: APXvYqwMZKRtssUNrD1zPRVi56HIIK9LZgJvd6s1ukd98Qq60sSI31JlavCo1HrpyN3esU/uMK3vrw==
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr3972863otq.216.1556742306623;
        Wed, 01 May 2019 13:25:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 189sm16943760oid.35.2019.05.01.13.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:25:05 -0700 (PDT)
Date:   Wed, 1 May 2019 15:25:04 -0500
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
Subject: Re: [RFC V2 01/11] dt-bindings: soc: Add dvfsrc driver bindings
Message-ID: <20190501202504.GA32615@bogus>
References: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
 <1556614265-12745-2-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556614265-12745-2-git-send-email-henryc.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019 16:50:55 +0800, Henry Chen wrote:
> Document the binding for enabling dvfsrc on MediaTek SoC.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/dvfsrc.txt    | 23 ++++++++++++++++++++++
>  include/dt-bindings/soc/mtk,dvfsrc.h               | 14 +++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
>  create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
