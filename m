Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033DEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF833214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Zl4gAnpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392987AbfETR3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:29:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33474 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391117AbfETR3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:29:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id 66so13782304otq.0;
        Mon, 20 May 2019 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpVsPzn7fqjajsRVSaLIebq0yUptaINVy1fHJtkXPPE=;
        b=Zl4gAnpq82J5MFlntHb0LMgdoq5VDUJmwbDPgV+pzvh/R1GUJdW+JYwH3lZimVSguZ
         M8Ql72g3Sr5ruIVtEKBSvYyQ9D6/Jd5h/xypTp/2Eb2qyG2llH1yF0wrwQHGN9/W12xM
         jflYhcAs12hzCdqv9HDH8rDiUmU6+6zSni6Ed0Nke4aidDeeoqK6ZFrjtqWhw4L4/ZeW
         a5/nJYfzGgixmsy38y0di6MNhvIdwlEANel8J6OK4UxIJjZ010+w7CFwHY9HSYTkRYsp
         sAqiyXLwFjJaTYnbsGVznOGn4nBIo8JLhE5v9rXdZvHyBFYEvTmRuzsLtWA0xT+1ptSk
         Y34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpVsPzn7fqjajsRVSaLIebq0yUptaINVy1fHJtkXPPE=;
        b=NieRsqoNkDTsRy1QekS10xU/Lrhn1IK/ZJC14ysBUEnOUH/HJ+ZDU7Jw60iwwdQNwE
         6m5THig5y89tkrZJQC+q0PjdRdxF/z01ZNzirL1gJfJjLsRF01lOAb9hi2MAydVHSiqI
         oAYsTpXw3+prk+4NDdGmqfF3yqrkgkAC1ey3BVvFY35qe/vs5gAmrbHimTlRlwLTzIN3
         5r6I8fE+iSVYUjVaXh98JkDPGMOw5nexjY/R7nKkCHKBj5+WRx2QlR03ymv2nj6/4g8j
         3xpfjwIqEdNstrFLpsclElj5irEKw3e1bAuxv9SvG/12/pwQDEB5/K96Szihlar8wSU/
         YOBw==
X-Gm-Message-State: APjAAAUNzu8VG8x0jUOnX04d1YISyfw2ZiYaTuzEBSFJzS14RYxma+HF
        9RzHxxDjp0tlnsabxyuZfPcVP5imF46lhYdlKzTcuKMgNbs=
X-Google-Smtp-Source: APXvYqy4fRDdNCMFLSSJ4ARTkpXPXphsa/ThOeZsGf2fWAEnDHoL1pf0F5r3Bjtzvtx9joN495LmCIFtAQ3r2hD01c8=
X-Received: by 2002:a9d:69c8:: with SMTP id v8mr46369281oto.6.1558373369442;
 Mon, 20 May 2019 10:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190520131401.11804-1-jbrunet@baylibre.com> <20190520131401.11804-2-jbrunet@baylibre.com>
In-Reply-To: <20190520131401.11804-2-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:29:18 +0200
Message-ID: <CAFBinCDR_eYBEtbkvF3mF4VdsNuTuWEirAzViYrwVvfjYNpymQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm64: dts: meson: g12a: add ethernet mac controller
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 3:14 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Add the synopsys ethernet mac controller embedded in the g12a SoC family.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
