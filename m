Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C06C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E48920651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="idojTlzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfDEVnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:43:21 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41451 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEVnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:43:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id 64so6963035otb.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 14:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDn28YelXWYOf7+CuZXkX6taf58/naB2OvMOq0CCjvw=;
        b=idojTlzhQuwrszkcgS8QDGlA645mbn2AMSrdgrSntApgi/DFjqVoZLUsTZeT30CbdP
         eqTBLk+fFH6CMD2t6cRQlAXsnsvnzPvpX9+h813dy1VleAZYzROzZlUgo+NJKjpDOoR1
         Qa89uxPl1Cs7goVxBN+hgBYcVhyu2h8Gu4rqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDn28YelXWYOf7+CuZXkX6taf58/naB2OvMOq0CCjvw=;
        b=qOntXVmTnRiedQuBC3XpT6DKeUlo2+qfeFswK2Tm1adLAmcV5dtyzMuEOpE6DbaJ1G
         wTK70Evo9MqOe6w2olF2b5qlOkEQSMdcMwPzqpfVvrAvghMf00IdqGi3YR0QN15mjSY7
         5/u6UegDx41HTR+tfju7wBCTwpGWZfFzY4lLONvxDCyNzahIhz7cR1K7mXB15+x9QtV+
         uIG7jMsEJ09di8YTs+EAV+Hj6FkYjBW/0hOlL712A3dPMtaOebcRvOU1H1Dy/4kEsriT
         9jpLT+8ODR5dqefbG+NCeMFciFrQxxCp8UxZYpGIsS7F1ijk4dfSEZt4XWfMvs4pZmuT
         NQBQ==
X-Gm-Message-State: APjAAAUgyC4OcQcawBwJWj5YsbaE/LlEG/fVReSMz30hKSJlPL5OThgs
        lMDkmOgLN3jqFcO8q/hSGmjHryaJgAs=
X-Google-Smtp-Source: APXvYqy4W+BtCRcfIdP3ktqlpXbYux/zhd0jouwC/8LhUNX0Oen7EoL2RmhqhfjdTSVsvQpqP5UN+Q==
X-Received: by 2002:a9d:32f5:: with SMTP id u108mr10380859otb.153.1554500599971;
        Fri, 05 Apr 2019 14:43:19 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id z2sm13505229ota.56.2019.04.05.14.43.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 14:43:18 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id s24so1795695otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 14:43:18 -0700 (PDT)
X-Received: by 2002:a9d:61cf:: with SMTP id h15mr10096294otk.140.1554500598022;
 Fri, 05 Apr 2019 14:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190405200742.107973-1-ncrews@chromium.org> <CAFqH_52zYVjg1aZ4JujZxh591Opbkfw=7FS8Bmwmn5Wao3N-xw@mail.gmail.com>
In-Reply-To: <CAFqH_52zYVjg1aZ4JujZxh591Opbkfw=7FS8Bmwmn5Wao3N-xw@mail.gmail.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Fri, 5 Apr 2019 15:43:06 -0600
X-Gmail-Original-Message-ID: <CAHX4x84AJvtD7mwWGO4N=XjfK8G_RuJyQd4R+EU2VxmLJAf-rw@mail.gmail.com>
Message-ID: <CAHX4x84AJvtD7mwWGO4N=XjfK8G_RuJyQd4R+EU2VxmLJAf-rw@mail.gmail.com>
Subject: Re: [PATCH 1/3] platform/chrome: wilco_ec: Standardize mailbox interface
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Oleh Lamzin <lamzin@google.com>, sjg@gchromium.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Now I'm confused, isn't this the same patch I picked this morning from
> you and is already applied in chrome-platform for-next?
>

Sorry, I didn't see that it was already applied in for-next. Just ignore
this patch and assume that the next two in this series are based
off the current state of for-next.
