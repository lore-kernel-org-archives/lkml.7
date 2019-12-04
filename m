Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82857C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF7F2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575496898;
	bh=RqWACUmuPudjHR03AtqNM64fs1ZeU7ipJVncyGUzQqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cg7VPiDbqrG0jx4DDgfzgvisPeG+Rm4uHbsV+1ciVmp6souJhQzbodIZ0Rtu2mE3Y
	 fG8A90PQI4N9bgyfepdMnaOnozZlzae4A1Q7bmFkpji5ouDCs9Un5+A7d+CX80mYJF
	 rp+20sUeAzYW4snHFsc0xjT+IKc+QOBILlETeKEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfLDWBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:01:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33491 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDWBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:01:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id d17so756986otc.0;
        Wed, 04 Dec 2019 14:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qKR6o4UGPy9iqIfUp6iJ8SJ9UqWScNbqbObfmkhLaUM=;
        b=iY7lvuXAgKnkd8l66kAM18dWzZtBSNEFJCe4Vf1/nujZw6XtQNciIoF6tF7wZcOs+i
         K8OkDEMFeCXREvX3KfuxxqnOTFWWoH7IzBaLjiHXhZ5gtK/dfdh4qDOZ+XqBTKiIXJMK
         S7gKOvEm5XOEvTPNlnWj+MxlmuhFVsj7fnWts/iXM57t0S6piutMy1x4dfhFMmRKTrfM
         p/kBJOpOC+xGDV3Pa+/d+28bp0RS+Pix38px/4v6WO7m8yO0E049zgZo+36JybVtMu9n
         4W92WuU0FTsUG8Lxz3D10j2VTeTe2Ye9f41WBAPpHBF+3BlWf8wViY2b3bUTcJfSgq80
         yHvg==
X-Gm-Message-State: APjAAAX22KyauK3wsWjUFPI/0miqxFisEfq25wtwf4Nkitq8wL3MXsIQ
        BOsu9yA5G1kJtpASRAV/Fg==
X-Google-Smtp-Source: APXvYqwrPt2PI9ParnlGucs0G+mALP2GoBO6N+l83sOY7Tbcy0oTsamiEFYR6brfLpKlt++s6q558g==
X-Received: by 2002:a05:6830:1211:: with SMTP id r17mr4309425otp.157.1575496896226;
        Wed, 04 Dec 2019 14:01:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i15sm2625353otl.69.2019.12.04.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 14:01:35 -0800 (PST)
Date:   Wed, 4 Dec 2019 16:01:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH] dt-bindings: regulator: Convert stm32 vrefbuf bindings
 to json-schema
Message-ID: <20191204220134.GA25911@bogus>
References: <20191122104536.20283-1-benjamin.gaignard@st.com>
 <20191122104536.20283-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122104536.20283-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 11:45:36 +0100, Benjamin Gaignard wrote:
> Convert the STM32 regulator vrefbuf binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> CC: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../bindings/regulator/st,stm32-vrefbuf.txt        | 20 ---------
>  .../bindings/regulator/st,stm32-vrefbuf.yaml       | 52 ++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-vrefbuf.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
