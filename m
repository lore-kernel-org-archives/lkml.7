Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EB4C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9617216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKYtsfji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfHNNH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:07:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41956 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfHNNH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:07:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so8766781wrr.8;
        Wed, 14 Aug 2019 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bUiJlyywrd9qOeHggGnBEMrvx4sujv2K9Nz5ZSaq2dU=;
        b=GKYtsfjiL1JCWXffB51v6DlU4Hf4CGt0TzUfD+DWd6krHAm/AGEbDjx4V6lg8DmUxM
         SGcxSQNTDAM5N97o6/T7xde8i4lkyy4/thacoLxGDFZTPbX3TObXcipXS9eizikgW+mq
         AHBj+DSxOiFhDMxsMAf6DAdPOq2C5k4UaqUn9TgaUNlT+Vr2zzCBnyV1d6xCxyHAg+mg
         zP+LgDrsGQEXp80G8rFl8+9UPhHX/Q3TOWCn9zETrIKcb3EM1yLXUewgs1q1Mx4tQu7p
         LG4VZ3dDhNc53CgM7rydsjj0fCJ2fWXBH3l4b3P4TVt8xiR4Xz6GbsQXskNkEoIdpQNm
         kyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bUiJlyywrd9qOeHggGnBEMrvx4sujv2K9Nz5ZSaq2dU=;
        b=qt0If+7DESJHnelyx3fESZDo1Hqlc1gw5Vqjuka9ZE5E2gQs32K9aZvTmG4q+Ce6aw
         CCGewTpItyjWAfIK2E8iAAl5xmxa13Fv2rNZfG+qg15wg5zNe6tvkwx+gIL1+yDlhAfD
         T4IMmTvthTAl2W9SOfxrh46qHxZ+louVTbxqng/39OLgCkEJZdajpY1d4ASqKqFIwsIL
         Wzs2xpLAgWDLy2Bd6W4JsbZErbNP5EV0A62vrcbra8zPIWj9t1PyDt9S8hDsJIUVRlMl
         qf1QXH7kl0Lc95xnpOlDST1HXe+sS2eZHriC2BXf3AlzA0Xj8pC0neFaiiKeaHrNWO/i
         kmrQ==
X-Gm-Message-State: APjAAAUFfCnLNfFNTgVIjtYCttd1tWWpzy+xrO5uAUetw20U69sdqBVW
        uc8wx3icsrq4rUNa/wPyRQE=
X-Google-Smtp-Source: APXvYqx5ozZfahRF9YtaP48lH4QJdsRI2C/SN0gyU2YSeYzTMX4cfhjZV8NYIPqRwSY6ofdZoF83wQ==
X-Received: by 2002:adf:9e09:: with SMTP id u9mr4308277wre.169.1565788075028;
        Wed, 14 Aug 2019 06:07:55 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g15sm24674256wrp.29.2019.08.14.06.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 06:07:54 -0700 (PDT)
Date:   Wed, 14 Aug 2019 15:07:52 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, mripard@kernel.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH] ARM64: dts: allwinner: Add devicetree for
 pine H64 modelA evaluation board
Message-ID: <20190814130752.GA24324@Red>
References: <20190808084253.10573-1-clabbe.montjoie@gmail.com>
 <CAJiuCccEQFvKemTodJbuEDzDy9j6-M4SYskxPFJ5DpsbQDnvkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCccEQFvKemTodJbuEDzDy9j6-M4SYskxPFJ5DpsbQDnvkA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 04:50:35PM +0200, Clément Péron wrote:
> Hi,
> 
> On Thu, 8 Aug 2019 at 10:42, Corentin Labbe <clabbe.montjoie@gmail.com> wrote:
> >
> > This patch adds the evaluation variant of the model A of the PineH64.
> > The model A has the same size of the pine64 and has a PCIE slot.
> >
> > The only devicetree difference with current pineH64, is the PHY
> > regulator.
> 
> You also need to add the board in
> "Documentation/devicetree/bindings/arm/sunxi.yaml"
> 
> Regards,
> Clément
> 

Done, thanks

Regards
