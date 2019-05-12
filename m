Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE9DC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 06:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9DF21479
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 06:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CIMFNhD+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LC4/aszL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfELGdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 02:33:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELGdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 02:33:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3A4CD60878; Sun, 12 May 2019 06:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557642817;
        bh=LRqOcn3W5Jvg48EvAG/96hFW0+IuN7adcjr82s2fw/4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CIMFNhD+XTQd6tQ6XYm/UvxCTaH1Uf97i3z5sP9Cx9F9XgogmUsL9pSWAvK0oXW20
         CZCxrWepssW7VTgmbskNRGIEFkP4vAt29fYXbV1knanUewKqNpAiG4pfsOmMN163bZ
         sCSbkJPuInOoTVEXtYA1oQyyZd1NDXXSUIQ/7NqI=
Received: from x230.qca.qualcomm.com (37-136-65-53.rev.dnainternet.fi [37.136.65.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 02BCB60112;
        Sun, 12 May 2019 06:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557642816;
        bh=LRqOcn3W5Jvg48EvAG/96hFW0+IuN7adcjr82s2fw/4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LC4/aszL/ryOlHaLdE5r2FtGPVvKWvB8RDmZtXK23ZjB5yhJjJkDQBulREXs5/RAm
         p1AYj12/tdwSrelMNJ2flb8Ymj07f4LLUbMMKoIyvVZSDcPYb1VSCChEyDU4v3Vb9D
         rOBagNXFhMhEufA2SQFEczroIwSWf99XgRWKDQ+w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02BCB60112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org, johannes@sipsolutions.net,
        andy.shevchenko@gmail.com, syadagir@codeaurora.org,
        mjavid@codeaurora.org, evgreen@chromium.org, benchan@google.com,
        ejcaruso@google.com, abhishek.esse@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/18] bitfield.h: add FIELD_MAX() and field_max()
References: <20190512012508.10608-1-elder@linaro.org>
        <20190512012508.10608-2-elder@linaro.org>
Date:   Sun, 12 May 2019 09:33:29 +0300
In-Reply-To: <20190512012508.10608-2-elder@linaro.org> (Alex Elder's message
        of "Sat, 11 May 2019 20:24:51 -0500")
Message-ID: <8736lkji6e.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Elder <elder@linaro.org> writes:

> Define FIELD_MAX(), which supplies the maximum value that can be
> represented by a field value.  Define field_max() as well, to go
> along with the lower-case forms of the field mask functions.
>
> Signed-off-by: Alex Elder <elder@linaro.org>

Via which tree is this going? I assume I do not have take it unless
someone says otherwise.

-- 
Kalle Valo
