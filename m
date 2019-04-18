Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40905C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D10217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="p9rF2oUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390131AbfDRUSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:18:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32836 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389316AbfDRUSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:18:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id j10so2791981otq.0;
        Thu, 18 Apr 2019 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4uKOm5z3nUZHEwv2q0U/OJ6XUlDCtJlvE9SB0ftnIU=;
        b=p9rF2oUxcSW/fr5nED842zaQPHsd7xfHMXWgNhk/41PD23hUd+ZQfR8u4a0wS4/0Bt
         sOsjY7H7xcNNrj7w8WgnHIsf9kh64Bl2ahMXjgiQNqpKUP4NYTD3jq1a57GMBQIOq4WU
         5wXeehMLtFVq8byJH/80QF2gx/fW1olQQxWB6kqZCy3zUovLhmig7Ihu0mc0jEtbLShA
         /lS4cLwbrkykdbtiOWwENxD/jO1oWjaiRucolflvTUdOWXa0H+Kqdef3wg0cdlt8izg/
         BbltCE64d8yr/2FsRpQ/m6+vBDb43E3qit1J4LsdJfeVySSSz6v289taBgUUPuwrjEVs
         Ns0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4uKOm5z3nUZHEwv2q0U/OJ6XUlDCtJlvE9SB0ftnIU=;
        b=p9YeRYU9fQCf5V+YiMYWpTGVZj5k3p2xoVTE0SnIe+hyKIWGZ27LWnCCijsedOakeC
         0OdIO61NJORIUZqEIfYeG5zHAwVJz+etkNL1Zut48u2uUgDv4hdDn32xofkRN4UhrTEA
         svQLwLdjy9RuRFB3/2CoYYo4WTlJ30QGE0CU/Pi/Xh9CiitLgQY0yS9C/5lnGTANLu2y
         73dguZ97HLQVoe4FhdpjHXoQIJDyHUBr5C5s0wa+jmTr2Eb2f6Pz8xjCN8oFpKsfs/bK
         BO3Kk8shzP3EPUD7XLbX4t6q91qW2q/3UNnrS1MBiJEgJE7rFE/ltju0qm5z3DXMBQQU
         qBOg==
X-Gm-Message-State: APjAAAU5UXFAjxCIo8yHDPX97sIeZi+RVS210i6wXlBlxvTWh67rsz9f
        zmSEKqYlbSHMoqT0GElNdzsSqTHnYVfPyfipz+c=
X-Google-Smtp-Source: APXvYqyq6dBgPm5Sc5v35NoLipsVAWZrWf43pIQvXgq372Jl54xTlohkffpeUMcZZr3yvFiUD16IduSY8yGD7Nf9WnQ=
X-Received: by 2002:a9d:76d5:: with SMTP id p21mr57213094otl.308.1555618716898;
 Thu, 18 Apr 2019 13:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190417204355.469-1-jbrunet@baylibre.com> <20190417204355.469-2-jbrunet@baylibre.com>
In-Reply-To: <20190417204355.469-2-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 18 Apr 2019 22:18:26 +0200
Message-ID: <CAFBinCBM4r5qxhk9rBH0aqdHSg76hyNMOi9aAJG-hGJDHY-4Ow@mail.gmail.com>
Subject: Re: [PATCH 1/7] mmc: meson-gx: remove open coded read with timeout
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:44 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> There is already a function available to poll a register until a
> condition is met. Let's use it instead of open coding it.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

and on my Khadas VIM with patches 1-4 from this series applied:
Tested-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
