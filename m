Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3902AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 01:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A972133F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 01:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGN1QWR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfHOBQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 21:16:00 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36164 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfHOBQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 21:16:00 -0400
Received: by mail-wm1-f42.google.com with SMTP id g67so1560wme.1;
        Wed, 14 Aug 2019 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=YGuDiErQQ42Hc0nLZo7ea/SJqM4FxFI42R5TjzsfJsA=;
        b=tGN1QWR2w94STNXJ5XAm9NQnmk4cgErc0cbTOGHK2TyDKczEPSCJgPdL6RavLSXgr7
         Qej4aTK7MHDvw5ynyhPqvrEWJVGfTjyARQxigG+3Lu/JtcRq6grSb9hBTsPommEsCWTF
         eHsNJqO5LC/eslqFmmk7s8rlMiIxvMD9ceXz+2Vep79zwTTOmovB4+GgrJ0R3LqLstib
         qZCpOQ9kf0rtayH0DfiUwDM3ftdMuL9+kTnTYFp0Z6+rYaHm/wdFejUSZG1ltjxXNUL5
         r/0AeT7OaPXtVxQ2l3IzEsGMp7Eaq8eLYuOMpeiNTg2EPAdAPI6LEZQaJJG3yEkz4fyW
         a6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=YGuDiErQQ42Hc0nLZo7ea/SJqM4FxFI42R5TjzsfJsA=;
        b=fyFHvtVjorAFo03KA6LcTAB4lvnSoHTQqm82cSDrFkklC/0BlDEamGVdxW4ubKd+zG
         PpKtTU4pOdzyE61R1QPcVzzENyAG1wLrJB3npQNmoa4385tPmfjVJoznKOJgMHuKR0Ua
         j5u3zPX9nXRaEMtQQIAwLJo3tSr5OX/ccv7CrJ44hOcgRXWepML8HpLpIIlg+8zFn12J
         2J5OmV4TE9FxEgglIUTS9p1JhCBpwegZ66SNJbs/YAQGPEWZtvEk5qMqpCs/8hJIccoW
         r5Qq6H9V3R6b3I7akEkU5KWe40qF88ckXFIR3CkmOqzL3AGk3dj7L5bQe2TYZXFhZmDm
         Tlcg==
X-Gm-Message-State: APjAAAVSzB9fPH8/l5D4uiGEIIqTRZQ7DqJtwHLvmqB1O+3Ro2NTjrqS
        AGX2Pfotvx3NlHsYlh7GOZg=
X-Google-Smtp-Source: APXvYqxkGTdbx6xWI5leTDK/zEYEp87e9rAKfD3TiMJqqDUHviXKINTfVKjgwwNkolNE103wGSdsHA==
X-Received: by 2002:a1c:f918:: with SMTP id x24mr451668wmh.132.1565831758550;
        Wed, 14 Aug 2019 18:15:58 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id z7sm1005714wrh.67.2019.08.14.18.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 18:15:57 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: kexec on rk3399
Date:   Thu, 15 Aug 2019 03:15:55 +0200
MIME-Version: 1.0
Message-ID: <59055782-7fc2-4b16-af8b-a56fb845a43f@gmail.com>
In-Reply-To: <0408cb6c-1b16-eacb-d47e-17f4ff89e2b8@arm.com>
References: <ebcb52be-2063-4e2c-9a09-fdcacb94f855@gmail.com>
 <c6993a1e-6fc2-44ab-b59e-152142e2ff4d@gmail.com>
 <0408cb6c-1b16-eacb-d47e-17f4ff89e2b8@arm.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 14, 2019 3:12:26 PM CEST, Robin Murphy wrote:
> On 14/08/2019 13:53, Vicente Bergas wrote:
>> On Monday, July 22, 2019 4:31:27 PM CEST, Vicente Bergas wrote: ...
>
> This particular change looks like it's implicitly specific to=20
> RK3399, which wouldn't be ideal. Presumably if the core dwc3=20
> driver implemented shutdown correctly (echoing parts of=20
> dwc3_remove(), I guess) then the glue layers shouldn't need=20
> anything special anyway.
>
> Robin.

I just checked simple->resets from dwc3-of-simple.c and it is an array
with multiple resets whereas dwc->reset from core.c is NULL.
So the reset seems specific to the glue layers.
Is there another way than resetting the thing that is
generic enough to go to core.c and allows kexec?
