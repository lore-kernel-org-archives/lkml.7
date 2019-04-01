Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15342C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94A92084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554098850;
	bh=Tks0ya6GAWOLsVZZBukDFGF1xmNIIHsOD5/KGtz+U8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZU11KFuNTMQfaLCiDHXYsy5+6fS/04s3OxbTQunsB6NAPTo4U8Aht3w3gW1/450Qy
	 gUsawSgxe0fHZmTaQ/7gwUP1fnJZEhLR+gIkjyc5HyBKWhDp+VW/aaf+BUTt/Ip0HW
	 qlunO6TJTcYhTFix30n58Xlcr5g6+qia3Nr/NoIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbfDAGH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfDAGH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:07:29 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7141C214C6;
        Mon,  1 Apr 2019 06:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554098848;
        bh=Tks0ya6GAWOLsVZZBukDFGF1xmNIIHsOD5/KGtz+U8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CKgBpTHcfltLFhcLzqeLIuRfG3G5Fh/truEAPlutLVoH6OxzhOpigpHfQVDrr9JDh
         WY3cXF38/aUs4Yg48g1zw6Id+Mjb2Hv6A03WdBqUnes1E6II1nMZhF7Ek0WuQNomb+
         NTmxUMcrTaMDRWhs/nVPZqH8cvF0xmt5F82BYd+4=
Received: by mail-qt1-f169.google.com with SMTP id p20so9193840qtc.9;
        Sun, 31 Mar 2019 23:07:28 -0700 (PDT)
X-Gm-Message-State: APjAAAWS1LCkTb3VNtuJxzVpf6JuPAgIhQop1vAIjI+eKVs5f9EEOLe8
        dMl4uuuOsVhC0V8H1aPNdKMX0eAfYVGclghSHw==
X-Google-Smtp-Source: APXvYqzhDATrH5yJPSyYI+bNbOxnsx41TTkoABW0FfCdz5QlDWUZGR08am8xJ62rdQnzQtXraFyGr4dIXydByQR25Kc=
X-Received: by 2002:ac8:30bc:: with SMTP id v57mr3379777qta.26.1554098847686;
 Sun, 31 Mar 2019 23:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190331024240.3012-1-masneyb@onstation.org>
In-Reply-To: <20190331024240.3012-1-masneyb@onstation.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Apr 2019 01:07:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL7ncaz+D_xp17tQfjRp00Y5emnB4zyf-Ms4j8bdwb4Bw@mail.gmail.com>
Message-ID: <CAL_JsqL7ncaz+D_xp17tQfjRp00Y5emnB4zyf-Ms4j8bdwb4Bw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: correct dt_binding_check parse error
To:     Brian Masney <masneyb@onstation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 9:42 PM Brian Masney <masneyb@onstation.org> wrote:
>
> 'make dt_binding_check' fails with the following error:
>
>   Documentation/devicetree/bindings/arm/cpus.yaml:  while scanning a
>   plain scalar
>     in "<unicode string>", line 231, column 19
>   found a tab character that violates indentation
>     in "<unicode string>", line 232, column 1
>   make[1]: *** [Documentation/devicetree/bindings/Makefile:12:
>     Documentation/devicetree/bindings/arm/cpus.example.dts] Error 1
>
> Correct the parse error by replacing the tabs with spaces to keep
> 'make dt_binding_check' happy.

There's already a patch for this. Just waiting on arm-soc guys to apply it.

Rob
