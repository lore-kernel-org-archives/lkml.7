Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99037C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3A62183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556139349;
	bh=JB2pTfbdLCrFKBW53Eyyh+L38zpGBWdyy93V8mYDvr0=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=V0QV3mvV+ilFYvKI5DsuYHGF1lRoaFHwr+mcNlwyfKz7ziYyE3Rbs9SrD2Pincuia
	 jAel1/9FhAh559brleluaoekHAabOErLhzqk/a4nBAy7PBq0jL+PwkfOQuLG0j6uG8
	 FKNyzIZN27MLjfCChG3pgX88504A6IFF3U0cMdJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbfDXUzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387467AbfDXUzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:55:46 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E70F82183E;
        Wed, 24 Apr 2019 20:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556139346;
        bh=JB2pTfbdLCrFKBW53Eyyh+L38zpGBWdyy93V8mYDvr0=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=P4Z1foV9w7fCW+EHFfiEe4Tq6PwO+l8457MoNdkEdTofYAXQ1dlspOoXsOe4gp2M9
         0gf1dnj+5VZoiRNQ2E5g8Ct9h+9w5pIRNcdoFU0NMoP9CqULZ4yqWqmElCOUfbHoy6
         y5vzEHDR1OvXXvdUJ0YcChNBynhN9S0ldw+ORd2A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <E490CD805F7529488761C40FD9D26EF12AB29F8A@dggemm507-mbx.china.huawei.com>
References: <1553954142-65515-1-git-send-email-nixiaoming@huawei.com> <155606042712.15276.6873845293187802041@swboyd.mtv.corp.google.com> <E490CD805F7529488761C40FD9D26EF12AB29F8A@dggemm507-mbx.china.huawei.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH v3 2/2] clk:mmp: clk-mix.c fix divide-by-zero
To:     "chao.xie@marvell.com" <chao.xie@marvell.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "mojha@codeaurora.org" <mojha@codeaurora.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "soren.brinkmann@xilinx.com" <soren.brinkmann@xilinx.com>,
        Nixiaoming <nixiaoming@huawei.com>
Message-ID: <155613934508.15276.10077721853967398026@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 24 Apr 2019 13:55:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nixiaoming (2019-04-24 08:34:54)
> On Wed, Apr 24, 2019 at 7:00 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >Quoting nixiaoming (2019-03-30 06:55:42)
> >> The _get_div() function has a branch with a return value of 0
> >> Add a check on the return value of _get_div() to avoid divide-by-zero
> >>=20
> >
> >Are you seeing this in practice? Or just trying to avoid a div-by-zero
> >case that you've found from inspection?=20
> >
> This potential bug is found by code inspection.
> _get_div() is defined as a static function which is only refered twice=20
> in drivers/clk/mmp/clk-mix.c. In both cases the return value of _get_div()
>  is used as divider without any check.
>  If _get_div() never returns 0, then the branch returning 0 is dead code,
> or the return value should be check to avoid dividing by zero error.=20
>=20

Ok. If it's found by code inspection then I'd rather wait until someone
can confirm what the behavior should be when _get_div() returns 0. Is it
an error case that never happens or does the hardware support 0 as a
divider value meaning "bypass"? I'd like to understand that before
patching up a potential div-by-zero case and not knowing what it means.

