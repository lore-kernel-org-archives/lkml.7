Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C75C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C9F20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EcKSa99r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfDBNak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:30:40 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34659 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfDBNaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:30:39 -0400
Received: by mail-it1-f196.google.com with SMTP id z17so2766299itc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mA38c7xWt1m8i3vVNSD9qGXXFYv8OXeD3h6QR8Ch9u4=;
        b=EcKSa99rHQA/wj3uZT4dUls9FUztJ+oPTGG0sf8EIUUCeqB+i8nRW/yfGQTPWiXxqX
         YJ+uFkqQJNBPAzx1fhnRwo1YP+s1K7YPnI5I1VmIAhuu/8sJqRYh7A4oZGxG0so0ahTU
         u9XAv43aDYE219ANyq1T9/X+mSVtueIW4oaq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mA38c7xWt1m8i3vVNSD9qGXXFYv8OXeD3h6QR8Ch9u4=;
        b=KPk+io31ia3RovjCIFwQxAi1dBePeDos22tKZv04XgBHPJdEi/d8EmZYglM7yALyks
         z0s1uDou6hN69k+O9bLNkCmn3YdLfucTotPOTXuVfiWvVLdN8Gf0XoTc7qcPI/qLlsf2
         8LrdnqVU6qE3JBJpFKk/gavW/mjavHB+YRdCzbnbgqwR1IoKxxUDb0tMwbKsAzQ6syfw
         dMqm0LhIE9/3V6myw0SnbTsA5meThRYu0308ps1+rxcbznOfYsxTyWKH19RNBkxrqp79
         sEnRZIL250E04COfqYwbH15O2LCN2oavsJ3+XYLT4DEr6sJRwGOPDag22Iq1S6A65RN0
         pEdQ==
X-Gm-Message-State: APjAAAWucQxWa84E0M/20HtyCFC183btLZW0UmRz0NMsyt7TMaIdyGe8
        nNizNsb81rg18JleJnFcs2vde8CabnOkmfVcwKfoFQ==
X-Google-Smtp-Source: APXvYqzsUhulnbFJh/PUkBEcvgYk9wMF4f5CUxOsx4Shf1oAUovmMkiXNlDZUs//IPcVx8oQj3J6+wQ3xwT6yY5hqyg=
X-Received: by 2002:a24:1cc4:: with SMTP id c187mr4312793itc.85.1554211838606;
 Tue, 02 Apr 2019 06:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190321082104.2874-1-jagan@amarulasolutions.com>
In-Reply-To: <20190321082104.2874-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 2 Apr 2019 19:00:26 +0530
Message-ID: <CAMty3ZBKGpsGLJ8Z-WEOH+puULrh5BjREn+608dUmTMUW9Qhqg@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] input: touchscreen: Add goodix GT5553 CTP support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 1:51 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> This is v7 patchset for supporting goodix GT5553 CTP. Here is the
> previous version[1]
>
> Changes for v5:
> - rebase on linux-next
> Changes for v5:
> - document bindings for required regulators, which are need during
>   power-on sequence
> - enable, disable required regulators as described in power-on sequence
>   using normal regulator calls
> - update the proper commi messages
> Changes for v4:
> - document AVDD22, DVDD12, VDDIO as optional properties
> - use regulator bulk calls, for get, enable and disable functionalities
> Changes for v4:
> - devm_add_action_or_reset for disabling regulator
> Changes for v3:
> - add cover-letter
> - s/ADVV28/AVDD28 on commit head
> - fix few typo
> Changes for v2:
> - Rename vcc-supply with AVDD28-supply
> - disable regulator in remove
> - fix to setup regulator in probe code
> - add chipdata
> - drop example node in dt-bindings
>
> [1] https://patchwork.kernel.org/cover/10819645/
>
> Jagan Teki (4):
>   dt-bindings: input: touchscreen: goodix: Document regulator properties
>   Input: goodix - Add regulators suppot
>   dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
>   Input: goodix - Add GT5663 CTP support

Ping?
