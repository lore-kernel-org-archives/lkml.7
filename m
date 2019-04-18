Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6D7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796C42183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TxpOoumm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389703AbfDRQqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:46:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39448 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRQqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:46:12 -0400
Received: by mail-oi1-f195.google.com with SMTP id n187so2110842oih.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9iLiURtyIX3/5eVXfKhiiuM366BsRB2H0v51P1Nra/A=;
        b=TxpOoummUQlpo/zJEelBP5cySuekl2Bck6p/bZvg7Kb2h4F1d2ObbfgBDR9bfK8dPR
         PecA+7tWxuYNrbO+LnhoctRw/eWSIKWi5sDNb0PJPxSw6py/3LgmWX2jPsoo4ys/q7pL
         5//6+wRFTIkWWPja9UXAlhepzoX6/3oUD+OdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9iLiURtyIX3/5eVXfKhiiuM366BsRB2H0v51P1Nra/A=;
        b=AN1YizRa2vA7KXOK4RuN2BZTJjRbHV5XDIfb/aIn173rCjQU+Y1wc8EJmQHuKOUApo
         r0Sp9/nF0hKcyxyT0Qc7c3vVIKMv/QHsGNH0M8lDhQi4rHzV6Oq4UBGxVvSqlNl2VyPD
         2tkjOOUXQJZMGLNqSf4iVxktZOnJ6aCULJQmzMzsSinWLkfh4sbS9DqAoDbuhxrA4ILg
         WGi+jxCawZP3e9Qes/bMNQOYutqPW8X4k9jLjQA5HB6Hl4HWP+7+nL9At4CCMoQQMtF6
         mWGyaqemUwiEmInT/omzVPlM6mNAfJq5PaIudib13cGxBMxXwigIa21hd850BA71IBo2
         lz5A==
X-Gm-Message-State: APjAAAU4ewDtoULqmpO56IMmqGXY7F0Yvkzc3wAyO8vSVs9iAzbpNpCP
        fhYH123ZvmE59ftJN+30BQc7RCBDvsQ=
X-Google-Smtp-Source: APXvYqyCbmj1X+S1OhFuT21pn6dKAnEqVYkS2W/FNj+BpjePyN3e4xBzCUu3MEbwhEQ95UyiDTit4g==
X-Received: by 2002:aca:e30f:: with SMTP id a15mr2591210oih.15.1555605971686;
        Thu, 18 Apr 2019 09:46:11 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id 6sm1014269ota.79.2019.04.18.09.46.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 09:46:10 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id v10so2125759oib.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:46:10 -0700 (PDT)
X-Received: by 2002:aca:cd95:: with SMTP id d143mr2522433oig.111.1555605970120;
 Thu, 18 Apr 2019 09:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190417004320.232200-1-ncrews@chromium.org> <20190417214022.7jk3usygcpnls3pr@earth.universe>
In-Reply-To: <20190417214022.7jk3usygcpnls3pr@earth.universe>
From:   Nick Crews <ncrews@chromium.org>
Date:   Thu, 18 Apr 2019 10:45:58 -0600
X-Gmail-Original-Message-ID: <CAHX4x85pmo5j1wWLrsNz+nioy-oTwb4NDJcrUKssvdofCmxKug@mail.gmail.com>
Message-ID: <CAHX4x85pmo5j1wWLrsNz+nioy-oTwb4NDJcrUKssvdofCmxKug@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] power_supply: Add more charge types and
 CHARGE_CONTROL_* properties
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Oleh Lamzin <lamzin@google.com>,
        Bartosz Fabianowski <bartfab@google.com>,
        Daniel Erat <derat@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, jchwong@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 3:40 PM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> The changes itself look all good to me, but this does multiple
> things in a single patch, so please split it into multiple commits.

Thanks Sebastian!

I split this into 3 commits:
-add more charge_type's
-add more CHARGE_CONTROL_* properties
-Add missing documentation for other CHARGE_CONTROL_* properties

and just re-sent them.

>
> -- Sebastian
>
