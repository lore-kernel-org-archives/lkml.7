Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6993BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F52520880
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565221354;
	bh=AB0/GU2h6UDA8h5FXu3N6Lb3ksMEGrIp/OcfbfuwI5w=;
	h=In-Reply-To:References:From:Cc:To:Subject:Date:List-ID:From;
	b=x1h2qx/UuAeiqqU/thqUR/POv+chuwlIU7e1+iavSchi2hTvxJTbswPH/Wgb3GnyH
	 tbjifjQR537/HflI1UZcerTNY/jft93H8KScDJjPnD+/NhYR/6Ri2h81k0L52rIaDz
	 iiT9zq+RHX2G1Cy7sAhR52/dtea3pMsEzTrpdw5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389376AbfHGXmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387981AbfHGXmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:42:33 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27AA720880;
        Wed,  7 Aug 2019 23:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565221352;
        bh=AB0/GU2h6UDA8h5FXu3N6Lb3ksMEGrIp/OcfbfuwI5w=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=g4jKpvg5O2bjHaVoG/3b91MBzydKjYsPJ2V0u9zxzG6GvKDjfXVeFp1uM+ImQHCyW
         9SekbeHZnKbmLeUs0RGRBDVh1e0A5D8PCKq2ZbGyzc0O3hIPbBec02LHfya3GJcxIQ
         wACvdtfptz19RL9raollDDdGq9xtTPTII5QVkuWw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1565037226-1684-1-git-send-email-jcrouse@codeaurora.org>
References: <1565037226-1684-1-git-send-email-jcrouse@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-clk@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2] drivers: qcom: Add BCM vote macro to header
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 16:42:31 -0700
Message-Id: <20190807234232.27AA720880@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jordan Crouse (2019-08-05 13:33:46)
> The macro to generate a Bus Controller Manager (BCM) TCS command is used
> by the interconnect driver but might also be interesting to other
> drivers that need to construct TCS commands for sub processors so move
> it out of the sdm845 specific file and into the header.
>=20
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

Unless this is supposed to be applied by me?

BTW, I wonder why we need an rpm clk driver much at all nowadays, except
maybe for the XO clk state. The big user, from what I can tell, is the
interconnect driver and we don't use any of the features of the clk
framework besides the API to set a frequency. Maybe it would be better
to just push push the bus frequency logic into interconnect code, then
XO clk is the only thing we need to keep, and it can be a simple on/off
thing.

