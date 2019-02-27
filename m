Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C93C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D16E214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551311739;
	bh=RmS8JCRC6g9GD+LJAnw0Z4Ys0qNTUtcMDz0v7UNuvHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aLZ7M4fTQxKDsEIFJTUXOZ8gcnDKde0Ck8nqiYmaf0tx8I0e1t17gmeoOweAw1YCw
	 07P9CuvMTwRp+s0WF+q3ss+fp2hWZ8BOqavgsBnKuRFk5jC2Yh+JZPCSycQsgZArun
	 qAEVtVQV6VYRrJVkey1wkL1yaI2XhVPxBUbV4NRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbfB0Xzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:55:38 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41226 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB0Xzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:55:37 -0500
Received: by mail-oi1-f194.google.com with SMTP id e7so15038285oia.8;
        Wed, 27 Feb 2019 15:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gwr0lL7ausIMvl3v87iEFANA1V7ayutRRFTARWb+/x4=;
        b=O9NmHeYnUbbrcXevUBxhntcJdFZydvKHhWQziWrXBI5BPi4cR5TlR5FMRmDwY+sLdE
         SX5Gq6vofO7qH30mAB6VkxZ59KdMMzqkdDH81iXfH4sJVwOyQEQLF1DYI+9GrWSrKy7u
         9Cfnm5IIQkt69I37LGUU6WfY7ySJfBJAQ4O/SkTYHVWmGJv3gW99B5XRiX5Z+fK2MPFy
         ZruPtDBgGfa2JOZeYr+oK84SYaAY/PHx7m5K/7HFbe7BNGxV3N7j7gvqsR1WqgFghFZp
         pXM/No9ctXwjAJx4QLSikZdrkvElgniz2T4H5q66pOZ2fAso37oxTZponlv+TjwGVU+G
         3J5w==
X-Gm-Message-State: APjAAAWivcgeFWyZ8xx51ynpFq3wDDwTnl7C91lv7kVNSygwkVYT9fhB
        vdGaTCfpNmkrHYc50t1HGA==
X-Google-Smtp-Source: APXvYqwxqt3MLEfWgMgyT/vnJltyR2ds9pg/dFvlUx1Ia4FSdn7TpPAp292vaa0D58d5NIlptlX6Tw==
X-Received: by 2002:aca:b541:: with SMTP id e62mr1251040oif.168.1551311736813;
        Wed, 27 Feb 2019 15:55:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v20sm6961184oto.31.2019.02.27.15.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 15:55:36 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:55:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: Re: [PATCH v4 1/9] dt-bindings: mfd: Add ST Multi-Function eXpander
 (STMFX) core bindings
Message-ID: <20190227235535.GA24395@bogus>
References: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
 <1551260094-32570-2-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551260094-32570-2-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 10:34:46 +0100, Amelie Delaunay wrote:
> This patch adds documentation of device tree bindings for the
> STMicroelectronics Multi-Function eXpander (STMFX) MFD core.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/stmfx.txt | 28 +++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
