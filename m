Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F45C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A7D20879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750435;
	bh=notVvlJTG7arM70zO1IahXn3Vh6K7XI155hcDHLwU1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=n0aFqlPcMdbNbQHcjQfSkcImyioVNHRlEt9MuwnrUTFYiVK2BRGbshPpMoBbTE3cX
	 C+E1w4fX83xCwRL32D4pxPvnWJIABzBYeuSDwgoIumPTmNV0ud4DSGZet1BwDJlmhc
	 A2LIlUXYa77nbiZH7fvBLy55tdKKuXD6doopl0KE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfDHTHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHTHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:07:13 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D51621841;
        Mon,  8 Apr 2019 19:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750432;
        bh=notVvlJTG7arM70zO1IahXn3Vh6K7XI155hcDHLwU1k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hZjNz2R8Q2SafNy2pkoLYE2nWy0m4FbIASaKghfokIfsFaKwWm135b33WGuSnldEW
         7CYXzmmkAo3KSgcWkIDJo2IhJkQfUKLilHVSZKJP0qI+Q4D4L4p5G3UDWavyp0Y8j7
         0vRWohpWd/gkv3Iqi8r+Q1GKNlKWqbaGziJ77slc=
Received: by mail-qt1-f172.google.com with SMTP id v32so16773856qtc.10;
        Mon, 08 Apr 2019 12:07:12 -0700 (PDT)
X-Gm-Message-State: APjAAAXx28VxuOg/zFVoZ5zYA6dfCRdfE8g8bf4vuyZvhmhbKEyV+5n2
        kiwnmTKYINenORSRJBPEL1uPfiMW+P31A54Q0A==
X-Google-Smtp-Source: APXvYqxIuKEm6QsCuMyxKSYf9DqboCj2GF7kP4seEw0UvfqWpMMSM799AJ/qdwAB1r67wOrLq/VikJCRDnYIQud5B88=
X-Received: by 2002:a0c:b656:: with SMTP id q22mr25672380qvf.205.1554750431765;
 Mon, 08 Apr 2019 12:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190401080949.14550-1-narmstrong@baylibre.com>
 <1640dd7b-3576-d9ce-0641-6b6a64a87275@arm.com> <d26f1ce9-c56c-5e51-37f5-0689aa198dc0@baylibre.com>
 <5CA9CE1A.6060109@baylibre.com>
In-Reply-To: <5CA9CE1A.6060109@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Apr 2019 14:07:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJj4pae6AuK=HGU5GuZogFKyAbU_y7Ls_CyTcV6qXH_rg@mail.gmail.com>
Message-ID: <CAL_JsqJj4pae6AuK=HGU5GuZogFKyAbU_y7Ls_CyTcV6qXH_rg@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: gpu: add bindings for the ARM Mali
 Bifrost GPU
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 5:17 AM Neil Armstrong <narmstrong@baylibre.com> wro=
te:
>
> Hi Rob,
>
> Le 01/04/2019 13:24, Neil Armstrong a =C3=A9crit :
> > On 01/04/2019 12:00, Steven Price wrote:
> >> On 01/04/2019 09:09, Neil Armstrong wrote:
> >>> Add the bindings for the Bifrost family of ARM Mali GPUs.
> >>>
> >>> The Bifrost GPU architecture is similar to the Midgard family,
> >>> but with a different Shader Core & Execution Engine structures.
> >>>
> >>> Bindings are based on the Midgard family bindings, but the inner
> >>> architectural changes makes it a separate family needing separate
> >>> bindings.
> >>>
> >>> The Bifrost GPUs are present in a number of recent SoCs, like the
> >>> Amlogic G12A Family, and many other vendors.
> >>> The Amlogic vendor specific compatible is added to handle the
> >>> specific IP integration differences and dependencies.
> >>>
> >>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >>> ---
> >>>  .../bindings/gpu/arm,mali-bifrost.txt         | 92 +++++++++++++++++=
++
> >>>  1 file changed, 92 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bi=
frost.txt
> >>>
> >>> Changes since v3:
> >>> - Added note about discoverable model/revision
> >>> - Enforced fixed defined irq order
> >>> - Fixed typo in accommodate
> >>>
> >>> Changes since v2:
> >>> - moved to a single compatible since HW is fully discoverable
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.t=
xt b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> >>> new file mode 100644
> >>> index 000000000000..711c9ead17a2
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> >>> @@ -0,0 +1,92 @@
> >>> +ARM Mali Bifrost GPU
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +Required properties:
> >>> +
> >>> +- compatible :
> >>> +  * Since Mali Bifrost GPU model/revision if fully discoverable by r=
eading
> >>                                              ^^
> >> s/if/is/
>
> Should I still send a v5 to fixing this typo ? I can fix it while applyin=
g it.

No need to resend. I planned to apply it, but if you are going to:

Reviewed-by: Rob Herring <robh@kernel.org>
