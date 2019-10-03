Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AD2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCF520700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118201;
	bh=i4Gdla/qLYCwUY8TXC0PxpCn/O4eLhZk3Oh4yJNbqjQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zInew2YK1cFog0YAbCman5KS5Do7hV8wSqzlKB7M+JEFw5qBZua/bmVKyl96zw4hq
	 dfy+OdHpkGwGvoJTTsVqXNWsQo5UTrfiZRj+x15Oi2Ta4sNk28148KZwsJf6lgf82c
	 qC76hhQM41f3uo4x/qibrt/BWdW0SfFaWIqK3R/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfJCP4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730614AbfJCP4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:56:32 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B18C222C8;
        Thu,  3 Oct 2019 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118191;
        bh=i4Gdla/qLYCwUY8TXC0PxpCn/O4eLhZk3Oh4yJNbqjQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y+LYdsAyYVPU+ogedopimwB/UhsnGsp2oUl5tLvk654eTHDmIeoSWG2nCGII7q6zW
         8/Axawckxy8TxeX/6wm6AHbtuWHbXt5CjRRIqm68o9nzigMg4+pQjLefid3sH8WUKU
         BEnk+1qMQXkvQCMtJdagzQSxknxFVWIvIJHvHP7U=
Received: by mail-qt1-f170.google.com with SMTP id n7so4287238qtb.6;
        Thu, 03 Oct 2019 08:56:31 -0700 (PDT)
X-Gm-Message-State: APjAAAXmlS7+fJ+TCZeTTUwZUbiSyFC4mD20SWVSlrHlcalh1isF0IVD
        19fiWqBYLdnmAq2IrNU5s82NfCD3LZqHh0OP7w==
X-Google-Smtp-Source: APXvYqx6BBDgfwU9lYgWoBXJNLC1ki+lOywVLMS4eE76V10EcL1hEp0zvvi4cS5atfEMr32Ls+zx4zC9aO+o+md64fo=
X-Received: by 2002:ac8:31b3:: with SMTP id h48mr11022378qte.300.1570118190216;
 Thu, 03 Oct 2019 08:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <1568837198-27211-1-git-send-email-vincent.cheng.xh@renesas.com>
 <5d93ce84.1c69fb81.8e964.4dc1@mx.google.com> <20191003145546.GA19695@renesas.com>
In-Reply-To: <20191003145546.GA19695@renesas.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Oct 2019 10:56:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK12p48gqZdwNfYGNsBafmjMY=5U=QcHPHZy5sD-nGntA@mail.gmail.com>
Message-ID: <CAL_JsqK12p48gqZdwNfYGNsBafmjMY=5U=QcHPHZy5sD-nGntA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: ptp: Add binding doc for IDT ClockMatrix
 based PTP clock
To:     Vincent Cheng <vincent.cheng.xh@renesas.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 10:12 AM Vincent Cheng
<vincent.cheng.xh@renesas.com> wrote:
>
> On Tue, Oct 01, 2019 at 06:09:06PM EDT, Rob Herring wrote:
> >On Wed, Sep 18, 2019 at 04:06:37PM -0400, vincent.cheng.xh@renesas.com wrote:
> >> From: Vincent Cheng <vincent.cheng.xh@renesas.com>
>
> Hi Rob,
>
> Welcome back.  Thank-you for providing feedback.
>
> >>
> >> Add device tree binding doc for the IDT ClockMatrix PTP clock driver.
> >
> >Bindings are for h/w, not drivers...
>
> Yes, will remove 'driver'.
>
> >>  Documentation/devicetree/bindings/ptp/ptp-idtcm.txt | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/ptp/ptp-idtcm.txt
> >
> >Please make this a DT schema.
>
> Sure, will give it a try.
>
> >> +  - compatible  Should be "idt,8a3400x-ptp" for System Synchronizer
> >> +                Should be "idt,8a3401x-ptp" for Port Synchronizer
> >> +                Should be "idt,8a3404x-ptp" for Universal Frequency Translator (UFT)
> >
> >If PTP is the only function of the chip, you don't need to append
> >'-ptp'.
>
> Okay, will remove '-ptp'.  Thanks.
>
>
> >What's the 'x' for? We generally don't use wildcards in compatible
> >strings.
>
> We were hoping to use 'x' to represent a single driver to match the various
> part numbers 8A34001, 8A34002, 8A34003, 8A34004, 8A34011, 8A34012, etc.
>
> What should be used instead of 'x'?

Enumerate all the part numbers. Are the differences discoverable in
some other way? If so, then 'x' is fine, but just add a note how
models are distinguished.

Rob
