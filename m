Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67586C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381F52183F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qnx/fCIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfFNRE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:04:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46509 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfFNRE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:04:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so1867892pgr.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GRNhWBdNTilur/4Qu0VKxMp8RHH2Xu/iee1oWBanHcQ=;
        b=Qnx/fCIVfWiWASj1BfPRmpagCrJESCLnbzOnBc+UHuB7cHWif0IVEz9Scq1PY4sOPa
         LYsNN2IgRPUMtrZYbx4LxU6tScbnCsCWPDXg65TkQ1LzaWJ7mMsI+pnfUBAdU/vmxW5K
         XU6T/Ku592e7S9+k0xRE5vsFZxS04ZzR/EY/pjIGGs0iSxzw1rbdWZOYaTCPM2jqJ4Qg
         nbqVm2/XlJY3x1/5lmX4rDO3jNiPEnKC9n3rz0YEiW4Rasx3YTPVGbCwCd4txEMzqu8p
         Iqo9+V9U/472EEGlT2arMhZDYMBQkiA33FRYpciTYnUb6ok6MYm3syLElTOzoVzKykSL
         lMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GRNhWBdNTilur/4Qu0VKxMp8RHH2Xu/iee1oWBanHcQ=;
        b=AaFJR7ueNdUrjqqNM00DUXR3lFioAdKhtaJzmvEfM2RhfHa0l4eXLQ88pHXVAdnzXS
         5VtLrCxB9pwxx6bS/SrIi+qJVMf+XW9vjcgxWyXcESBE080nXchlbW2ONcGMtoy9LV3/
         hoT5Ci2BABZVTRj3mKK1L3iPIRhzD1/yb6oaGuzzigl6+DBV/2wUmOaSkv7d7mEq5qlP
         EFNi8Hk90AEjOmyu1170Zaru7Y/TdW5rI/Pgc+/2YU4w5HyMMgGfLxM5nArJAbAVjueV
         eCAskW62C1yeHueSAjYE7WTJ04DdfnwoqQCC9jDHVCH2sZ6F4AeWEzVSnRWIuZAtpw9Z
         ea+A==
X-Gm-Message-State: APjAAAUaCS8wcQBz6YlWTmLj434S7uMQtbfowrj2K93wjl2Wur2Xe0yX
        KYsryfhiXSTHDd1Ud8hPz/yt
X-Google-Smtp-Source: APXvYqydptQgfMZN2eXp0DabgkT3g1XVFZjDoA9VlZwMca7DYvYxnhdTYKAHeYylQKIGsw2h9X4FtA==
X-Received: by 2002:a62:1515:: with SMTP id 21mr21874961pfv.100.1560531898101;
        Fri, 14 Jun 2019 10:04:58 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6298:46a1:bdd9:1134:3bdd:7ab4])
        by smtp.gmail.com with ESMTPSA id n1sm3061706pgv.15.2019.06.14.10.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2019 10:04:57 -0700 (PDT)
Date:   Fri, 14 Jun 2019 22:34:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: arm: Convert Actions Semi bindings to
 jsonschema
Message-ID: <20190614170450.GA29654@Mani-XPS-13-9360>
References: <20190517153223.7650-1-robh@kernel.org>
 <20190613224435.GA32572@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613224435.GA32572@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 04:44:35PM -0600, Rob Herring wrote:
> On Fri, May 17, 2019 at 10:32:23AM -0500, Rob Herring wrote:
> > Convert Actions Semi SoC bindings to DT schema format using json-schema.
> > 
> > Cc: "Andreas Färber" <afaerber@suse.de>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v3:
> > - update MAINTAINERS
> > 
> >  .../devicetree/bindings/arm/actions.txt       | 56 -------------------
> >  .../devicetree/bindings/arm/actions.yaml      | 38 +++++++++++++
> >  MAINTAINERS                                   |  2 +-
> >  3 files changed, 39 insertions(+), 57 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml
> 
> Ping. Please apply or modify this how you'd prefer. I'm not going to 
> keep respinning this.
> 

Sorry for that Rob.

Andreas, are you going to take this patch? Else I'll pick it up (If you
want me to do the PR for next cycle)

Thanks,
Mani

> Rob
