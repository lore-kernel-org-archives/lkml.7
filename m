Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08445C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14E3206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TV1dbV9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKUOLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:11:11 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37242 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfKUOLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:11:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id d5so3391855ljl.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZp3HZ4CKNPLF//CwB8gN5FR3ZN9LXNqaq8gnIY9lss=;
        b=TV1dbV9lyonvtfSGvpV6EwZrUuYPTpxYOEMdb1LbCyh+VetcAIHKxihGj70aQmaHKi
         Jbfo0/nwGKrjOeT9naSsYqWbC0wFK2WNlWkcD796+PQoeu20wo8S+fo8xsAxhupzlyhm
         At2eTQ2nSxGaWd0VNTDcIjgkruYhepM4WFEJqpCMvRqc5JGBfowCbGDAFKSdHCjnsi2C
         rTtLqjjuYKoig5K8741JFDTNQX06tnpDlUzpQ0utEWbbIO9STHRxgEB+3U7nXV8SFFM9
         g+UHbJUaMBf4nM7iue+4JgIi4v4bCVAXNRQ4OM2htN3Qb8YYLjcanxo5t1VpCxaHn7gj
         uoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZp3HZ4CKNPLF//CwB8gN5FR3ZN9LXNqaq8gnIY9lss=;
        b=GvJXA0hP9iz0n6QBHoxmgkOJxdsZYbzVgUeLlglX2x2RxowiegXxUnnKVJqgp0zUjT
         7Udm4iMDKLNRJKj1ZyTTeWZsjU2RF9R55GFesdSuFTiQ8MEX2lJPAoc4nFy/9Kf/us2r
         PughlWEEFZ/gpe7X3QwRGk8MR80t8YIFY2GNcDzolAqWexKq0utlrqSjkT4ULTUwpW9z
         +WhoT55Ztdyr6JECXBfMUC9QcbPmLS5sJd6FZ+Bao3P1qqehYtSo9WZoj070uy7iwsEA
         P3oKq80ZkctH/CJT97TMRDaF5sveenE6VHN8c8y9KZLHw/HRkVS4PnDa0iwwgXcL+xYo
         PPlw==
X-Gm-Message-State: APjAAAVIG1ZJbJ3JWYByu/J6IayFXpoJmpM5CJehHMb9o6w5smRZKoRe
        3VvmzslPtihAkow8aqN0wl1upyXfBAmEaX58W61hIf1aYR4lmw==
X-Google-Smtp-Source: APXvYqw/OvC80RhBpcecfqxISdh2BHdrs0IQTSNl+RC5Xe3qzLrFkd3gyaJp1si4to4KQHXP9TembWEhedC2KDCY0Ko=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr7685413lji.218.1574345468756;
 Thu, 21 Nov 2019 06:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20191119155211.102527-1-paul@crapouillou.net> <20191119155211.102527-2-paul@crapouillou.net>
In-Reply-To: <20191119155211.102527-2-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Nov 2019 15:10:57 +0100
Message-ID: <CACRpkdbGeyu1xiz2TzRAOoF5Ou9irCSWNyPzZ4o+TAaveqUKmw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: ingenic: Add OTG VBUS pin for the JZ4770
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 4:52 PM Paul Cercueil <paul@crapouillou.net> wrote:

> Add pin mux configuration for the OTG VBUS pin of the JZ4770.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Patch applied.

Yours,
Linus Walleij
