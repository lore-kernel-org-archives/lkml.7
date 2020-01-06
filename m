Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D51EC33C99
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3965720801
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578279887;
	bh=EjEpGRL9NlxAvX9cNaQGg9dnTQY6YEY9R928u+nuz+E=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=woc7umvPwwM8BCIYipXAC3tB2ekerhnx89zd0g8OfAfBEYqfmWO2JRnruHDXDljcE
	 CSR7zfAuLaOdTnaGmRWfBVdlMXYWneLwtQJygqXTR2ysVtQ6uUMqzAOi6+Q0pbPWy9
	 FjHLm8Qutq1Q2JhNIUwu3ScAca5ue9yMN/BClUMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgAFDEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:04:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFDEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:04:45 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FB7720801;
        Mon,  6 Jan 2020 03:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578279884;
        bh=EjEpGRL9NlxAvX9cNaQGg9dnTQY6YEY9R928u+nuz+E=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=F313OMPGcGNr2cgxR3iMtVtu1+Jem0dBFxVnqgOSdnKYdABWewchNEJM2XsLRa8qs
         TEEbd1oKsjgAqcR6bWE67HT+oSMtNeeFYSY8Krykp+uppBc56EHKx4tHs8nO/UuSFR
         0I2azvHeoUiHM9fdHPwec4IRqCdMZ7hC3YVE0OW4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191114101718.20619-1-peter.ujfalusi@ti.com>
References: <20191114101718.20619-1-peter.ujfalusi@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony@atomide.com
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, mturquette@baylibre.com,
        t-kristo@ti.com
Subject: Re: [PATCH] clk: ti: dra7-atl: Remove pm_runtime_irq_safe()
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 19:04:43 -0800
Message-Id: <20200106030444.9FB7720801@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peter Ujfalusi (2019-11-14 02:17:18)
> This is not needed for anything, and prevents proper PM transitions for
> parent devices which is bad in case of ti-sysc; this effectively kills
> PM completely. Thus, remove the flag.
>=20
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Applied to clk-fixes. Seems important to not ruin the PM experience.

