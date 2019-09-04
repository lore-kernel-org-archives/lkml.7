Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24177C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15BD2341D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567593003;
	bh=amI1d8yBvn/2nQ7SmkYLPb5JPFI1OXVPx3baApwdu8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RMhEEzJqjf6R5OclTriR7ddAaNAHzKKgunzK9IHJF/UN+srjs31I1FTNV5mOe/MNn
	 DGuesAx1zsXogZqBAoBK4QoXJ30JXFp8H5iKkpVJgaroboUPoE8IHqHaaHXGuu8DcR
	 AZaRofamDP1rcjmYFeiWpzhvbRf1PARMvMJfU3Qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfIDKaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbfIDKaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:30:02 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFC1E22CF7;
        Wed,  4 Sep 2019 10:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567593001;
        bh=amI1d8yBvn/2nQ7SmkYLPb5JPFI1OXVPx3baApwdu8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xXG3NamgpFpa7gcnPc4QyAtk7YZUkfh/zMJImAfcZyYdHdyELG/2eiBW6+o8FZwu0
         /Pkw3JsLwiMQIq9fhpUhoC7+NsZN14qmm5haKM5JBM3iK2vY+T1nVBBlqYHO+YkVkp
         38x5ALAStfAInaeaRplFYrEI0M/eiEdsVzxpGIFk=
Received: by mail-qt1-f169.google.com with SMTP id t12so23711566qtp.9;
        Wed, 04 Sep 2019 03:30:01 -0700 (PDT)
X-Gm-Message-State: APjAAAXgbVWrZgTZAyBW49R8AdsG0jE7Dfq2WwOST7kz7lRqW6FOylX4
        2V4uzll/0ajcP6mNCisss07u6Iz3w+wzzy+gpg==
X-Google-Smtp-Source: APXvYqzTP+mgbJl6qP03BXMD1qIfb+4LM4ULeWNvke171DdGIssPz0kzGCRX9eANVeuAuu1eEKJVX3ie/ck0yCk5VC0=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr38455056qto.224.1567593000985;
 Wed, 04 Sep 2019 03:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <1567592383-8920-1-git-send-email-pragnesh.patel@sifive.com>
In-Reply-To: <1567592383-8920-1-git-send-email-pragnesh.patel@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 4 Sep 2019 11:29:49 +0100
X-Gmail-Original-Message-ID: <CAL_JsqK8UpZ1Nn4CbcKgW7xgezy20JtdJ6=niyJK_aV3as6Jxg@mail.gmail.com>
Message-ID: <CAL_JsqK8UpZ1Nn4CbcKgW7xgezy20JtdJ6=niyJK_aV3as6Jxg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: serial: Convert riscv,sifive-serial to json-schema
To:     Pragnesh Patel <pragnesh.patel@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 11:20 AM Pragnesh Patel
<pragnesh.patel@sifive.com> wrote:
>
> Convert the riscv,sifive-serial binding to DT schema using json-schema.
>
> Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> ---
>
> Changes in v2:
> - Replace enum with items in compatible property
>
>  .../devicetree/bindings/serial/sifive-serial.txt   | 33 ------------
>  .../devicetree/bindings/serial/sifive-serial.yaml  | 62 ++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
