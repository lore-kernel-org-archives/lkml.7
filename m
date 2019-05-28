Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E29C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1C420B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ko5bLkd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfE1UQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:16:10 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:47005 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfE1UQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:16:10 -0400
Received: by mail-ua1-f67.google.com with SMTP id a95so8539584uaa.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2PbUTDuXiAxR50haxEpsxltfONNocyGAYpvkm6Pt77c=;
        b=ko5bLkd/y0RUxLPfQLyJORMqZAJZ0nVfF3nCqs0In1f2QhZLPWX2amL/jAibl3e+om
         BKfY2EVCPBKAgbqF0xzsmG3zFZSODPaVgkcJvPPJS6P8c09Ynx5nItSJcyyyeaP2nefj
         CuP4vKDfBze7YiB/IpCx+JdxGf0Jtst4YpN2xBl+Xa5Prij4hddFW32YgRkGpdYv1fwa
         D9okItb0t5RHxS2Ud3wks5da82bFdQ4RuEjuQW+OBYGSHdgFk+HB+UwFJZcTxFzD1l7L
         e+JP8BYNU8JOi/yTfL8cFdYJHujER2/IFT3zbnXOzSVLtovwT2XyS4cAwYN7Sz2AAbHO
         QhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2PbUTDuXiAxR50haxEpsxltfONNocyGAYpvkm6Pt77c=;
        b=HYj3AwNgO6CZgRM/q1r/UGYQeyYr9NDgAYozVGlB7lXoin05OVxRbLurY4R5y0BD4v
         K4BjYBU1F+1JS2Gu99gVsJt7q1zIrRGzjekLNJ2z6P6bkYECehKJoqByMPcHWvj2XjXo
         etUrzJB85hhJuG1caOLSKcBlO2P8aCcDEyyECipVS6CCcaVp3ePtKxhgErEfxuaIB2Yf
         i1ApZ3piUPnmr4l8sYG5zKecS0Nm4T3shVYYt4I0IScDBOeibDhblkfq8XkCY2y1z1JC
         Iu6jjs0A6m4DKxEja4s9gBsiT+9rZqMpj94MatJet0YFND13ju84940BtVhediOSLh6n
         CvuA==
X-Gm-Message-State: APjAAAVDzrVa8esZl63D9Cy49yffaKhZ3arIws34PsmcHvLiD0DYQP9A
        yOcaCqG7XfqnlnrjdsOjwco9FmLAeUa7sCThDV94CQ==
X-Google-Smtp-Source: APXvYqyQ0hLU7UwIkXoY/QKHPtDLXWNKslpvQscksQMWS+akarx5ZiaNucaVpZ6BllxPV6E6PXcqbQMtRLQ2JTb++yo=
X-Received: by 2002:ab0:24d:: with SMTP id 71mr80022849uas.31.1559074564237;
 Tue, 28 May 2019 13:16:04 -0700 (PDT)
MIME-Version: 1.0
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Tue, 28 May 2019 13:15:53 -0700
Message-ID: <CAJpBn1zrkKMteogJt__6zx6gE+=pO2P5Opv0fSNhZNm9GLGWDQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/1] net: mscc: ocelot: Implement port
 policers via tc command
To:     Joergen Andreasen <joergen.andreasen@microchip.com>
Cc:     Linux Netdev List <netdev@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 14:49:17 +0200, Joergen Andreasen wrote:
> Hardware offload of matchall classifier and police action are now
> supported via the tc command.
> Supported police parameters are: rate and burst.
>
> Example:
>
> Add:
> tc qdisc add dev eth3 handle ffff: ingress
> tc filter add dev eth3 parent ffff: prio 1 handle 2   \
>       matchall skip_sw                                \
>       action police rate 100Mbit burst 10000
>
> Show:
> tc -s -d qdisc show dev eth3
> tc -s -d filter show dev eth3 ingress
>
> Delete:
> tc filter del dev eth3 parent ffff: prio 1
> tc qdisc del dev eth3 handle ffff: ingress
>
> Signed-off-by: Joergen Andreasen <joergen.andreasen@microchip.com>

Looks reasonable :)

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
