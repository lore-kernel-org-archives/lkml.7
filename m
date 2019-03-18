Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB65C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860BB20828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kOlc3ISS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfCRTix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:38:53 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:46463 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCRTiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:38:52 -0400
Received: by mail-pg1-f181.google.com with SMTP id a22so12064829pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references:from
         :subject:cc:to:message-id:user-agent:date;
        bh=qqxq7T5e5SNvDLSGq+7M3dJLQIOrKKJn/oIAQ/s9/s8=;
        b=kOlc3ISSirC/Z4adxBQJt4TUkQoEy30wx6L4jqV7uvK3O9KcIZqGwmbYOhLOxeUNNw
         I2BCjiW/D//Bg53tonifGW+wDTKTpvHP88HS/hUgDI2Wp264i56PixcOXexWMUJua2wn
         J37CgWnsvnEtOn+LVBJHLP0jFUVKB/FW4yxok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:from:subject:cc:to:message-id:user-agent
         :date;
        bh=qqxq7T5e5SNvDLSGq+7M3dJLQIOrKKJn/oIAQ/s9/s8=;
        b=VlQipCZ1fUfBhaCQ2FiF33rGLNWkyvlyN9KOUDgiliYqMVPikEGjIw4Il4PoDzTIdG
         6l0PUWqexXUwfoFpj6ZGintNG1v0N4ReCoH60gRVm8rSXvGAGyk+eyqH1okTVFGT5+qD
         itin59ldUgwTlxOpjeOO5NGVU/NTgsxdWX/qhAbri41wX+UrJ6kKUj1AeeDdhbM2UQpi
         dUnDUkKA/MEh1dzwnN6/+XfW2zbviNLrQDJPQwpmiOD96GvmGyVkH2QwaJhDrb6dPGMN
         rlC8LC7z9UCaud6nfDQaMP4QyVRLvHyqW4T4UMOuwEY2JX78swC5bnQZRQo1xNpSNYKT
         sbKg==
X-Gm-Message-State: APjAAAXircF5C7jkYbC01NBascqWJPiUP8FuoFgBv/FEgkb50MOqiDuv
        4saP/Lp0IvEDBOaaif5TJiKhKQ==
X-Google-Smtp-Source: APXvYqwFtiO0T+Xf4AI3DDLsMYvKLrAnkFR1dCO9LFgMsjAal7tAT10BEyXROZcuHQXN3mJC2CUGCw==
X-Received: by 2002:a62:b608:: with SMTP id j8mr21252262pff.183.1552937932015;
        Mon, 18 Mar 2019 12:38:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j24sm19412189pgl.58.2019.03.18.12.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 12:38:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190318183636.GA31345@roeck-us.net>
References: <20190318155457.197339-1-swboyd@chromium.org> <20190318183636.GA31345@roeck-us.net>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] firmware: vpd: Drop __iomem usage for memremap() memory
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Anton Vasilyev <vasilyev@ispras.ru>
To:     Guenter Roeck <linux@roeck-us.net>
Message-ID: <155293792998.20095.17902613055366994243@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 18 Mar 2019 12:38:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guenter Roeck (2019-03-18 11:36:36)
> On Mon, Mar 18, 2019 at 08:54:57AM -0700, Stephen Boyd wrote:
> > memremap() doesn't return an iomem pointer, so we can just use memcpy()
> > and drop the __iomem annotation here. This silences a sparse warning.
> >=20
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Anton Vasilyev <vasilyev@ispras.ru>
> > Smgned-off-by: Stephen Boyd <swboyd@chromium.org>
>=20
> Smgned ?

Hm, something went wrong!

>=20
> Other than that,
>=20
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks. I'll resend with everything fixed.

