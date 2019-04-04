Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71DB20657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snJzknT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfDDStV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:49:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37877 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbfDDStT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:49:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so1671589pgc.4;
        Thu, 04 Apr 2019 11:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fhthWg+4bb693ryKXhtxexq2d6YkIfwzg1YQYQPDMWw=;
        b=snJzknT+5byfixTSvxn0tDY92jhUa4M73mHtAY8HODDdECwTVCSMTlWTTdwDWG+hB0
         62DAxKrSzFRxU3/miEZHDBbE6axSjnkQE0mr37xO6wijyimOMcnz5joNGjcQtk29TUEV
         6Ip6ahAr9N+DJCrC5XqZo+XIoX5RmdEX9F9ZUAyRg7t12m2SFnguu+HQgWwoXvPQT1rN
         j/3rhZ/lMGb78MM9ZDatlK/QigcggHM46u2yMfZVbrvgNLhI771zjP8wpPZSAWlIn0kg
         ptkxTl4oeQ8FMkQSvTZHQlrwnZx4aSOC2tkzP+6/SDCWv2u6nFSJpgKATLvdEiZw3SIP
         EGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fhthWg+4bb693ryKXhtxexq2d6YkIfwzg1YQYQPDMWw=;
        b=PEQeapKaqnyv7IOjKLaTvT6yxUPOl1rJ/ry19QQjmloLJAsAupcXQyWnKjXc7zFgBg
         Gxf5OdB71lmylgMYmjl81kjJHCNCS4lhj/Z1B4kAQji28J65qou/ld9hjnwqjG5Lvtdp
         816PmNE+kDlOi2OYrgoE0GLFJlgaHyJAbg4RGUKQKatjoGznbFlityNU1TNDr5q4UvSy
         QeEu+s5eguCKRFuChZk3cXilwAEFE3seU2pSD+jApIncD21/LfB9lvxPA/FfXKBsYKlF
         INVRqPLqWozFD5r+v8OlFTSqjU7sjj7ujERDNBSd3xMl1j6tnp/oJdxVq+/qdRXr7tPE
         r2LA==
X-Gm-Message-State: APjAAAV18nmwGUsgoERzHIAME40B7aZoSXG4hSfM+04uzOtmdi8CDVvC
        hyaSoCn1CHowxcA4oNYbsJs=
X-Google-Smtp-Source: APXvYqwa/u6rGfPiP1HzQO/KPTKSCAhsc28jq8l48RBohgkD9RjOLuZlNyPB19+4pjXto8k2tt0tig==
X-Received: by 2002:a65:4489:: with SMTP id l9mr7303425pgq.1.1554403758480;
        Thu, 04 Apr 2019 11:49:18 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m69sm30537817pfi.151.2019.04.04.11.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 11:49:17 -0700 (PDT)
Date:   Thu, 4 Apr 2019 11:49:15 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     megous@megous.com
Cc:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        mark.rutland@arm.com, Ziping Chen <techping.chan@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-input@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH RESEND v4 1/4] input: sun4i-a10-lradc-keys: Add support
 for A83T
Message-ID: <20190404184915.GB116898@dtor-ws>
References: <20190327023339.25975-1-megous@megous.com>
 <20190327023339.25975-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327023339.25975-2-megous@megous.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 03:33:36AM +0100, megous@megous.com wrote:
> From: Ziping Chen <techping.chan@gmail.com>
> 
> Allwinner A83T SoC has a low res adc like the one in Allwinner A10 SoC,
> however, the A10 SoC's vref of lradc internally is divided by 2/3 and
> the A83T SoC's vref of lradc internally is divided by 3/4, thus add
> a hardware variant for it to be compatible with various devices.
> 
> Signed-off-by: Ziping Chen <techping.chan@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, this and binding patch; the dts changes should go through other
relevant trees I believe.

Thanks.

-- 
Dmitry
