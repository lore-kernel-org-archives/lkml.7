Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E8C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8208B20674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFtCSVlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfDWJHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:07:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41061 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWJHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:07:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id k8so254027lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQXl4GI8LCtJ7tchFb4L9MMTTfmI0SP/CuXmkPOuE30=;
        b=HFtCSVlrozghsVO03DrSDcob7GFWQpWzfaR27CikW+86Utt/UyK/MrmfnQyPCRSp+h
         h464X75zu7QUyHTgNdoLPyu3f5p7RD9KCmUK9q3x/IfrGynYaniI0ghGhcrBvsB/Wmdl
         5hAR6WCQuhfi8oFpLLXu2KXcbTjfb71wPuUtgFt2RXNQgdJyvH5/OhD3gwB+de+I/48/
         0mabvFFz8Y4ynHRRTP5q5UHiNdD1jjZLFfc7P0XECTgY/w+/dSEet+Nclo9nzAWXOoIu
         i3gz0HaeENHhXLtR+5jD7jo7rue3L9YYRkemNc0VQvczoKzrsia4A3H3NJrOdLUDZnwQ
         tU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQXl4GI8LCtJ7tchFb4L9MMTTfmI0SP/CuXmkPOuE30=;
        b=kjKwQYFsDTv8KTKI5Vx2unhniBXgfLu68irxSc30URx7bwQgLMLNPgKuzseRj0qtCD
         FnSWvC4N7Ed5Ri2li41rNSrh8cB9XXx37mfKA6TPJ5uAZKG65Km9ojAyPAavAdY8odko
         Tuh6eCs9YXD9nCQpVxCtYCC2dbtdYWCFsN2sYMiGyx0dZXKsZc0008BIRqDgud7GbeLE
         qca1K4DtkY3CjosaiFACaLV4hTAiQ9rLwjkBLAA5P+NHk/0WNnZzEc8IJ0MZ6k0//zyE
         Ral3zEAvNTroQry45iz+MVAN6Fx5pSw0NmUYMJLYxwELpQX/c0df2NIGU/+CG1lColD5
         5Vig==
X-Gm-Message-State: APjAAAWglZrbIXb/8WJBH9Cnxo3SPYSeBUHdfndbB6dXlIBqvPsFObwh
        nHlSCCUzH9JdWHiAmOnV+wxR1lrkKECA0FOBp++gvQ==
X-Google-Smtp-Source: APXvYqyNdvwE6gqpqEskcCvlalr9G+qsUDg6dOPMSJ4cnuChqVrvZPA+aMquD8HT/sxViqQ8X1z1oEDIRzQqkedNDdU=
X-Received: by 2002:a2e:5056:: with SMTP id v22mr3133244ljd.153.1556010459966;
 Tue, 23 Apr 2019 02:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190412141158.21246-1-axel.lin@ingics.com>
In-Reply-To: <20190412141158.21246-1-axel.lin@ingics.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 11:07:28 +0200
Message-ID: <CACRpkdYbJtNdZctOdLt7Yy7iYKV9FkQWUb==CscZ80xX_UWjSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: ab8500: Constify regulator_ops
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 4:12 PM Axel Lin <axel.lin@ingics.com> wrote:

> These regulator_ops variables never need to be modified, make them const so
> compiler can put them to .rodata.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
