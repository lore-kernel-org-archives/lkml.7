Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99453C32751
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7109C20880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtR7cxMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfHEJ1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:27:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44497 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfHEJ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:27:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so78664825ljc.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miq5LJnsHycKAbKrX/aqmgv81qAV/3Tn1hYeTeovT1s=;
        b=EtR7cxMhkbo7QWXknDztSh3qlAqEOooXAsGcenCHLESfVSPbSJWe0po31TRFEGZCIP
         fbQ06k3afzdBiUxV4RZbezu+E5YrrIXsxeOFDqDVzK0lJkRJ0/Vx6GU/Es+xagKNV/PF
         uerC3lf6diy5kPWhdalSC/w682CwmdsKYqbEZHz9RCwFxmK2MloL0OZ3SozE+GuKGAvc
         7vMUN6fGY+7VdYhwHDQRHAYl7E9GxcsgkRw9VUaH06UBlMiXXsngXurrle9rXAJwquJA
         6Oy3ra3Yqv7j9D0RHZ28Exk5bHTmk2XCYGAAjypo/3LtY5/0lMJV6Sxbp++wNWRVYSUB
         Rf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miq5LJnsHycKAbKrX/aqmgv81qAV/3Tn1hYeTeovT1s=;
        b=lDzI4Yj67phZWCvo+6BDgOcOgzEAKWAEevz8ExIrDCI6C6nIzUjWy323qZtv6R6CcN
         aHZSfGXtBgKnyq1GsfSwsMQ2Hprm+6VCVtHhXB4l5ol+S0NEvdo+79g96g124SFdrujM
         MhukIDE3+yGRkKzSlFxxrPyN8m+RNOTu0BxOMn9VluCqYroWxjpeTN0Nn6AjS42cgosn
         smP5kNEWG3jR5yzFAB9meQ29ROzBbY8Y7CU7AbVjTNZgixfO66Oij9RNDHemPLuiNqUR
         3NVMIWK0Pw9NvP3dfdn4XbkrYk+CqOGwIZ6WcAvdf4VytzaGouzq/kJgImoIpYYl+yxq
         ncQg==
X-Gm-Message-State: APjAAAWYv4PAOv5jy7RwdI/xx9LgW+kdiIkEdSHIt9yQqOyPz0rbsOJG
        hWotE9NX+WWtgqS432/cYIuWZjOJDICDCX3CWGXh3A==
X-Google-Smtp-Source: APXvYqzZZ+BV1zGXdPbqQEmcBkpwiyKfdqckHRWRksBBrs7TwsFvmAQry9T8pnndwRc5cffdFpZW/uNyp6Z0yYoRD50=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr14713714ljm.180.1564997263156;
 Mon, 05 Aug 2019 02:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190721125259.13990-1-hm@bitlabs.co.za>
In-Reply-To: <20190721125259.13990-1-hm@bitlabs.co.za>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 11:27:31 +0200
Message-ID: <CACRpkdYy+ZbcxwswOx9WWemmsSUcWKdLRXDGKeYkhbC2UYGGKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [PATCH] gpio: Replace usage of bare 'unsigned' with
 'unsigned int'
To:     Hennie Muller <hm@bitlabs.co.za>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 2:53 PM Hennie Muller <hm@bitlabs.co.za> wrote:

> Fixes a couple of warnings by checkpatch and sparse.
>
> Signed-off-by: Hennie Muller <hm@bitlabs.co.za>

Patch applied.

Yours,
Linus Walleij
