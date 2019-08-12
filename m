Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5795BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A80B20679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R3ughcKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfHLOLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:11:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33372 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfHLOLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:11:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so49762169pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=SGmz9dqjmCs8LvKp8zAPaRvxUXfTfgA9DZoThPq2Zfk=;
        b=R3ughcKyKsB9ynwRlDUsBLeJxI0wTbh9U80+BlPTlWvHY+mqcPo242YZTHm+JtJVAc
         03HDm073tE3NUowLGnh1grX2Jlf2obWoidM+GpcRmXCtxRhD3ML6+Ho3e5CCnYdQtSQF
         YYKNKJVM6zuLv9oARY8wdlHcGrlU5jzsaC5KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=SGmz9dqjmCs8LvKp8zAPaRvxUXfTfgA9DZoThPq2Zfk=;
        b=K503lgBFpA77fthfgLnyWcTFzlfIPeHP1KrP1IDYAAFcrgdK1y2ozWfSUfjXmC95Hv
         86U0FdpDY0G4o3nimYI7zog+1DobZ1PATHMFvMt9mOP2sQXvA6Bnb1/QNmLFpYL5Cbiz
         P0n0Dl916SLpi9Oi+WJgT7HC1YwnXkRFpXBLHEIMRI+KO1KugCb4L664L4D1QI6siB9o
         ZWlfprpwrxMGq/egPC50dxfq2R+4+ObZvzXp8VOPVFGccPZkUA54gqe19CEn89SGI87M
         ZF+imsyaD4r7h3MKV2gODwWR6oshMusqqil+/9uKGa1yQ+3A+yMT/gd4jQ2yD+kjZTCK
         /9gg==
X-Gm-Message-State: APjAAAUGLwWw/vt6wWPD1HrgpxtIxBzYe8EAdv9kpsWrVISnfcgF5gJO
        oy5tSMvUxw9AvLOYF9tgnJOip4p/55E=
X-Google-Smtp-Source: APXvYqzTkLEQ5LoC3N/FY3dMkzdpLY6L3s+itMqvlWa1al4ZT/JMownU9ERVCLrnb8PqFtNEfE3iTg==
X-Received: by 2002:aa7:8085:: with SMTP id v5mr18669427pff.165.1565619110657;
        Mon, 12 Aug 2019 07:11:50 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o9sm70839997pgv.19.2019.08.12.07.11.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 07:11:50 -0700 (PDT)
Message-ID: <5d5173a6.1c69fb81.3bbe4.6118@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <93400d11833bd42c4be0b846416ff1f469904784.camel@linux.intel.com>
References: <20190806220750.86597-1-swboyd@chromium.org> <20190806220750.86597-2-swboyd@chromium.org> <93400d11833bd42c4be0b846416ff1f469904784.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/4] tpm: Add a flag to indicate TPM power is managed by firmware
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
User-Agent: alot/0.8.1
Date:   Mon, 12 Aug 2019 07:11:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-09 11:02:01)
> On Tue, 2019-08-06 at 15:07 -0700, Stephen Boyd wrote:
> > On some platforms, the TPM power is managed by firmware and therefore we
> > don't need to stop the TPM on suspend when going to a light version of
> > suspend such as S0ix ("freeze" suspend state). Add a chip flag to
> > indicate this so that certain platforms can probe for the usage of this
> > light suspend and avoid touching the TPM state across suspend/resume.
>=20
> The commit message should mention the new constant.

Alright.

>=20
> > +     if (chip->flags & TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED)
> > +             if (!pm_suspend_via_firmware())
>=20
> Why both checks are needed?
>=20
> If both checks are needed, you could write it as a single
> conditional statement:
>=20
> if (chip->flags & TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED &&
>     !pm_suspend_via_firmware())
>=20

Ok. I'll combine them.
