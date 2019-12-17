Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870D4C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5466C2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576586539;
	bh=fn0Mzuac6XWWX/lbHquGjs8c6za1aC4Yj8JI7MDkpHw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pDU+cHOdPeK6xseyl3fG/eIWVpaZmuZIjZhM2oermoqaJaX6NNoiXkcNsUwo5Cpef
	 9llT5s0IgY4StMnY0A6mI6ZQ59KqptReGGiKT9DSZ5JzejAUxf2yIXhv9MoKZKNqGW
	 /65GFZhn0Pr1j5RSlRnibXIzuvjQqlKMWRVmzOCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfLQMmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:42:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfLQMmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:42:18 -0500
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C48B2146E;
        Tue, 17 Dec 2019 12:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576586538;
        bh=fn0Mzuac6XWWX/lbHquGjs8c6za1aC4Yj8JI7MDkpHw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dbnFyqnyj2HrknsdSsFIT4Ye6BcJGISFdWg2Cq9UMN6cMktzCIM7a6ys2i4IebeeM
         JTrHctRXis+Fq3Tqe1+CAkWQ4ZHIp5i5QNS5BgWOy4TWs/mpWAux4s8ZgT14NG3UxO
         DxwWZboV7QSJ4aBjEBER0zmVIn+RuQM7p9YUq7tQ=
Received: by mail-lj1-f174.google.com with SMTP id p8so4126731ljg.0;
        Tue, 17 Dec 2019 04:42:17 -0800 (PST)
X-Gm-Message-State: APjAAAUcBf4x7Iriw5p2HgzG9nDIoApZ8B/kb8pbPC3y8fXNNLQntwzS
        0cJ5pV+BB22N6QS+4hVcz3wZkIUV4lDWKDKCiyY=
X-Google-Smtp-Source: APXvYqwkp8CWsEFyEekYy1CYPaxi/8JkVNoBZdvgkoMYBa+yBWdKEK/4Pd+Lr0BWIJi5vIveL7uxDcLnWXady9cM+rQ=
X-Received: by 2002:a2e:b0db:: with SMTP id g27mr3138848ljl.74.1576586535875;
 Tue, 17 Dec 2019 04:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20191214152755.25138-1-angus@akkea.ca> <20191214152755.25138-2-angus@akkea.ca>
In-Reply-To: <20191214152755.25138-2-angus@akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 17 Dec 2019 13:42:04 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfYYFthdwn5XeJ_Meo-12vsCKQKhjG8kc+R-vTEzjp9nw@mail.gmail.com>
Message-ID: <CAJKOXPfYYFthdwn5XeJ_Meo-12vsCKQKhjG8kc+R-vTEzjp9nw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] power: supply: max17042: add MAX17055 support
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@puri.sm
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2019 at 16:28, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> The MAX17055 is very similar to the MAX17042 so extend the driver.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/power/supply/max17042_battery.c | 17 +++++++--
>  include/linux/power/max17042_battery.h  | 48 ++++++++++++++++++++++++-
>  2 files changed, 61 insertions(+), 4 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
