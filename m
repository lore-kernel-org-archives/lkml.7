Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F7DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75902206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574348300;
	bh=gyTSJzpcOt0QVr5r+vDYqyTq5GBE/WSYWVfeS5b9RvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k9kYyGPzphux8ZDWMk9YfMLYxynHcVgHuVUdNaZC0R2W2Q6VI4LC3cg1f2J6e9/s3
	 bGgvK3ksFYJqNwA9kfL9mdvRNGU48M+WLWaKB5uV2xkbksMSHhVlVJZ1wpOaQQ94v1
	 ipCY+P8CaFRwWGadgJEQGti3fV0liuaLuIDC1EAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKUO6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:58:19 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36177 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUO6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:58:19 -0500
Received: by mail-ot1-f68.google.com with SMTP id f10so3177533oto.3;
        Thu, 21 Nov 2019 06:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7EIsUYwJkB766iLScM9zDv7o8KxiAB6USuY8ETmVybU=;
        b=f5qeG5fBjoJaBoZ2HFsA1ZkjkiBu7PRLth4nPF4plIVbxEuJtN6suwjSDu/qVA1GDE
         OA+QB3xzt2YVUNHxQ6aMgvX7Yc6+1PMhA8crCH8vH/0rHbf9Dke3qXOXAmuJOzHmq1Ek
         17UDaFZxuq1IP7fPj/O6qDmjlxZpvSuBgXmZh6NG7fuC1gQvD8pa6XhZ0mDqEIPyio5S
         lnUBb0r1vHRnmxpBYAOlSSB9AcSkuezErAtmRtPczkXxpf+j8sZfe7BzPGuztF8MaH01
         xKXmCvt12wRmKRyNVGNagwcUpAQ8/l93/O8vSJXbvwxN29aljlxUet3O2YlTqB36Wba6
         xPQg==
X-Gm-Message-State: APjAAAWzRrnU0+bfAJ5Ljed5uq59Wk8SGPusJ2BuTvbJGmoZz9Db4H7c
        SnPbZra1Ut7Yzdk3Pxjnjw==
X-Google-Smtp-Source: APXvYqzCaXK7A81tARs+0Mx+z8Ukzrqn/rzZHEMewuSJwm726s/GHLxW8FN20eTgJW6E10YMzqCV4g==
X-Received: by 2002:a9d:7399:: with SMTP id j25mr7203672otk.155.1574348296793;
        Thu, 21 Nov 2019 06:58:16 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n5sm957812oie.16.2019.11.21.06.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:58:15 -0800 (PST)
Date:   Thu, 21 Nov 2019 08:58:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v2] dt-bindings: remoteproc: convert stm32-rproc to
 json-schema
Message-ID: <20191121145815.GA4284@bogus>
References: <20191121095225.26775-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121095225.26775-1-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 10:52:25 +0100, Arnaud Pouliquen wrote:
> Convert the STM32 remoteproc bindings to DT schema format using
> json-schema
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 131 ++++++++++++++++++
>  .../bindings/remoteproc/stm32-rproc.txt       |  63 ---------
>  2 files changed, 131 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
> 

Applied, thanks.

Rob
