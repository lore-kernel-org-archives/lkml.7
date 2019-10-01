Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7353C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7484521906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569941116;
	bh=MbUa04KuNgItVwY5USdZ6TyEdh7Ae9N8Gs4WWEOl86M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sBpdyqBIRJTbvb/W7d7zeacute5Tfk0sg4h9acOPk5h4/bEiUrUALOAQlrSdlMAlS
	 2IFq29CIiMVLopzcJ4bqW6oNnYP7c9kZWPnIM/R0nFlk4aH2vb1HrVjDTgsXf+AhOi
	 RMbAfa2GpWdE6tINjOZldrdTVdaEQFzeUwLdkezg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389226AbfJAOpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfJAOpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:45:15 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4F9520842;
        Tue,  1 Oct 2019 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569941115;
        bh=MbUa04KuNgItVwY5USdZ6TyEdh7Ae9N8Gs4WWEOl86M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFmKGT1bGiYOjq9NeOF6ZlszpMGlsbIQP4oklizKksH/InvFpuvFnOy4k0wabtFDW
         EqN1M0DIAr0OMno+B4E6NmjoP+uDU2LQHX8AG8EWDe/er+gUhiF5mnlanLkBXk6/aQ
         AbfIJ9LTT2c0htND9zDy2ebgWId43mIb+VYq8iqk=
Date:   Tue, 1 Oct 2019 10:45:13 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH AUTOSEL 5.3 087/203] ASoC: mediatek: mt6358: add delay
 after dmic clock on
Message-ID: <20191001144513.GW8171@sasha-vm>
References: <20190922184350.30563-1-sashal@kernel.org>
 <20190922184350.30563-87-sashal@kernel.org>
 <20190923182159.GV2036@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190923182159.GV2036@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:21:59AM -0700, Mark Brown wrote:
>On Sun, Sep 22, 2019 at 02:41:53PM -0400, Sasha Levin wrote:
>> From: Jiaxin Yu <jiaxin.yu@mediatek.com>
>>
>> [ Upstream commit ccb1fa21ef58a2ac15519bb878470762e967e8b3 ]
>>
>> Most dmics produce a high level when they receive clock. The difference
>> between power-on and memory record time is about 10ms, but the dmic
>> needs 50ms to output normal data.
>>
>> This commit add 100ms delay after SoC output clock so that we can cut
>> off the pop noise at the beginning.
>
>This might mess up a production system, please don't backport it.
>In general delays to eliminate pops and clicks that are part of
>the PCM statup path (as opposed to DAPM) are not safe to
>backport.

Okay, I'll drop it, thanks.

--
Thanks,
Sasha
