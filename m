Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F00C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF397218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551312091;
	bh=q1T5iaEa2b4R1Gj+EQUVl8fwuZfLBtUF45gOHNybkwc=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=oPxAdANpZX9hD1njFRBeAvDBjnpFavLGU/EKoIoPevRON7Z+9nn0fv+HNvx4gGW7K
	 JsPBxuwvX9zmpQmtAMNIkxHJDL+i+GLNtIYP3CJjEoF/GAbglVNg+w/GVAPaGKy2R9
	 7Ekj/JSgd52QNF0Cq2udeNP3iWvneF5HVRqIXcms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfB1ABb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbfB1ABa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 19:01:30 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A64321850;
        Thu, 28 Feb 2019 00:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551312089;
        bh=q1T5iaEa2b4R1Gj+EQUVl8fwuZfLBtUF45gOHNybkwc=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=zDfH4MMVgN14ka7lGXfzzT6yY2UOpwoM08CbnIi2qMsfzFPy/UNF1wP2A5b/g9iRr
         PwUhxPaX9PMXbmoWzrOiLO2YgO8u71Zefm+U8ke7OoXBMqttzWVLRLqMM5NeX+IBF5
         UTrQgTHzCmkHGL4IJB+ltUYcHyGkireIt0QMTuqg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "oss@buserror.net" <oss@buserror.net>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "viresh.kumar@lina ro.org" <viresh.kumar@linaro.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        Leo Li <leoyang.li@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <155131208867.260864.6630901066653352400@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH v1 0/4] arm64: dts: NXP: add basic dts file for LX2160A SoC
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
Date:   Wed, 27 Feb 2019 16:01:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vabhav Sharma (2019-02-26 02:10:46)
> These patches were reviewed and acked but dropped during merge window.
> Patchwork link was https://lore.kernel.org/patchwork/cover/1004155/
>=20
> Changes for v1:
> - Updated lx2160a clockgen in alphabetical order
>=20
> Vabhav Sharma (2):
>   dt-bindings: arm64: add compatible for LX2160A
>   soc/fsl/guts: Add definition for LX2160A
>=20
> Yogesh Gaur (2):
>   clk: qoriq: increase array size of cmux_to_group
>   clk: qoriq: Add clockgen support for lx2160a

Who do you want to apply these patches?

