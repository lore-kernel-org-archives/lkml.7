Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40750C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF7D2068E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuTtyfYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKUSTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:19:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38490 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUSTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:19:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id v8so4331309ljh.5;
        Thu, 21 Nov 2019 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jNYZB6HR+wqb8arHv7GRpKx74US4vUMAWmhWTyj0qTo=;
        b=nuTtyfYl66uUFeJtwZavZv2RL+KDy3Kx0ceTXWBm/F+hSb2lPVMlkN9JCwKlPmuscR
         Lx+B/Tsuhim7vEgUejEkpsWKb0GkpW2m6cu3CwClSUQ14cGcsSJx0mP6usKJ3PpooOMT
         eYDYyosilZbijGTOSFoJ+hpLb39hAjgNtdEsdbJ9usAefad4y08++A5zpcFQB3XUxR5S
         VH264+/DCfO1B8+bZeMDu9zeJBw0V4wzgEFY23Nzvfwq+jtLCPkJwM9WqADu/p96m+03
         QtU2uzQT2tOh6ZY24SaoU0coFdL7yodIghVd70vB2ay8mPlTQ6KnSWbw9OHOA9ANx33k
         CMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jNYZB6HR+wqb8arHv7GRpKx74US4vUMAWmhWTyj0qTo=;
        b=IfyHU7E0UAKF0MN4ZrYXwXd9tJor1VZpyuiD1NYIesp3l1vh25T43JVQ8ga3NZZIdq
         CEiSMmS+huN0eMXJB9ZlwFIyyT1H+vZ+/6pntDXv1tY0CVIpK3ya88CBVy6rxNWvDl14
         XjRaOGCX5tA0Z0scFAD4S6nA2BHl3t3fVl04o5GR7LC7wkWIrwKWXOQBkhqVVLOY54uw
         D9LeO/0hmBziRurpWbQgLyYfPtDkbYYXN0gtwTsqIg5f5W+5uoQKNvIzUdMgD0d026vP
         iLRcGz9wAk5rOelgCMXvpnTaxnms+rloDVid9gfbEjBV1O/yBmKTFgUmRkpGFdhVfs4e
         jNWA==
X-Gm-Message-State: APjAAAXlCXvbHHXAs4dEvgNyTOenAfHSdpP3fXEKISWX8uzsBvYGLXfQ
        0bsfc3YKTZCcNxufOaOjuNmAg+v5xvIASdl+9+E=
X-Google-Smtp-Source: APXvYqw7G7h0II3vpRQ49tl3FIu1BFu1lw3gYIanP66FjIUZU5KfyHrzLC0QC5rCsRo7sFZSmhdHoFwqo9uM+bWKYXI=
X-Received: by 2002:a05:651c:387:: with SMTP id e7mr9151768ljp.0.1574360385518;
 Thu, 21 Nov 2019 10:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20191121162520.10120-1-marco.franchi@nxp.com>
In-Reply-To: <20191121162520.10120-1-marco.franchi@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 21 Nov 2019 15:19:47 -0300
Message-ID: <CAOMZO5BLO6G1bCpTaoRXzn2XaZ0AJcH2t3iouEw9KE3jAYk0OQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: Add Google Coral Edge TPU entry
To:     Marco Antonio Franchi <marco.franchi@nxp.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "atv@google.com" <atv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 1:25 PM Marco Antonio Franchi
<marco.franchi@nxp.com> wrote:
>
> Add Google Coral Edge TPU, named as imx8mq-phanbell, to the
> imx8mq supported devices.
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
