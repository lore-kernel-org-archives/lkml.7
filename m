Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B958C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C40206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553786698;
	bh=U3azWYoY9xJ85oSGbgG1tq5MfoHRVl01jID2cuu3X2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wXO2rK04KEU2bX+R08vn4LQ2XuiLMO2t6AL71r/k2CNKmj+E8Y6TOgU3GAzxI+k5m
	 0oWt78shs7AkJ86LbR+fDEFSV9FTZD3XvlWIyriNxiSHu0ipkHTuvmMEkIcsZWZ/Be
	 5p9WME0TSh8eaDgCmjxftTPt9FGb5ttFP7I7n9Zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfC1PY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:24:57 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38716 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfC1PY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:24:56 -0400
Received: by mail-ot1-f66.google.com with SMTP id e80so18707362ote.5;
        Thu, 28 Mar 2019 08:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OLEhsTdMmsextCr1NiMhv2YTxc8ypZaLDrCx27/q2RM=;
        b=Amf5rDhVLKVK9EK3DyLRC+KrpQqsM1fZbecMf8FChCuul7m2bmOWFMylIhZj4goca8
         6iV3ZtlS3uHukf37gSi5rdCSLopAL+kuiCqiw704EQigrKxsX5eNuPcYDNLkOkqib0+/
         MWfRlAliLQRQAI1/nKICi3Ecq3Z/K64UGnQ/QPMECwGMp6dPGeqONlzpxuwYWJkssm0C
         SOn2jiJ8AcOjvczF6ZCD+x1M8KQ1Kl0j/fyWjNa8Y5PdyTb7JAw1cFticeUx0pofWxRK
         qBBql7wW+FxPOUD7Gow8VVio8aGNowGl474bQjgtbNvLIjH17Y5isOU56lqkP5H6+KoB
         9WQQ==
X-Gm-Message-State: APjAAAVN2g8n4GFk9H5w1M/yRU60n/MBV0g5hs33WWMn8nE+HMlyiTok
        1UKVNbJZKCJ9OhZxS++emQ==
X-Google-Smtp-Source: APXvYqxAYnRWtrxe+CFeXICX28G+N1pD+0v9fHP/jZkXFAjUNeFs8KuQujCrbTL8gkSP6Aqo5Vrz/A==
X-Received: by 2002:a05:6830:11d0:: with SMTP id v16mr9894598otq.159.1553786695142;
        Thu, 28 Mar 2019 08:24:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c145sm5797576oig.0.2019.03.28.08.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 08:24:54 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:24:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 1/6] dt-bindings: hwlock: add support of shared locks
Message-ID: <20190328152453.GA31716@bogus>
References: <1552492237-28810-1-git-send-email-fabien.dessenne@st.com>
 <1552492237-28810-2-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552492237-28810-2-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 16:50:32 +0100, Fabien Dessenne wrote:
> Use #hwlock-cells value to define whether the locks can be shared
> by several users.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  .../devicetree/bindings/hwlock/hwlock.txt          | 27 ++++++++++++++++------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
