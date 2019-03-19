Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4B0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E61820854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmawiaJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfCSQSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:18:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39229 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:18:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so8100791ljg.6;
        Tue, 19 Mar 2019 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etTUqROHw1HaJTDhGvIZt0EO6KZpj1PXGxfhNca5ucQ=;
        b=lmawiaJ7laBrhJoXT9oKxlcozG9uOBBorKHKwOg7X5+FkhgeOHSFmMyd6nWaJ2cES7
         J7pPaRHrO2BAA5p7BzB0kKObmp5RUnyIpdb8wHJ6bVMQTMuuFtZxYf3Bl7OQuQxvDeL7
         zyhoH736JLs3xQumpvzhIYwHYlfjyInbBAeoTV9xla3Ezseo0Cz+7xfgaxgZYttqDK02
         ESXVn4hIuc2FHeUN/T9+h4M2+4gREl6vxfvzYI9y5fFqVcW4DWH6tnoGImrr5cQnSfPb
         7PgA01dC6MwytRRHdARsRbC2cr48adikrZVFu5Oq5t7BEqVhoSYrZQXwVFbixlpbpIvS
         ImBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etTUqROHw1HaJTDhGvIZt0EO6KZpj1PXGxfhNca5ucQ=;
        b=QsUsTSkM4ezEx59Z3GdCgrjwmPbOytD7PYxFWMu3/KKIPX/42T5E6Q6YrYJqKlzzqw
         mjBD7LtddCytOTHQMCpLwIu7eArKqEDxkfEPmtpr8W14AdZrZeQO9tR77f6Nr1v10+bv
         CYmHjNZK25b57M8uEDi5iC872qPxILSWldjAezchDKWvHjXdSfzHyuFm69mcA5gx/L46
         Vn2ERoMtsvPGw1Hl8WLDVFCCLyWDnkf9GPc9pol1Ug5nziUvialQ6o+HQwUt9p0PECPU
         +OZs7ru0wHOmrwb3Yd+/ReAyvs+Uo7cmiao/hPCh829g4nJKzVUKmPgLwOF9qZLHc8pJ
         nIaQ==
X-Gm-Message-State: APjAAAWd/l1a/yhAzzGpl0d+h/Ok74CvbIegbMiBT1XvAP2ZOLGhm4j+
        SNOq3fyXcWqjK4i6y33xU37UNDVpRsvirXgS2ok=
X-Google-Smtp-Source: APXvYqxjX6wgDL43DmN1612E3wvP+tjpcVDOqn7HdQaNehaRdfIGrYyQlMWv/Zb3mf9hA93CqlVRQDkF8msRk3m6vjI=
X-Received: by 2002:a2e:960b:: with SMTP id v11mr10434385ljh.174.1553012314360;
 Tue, 19 Mar 2019 09:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190311213124.29325-1-angus@akkea.ca> <20190319151009.7603-1-angus@akkea.ca>
In-Reply-To: <20190319151009.7603-1-angus@akkea.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 19 Mar 2019 13:18:23 -0300
Message-ID: <CAOMZO5CziDOiA+eVdO-pztw_+PAex9neHRwXAdNLFdgYxr1qNQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: fsl: imx8mq: enable the multi sensor TMU
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Baruch Siach <baruch@tkos.co.il>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:10 PM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> Add the imx8mq TMU (Thermal management unit) nodes for CPU,
> GPU, and VPU.
>
> Changes since v2:
>
> Updated alert and critical temps for commercial parts.
> Fixed node names.
>
> Changes since v1:
>
> Removed references to multi sensor patch.

Please put the change history below the --- line, so that it does not
appear in the commit log text.
