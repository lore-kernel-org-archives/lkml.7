Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0718EC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B6020844
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565742331;
	bh=QJGNq5K2WcYs2wUMlToJJUeku7ZnJDO0C0x7LZ2dbEk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=wlFZw9+aX2Dg/AUwbwqGwRclgaMas5kByamPRZCdA8nccKUR1IR+svGr34sdGg6ps
	 EYIF6s69yJINbPFZZ4oDA1QTJAwdj/XOAOUVt98PGHcrMN35dZRXz9YQsmpENRatCC
	 JxSHoJbZ2H/qeqMuctIfjrC1DlFr7oAz37hM+l5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfHNAZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 20:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfHNAZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:25:30 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 795E620844;
        Wed, 14 Aug 2019 00:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565742329;
        bh=QJGNq5K2WcYs2wUMlToJJUeku7ZnJDO0C0x7LZ2dbEk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dXe909GKrfuIWB/6ClVXkwkHGU1eUgNht8PtfTd39aOQzhMahTui/cQNXOb5U779Y
         6tUAlpb1aeHXZj2HKt5EYKjdnsObv0Jq/W2ITzFGLfqnOF+3r8dC6Sw9QAVqcPSY+J
         ntFwfNkoUkO3xJOmAIKhYyWUkyYje5cD1vOxQLyw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190731193517.237136-10-sboyd@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org> <20190731193517.237136-10-sboyd@kernel.org>
Subject: Re: [PATCH 9/9] clk: Overwrite clk_hw::init with NULL during clk_register()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 17:25:28 -0700
Message-Id: <20190814002529.795E620844@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-07-31 12:35:17)
> We don't want clk provider drivers to use the init structure after clk
> registration time, but we leave a dangling reference to it by means of
> clk_hw::init. Let's overwrite the member with NULL during clk_register()
> so that this can't be used anymore after registration time.
>=20
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

