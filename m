Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E76C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA931206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSUetHQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfHNNUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:20:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44493 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfHNNUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:20:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so111051514wrf.11;
        Wed, 14 Aug 2019 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EIBOABIhW8p4vzMRIEIDWwrsBhpWXDFAybGkjCNWRKQ=;
        b=FSUetHQY6NRHgTkY0+nBdWFJhmFzuUxs2z5T3kR2+7DfEMmcxcbkaQAaG/MLjdK2Jx
         W3pN2sZcErE2CpzPS/mBfXv7yBsAinrTX22+sqg+ev9kQMb3PT/+YHWt8V0PDmNJrkEN
         C0mCY6/4cjaPJ/i+JOLKIUD3DNn5FR+W82rhROSX46F7wheZfQ00+PTTYVQRuDYotIWY
         nHIQ95J1Km9b67RHKI76D8tQ22pTJyAdhqQgjTMhXxu9wG6HotCsTQtonuyR679Z2Eze
         bQAEKrHNV7J0xc/EJmcpfdY2U5vphstL9ERZJrJItotY7bcSGvVpsDyN/wkRbyB4d3NX
         odlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EIBOABIhW8p4vzMRIEIDWwrsBhpWXDFAybGkjCNWRKQ=;
        b=lFTjql8HrK+wfG4ZedRXiSBDpEAe/+Lcwaet3m8OYrxC5fChWxgOtO8bLD2r4UbeDp
         MhuI3gxPoCCWYyobpXmk7sbDfZxVsX+x9mFg+/08wPH3Nnqehrv9Coz7DRnkieVL4WV3
         TsMKWjemZuPWYCGUmyC1uth7ylxGDFzhclsetRS2kiRmOD1Vt6zAxJdwm8Y/BoTTZqew
         Y8ddqwB8V+FhvWrIYiBCSuw923PuMpxH6OmOKBWE9HeM8lJfbXAJ4CEQY+5HuKMA3A1y
         LzHapEyyhn86Vjhu/ekNB2nOQziXZ2R9QYKdD2KOvV/rE37gdekELE/jajNZOOXjwejY
         ns7A==
X-Gm-Message-State: APjAAAUra1jYhuD/Cq1PiEHjCPRSaW3WORzCBfWBGGJaG87tTlkIDfw4
        vjprS0ogW+VFraZ7mqM9DS4=
X-Google-Smtp-Source: APXvYqxPxJNpFq7yShoBZbT8+30pBidnt6vzd5XarUfPJG8vd8rhksyYc2DlG70mMUr/6xJy/kvXCw==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr51924177wrv.247.1565788804469;
        Wed, 14 Aug 2019 06:20:04 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id 39sm30148509wrc.45.2019.08.14.06.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 06:20:04 -0700 (PDT)
Date:   Wed, 14 Aug 2019 15:20:01 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-sunxi@googlegroups.com, mark.rutland@arm.com,
        mripard@kernel.org, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH] ARM64: dts: allwinner: Add devicetree for
 pine H64 modelA evaluation board
Message-ID: <20190814132001.GC24324@Red>
References: <20190808084253.10573-1-clabbe.montjoie@gmail.com>
 <1648748.TWHgARQioU@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1648748.TWHgARQioU@jernej-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 12:56:56PM +0200, Jernej Škrabec wrote:
> Dne četrtek, 08. avgust 2019 ob 10:42:53 CEST je Corentin Labbe napisal(a):
> > This patch adds the evaluation variant of the model A of the PineH64.
> > The model A has the same size of the pine64 and has a PCIE slot.
> > 
> > The only devicetree difference with current pineH64, is the PHY
> > regulator.
> 
> I have Model A board which also needs ddc-en-gpios property for HDMI connector 
> in order for HDMI to work correctly. Otherwise it will just use 1024x768 
> resolution. Can you confirm that?
> 
> Best regards,
> Jernej
> 

Sorry I didnt use at all video stuff (like HDMI), so I cannot answer now.

Could you send me a patch against my future v2 and I could test with/without.

Regards
