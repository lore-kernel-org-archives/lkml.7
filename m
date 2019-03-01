Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89407C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5708C2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="huVCOPQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbfCAOej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:34:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40666 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732420AbfCAOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:34:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id g20so11653431wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AzFdI4Ntgdj97NpgFu1Pq76ZwiCCfhzfWbTnGLzmdoQ=;
        b=huVCOPQttUFCzUU0qCt7hcrvx7oj3fKY/KikGZx1sk6HqGcdMi1I4gPxFh7Ic9rB3u
         +JNNU226XzPNSShC9xiNV97IExCOBg1B1JUzjp4ah9CsM8E3Z1h6QNTDAG2QYBONQawq
         09AgF1p/RG2YNOc7mGV5fO/F3wr724YgebXkWYCbtah81zVuWZU2wm7HIIWIzjFEtoCM
         K/AXyhXqPQd/GN6WX669GUP71JUWH2KmyYYDVKfpwq+qxxrpi8DcWnwxMVWHDTd2Oe0q
         RmMpZnONkKAiLApZQrTeu4uD7QnzYWk2/XjOhM4/pcYs6fh9cPrZe3vEa6fDMjF220Og
         tVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AzFdI4Ntgdj97NpgFu1Pq76ZwiCCfhzfWbTnGLzmdoQ=;
        b=Y2OM2Fv2eQw6jkTdYlEvJ1z6jDwzJg31eekayDEDLuTfTiylZ2RUEvlxEjusfGxVEs
         Z+Za20xc6qWnSSFNQkx1dNUjbmzriAX/sctFkFEYTRNtUTTa6gXnp6gjrrGDuYeKc7cB
         tlqMoDQIGJZz2fvJdBfjKBAFrnxfB8/knwlGPo7zc/l4fR/K3qIG3LWTU2JysUSkh+pP
         ABeyhkh0N2bO5mjZd7WNj1xeZ2JsQzAvnbJK2IKs+GW3aMkPhZaLn9YautDT+p70r3uW
         +N614diaX37Rk5uPXM5bMf2GxJMLFvYAy6ezf4PfVyzi83P3YtUCEkpyq47blglkD6vQ
         PgLQ==
X-Gm-Message-State: APjAAAV/sMRunV1jvDBlC4m3g0aZiawrcU+yTYJXQy/nElSkZ6bVjXep
        BH69aLKIUUsdTzqJPZsOqnApSchKdK2I9feDCQMEEw==
X-Google-Smtp-Source: AHgI3IZ5L2ZtjE5GWfu+b4LVWVTc58GkJZmXVJl/lkAxeSQtEy6vedWYbn4M8QWVnkCqM3skdkM82Z8IjOOWCHN7Ois=
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr3464632wmd.126.1551450876504;
 Fri, 01 Mar 2019 06:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20190301062432.2322-1-axel.lin@ingics.com> <201903011929.WkN8JU5R%fengguang.wu@intel.com>
In-Reply-To: <201903011929.WkN8JU5R%fengguang.wu@intel.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Fri, 1 Mar 2019 22:34:31 +0800
Message-ID: <CAFRkauDMAeEaptv5UZBGND=-58q-E0ssMaZjVw5XOUYZ2gTsrQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: lp87565: Convert to use regulator_set/get_current_limit_regmap
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Mark Brown <broonie@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot <lkp@intel.com> =E6=96=BC 2019=E5=B9=B43=E6=9C=881=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Axel,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on regulator/for-next]
> [also build test ERROR on next-20190228]
> [cannot apply to v5.0-rc8]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]

This patch needs patch1 and patch2 of https://lkml.org/lkml/2019/2/28/482

I sent it today because I think Keerthy can review and test it together
with my another fix for lp87565.
I didn't realize kbuild will pick up the patch automatically.
I should wait until the required patches get merged then send this
patch. Sorry for the mess.

Regards,
Axel
