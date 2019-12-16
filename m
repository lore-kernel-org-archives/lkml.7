Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E13C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353CE206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576511559;
	bh=eaQ3x3sQJkJ+Ir/RJSw4LQ05zXXPEkT+Q2g7IkDI1xk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zOGX4J5V2yyKOVCmsMuBuqmOcwb5GzHYqMBmShbhkR3G3DFon45doUNCe5EFOBCtu
	 DTgxQwk4K3eR7fha7vFIAoH1cj6YJMjXTezzGVDmokuHBMRR1citzk8xuxbkU14a+4
	 DaL0gTXlY5f+wz+FnJnKB4ZKApamqx5YRZ0XiN0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfLPPwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:52:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfLPPwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:52:34 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 941902146E;
        Mon, 16 Dec 2019 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576511553;
        bh=eaQ3x3sQJkJ+Ir/RJSw4LQ05zXXPEkT+Q2g7IkDI1xk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lgRlANm6ITls3sYB0vkQAD5vJ57JdMCMEmQ/XRM0hA1divZOs2sBzjxEwuea7F3a7
         ZAVlVG4YApTTQ/jZ68HF7/swo8gY4cFHYBLoYfyuvleEGHa3MTCyE1ipkW679xQY1G
         eFE5gJNMOLFuUWQsTsLrlxPgMeabqRVppPGDh7KU=
Received: by mail-qv1-f44.google.com with SMTP id l14so2293794qvu.12;
        Mon, 16 Dec 2019 07:52:33 -0800 (PST)
X-Gm-Message-State: APjAAAXb8i6qbCpmyTM+eR23BkUA2pmVn8hz7vbNMZ2j8UBJ0vIqeV7g
        TGf8IDaUcP5rV2NYQm6nAHPoPOuGzrumjiaclA==
X-Google-Smtp-Source: APXvYqwVJYkAlWIdZU2TFQfbL6hRU5QxGwsrdp61SPZ/B7ThiZyfT8pRxhhI4yQUPA1YvRv8RCRQMv+9we0zkJBDmxg=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr25719233qvu.136.1576511552698;
 Mon, 16 Dec 2019 07:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20191202233127.31160-1-ray.jui@broadcom.com> <20191202233127.31160-2-ray.jui@broadcom.com>
 <62254bbb-168e-c0ad-a72d-bd659a2c23fa@gmail.com> <0f0e965b-2e57-8b6b-0c72-1a1008497793@broadcom.com>
 <20191213235013.GA9997@bogus> <a5af90d0-eebf-3bf8-46d8-75160a1fc7de@gmail.com>
In-Reply-To: <a5af90d0-eebf-3bf8-46d8-75160a1fc7de@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Dec 2019 09:52:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKXdo+wouHZV9VFQojtQNK3NOLmj3NtnTmVo2fX541GPA@mail.gmail.com>
Message-ID: <CAL_JsqKXdo+wouHZV9VFQojtQNK3NOLmj3NtnTmVo2fX541GPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: Add binding doc for iProc IDM device
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ray Jui <ray.jui@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 6:00 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 12/13/2019 3:50 PM, Rob Herring wrote:
> > On Fri, Dec 06, 2019 at 05:09:34PM -0800, Ray Jui wrote:
> >>
> >>
> >> On 12/5/19 4:09 PM, Florian Fainelli wrote:
> >>> On 12/2/19 3:31 PM, Ray Jui wrote:
> >>>> Add binding document for iProc based IDM devices.
> >>>>
> >>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> >>>
> >>> Looks good to me, it's 2019, nearly 2020, maybe make this a YAML
> >>> compatible binding since it is a new one?
> >>>
> >>
> >> Sorry I am not aware of this YAML requirement until now.
> >>
> >> Is this a new requirement that new DT binding document should be made with
> >> YAML format?
> >
> > The format has been in place in the kernel for a year now and we've
> > moved slowly towards it being required. If you're paying that little
> > attention to upstream, then yes it's definitely required so someone else
> > doesn't get stuck converting your binding later.
> >
> > BTW, I think all but RPi chips still need their SoC/board bindings
> > converted. One of the few not yet converted...
>
> Is there something more to do than what Stefan did here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ab06837dd269b600396b298e9f4678d02b11b71d

No, that's it.

> we could convert other Broadcom SoCs, and there, just found another
> weekend project!
> --
> Florian
