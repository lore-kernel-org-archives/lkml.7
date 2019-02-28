Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DF6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962382070B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jcp24AHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbfB1S0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:26:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39094 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfB1S0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:26:36 -0500
Received: by mail-ot1-f65.google.com with SMTP id e15so8989787otk.6;
        Thu, 28 Feb 2019 10:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyGOj7Gihme18THlIsxBEwmuaWg/66u0OonCSBOQ/tA=;
        b=Jcp24AHY8pB7BJZgi1sUWUdOOzbymlUQevFIeTORPRV7okf9El5+AgAjQt0NBe1p8h
         qkBEB3mFuhthuBkJ8U80oQ9+bUTrSj/1AFCELpKSIAma5eofCKUjP3GOJnC4gfmBTBTa
         +T9VXIKpWeGyjqsqNfi77E1PvVHfH4SED02R4YfxUmESnoGasMXCF090YIaFFTb0FQL5
         7PtwEUooSzjVtjp72MMFotfMH3iUwDdMfUam08Nbwl8Au2HY5eTjCGmGyIWL14bmJzbg
         H4Nbpbvg+9sW5+D75tmZdKUDPpIgeVLQs4njvzpmWV7DAh74CeV5/GBR9avTG/FozJLi
         SRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyGOj7Gihme18THlIsxBEwmuaWg/66u0OonCSBOQ/tA=;
        b=BXlWMObq7T5cTM80Wpq0oLVDYamBNEUs3+B27EyPsxu+oZLYHhD4gHpbVTvbqaE79j
         Sky7U5sy1Ih7G3AzvS0BlV1kEFRe6sNHYqJczQ0R4pQmqGLFQDTDexLeW12M8UmEpS6/
         Oir/3yUKPk2MI/b6OrEm4KFsHVzTEdMYloO/ehvh9fMUnVkloCUBcAdgADsIKM/SE6Yc
         gevy3si+xzBJGK3GndTdYBf7EYGGkUcG8aecqiYfmuBnmBcX00PbO0GIRPPgCLO5LJTG
         EkLHkw09Rt86wIfUQbX0FcMxUPsrVAAmhlLDnOR2TyXsVgx8qm6HVktbBmkYzDLhnA5u
         GbgQ==
X-Gm-Message-State: APjAAAURFeBV/utkWyEw6BuWQ7QUpv4+n3pXhNzQ176a7WJujbh3WjJC
        7PGs5HXCtT74MEtIurYELkiYgQYvoanvfhuMeq0=
X-Google-Smtp-Source: APXvYqybVt/daya+4TN5DCOkkqcc3v8bPG+2WLMaEE2ZfN3Aq/qJknlyO6vaLHUd3XMREV8LdMlHOANkIjbB8Y4OxPw=
X-Received: by 2002:a05:6830:14d6:: with SMTP id t22mr664116otq.255.1551378395802;
 Thu, 28 Feb 2019 10:26:35 -0800 (PST)
MIME-Version: 1.0
References: <1551321831-11597-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551321831-11597-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 28 Feb 2019 15:26:25 -0300
Message-ID: <CAOMZO5C6UOG5aW2EiUMNqMjsQRqqotDWvtA=EBwctYicxXJ1yw@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] dt-bindings: memory-controllers: freescale: add
 MMDC binding doc
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

Hi Anson,

On Wed, Feb 27, 2019 at 11:48 PM Anson Huang <anson.huang@nxp.com> wrote:

> +Required properties :
> +- compatible : should be one of following:
> +       for i.MX6Q/i.MX6DL:
> +       - "fsl,imx6q-mmdc";

You missed the entry for imx6qp.
