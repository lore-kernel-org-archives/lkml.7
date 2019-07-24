Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457DFC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFD62173B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ek1BINi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfGXSnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:43:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39296 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbfGXSnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:43:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so21650963pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qiU1TfBT/KK66R/TOLH5DkaauwA1Q2lRA1rBib8JZqo=;
        b=Ek1BINi7A7AhMjbtrG2l3eWV3rDIsxSJ7uaNLpNZrH2IMmmO2Uekvun1GK8CJiTCnh
         Me3Czt/+vvR8/SoH2HVlIjRTO9TQr7BXiZ50k3jrYhmh7kAcDk+icjL8VDghTfdY9Epc
         WUdyNQ+SFJbCJtDFJeHM/eM/DKweUy7/JWgZ/MfBEKZynUUg4NOB2TqrI+jSWjeOb4qt
         mxieuG0DTD3pcFUQV5GrEhwopopk4Io70FPuxsT8CbWMidQdjfk7iENHqYW8kfgtyZJk
         o9LOgtEfvLEAYGK1thWzXEY7mxJiVcE+WSU7prQV09eZyRX8QNEuuMa2oIM/YaVFN79m
         qQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qiU1TfBT/KK66R/TOLH5DkaauwA1Q2lRA1rBib8JZqo=;
        b=dkuuLkZWuONaulKITmm2TJlkjChjUvMzjj2lmwjSQftI1bLaCmm8zM2xNtauZBLsr5
         1HEkFEihbZsoUXuYwuaYaCi8vu71GG9SEeNZ4+K8ch4kvYxkJswKt/DU86VXpBLP5aiL
         PxpxrZdXsatBtX2rNaIwlCVnTWlauobCWy1oe78lsySeiH7P6TTiPf3G4NSUnuAGDUbM
         iYS/ujIJCsKciF2wLifBw8T+Bb/j6tSGpq7qFuSCSb5hizHXtTnGRNLH/GQNAK3dQT9G
         lOSVO4+4toIInsuTxC0KMY+qsonxAYzGD9HjEUXwnbE06TAEgveXXcsoFUewR6pl03g2
         pOFQ==
X-Gm-Message-State: APjAAAXlLgKzHGLaazgcFlrCykQfVDtna4IKw1P6vQaxQt1s2OviyQUZ
        +nCrjUZVa7DQKj7qPSLoMQaDkAnz2Qk=
X-Google-Smtp-Source: APXvYqwZ1wGRNPflbmAAPHX2GTDlZb9Q2mKbFReCTbmwBkJ7MwJlzjjPqV2xROXE1gpvPpzze7UpKw==
X-Received: by 2002:a17:90a:20a2:: with SMTP id f31mr88160029pjg.90.1563993822260;
        Wed, 24 Jul 2019 11:43:42 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p68sm58404643pfb.80.2019.07.24.11.43.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 11:43:41 -0700 (PDT)
Date:   Wed, 24 Jul 2019 11:45:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: msm8998: Node ordering, address
 cleanups
Message-ID: <20190724184507.GN7234@tuxbook-pro>
References: <20190722165823.21539-1-jeffrey.l.hugo@gmail.com>
 <2165bbd3-aa60-bec0-4ee7-dfb7dc1dd1ad@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2165bbd3-aa60-bec0-4ee7-dfb7dc1dd1ad@free.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24 Jul 04:16 PDT 2019, Marc Gonzalez wrote:

> On 22/07/2019 18:58, Jeffrey Hugo wrote:
> 
> > DT nodes should be ordered by address, then node name, and finally label.
> > The msm8998 dtsi does not follow this, so clean it up by reordering the
> > nodes.  While we are at it, extend the addresses to be fully 32-bits wide
> > so that ordering is easy to determine when adding new nodes.  Also, two
> > or so nodes had the wrong address value in their node name (did not match
> > the reg property), so fix those up as well.
> > 
> > Hopefully going forward, things can be maintained so that a cleanup like
> > this is not needed.
> > 
> > Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8998.dtsi | 254 +++++++++++++-------------
> >  1 file changed, 127 insertions(+), 127 deletions(-)
> 
> LGTM.
> 
> Reviewed-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> 
> Rob, Mark: when there are multiple reg properties, why is the convention
> to use the *first* address in the node's name, rather than the lowest
> address?
> 

Per the ePAPR (section 2.2.1 Node Names of v1.1):

"The unit-address must match the first address specified in the reg
property of the node".

Regards,
Bjorn

> e.g.
> 
> 		spmi_bus: spmi@800f000 {
> 			compatible = "qcom,spmi-pmic-arb";
> 			reg =	<0x0800f000 0x1000>,
> 				<0x08400000 0x1000000>,
> 				<0x09400000 0x1000000>,
> 				<0x0a400000 0x220000>,
> 				<0x0800a000 0x3000>;
> 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> 
> "spmi@800f000" instead of "spmi@800a000"
> 
> Especially, since the reg props could be in any order here, given the
> lookup by name.
> 
> Regards.
