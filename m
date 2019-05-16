Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56B9C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63D920657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558020771;
	bh=r68WH/4euMEIF03eDgl3acP0UnHdg4XoFgWuEe+zmHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=whFQv3x/XYCr5mYbT/QkkQFXL4pi5MU+3VfxzXr5WpcGTzr2KS5VR2jkYRZRRT/YP
	 x0bxsmkn14RFbGa8lD5qjnlWiy+Ia2YUowvGZU8w7d7pY38TFaoqdp940Xs5Pnvgov
	 SSL/OrvBFcUdarOBno4FfcJTGdhuI6u+gJTKLdbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfEPPcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEPPcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:32:50 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D728C2087B;
        Thu, 16 May 2019 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558020770;
        bh=r68WH/4euMEIF03eDgl3acP0UnHdg4XoFgWuEe+zmHI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zhfDnVk7ujI6CGqluZR6aypzeESD4uPYQ91GeF8Bo5/xBsIX9k94BQ+q2Ia3O8Asf
         kFFy3DcTaWqWZt6s6iftPXG/MOY5b7tTFqJsjY6BvWTMo+LdZvNeK3AGIFDAR+vTnK
         P20VCQijmK3M7urTw5uXt0JNAGbnBnc+e/TgXtqo=
Received: by mail-qt1-f171.google.com with SMTP id y22so4372258qtn.8;
        Thu, 16 May 2019 08:32:49 -0700 (PDT)
X-Gm-Message-State: APjAAAUlRaQHVvNpPDZ9PWq6a7fcLUYmFcYN31MC+tI171vR6VtIzjFM
        xZ45DVUKFBuQCgIbPLtGuEbxIaWadRQmlcv/eQ==
X-Google-Smtp-Source: APXvYqySyBWIP8bNkRclfMXh66OEqZoiEOpv/b5tK4fL27uelE9OPAmunH3JBsEYv3jZ06Wmkpj7Be8lFtgdVnowH0M=
X-Received: by 2002:a0c:fe65:: with SMTP id b5mr40835148qvv.106.1558020769085;
 Thu, 16 May 2019 08:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102817.188519-1-hsinyi@chromium.org> <20190516102817.188519-2-hsinyi@chromium.org>
 <CAL_JsqLx1UdjCnZ69aQm0GU_uOdd7tTdD_oM=D7yhDANoQ0fEA@mail.gmail.com> <CAJMQK-jrJQri3gM=X6JRD6Rk+B5S4939HJTptrQMY64xEWr1qA@mail.gmail.com>
In-Reply-To: <CAJMQK-jrJQri3gM=X6JRD6Rk+B5S4939HJTptrQMY64xEWr1qA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 May 2019 10:32:37 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+dVg9E_EzpoC4Bz1ytUckDGXUcEJyU5pV2HS6rZuKmHA@mail.gmail.com>
Message-ID: <CAL_Jsq+dVg9E_EzpoC4Bz1ytUckDGXUcEJyU5pV2HS6rZuKmHA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: implement update_fdt_pgprot()
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 9:51 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Thu, May 16, 2019 at 10:37 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> >
> > Why not just map the FDT R/W at the start and change it to RO just
> > before calling unflatten_device_tree? Then all the FDT scanning
> > functions or any future fixups we need can just assume R/W. That is
> > essentially what Stephen suggested. However, there's no need for a
> > weak function as it can all be done within the arch code.
> >
> We need to add a new seed for kexec

Doesn't kexec operate on a copy because it already does modifications.

Rob
