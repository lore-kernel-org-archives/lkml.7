Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7E3C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258012468B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575619783;
	bh=TDuu0Z/gwUKku+CQHKdwFINeazvbar/bioj3SRhqow0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OC/6uvTRbG/Gw6KUkO73DpEgbSqsyBcWGeeHsd5vq04MRNY4Jii9FeEsYL9J6HBNb
	 hEnHzO92nZbclH49qMfOecLku4ElVTBEmNKZUlpi5t+VzhCU2WcgWt8OqyAjSbr1iF
	 GkixOu18w6oBnzlt3DGfMfDOL3IK1zWEhLsIH7HM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfLFIJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:09:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfLFIJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:09:41 -0500
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0A982468B;
        Fri,  6 Dec 2019 08:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575619781;
        bh=TDuu0Z/gwUKku+CQHKdwFINeazvbar/bioj3SRhqow0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WyQ0utPmaHsbG/wVzoc8um4JCFfVNkNJeJXexTOXDXU2rx8i7Xn2P5IhTq67SJBlY
         I6nvJ6SnYuKOfLbPc0dM4mtxZ58xlCpEXiDpEssuSlVmpSlnD/O5r+ryX1sas1b4ti
         tiYm6EiBqArZoWLvpSJ6wr3Aq2SPTGfNo+mDyrJc=
Received: by mail-lf1-f42.google.com with SMTP id 203so4533714lfa.12;
        Fri, 06 Dec 2019 00:09:40 -0800 (PST)
X-Gm-Message-State: APjAAAWcrC4BPRR/CCYRL5a2LYWYPUYitLrW2CBZblOA+DKdidmODTJ/
        /8rab6LdFgb3L2sarzrPxO7lccbBrrOOygp2DCc=
X-Google-Smtp-Source: APXvYqwoeGeFzHRQk9JV8pweuDAJo5lmepN12sLK3MbpE8KCoo3haMb9sxXnMb7tL+YQqRDTj60eqjt12aJqaaWMbJ0=
X-Received: by 2002:a19:c205:: with SMTP id l5mr7254976lfc.159.1575619778968;
 Fri, 06 Dec 2019 00:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20191201075914.23512-1-kkoos00@naver.com> <20191201080314.GA3716559@kroah.com>
 <CAJKOXPet=RyJ3nrcOooHdN0GSO33Ce82-9L_X0oYC2MjN7nOig@mail.gmail.com>
 <CGME20191205160249epcas2p3c1dcb24aba71f6b4264e76ebea36348c@epcas2p3.samsung.com>
 <20191205160243.GA757198@kroah.com> <000001d5abd6$ae5a6b50$0b0f41f0$@samsung.com>
In-Reply-To: <000001d5abd6$ae5a6b50$0b0f41f0$@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 6 Dec 2019 09:09:27 +0100
X-Gmail-Original-Message-ID: <CAJKOXPddtiVVsCd-RUB=HboxSRxmN86uwRYuR_-JZYSYd=cJQg@mail.gmail.com>
Message-ID: <CAJKOXPddtiVVsCd-RUB=HboxSRxmN86uwRYuR_-JZYSYd=cJQg@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: samsung: support driver modulization
To:     =?UTF-8?B?6rWs7ZiE6riwL0hZVU4tS0kgS09P?= <hyunki00.koo@samsung.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Hyunki Koo <kkoos00@naver.com>, jslaby@suse.com,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kkoos00@gmail.com, Shinbeom Choi <sbeom.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2019 at 02:44, =EA=B5=AC=ED=98=84=EA=B8=B0/HYUN-KI KOO <hyunk=
i00.koo@samsung.com> wrote:
>
> To support module for Samsung serial driver,
> I would like to split the file into 2 files.
> Because it cannot be supported in one file both early console and
> module driver
> Thus some function need to change to EXPORT_SYMBOL to use in module
> driver file.
> I'm not pushed yet for module driver.

Hi,

You sent few patches independently of each other. If we did not ask,
we would not get the idea why you need them. This is not how the Linux
kernel development works. Instead, start preparing a proper patchset
to achieve your goal. This patchset will contain multiple patches. It
should go with a cover letter (see git format-patch) explaining why
you do it. This way reviewers will know the big picture. The entire
work should not break existing systems (see comments for IRQ combiner
or pinctrl). You should consider how your change will affect existing
systems.

Best regards,
Krzysztof
