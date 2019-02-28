Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF09C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B684B218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNTdLMJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbfB1S16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:27:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39218 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731474AbfB1S15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:27:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id e15so8993787otk.6;
        Thu, 28 Feb 2019 10:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Wb4Sk2aPP3ObI+K6cINJDHonqGOmDkpOENIGc6U7/I=;
        b=sNTdLMJAzbD20FJYlH6F90kRnbLXrAy9HdIQQrxX2JPkeZ59MVuOAWO/DExmKfh6EX
         p2T+mxdKn65XawegVHB1XiBaj6m8l9uohk2YoaGdBsf+mnBgz1Gp1T8mXaWWuriNk3i9
         VQoXHbzuM9pBJkxVObYQOBdV3g8d+oxCIejAaAjAKfHyy6/nFnA0RTdxH1TkCVfwXdBE
         2+aFvRIdXt8gnTM3A1/xTzBIlD9H5TTxrXi9YyZ4VIPPWKHenU6RoAnge/zQ3FKu8mDz
         Gkmduus08UeJ5RPOypglc8bRwo2o1R1b+WJ6lizWhQe6nhA2CJ1DpxBeUpKpoLXgHVTA
         SV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Wb4Sk2aPP3ObI+K6cINJDHonqGOmDkpOENIGc6U7/I=;
        b=eekQfO6ROP/14AviYUMhDlTTP0zt2DTTwjysBooIp0AhNZ3MmDnYkgx2bO1mZV9Y6U
         IX5+fYFU5rIyBSdKGY/yFk3+n4dSXcN4VjsccQcLrSNt6a6IU1VS/KmGHj59K5sMNeLs
         pFECRbzKItHLtF3MITvGQp+LjfOUrTKUamFzwUgw4VQeY4oWQe6DiECRaoN61HeiylRu
         IzxIFkZoZiTs95U8yDiZbHX6QjtekO8HbHjDDq1sNHHaERnnS8QG/JSkeVjxUL+nY8iB
         Z+YFNQHzAXdMIjj6OIN2/72ABFn3DBrB/pxIiKGkpPPUwkEX5qh0CnfJMYjZQq8o33Vb
         9HIw==
X-Gm-Message-State: APjAAAXWngCrL1+vmLGg9G2lm+CpVkidmkeB7v30vwpy2BOJmLWE5X+1
        fgUQnJVUfqfDfo7/31bnCIkB+DOY7/y9Vz2VUuY=
X-Google-Smtp-Source: APXvYqwXLVibQkBQ5OOp6Q3QaFYd82w/KgSvtUDOv7BOlbzHPCg1nYCMW4wuiedWgudZ+GToL9h2L15XiM1Jc54ryqY=
X-Received: by 2002:a9d:72c2:: with SMTP id d2mr712498otk.228.1551378477139;
 Thu, 28 Feb 2019 10:27:57 -0800 (PST)
MIME-Version: 1.0
References: <1551321831-11597-1-git-send-email-Anson.Huang@nxp.com> <1551321831-11597-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551321831-11597-2-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 28 Feb 2019 15:27:47 -0300
Message-ID: <CAOMZO5C8CWu2ArCZ1vMzZsmpFKt9RuR+FrfB_P3S35s8Ynbt2Q@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] ARM: dts: imx7ulp: add mmdc support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:48 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> i.MX7ULP has a MMDC module to control DDR, it reuses
> i.MX6Q's MMDC module, add support for it.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
