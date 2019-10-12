Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7663C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 13:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853EE2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 13:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UerOCV7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfJLN4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 09:56:09 -0400
Received: from mout.web.de ([212.227.15.4]:60579 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfJLN4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 09:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570888555;
        bh=YdsuZrSP+jJJMluIACwENlwHKGfUwYpdRS9znBsqOH8=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=UerOCV7unbMXupz5/JZ7ZHjLBGOSySWDAstzIbEciWvdUk45/iifgUfy2VQizQiUN
         VSifMEWLXQnOoFpVv3rtGt35qOdYI4T9gb/rXn5Y5dkNhR/ZyyV7ps1ewXq9pPIgFm
         cWmjB4R1F4CIiob1+5FmhSesFt0CP4T9VjP8TMhQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.155.250]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lsy7e-1hvSLo3MNO-012bFA; Sat, 12
 Oct 2019 15:55:54 +0200
To:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: clk: rockchip: Checking a kmemdup() call in
 rockchip_clk_register_pll()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Message-ID: <e96505a8-b554-f61e-3940-0b9e9c7850ff@web.de>
Date:   Sat, 12 Oct 2019 15:55:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lfuKZ77lF7iOIkLERuu8Fipch5A0vXrXLcCnxR+nhPRJzXd1O5n
 LxtG8xETpSQLuwurZpMMSk18/YBSZFblP0REDBZ1L8B8W+J1enbIClSuRXZM2U636EPlAdU
 S3YQIZEHCfo17jED1mBt9bw8l4iqtJbPm5M/y1b/ZwljtvrU9fXxrTkWfVmPiKECb279KRI
 4ooFcnZez1ZBL+Ob666AQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pQ0RpfS4Wdw=:uaTSn9e6mWPRfwImIcKNNn
 gbKBjD+IcCl0LnR+GI7YbPxI9NHXx2bC3TJZBIOoyS5GzmoBlMO//dYkNo2uLZXnUjH200Jpt
 8zERy+C+52/xfGQ3X4d4fNqX5ajvNqqsg2K+C5hzZucy1Nev3vKwFOszsefvn0NPqvwqmpDTX
 Rx1BfUG0cWG+8phexbs2k79CrpUXXsONZ2BVo/EMlto3a4ShKDN+XCCGbg7sViK9yXbF0L8dI
 149SfMdzlDEOHol+dP9+Mybwzb7zghMlvp5uM7bOaOds0NpXcvgKJkU4ZpX45qZg9+bNTRXMV
 eaJXLuO3y3BWuWPVcoVQOPfL7ofA/WkioRgI7FAQMVDmgjhgx6Ca3oJVAZtxizEWL3jFYxoY+
 XSRx+41uAh7MWnRcmSLrn1vcPuC4jZDYpr2OPMt5Lpbk8YNkLlAqCbPvM/P/A3GRmlG3wT31I
 fFIWjRJkQlq7BOgEsXEtiutjoS7l1z4pIz9w0bP9VmdzRseH8X9bBecWfTnJ8cTwKrvPqixHr
 UMwf7NxUmPxqlrW3m20aU6iLz7S4iDm+gvU2ODtQ8hAoRj5izjE5yqVOrGobrbYJ9ihoQlvYB
 SV6Eqys8nJJ/Hp5E45wco1FZd6ag3U47owsGUgw2OtvC6et+X2vGy8o4z6daIxLvviQE4PVxB
 1i0vRfAjrBDKGQu7U4g4tT5eMoK9b+qKSVW+gw8nu9byLJ1zS3ylLB9Pj5U8f8YCmeSACyGGO
 aJQ+J88lB0Ds325YCHmASepaOrdrZ49Y2knScabV8LxY+TBYPSoTASpTeaQxKFCpu3aVOBcVW
 vnkDZh57/z6H3MBE/B4oNwRbtzg0cd0guB1KjdEx2zKI5Kf4iwr6apo+tuor6n/swAmhY1Mtc
 wZFz1xYsLwM69g89dS48Ovy1CK6xDuBBr/uUDVNlV3LDqYL2DtY4R0wUF1zDym3PAB5PmyRrC
 HKadU2KCVlpaSklYdrTdRKKt2tHNAyir0sX5e046sSwVIZFbijkerbEOf641xVdjijCbW1VAY
 AouQ4cZ5de/BHvsRfVPQ/JN1IE5dPXFNJO0OiFm/gZ/1U6zvm9LyUaz6j2oWpG1gl3WPPPgjB
 Y2c4halA+RbF8KESIRFoRe0+8bzeWI8RqCVbHw95cw4HHF4N7SQrUCq0/E8VzmdCSKhe7S78V
 Ci0ZHZ3WHYbXhNmEHwAC/fyEVigjVGvbpI1HqlS0XMM7Xby6upoc1+wk7xlFsuPQ3ugnAdNyB
 zZhdSqycu8dIa4Ue408mD2tIttdm7Uai71Zpu9lZyiU4MRA4VQ9KwZ0pM4Vs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried another script for the semantic patch language out.
This source code analysis approach points out that the implementation
of the function =E2=80=9Crockchip_clk_register_pll=E2=80=9D contains also =
a call
of the function =E2=80=9Ckmemdup=E2=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/clk/rockchip/clk-pll.c?id=3D1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a=
#n913
https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/clk/rockchip/clk-=
pll.c#L913

* Do you find the usage of the format string =E2=80=9C%s: could not alloca=
te
  rate table for %s\n=E2=80=9D still appropriate at this place?

* Is there a need to adjust the error handling here?

Regards,
Markus
