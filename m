Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F8EC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71222190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570818908;
	bh=VrIjCjeCJtSwwOFvAswWO8zYeoA6k350yygwzNFOqds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XCYFDkMjuaCVLbnwsRJAuKX65P+dD34b3mJDkT1X1qDN1ZK7pEuk78V6um/OnAh+q
	 RLaObLgdftXC6SedKplIxB0YvRX2Egg9XdL/LDiGvcTSuYEbQjeCHV9w8oMnalSPHJ
	 B1x8j6yRoZvRbWaiF6qGrGxEHvyntNeQ2i/tBx2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfJKSfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbfJKSfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:35:07 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC7E62190F;
        Fri, 11 Oct 2019 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570818906;
        bh=VrIjCjeCJtSwwOFvAswWO8zYeoA6k350yygwzNFOqds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uf+6ZDO1znTClCJfgItB3zWCf/PrHoKnUZNzgxU7bq9CV74H3xLyxry5prNwCD90E
         cHV2PbrAT47N65ENH7+SeQzgduJrVnf8TYw0r1URPqCvvRBGijV2L/z0agwDzqlCmM
         tK4yIyp6asvn0ngHMlsN083OpACx/m0LgG52TtvU=
Received: by mail-qt1-f170.google.com with SMTP id l49so1258948qtc.4;
        Fri, 11 Oct 2019 11:35:06 -0700 (PDT)
X-Gm-Message-State: APjAAAX1GWngo+eIkNEAQZIKlDsemAuYYO6vEVdJz7n5cQV32cJASQO8
        EgdUHJ9DwijtTTlEpuFYSuoqCpDMoSeGl0ME8w==
X-Google-Smtp-Source: APXvYqxXNZXqhjX1vv0yrBQ2zPizCbCr6wZ3R6Kbqa0L34qgtUc+z3yI5+jQD/V1ZY3gsinMlNgwXR23TqSfelUsfUs=
X-Received: by 2002:ac8:293b:: with SMTP id y56mr18601675qty.224.1570818905926;
 Fri, 11 Oct 2019 11:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191011131018.24035-1-benjamin.gaignard@st.com>
In-Reply-To: <20191011131018.24035-1-benjamin.gaignard@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Oct 2019 13:34:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKboUPGFcz5SPA46WDxTa7aYSF7FN8LHhi4SFOz1PvrfQ@mail.gmail.com>
Message-ID: <CAL_JsqKboUPGFcz5SPA46WDxTa7aYSF7FN8LHhi4SFOz1PvrfQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: hwlock: Convert stm32 hwspinlock bindings
 to json-schema
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 8:10 AM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> Convert the STM32 hwspinlock binding to DT schema format using json-schema
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> change in v2:
> - use BSD-2-Clause license

I asked for dual license: (GPL-2.0-only OR BSD-2-Clause)

> - use const for #hwlock-cells
> - add additionalProperties: false
>
>  .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ----------
>  .../bindings/hwlock/st,stm32-hwspinlock.yaml       | 50 ++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
>  create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.yaml
