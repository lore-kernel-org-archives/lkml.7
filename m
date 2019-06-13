Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF08C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB772147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560467087;
	bh=fCq06nbKjkpm7klJsJ9J+Cv/5sxhrKnWx9tGmhqZk8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FoBrzaRSbcHhlZXQYMZVQtQ7M/0HT3fT1MtkagPz/noXiLJwiMh3kOsNS+SyUKe1b
	 m0sXa04oJxSyFrwAvkndFBY3B/XNdcSlcxbBKqhORyWwTSctOqXfX84IHR8G7raFQD
	 R5gkJoyIE/sHUjCpNSRmuqeKN7vaik3Wb2cbXUxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfFMXEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:04:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38175 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfFMXEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:04:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so512135qkk.5;
        Thu, 13 Jun 2019 16:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WvdSBZS6GY1RJhEJtYBVxaPueBDOjU15Kwk1F3xhAKw=;
        b=pc1BpYSZsbFrAU8pADmT1ZwAQdJku8uNWDATtMleW4Ko+dgfX7Bl9NeLyI+X84bSFs
         zL7e2CTwDETICIuQSb/1ngwmrqCr8H1SgVCw/LXkLuBdSp/CdO5p6CK2+G2EqPjED3qc
         VsUThxn3PEWqYkN5Edps8KUnj/yiOq0o6F2RgcIq6IaA7sMl4Sltzq+TJevnObw50G/Z
         XHAkidNgDKFDUoVA+OlNxR8vvT3wSBR1KJmNA0xTiBiTJjuFdUoEIhbmHGX6j7QGTcHs
         Mwyr2DJTI6ijmP8XQ4zCrQtHa1z/ylftARw2Qx7aFjFq9P4kHwOE/vZeZlZ+VgA7g0c/
         mCqg==
X-Gm-Message-State: APjAAAUHMWJnjxZ6fkW9X5IezRsPte1fE9p21VZRHFYquIG7y0JvzF/I
        e8A9wzvA4AuLqmyPr1FyKw==
X-Google-Smtp-Source: APXvYqzScKZ4qE7itNJAlKiopqo9SW2cEVK0YP4JF71kRJYGkwf5iKWWerwdZXEFYIG+JjdrDheMmw==
X-Received: by 2002:a37:aa8e:: with SMTP id t136mr6599276qke.222.1560467084536;
        Thu, 13 Jun 2019 16:04:44 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id y20sm736495qka.14.2019.06.13.16.04.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 16:04:43 -0700 (PDT)
Date:   Thu, 13 Jun 2019 17:04:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gerald BAEZA <gerald.baeza@st.com>
Cc:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Gerald BAEZA <gerald.baeza@st.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: perf: stm32: ddrperfm support
Message-ID: <20190613230442.GA7783@bogus>
References: <1558366019-24214-1-git-send-email-gerald.baeza@st.com>
 <1558366019-24214-3-git-send-email-gerald.baeza@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558366019-24214-3-git-send-email-gerald.baeza@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 15:27:16 +0000, Gerald BAEZA wrote:
> The DDRPERFM is the DDR Performance Monitor embedded in STM32MP1 SOC.
> 
> This documentation indicates how to enable stm32-ddr-pmu driver on
> DDRPERFM peripheral, via the device tree.
> 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> ---
>  .../devicetree/bindings/perf/stm32-ddr-pmu.txt       | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/stm32-ddr-pmu.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
