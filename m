Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53FDC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A424205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575496869;
	bh=yx4r9GPAAXhlpqqHHdFk6q931E8dJfCntRGF5ZzPq+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E6URKmjXSofj3mAJI74mzMl3Q1A6X8mTBODWf/mC0y71ugErSMzVHbbOfyub0EbRU
	 X5qyRt+ni0kq2TkTPb+Q7h5lBuQxbX7LWRZJbivjGmn3F2MLiOkbrz3qRc7HE7p4+f
	 GbVFoQyf77tVQBYYai5QgStXlnzS3evXFRIn4IAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfLDWBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:01:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46718 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:01:08 -0500
Received: by mail-oi1-f194.google.com with SMTP id a124so709968oii.13;
        Wed, 04 Dec 2019 14:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oVB+SJrxK3RMm51aDtljP2ankvSuypjIzEocNKn6UpM=;
        b=oFQZNnk6+4LFPJTLUGZquB7SyciRfnHTMDEZUfJNr/PtdrfWlObvNXNEsDfXOgQc5c
         kyGFlNzy4zfHrmkm+dtMbZHS4w1ez6qhPcwgCNyS0M9sxq9H0QHGI7ehY9nfGxeOZK6I
         WkhHMlufrstzBImoQOpkkrU9yxcAdvko/7EGyIIIi6LM46e1dMNPabjaFslHKLNFxz7t
         TcqwB0uWNy/UGJ5DbsxD4tuwVd8613mkOLKIi3Exbmd2Up02YhCye7JU5O1cO0Fvwr66
         m9qzeSMKG+0r0MRqWQv7Wg+l5Ocqbf0Takk6ZKaIeZxvOtxtINY3IT8b48GOZcau8FIt
         Gw7A==
X-Gm-Message-State: APjAAAWZaV9zNtZYh2jrE+m22sC1nXpVIE4/4INrj/AmO7XeqP7Zu1lF
        lfZVJmuFbCrsqAFiGPfrTA==
X-Google-Smtp-Source: APXvYqy5PaRTvaNg7atPKSB0FWnrDYidmZNc445kfj9NxtzhCF6A5nZanw5rMCLux8b7qY6RI8v+sw==
X-Received: by 2002:a05:6808:8e:: with SMTP id s14mr4219438oic.160.1575496867234;
        Wed, 04 Dec 2019 14:01:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r24sm2644286ota.61.2019.12.04.14.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 14:01:06 -0800 (PST)
Date:   Wed, 4 Dec 2019 16:01:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH] dt-bindings: regulator: Convert stm32 booster bindings
 to json-schema
Message-ID: <20191204220105.GA25020@bogus>
References: <20191122104536.20283-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122104536.20283-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 11:45:35 +0100, Benjamin Gaignard wrote:
> Convert the STM32 regulator booster binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> CC: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../bindings/regulator/st,stm32-booster.txt        | 18 ---------
>  .../bindings/regulator/st,stm32-booster.yaml       | 46 ++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-booster.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32-booster.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
