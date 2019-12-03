Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5EEC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D9F2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412145;
	bh=ZDwlZcEh4OnMpDgXDfGnbemvackMvCJ/D0nXnz0P1Ow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fqa+NvzsBySvWN3R42p13ayKkfrDaQFLOPcEOeimCntuSpof2AMn5pH+z/L5ddtXa
	 3T7w6isfmn6mzEwYY9rWCSuaPcYM/SIqtAPDxhV/Q4mI2n190dd1E6W9rPD18dtIe7
	 8OYfGze3eeQVbfo/06wH71yNxIUMYK6VJuwCjgSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLCW3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:29:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbfLCW3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:29:03 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9442073B;
        Tue,  3 Dec 2019 22:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412143;
        bh=ZDwlZcEh4OnMpDgXDfGnbemvackMvCJ/D0nXnz0P1Ow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cM957qncrcp7ghV2Fqz53oQOIB+zquJzFTZDg7axDyXoQLJHILOfBseyNF9yTQmPc
         IM0lweyB+cBA4xdv4I9iciu57pL3EfY5zs35YakuareM5lKXAQLfQaX1M8RSJFXE8d
         0Vjtw+KLAdDpCSdtD5o7cp20feLCIcRUc0qhbNHc=
Received: by mail-qk1-f178.google.com with SMTP id d124so5190051qke.6;
        Tue, 03 Dec 2019 14:29:03 -0800 (PST)
X-Gm-Message-State: APjAAAUI5tq8Jjaun2U16AiDiNamb5AUHpJ6sedIXu6GMn7dOZu43D6V
        alzexj5cwjKYhN+92F6Tq3c79DjqUTtW0vXwKA==
X-Google-Smtp-Source: APXvYqy48vLvDIG0rC+yzxuPzMvN5G+2IkpyHG90OUQ5OAN24HZI4iXG5QbUFNLup+OAMp3ErXCIG11O3mwffMrXkwM=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr7985272qkg.152.1575412142251;
 Tue, 03 Dec 2019 14:29:02 -0800 (PST)
MIME-Version: 1.0
References: <20191119194623.23854-1-robh@kernel.org> <46d7e474-d2b0-10e4-d9dc-f7783c49e699@gmail.com>
In-Reply-To: <46d7e474-d2b0-10e4-d9dc-f7783c49e699@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Dec 2019 16:28:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKEmEm+XULPEyxP9O+H6dwtD_B+yYaJbeZPWXn_NJhZWg@mail.gmail.com>
Message-ID: <CAL_JsqKEmEm+XULPEyxP9O+H6dwtD_B+yYaJbeZPWXn_NJhZWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: leds: Convert common LED binding to schema
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 10:46 AM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
>
> Hi Rob,
>
> On 11/19/19 8:46 PM, Rob Herring wrote:
> > Convert the common LEDs properties bindings to a schema. As trigger source
> > providers are different nodes, we need to split trigger source properties
> > to a separate file.
> >
> > Bindings for LED controllers can reference the common schema for the LED
> > child nodes:
> >
> > patternProperties:
> >   "^led@[0-4]":
> >     type: object
> >     allOf:
> >       - $ref: common.yaml#
> >
> > Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Dan Murphy <dmurphy@ti.com>
> > Cc: linux-leds@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/leds/common.txt       | 174 +------------
> >  .../devicetree/bindings/leds/common.yaml      | 228 ++++++++++++++++++
> >  .../bindings/leds/trigger-source.yaml         |  24 ++
> >  3 files changed, 253 insertions(+), 173 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/leds/common.yaml
> >  create mode 100644 Documentation/devicetree/bindings/leds/trigger-source.yaml
>
> For both 1/2 an 2/2:
>
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

Thanks. You should take these in case there are other changes during the cycle.

Rob
