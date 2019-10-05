Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDDCC3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138192133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgjWKlxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfJEKqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 06:46:11 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44085 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfJEKqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 06:46:11 -0400
Received: by mail-ua1-f66.google.com with SMTP id n2so2777815ual.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 03:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NBau6UJ6WL2ddYtAYMdA80zmZN/G42WesJCt0Zydss=;
        b=rgjWKlxW9tafdD4yyJKlyJ3fDSeUYo3JZw3SUJ0LHcNajjFT4Wa47p58hsp3+NL64T
         6KBk/fGyySiX5MNzTu6tWQSHsKgdN5WgcaRrbJYdrv24bE1eWk2I8xdAXDbk96a4tosK
         RmtzUENrWXv/rqlDhVEwKMJeogEs5cW+gyDBGsJs35G+95cS4+7qYrqCMpjL0Xjz5xOz
         bME61cVek/zFyDevyHVLeXU6RbY5hjFdbbqKNuRWFzsFcD8TA3iCmkr3nGAYlVns2D7l
         Dyet9QXEy/VF+wDG6WVXCsZYucQag63sGLRjhnkK3PHtGWeca/je8frl4HErW1Z+8dty
         zWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NBau6UJ6WL2ddYtAYMdA80zmZN/G42WesJCt0Zydss=;
        b=hOyElqwvLRNF67laN/mtcPANOkGYlixsHAqfCyv4WkubXx40mNyRIFsLQUrnGfSf+c
         DLj3/9JsUMM/yoxJqQ9Ko0yXSCaxafFW/jO3KSg+3DQuI3710tiJ+51CUTKltSy/YDgx
         XZRE4a+oSr2CTCAXVlnz5F+Og+rSu2C3Smode4Jr6HpuOkAPBBFTHYSK+55QGlnHRNHE
         YM0pp/JRqazJUORx/QMIuR5pMDPfr/fedpzwTJi931hpQDcg9iN58UvmlNLm+9hQLcfm
         YGYWmzrEQlyOoNCGMl/QfUm2ojYMAOWI4MUmWm61jEpjmpoh7sOPMsM1rrnWEASj44Jc
         KI+g==
X-Gm-Message-State: APjAAAWU6L/DkFjx53x+gcZQ27gbmywf8drniK/KAFu/FYy2vknhf2nX
        CAWbFR6trt41HOYg7Nl6z0hYFygVzKLlpGTrLSzXjQ==
X-Google-Smtp-Source: APXvYqxEOr3RSt51beUrP7OY3vmj41VQD6z59rmXEAfyCOygVKLMa/biB9kSbotTKpovb5quSuYbWvEfv8AdENWlImg=
X-Received: by 2002:ab0:7415:: with SMTP id r21mr1893206uap.77.1570272368324;
 Sat, 05 Oct 2019 03:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <b47ec7088aa4b07458519ab151de92df552a9302.1570101510.git.amit.kucheria@linaro.org>
 <20191003115154.6f2jgj3dnqsved2y@gilmour>
In-Reply-To: <20191003115154.6f2jgj3dnqsved2y@gilmour>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Sat, 5 Oct 2019 16:15:57 +0530
Message-ID: <CAHLCerNoLyQ-e70=1VMPO_J_amA+-2vtHwfoUabo4dhUWj-H0A@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: media: Fixup Allwinner A10 CSI binding
To:     Maxime Ripard <mripard@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 5:22 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Thu, Oct 03, 2019 at 04:52:24PM +0530, Amit Kucheria wrote:
> > This new binding fails dt_binding_check due to a typo. Fix it up.
> >
> > linux.git/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml: $id: path/filename 'arm/allwinner,sun4i-a10-csi.yaml' doesn't match actual filename
> > linux.git/Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.example.dts' failed
> > make[2]: *** [Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.example.dts] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> > linux.git/Makefile:1284: recipe for target 'dt_binding_check' failed
> > make[1]: *** [dt_binding_check] Error 2
> >
> > Fixes: c5e8f4ccd7750 ("media: dt-bindings: media: Add Allwinner A10 CSI binding")
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>
> Thanks for your patch.
>
> It has already been submitted though:
> https://lore.kernel.org/linux-arm-kernel/1568808060-17516-1-git-send-email-pragnesh.patel@sifive.com/
>
> I'm not sure why it hasn't been applied yet though :/

Perhaps a Fixes tag will allow more attention to it?
