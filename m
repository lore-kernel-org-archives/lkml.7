Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F7BECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AFC21848
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571073573;
	bh=CHr8zeU6zPNp08eQU/Ju1rK8x/y8IY7MeSEwI3wxYmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Foh12+LsSVEQspTlVl88tUfeIQ/qqY4XkZFuAqC/ivlJwlp+b7bJq8aMucbr24VRD
	 1XbkxRhcDruRT1XFUb08bVlBHhGbUSZ+mjD/IU1nZk/yKUqLQ2dRqxDddaWv7EO0X6
	 4YLBz0cf17+cSY2gKbbP154MgY5gM1OY+yKnp/SU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbfJNRTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:19:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41868 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387802AbfJNRTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:19:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id g13so14433236otp.8;
        Mon, 14 Oct 2019 10:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+uUeApNQ/RRi9uJOAghMByheAKVmX2xvxdgsFJpIgzI=;
        b=J5nLJ1X0BwERZM+Z+A+GuFYTmVQZYWVEn2SEx1/L8Dx/VZo0If6BpF0vzl6EUNx90D
         jOMU+w3WJw9fclIWlPJGos3CvQPmRvzy1j5STjkUBg+EPGtcTg2d9lQvkMnzWCNOTAay
         JkFbAHbNeQl/1aQHbk4nVBkZMa66wyPsJNDUtY5ebk70LHS2AFP7xGERV3jHu1kamdf2
         sA8+BxQQRthrqAMOSZgtsByeSrZoXLsNirElsajx4YltXfuBhGzC5/F0TD8JnTqb8FGF
         WGKruj9U4OlTyIJy3zgaNsA27q5SaKW2mycrMqo1lavHKaHfr2NLC3Hfyp9144BUCv7G
         U3ew==
X-Gm-Message-State: APjAAAWlogRYOlXsFR5rkdTwTjfTcOP2kko94CKs9erX+rhTqB8+QR6S
        1dSppcQ5EXFOOXPwMNqbcA==
X-Google-Smtp-Source: APXvYqwwc3TAele/wXkLIzld34hhRrtg4CXjhYEk7aGrc/Ao9TLXsgP0bWPSDHfDCTXjh05CVuGCDw==
X-Received: by 2002:a05:6830:1103:: with SMTP id w3mr25682147otq.312.1571073570114;
        Mon, 14 Oct 2019 10:19:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v24sm5478615ote.23.2019.10.14.10.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:19:28 -0700 (PDT)
Date:   Mon, 14 Oct 2019 12:19:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        alexandre.torgue@st.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3] dt-bindings: timer: Convert stm32 timer bindings to
 json-schema
Message-ID: <20191014171927.GA9665@bogus>
References: <20191014092316.24337-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014092316.24337-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 11:23:16 +0200, Benjamin Gaignard wrote:
> Convert the STM32 timer binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> changes in v3:
> - use (GPL-2.0-only OR BSD-2-Clause) license
> - fix identation
> - add additionalProperties: false
> 
>  .../devicetree/bindings/timer/st,stm32-timer.txt   | 22 ----------
>  .../devicetree/bindings/timer/st,stm32-timer.yaml  | 47 ++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/st,stm32-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/st,stm32-timer.yaml
> 

Applied, thanks.

Rob
