Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF90C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2052070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565592231;
	bh=Au2I1+pUG8x4q8Vy+c0mrDmoxr5LQjnxTD3Xa5TQ1QU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nsP7H2aTPUrqmEo5KnufKdVSgF6srI2tPRS32851Au8ajoXAPmWh4ta3XhmtPucuT
	 h+FFHdKZWOIcBWP+i/gDxJnpi7l8QxT5aiqZtJ/vfV62iyD+9KB9ECCu3tdHZ7llLb
	 XotoumKrHfvHKe9ILqV+vebeSvPQZ0pihgwKwfxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfHLGnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 02:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfHLGnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:43:49 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3175E208C2;
        Mon, 12 Aug 2019 06:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565592228;
        bh=Au2I1+pUG8x4q8Vy+c0mrDmoxr5LQjnxTD3Xa5TQ1QU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mbt0BRjkREv80x2Y1XC6k01N3P07Y10yQ0YuB/ojwaH/IlA4yjz+wrMCxIM2bVyq5
         PT4q8AY+Q/0MTBx2VYvfDiW8s/UGZzey9WNhPzsO6iw183/5duURR5uS2WF5IZhscv
         mZGKDaC7SoOt80tFLSB5eU3kVqm2I4ELWgO3hhuI=
Received: by mail-lj1-f174.google.com with SMTP id 15so5534874ljr.9;
        Sun, 11 Aug 2019 23:43:48 -0700 (PDT)
X-Gm-Message-State: APjAAAW64XNYsW1FiwOe67PcZ4ZxCcU5X6JEUBFeSbDrmKC7cGq/4Maj
        oMBap0U7WbTT8pCnTTAe5CBVZc/29AiRqDP+0/c=
X-Google-Smtp-Source: APXvYqwTeVn92BEolAItuNZHe53VnNj3QCoRCdIpcVGtJTAkEKRjOqmtUpzwDjY4TbKPcg+mlkRd1l0/IhIzzOgy18Y=
X-Received: by 2002:a2e:8197:: with SMTP id e23mr608659ljg.80.1565592226364;
 Sun, 11 Aug 2019 23:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190808172616.11728-1-krzk@kernel.org> <20190808172616.11728-2-krzk@kernel.org>
 <de032954-2b6e-5aa9-0d91-c37417c8e162@kontron.de>
In-Reply-To: <de032954-2b6e-5aa9-0d91-c37417c8e162@kontron.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 12 Aug 2019 08:43:35 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf_uJUhNrciK1mFddN+gZ8vxtTEsz_uF7k60+EWYW94OA@mail.gmail.com>
Message-ID: <CAJKOXPf_uJUhNrciK1mFddN+gZ8vxtTEsz_uF7k60+EWYW94OA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: eeprom: at25: Add Anvo ANV32E61W
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "notify@kernel.org" <notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 at 20:09, Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
>
> On 08.08.19 19:26, Krzysztof Kozlowski wrote:
> > Document the compatible for ANV32E61W EEPROM chip.
>
> This chip is actually not an EEPROM, but a SPI nvSRAM. It can be
> interfaced by the at25 driver similar to an EEPROM. This is not the
> ideal solution, but it works until there's a proper driver for such
> chips. Maybe you can add some of these details to the commit message
> here. Also there is more information on this topic here:
> https://patchwork.ozlabs.org/patch/1043950/.

Indeed, I'll correct the description of commit.

Best regards,
Krzysztof
