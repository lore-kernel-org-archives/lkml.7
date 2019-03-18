Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72785C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFFF20828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CYPvVvt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCRTjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:39:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34629 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCRTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:39:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id r19so15555508otn.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGgCTUc7PrXmapvItTm0TAlgoUUh0KcB9uVn9jFtG0M=;
        b=CYPvVvt3z++hs3TSLs3l2bTThrnLI5zCUXwJN83g3VKx5McM3ZX8X0RRyotRdVMfPx
         6006NnSj8NioxaVVRoiFZsq3wovAt7PfPK6JpC7t1QrrEVr0tEGaRkdkjV96WHVvV8tf
         Jaq4TnIoc+qGsc99LfcfRBRQ5uf85b/De4jDMrirHX6VlsqkwZd/X7HIG9Cv6ElcabPG
         Mx9Ou+E9npxuBPNbbbcMrBLBdbX8nrcfMaKTcamzDwu28VQkYDwR7DAFxkndvcWt+FEe
         izlE2QKG+a+xuxWjEG5Vg0inkJfrRbadLHa0EIJkKfWah5QKr6zRfwtLUe614vfca8W0
         NThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGgCTUc7PrXmapvItTm0TAlgoUUh0KcB9uVn9jFtG0M=;
        b=FckJUt7oax6DlaR3Gq9FAHWMr61ABtL/Q8yJ42qZ4sWVy1jVSH4SJI5N3E/pKtQPNO
         G6CSjj2V1QC+seVtsEQI87p6CFTpD5bW5TtJzZKArJRcsV41oRY7NkNWzHu8D1ymnDOL
         bbfTL69wzVcoAvzsjvfVDXD2lSk5v6q8X1J7LggTLp+YkytFvsLG2L4nJgig+obsptJ+
         A6uYOTSeY6VqriQunnO4XqVGHzgIXksuHsfc/2kzkCcyyKaH3rXDV+Z3TW/ml4iblldI
         prjyc1Df6OcMQOn0n0VUqXmuAyuT1EcVtXQEAzqu5bGb0t+zMFjIx7MRDidsS88DQZMa
         yaug==
X-Gm-Message-State: APjAAAUbFQ/RSW0zeW/OFNqd5m3fP3xm4Ny7DWg1JEApP3uzrFvX4Uv+
        V0oddQ598CoJXBe0+TgUdVexrqFHv7yncWWs7+A=
X-Google-Smtp-Source: APXvYqwlaG7jOkef9H61Qc05HXQmeQ729Rr+O+UCrs2UYzLUnZs/un+Ha1yR8cfKcddzpzmghrHcUOZxUPfBy5TzzxA=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr11957242oth.308.1552937950723;
 Mon, 18 Mar 2019 12:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190318095851.4062-1-narmstrong@baylibre.com> <20190318095851.4062-6-narmstrong@baylibre.com>
In-Reply-To: <20190318095851.4062-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Mar 2019 20:38:59 +0100
Message-ID: <CAFBinCDvvpn3xXvUvb7wXvEj+65XnT5Dms=7152qNu2FcCwxRg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] arm64: dts: meson: g12a: Add UART A, B & C nodes
 and pins
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:00 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This patch adds the 3 UART nodes in the EE power domain with the corresponding
> pinctrl nodes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
