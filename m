Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017D1C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA372082E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576884134;
	bh=MdiXcACD5LHvVwITpJvoqXPPYnrRaI8dy0H0hDunzkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=scaBqIEihpJQ1NsyWhrETF0BdBeqXmazz3KIrUxyHe48FgcyDeJZ1ljnoGfaHVwmY
	 GMWGPGNnGXWIJlo6COYwxH4H3Q/t3kC4u1EAGk7iOoFJidiSQplY8ivMY07tkiHwcx
	 7r1qXtnmgdlndc620v0twaRHyKQHWuc+9wIfDggI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLTXWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 18:22:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46446 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfLTXWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 18:22:13 -0500
Received: by mail-io1-f66.google.com with SMTP id t26so11017088ioi.13;
        Fri, 20 Dec 2019 15:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iGnGaTzlaPQuDPbDuv+j/KpCNMFrc187P8QK8eCT+ho=;
        b=Jm565O4KcGosvlRvEdsD7VuXnnSTXfkFqeUiejXfoMHzeWkiLsjwSqppstEDOnQlw6
         FXItBDFuMU0FPpt4fVzJ2WVKHMeYKDd05+2wY4NyuIoUtNWagE24FJfEQH4YJAPnO1aV
         dbw4xvWoiwRelXw4oG/KN/2Bq/83R5DaNPj8kiGy+S0dZHdsvMJRTzTv5Iy2yiijB+Qb
         hq7vX6FOKuP+HndhFm8PmjMz7w4zAjy6x7HZhGIj2W8Mo+5WXCf5kHUR1nHSaA50DLnu
         LllOrmPv0skvL6e/C+S67v5CL4MZWJHftSildSEDemnWekDsJhnr9hrrEcYqebgX8i51
         +Dxw==
X-Gm-Message-State: APjAAAUorgJF1KOLuvpJR/e8Ydl5Na6D3AQwKlKvPIDfxtL36Ur0lSMT
        7pfL3ojQoVUDEgh1f3CFyA==
X-Google-Smtp-Source: APXvYqzaQq+TliM16DK84d0o/LALAuwPTz8TyJrdclzToZvqk8Pp/6zZyxjVWmtaX5B44P1whUENXA==
X-Received: by 2002:a05:6602:220b:: with SMTP id n11mr12411540ion.6.1576884132846;
        Fri, 20 Dec 2019 15:22:12 -0800 (PST)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id d12sm5570826iln.63.2019.12.20.15.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 15:22:12 -0800 (PST)
Date:   Fri, 20 Dec 2019 16:22:11 -0700
From:   Rob Herring <robh@kernel.org>
To:     Yannick Fertre <yannick.fertre@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: Convert raydium,rm68200 panel to
 DT schema
Message-ID: <20191220232211.GA16273@bogus>
References: <1576853660-2083-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1576853660-2083-1-git-send-email-yannick.fertre@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 03:54:20PM +0100, Yannick Fertre wrote:
> From: Yannick Fertré <yannick.fertre@st.com>
> 
> Convert the raydium,rm68200 panel binding to DT schema.
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---
>  .../bindings/display/panel/raydium,rm68200.txt     | 25 ---------
>  .../bindings/display/panel/raydium,rm68200.yaml    | 61 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.yaml

I already have a patch posted that converts this and almost all the 
other panels.

Rob
