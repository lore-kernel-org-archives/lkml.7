Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C03C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D2020449
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="TyrKgrHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389670AbfC0SP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:15:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38168 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389927AbfC0SPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id g1so10495333qki.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=EcSrPMl1JUJwbCY92iztc9qaOBbPIQ/hlneZl4HYObo=;
        b=TyrKgrHId+UYpgCdscy1hsk/ZJchlsP41gEIoj2w/IkpPD9torUKlTt0iwPdSDWCr/
         zXbEPgvWGr8IkNoavSeXmpYhipcG0Mxl8xVRMx514voffH9mKe4TxBgLE+ADKjkVq2uJ
         oKJT03Jakrgu851DQ0bqKHKWbn94J0Fmwm57PfvgeZhcdZypqY3o1e/3dIkWUzpmZSN8
         Q5ko3LGTujcXFtNpGYnuqybcyzX6KKeuI9yqQptqzqteS9+zUcZ6n48Bh4Qs1Z5BBMjE
         dEWbNTp4IiSCuIJ87EaSh/7F47Z4GEdxE1CIdcDmu/LqUsta1HJgFdtVuEcmLaWC2tMz
         vp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=EcSrPMl1JUJwbCY92iztc9qaOBbPIQ/hlneZl4HYObo=;
        b=T1ae29vi2jXJ4KAlrSTSeInBuG5S6b7JB24zKxGRfgTC14RgEpsJ5hvS1Ld4FWY6lK
         Q+rqciky5UV6LabPfDLvhxEDqT4ttf5EmD/MwOzFr/lCD+2JqHPX4U6ar9Wdx6K8EIib
         yOdAsLWoxfsvJCz6zgai2dhVACUKbP81r2/7/HeChxKGQ3c4UzFO3Qt4RwPlcVEkf0I1
         vrPVKWxZP5elJW31xq3WiqvIUyKP0Wv/D/t9ONbaWCtVFNV1AwNeoYqziodWF/yDT3xZ
         H6pk1+edDWptbWw9c3qdITsklV0KiIDo+hzSEIMUQvDr/3pOSWT+UsKPDMCZB51AtZ8H
         Gi7g==
X-Gm-Message-State: APjAAAVuPoZGYzcKoqvgQPrSLbH9C//lfa6P/bkZfCHfgOCTMFxvzlh7
        QulqHmgelEAK4ULQqt4F2V8Zvw==
X-Google-Smtp-Source: APXvYqy0pes/HIhQyn4baHq6yseP6CuIFrm6CpgT4TPQyJYaaz/+LcQdDc9XhyeDLenOKDG4q35ZMA==
X-Received: by 2002:a37:59c5:: with SMTP id n188mr29677597qkb.208.1553710553792;
        Wed, 27 Mar 2019 11:15:53 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e22sm14373304qte.42.2019.03.27.11.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 11:15:53 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:15:49 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        John Hurley <john.hurley@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        oss-drivers@netronome.com, netdev@vger.kernel.org
Subject: Re: [oss-drivers] [PATCH AUTOSEL 5.0 234/262] nfp: flower: tidy
 tunnel related private data
Message-ID: <20190327111549.32911fa7@cakuba.netronome.com>
In-Reply-To: <20190327180158.10245-234-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
        <20190327180158.10245-234-sashal@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 14:01:29 -0400, Sasha Levin wrote:
> From: John Hurley <john.hurley@netronome.com>
> 
> [ Upstream commit f3b975778c176b01eba10f869a5a64c6b8550c23 ]
> 
> Recent additions to the flower app private data have grouped the variables
> of a given feature into a struct and added that struct to the main private
> data struct.
> 
> In keeping with this, move all tunnel related private data to their own
> struct. This has no affect on functionality but improves readability and
> maintenance of the code.
> 
> Signed-off-by: John Hurley <john.hurley@netronome.com>
> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Not a fix.

Is there a way to request patches under drivers/net/ethernet/netronome
to only be considered if they have an explicit Fixes tag?
