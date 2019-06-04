Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D069C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B56020874
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfFDU3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:29:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46766 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfFDU3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:29:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id z23so5878179ote.13;
        Tue, 04 Jun 2019 13:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShuaCglHMPdgyal6GGIwZRaEUD77Ogg+O3HSaYQ63/E=;
        b=CVlglNZ3fYT4sh8jRWA/ENRM9vOKKJjFYdOARzZ1z7pILRDYvcSXjw8hfk1n5DZB46
         +Wpw97xUeg2KhxiPjzKvwzLsF4dV6hXeSdH9knYD608BgLnxcm9eaq0nwetMrWFA2ApI
         rxwP6BdCLtfkLy2d0piYEl8AX12J58q19PkEWtxIrskemvH+Wl+qSz0NsaWJSBBECyqI
         Lb5R+24tRU25cY7s9uj8/UoIX3Xrsr5ytlM3S4XF1ZmnG0bNJ/XY8onMb37q18vDnRAi
         J1WW72rkqXCF3ZWLffe8szpKfcSSq/sg6akDLZqg3VKxZlCt/f+y/nNBeEmHOkipSmIY
         20YA==
X-Gm-Message-State: APjAAAXu9ecDkXRoi33uMBcaZLaumAoKA0RyxksZQ/bcH53NIoGyd+Ie
        8NZFDzxcoDMTtK5VX6G2HzcEB4nGkdQ=
X-Google-Smtp-Source: APXvYqzdjcPNxGvRaK3k9+6Xl7HY5PmwVR+6Vap5/aUXIsaKiT4UalW3DZdexmg8fg9F9Ie21T4Lqw==
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr457114otq.162.1559680175033;
        Tue, 04 Jun 2019 13:29:35 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id v13sm6022078oth.23.2019.06.04.13.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 13:29:34 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id t24so7102820otl.12;
        Tue, 04 Jun 2019 13:29:33 -0700 (PDT)
X-Received: by 2002:a9d:6058:: with SMTP id v24mr441623otj.110.1559680173629;
 Tue, 04 Jun 2019 13:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190501092841.9026-1-rasmus.villemoes@prevas.dk> <20190513111442.25724-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190513111442.25724-1-rasmus.villemoes@prevas.dk>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 4 Jun 2019 15:29:22 -0500
X-Gmail-Original-Message-ID: <CADRPPNRfAk2ZWJQt=Wx5SEqvw4iSpzkj8_XvHa_CZYHDAxFgxg@mail.gmail.com>
Message-ID: <CADRPPNRfAk2ZWJQt=Wx5SEqvw4iSpzkj8_XvHa_CZYHDAxFgxg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] soc/fsl/qe: cleanups and new DT binding
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        Rob Herring <robh+dt@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 6:17 AM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> This small series consists of some small cleanups and simplifications
> of the QUICC engine driver, and introduces a new DT binding that makes
> it much easier to support other variants of the QUICC engine IP block
> that appears in the wild: There's no reason to expect in general that
> the number of valid SNUMs uniquely determines the set of such, so it's
> better to simply let the device tree specify the values (and,
> implicitly via the array length, also the count).
>
> Which tree should this go through?
>
> v3:
> - Move example from commit log into binding document (adapting to
>   MPC8360 which the existing example pertains to).
> - Add more review tags.
> - Fix minor style issue.
>
> v2:
> - Address comments from Christophe Leroy
> - Add his Reviewed-by to 1/6 and 3/6
> - Split DT binding update to separate patch as per
>   Documentation/devicetree/bindings/submitting-patches.txt
>
> Rasmus Villemoes (6):
>   soc/fsl/qe: qe.c: drop useless static qualifier
>   soc/fsl/qe: qe.c: reduce static memory footprint by 1.7K
>   soc/fsl/qe: qe.c: introduce qe_get_device_node helper
>   dt-bindings: soc/fsl: qe: document new fsl,qe-snums binding
>   soc/fsl/qe: qe.c: support fsl,qe-snums property
>   soc/fsl/qe: qe.c: fold qe_get_num_of_snums into qe_snums_init

Series applied to soc/fsl for-next.  Thanks!

Regards,
Leo

>
>  .../devicetree/bindings/soc/fsl/cpm_qe/qe.txt |  13 +-
>  drivers/soc/fsl/qe/qe.c                       | 163 +++++++-----------
>  2 files changed, 77 insertions(+), 99 deletions(-)
>
> --
> 2.20.1
>
