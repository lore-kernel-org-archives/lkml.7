Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E706C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27327214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552397773;
	bh=00wyTXqWX76U7EJhEj8ZAT23m2crFFSJsLkJ4U8IQwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MhyGRCj1v+CbZoaTaaGw3Iag8HRlQyT4TJh5iemjuJQ2PVdHemNmCMU+3TNOAiWLr
	 cjlCTQa6yyDqJ6lSpdcKKPB27rfXqDc+93+dsoD7Aj0UqsNLtWBoPnMb/FsiSUAYZr
	 sGftqMniHsbSbH2sC3V7AZ4NsphTdP2TRkFEjXtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfCLNgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:36:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45463 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfCLNgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:36:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12so2432418otp.12;
        Tue, 12 Mar 2019 06:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UU7k0eOZg0/Y7Vk5736NSTrT4B9Krd4qGWbggtfpSuE=;
        b=r9D1rTUjxB/qAvmV8BPwmts6G6ddUCLNhl3fKsUV6ZmGn9CnMVescHgvntUxzv9udI
         GF4GWTzJoj1oElMVRUdhT7NsUIe+Z+lQP0h79YnnWtcq04If9F+TnhstEjWj6IniAfA2
         dcPBI//YkdZOuVY0oXbRYn72lxeoCPWoSlcg0ffqcE/Hb5jq6KangWxhxqu5TMTO1x8w
         RWWNtPZ9taLAdd2aMUG0POCN9nRlHibNaPUr+MQGJUFmBLQHt6lbESz79kRkTxtJBXOb
         DHa56ZrshAjITgibYbXEWPutyRhj2cxz0AB22HMFIR1WxbfhQCjtXgLvH04jsp4UewIs
         M3Qw==
X-Gm-Message-State: APjAAAVrAU+9SCF7pPP+hkQIqnBJ5v1u4ZWx79ZKU/Mq1+u+gN04KAr5
        jbCkUlqnZruM3K0C+ee/SQ==
X-Google-Smtp-Source: APXvYqxYkAjFQYd9GvTq6ZGM50y0s50m8F/4PaomQm5+tq6hNZwpYE2cMwpdYoraACxVLX+cIlutGA==
X-Received: by 2002:a05:6830:2089:: with SMTP id y9mr23026751otq.329.1552397770323;
        Tue, 12 Mar 2019 06:36:10 -0700 (PDT)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id h25sm3359075otl.29.2019.03.12.06.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 06:36:09 -0700 (PDT)
Date:   Tue, 12 Mar 2019 08:36:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 03/15] dt-bindings: mailbox: Add a sunxi message box
 binding
Message-ID: <20190312133609.GA31956@bogus>
References: <20190302042951.53671-1-samuel@sholland.org>
 <20190302042951.53671-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302042951.53671-4-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Mar 2019 22:29:39 -0600, Samuel Holland wrote:
> This mailbox hardware is present in Allwinner sun8i, sun9i, and sun50i
> SoCs. Add a device tree binding for it.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../mailbox/allwinner,sunxi-msgbox.yaml       | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sunxi-msgbox.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
