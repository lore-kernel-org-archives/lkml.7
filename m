Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7E0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACD021855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552582694;
	bh=2KvM+e1dKx8G6vr07zZ+mwL5R2sG6kd8OGTH1cw/uVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XYaXkcldtWDcKGqRQeNM9P7XiYI4guvVYK3aoppIz5gbrwNnixVtXeoOWSTf3pkeO
	 4ZL+SRBJgufGXjv4yw/A3/v18zDsyFDYdvxegXbMn8i2kQcL5eKMu9kFTbc+pafYy6
	 Q5FUFaJjr8exr6aWmT7iYwrY7PisGl/55rXx4lN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfCNQ6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfCNQ6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:58:12 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D05562186A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552582692;
        bh=2KvM+e1dKx8G6vr07zZ+mwL5R2sG6kd8OGTH1cw/uVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VfjLcKX3N07Hds1Uz6tACSrsd4SDiijY7o4uiHz5AdrX5EPqlBmCiV9H6L/KI02GK
         TPUNzn3AJbFELHix/V6S1JSzxz871SbtOM1mcO+ucmjTUWx4EDmHc/7Zy4FW+lns7s
         5gFkVeqVxP20K21bdHqVXcbNHoreslLLvtgPmgVE=
Received: by mail-lj1-f169.google.com with SMTP id v10so5468025lji.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 09:58:11 -0700 (PDT)
X-Gm-Message-State: APjAAAUZx62AmAJndJqJPZot5UOQBSDCus2AD/8tVr3l3ViH6fVzz8lj
        tE1BQrNA/YMFOL2bcRt8MT5GQqoOieHmnKAqx1M=
X-Google-Smtp-Source: APXvYqzl9EiOW5bi/26C2YGaGAivu/d6MF8GQU/GjSXyO7MLAlAoYci/bw1XXf4/UDBzazF+8dIBcsQY2AcM37DB/SE=
X-Received: by 2002:a2e:5bc5:: with SMTP id m66mr9182060lje.19.1552582690018;
 Thu, 14 Mar 2019 09:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190312155241.17277-1-axel.lin@ingics.com>
In-Reply-To: <20190312155241.17277-1-axel.lin@ingics.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 14 Mar 2019 17:57:58 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfoAEhEbbkOtyqgvBzTdNZ+oFR5Nfu0eJPiV4G3XYaKPw@mail.gmail.com>
Message-ID: <CAJKOXPfoAEhEbbkOtyqgvBzTdNZ+oFR5Nfu0eJPiV4G3XYaKPw@mail.gmail.com>
Subject: Re: [PATCH] regulator: max14577: Get rid of match_init_data/match_of_node
 functions
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 at 16:52, Axel Lin <axel.lin@ingics.com> wrote:
>
> This driver has been converted to use regulator core's simplified DT
> parsing code. So the match_init_data/match_of_node functions are not
> necessary now, remove them.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/max14577-regulator.c | 55 --------------------------
>  1 file changed, 55 deletions(-)

Looks correct, thanks! Although I do not have anymore HW to test it.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
