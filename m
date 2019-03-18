Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F7B20872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lNRN7zqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfCRUGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:06:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43155 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfCRUGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:06:22 -0400
Received: by mail-oi1-f196.google.com with SMTP id 67so14114025oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4pDkE66N9sGNKASHxnAqppvdriwVXM0y6liBW4Fl+g=;
        b=lNRN7zqpEJ8dA5/HKwAmAbooQdHo3yI2q0UHdjzO1S0KU2vfJHhHROTU87zXAF9bV6
         hDAeeDi9oqizsUrR/9kHy/rc7DBPJrs+A6NkihmcpUhcHoZ+t2qJB98Hhz0+lJRa51w9
         8amF8TOrQy4iNlTU6IFPR0PW7y8SPPi4fGijMIO02tSt44hV6b2RgUFZlOP/gIRbhXbh
         DBz/dKf/e/65EYMJ3QcHNNaTeb1E2MYThpaQBdsMblubS6L88Xo7i90q43RfiuHf0DhI
         hGWelWTaJaOlE4b5zMEP4oYITZUHsohqRPI1cswqre4NUcL4uXUEghvMvDvqzwJxm/Ky
         kEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4pDkE66N9sGNKASHxnAqppvdriwVXM0y6liBW4Fl+g=;
        b=PDdsKU9OrYixiDj4KEHXpx5gGxdbYZNhdRAGTeSlrx1ID6NAo+gK77F7/wvXJNwUE7
         3B4582WV56aSpW4/9cx6V0nOeqPBlEE4j6m8SFyKFqvgJvcv/MARmmPO1a/juqSfeDkL
         vq9KvSdvUvC+BOl/xxmuXSx2WdcUMjR6SHxqLDVBfvzTx3cN8hGgyUXUuAywVfds5B1/
         jcsn7dg1GMSN9+odAe14ZP2IoLrBRQ8HQPxnXzopn5K7Zypd/uVh5nPZn+tlwTVl3ssx
         cYVGeKVXYc55kuVdcel/zJn8kfwFA91/hSv9GKYOxPKvY4h9ewUXgAK/UBJSNC2/bGqQ
         8NYg==
X-Gm-Message-State: APjAAAWyQcahRAtgwFb7aL3JsLytEa1btW/N0tSLMnYQbpnRsIMmg65I
        WfiksILI8V0tZzq1/p4qiOBVCftv9Zg+1zwKptY=
X-Google-Smtp-Source: APXvYqxr6Ufg5Lzv3ks/Djyr+Vp6g1/TOH0X3DdnsVANCN9W9gLpf0+qzDm1JC400HNvczEqZKvX9CoSAXdvIm8HiIQ=
X-Received: by 2002:aca:a9ce:: with SMTP id s197mr428994oie.129.1552939581538;
 Mon, 18 Mar 2019 13:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190318100458.5619-1-narmstrong@baylibre.com> <20190318100458.5619-6-narmstrong@baylibre.com>
In-Reply-To: <20190318100458.5619-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Mar 2019 21:06:10 +0100
Message-ID: <CAFBinCDueGJymC+SgPe7B2D_EavWFxjq8FHfhWr9RTPwxqsSmQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] arm64: dts: meson-g12a-sei510: add regulators
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:06 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Jerome Brunet <jbrunet@baylibre.com>
>
> Add some regulators. Still missing
> * VDD_EE (0.8V - PWM controlled)
> * VDD_CPU(PWM controlled)
> * VDDQ1_5
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I have no details about this board but the changes look sane, so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
