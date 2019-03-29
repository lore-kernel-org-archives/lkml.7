Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B50C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 01:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB1920700
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 01:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfC2BBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 21:01:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42301 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfC2BBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 21:01:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so517765qtc.9;
        Thu, 28 Mar 2019 18:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOaNSZEY+LGa8t9QnIWXecoNcLnV1KxKWyoBUklaSeE=;
        b=UNlZdxBw/yidN/wm86s5SS0AqzVUO2ifWBy15okSYp/q9thxMqMxHKL4GjG3K/vRbA
         e9yx1CTvQHdTBH+vgX/XSYacn+zavRBNQgtLFNiaorG0DyNuyJOL1Eu/PqMOLuIYPbHp
         yeO5xwk6zjXhZPyDq90Z43S3Ee0nAO+e8elxwFkISrjoVjRUtX6GXArf4BM1a32wKRzm
         +RXqrWnajtmafPFiLfaY/qt9m5ZScdO+ByaQSf2Km0Kr2FHEKDBHStKHJrbxUAWJBxjS
         hRHFaiIMa3jRXJS7dOvuxGAZvigqYoFnUCYlHmKr56+cfI0v99edq8w5o8ajlR6hwpB+
         EEnw==
X-Gm-Message-State: APjAAAV7IUd98yUdpfWrIhxFDA9SmnUp6cMjY6i7mHzSDhe5eMHrtLSX
        Vl8LzWfLpNnwlNSQPPz389zqBPmn47p7cb6A8Hw=
X-Google-Smtp-Source: APXvYqxeTeT1ddGLHc9D0d2WsZx3WO3Kr0k4sCBTSQi5PLEcVP0kkRSoQeF89E6TnbiDILi0Z+fX8Gky7PPpGcRk7uM=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr37818415qve.149.1553821267172;
 Thu, 28 Mar 2019 18:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <1553792993-7722-1-git-send-email-grygorii.strashko@ti.com>
In-Reply-To: <1553792993-7722-1-git-send-email-grygorii.strashko@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Mar 2019 09:00:50 +0800
Message-ID: <CAK8P3a2MP-YNkHLG9LgrQ_zeRWiJkwwNXJmptunF8+_uZTcYFg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: switch to readl/writel_relaxed()
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 1:10 AM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>
> Switch to readl/writel_relaxed() APIs, because this is recommended
> API and the MDIO block is reused on Keystone 2 SoCs
> where LE/BE modes are supported.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

In general, my recommendation would be to use readl/writel instead of
readl_relaxed/writel_relaxed everywhere, because they have much
more predictible behavior. If you want to use the _relaxed version
in the fast-path for data traffic, that is usually fine, but then I would
add a comment next to it to explain why it is safe there without extra
barriers to serialize with spinlocks and DMA.

Changing away from __raw_*() to enable big-endian mode is of
course a good idea as well.

      Arnd
