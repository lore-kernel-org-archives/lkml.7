Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85140ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC352089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6Fv2XHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439389AbfJQJOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:14:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41102 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408466AbfJQJOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:14:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id p4so1433806wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 02:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yjPrzn+rbWZoq833/48Q3sh6NkFGlqikUBvXOdOFU/s=;
        b=Z6Fv2XHs9QqD1rEXGmmmX5ahLogdFvvhJUz819zJs4r/BRLqCmdm8SQo5nB6ibNvZB
         hIfwYYzuHIMa/R7+rkUIwXH0R1SFKuo2lEcaJvuY+K4yh99avYMWJ/BNrwAXmN7PoXWX
         2UQPRQ7lbnOJC91Mk/qLFouiz5RPnwfDU+ZfMUP+Wu1hruOpe1fT8QaX6y9o7GXTon0m
         QVP6FhUSk246HsgRiZLFWXLWzYrd8MMf9JDCLbry3hHbo9ZoDUm0b5JxA1QwVUAd2aby
         cqwjlbNhOgComrC9zLQlZgEhpflhdfKT5I9+2uXyCKnXbI8UTXC8cklwD0/Lm+paE0vA
         g3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yjPrzn+rbWZoq833/48Q3sh6NkFGlqikUBvXOdOFU/s=;
        b=TXAgP9BT9zWFTwPICl009GBJ2xW1SPIcdvjyt+17Pv4ws7v659ovhyEercUp5vgufy
         oJM/ugeRwj8Rr/ZF6c4TArihaLjUs6ebpHKeVwmG9711Axg2JUu+JL/l06qAuuNVNv21
         Me+lKoCnAxBh6OgSndZ3EKTmnQNb79g6RVPtUJvR5nn4AVPRCmnp1gnjtEC7XM+DJ3MY
         Vo8I06rHOaM/0tE0ZQr4YMUFcNuWXaCx8x9+o2io8n8HIYOmOv6qW9hZkJOeLNVyUPtC
         vd6WIYJD2YxAMYhRXg0rlNf9XlMK/FgjnBEXWIhrXmiXOH4gNz1kpei47pNXF85LAhl6
         LujQ==
X-Gm-Message-State: APjAAAWf//bgfMZxIvbQUFJqefDFCbm1NPggaqHJ3hQOBzZ7IhWGvYu9
        w3/QNiOE4h3q457ztUXVsznpzsCLaKnH7Q==
X-Google-Smtp-Source: APXvYqwFWce7Be9T4GJkKCnueWMNcy7EoB2ARFDRRGv/8mvX86gjO0m9yadrrwRA1AWNiJEVduv51g==
X-Received: by 2002:adf:dbd2:: with SMTP id e18mr2052978wrj.268.1571303644897;
        Thu, 17 Oct 2019 02:14:04 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q66sm1867902wme.39.2019.10.17.02.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 02:14:03 -0700 (PDT)
Date:   Thu, 17 Oct 2019 10:14:01 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Subject: Re: [PATCH v3 3/5] kdb: Remove special case logic from kdb_read()
Message-ID: <20191017091401.76sqpcymegxur4kq@holly.lan>
References: <20191014154626.351-1-daniel.thompson@linaro.org>
 <20191014154626.351-4-daniel.thompson@linaro.org>
 <CAD=FV=W44zXesz8b8Z05_k7JjPW8D9z8fGT3GiGFSmSLw85zMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=W44zXesz8b8Z05_k7JjPW8D9z8fGT3GiGFSmSLw85zMQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 09:10:22PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Oct 14, 2019 at 8:46 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > @@ -91,12 +92,17 @@ kdb_bt1(struct task_struct *p, unsigned long mask,
> >         kdb_ps1(p);
> >         kdb_show_stack(p, NULL);
> >         if (btaprompt) {
> > -               kdb_getstr(buffer, sizeof(buffer),
> > -                          "Enter <q> to end, <cr> to continue:");
> > -               if (buffer[0] == 'q') {
> > -                       kdb_printf("\n");
> > +               kdb_printf("Enter <q> to end, <cr> or <space> to continue:");
> > +               ch = kdb_getchar();
> > +               while (!strchr("\r\n q", ch))
> > +                       ch = kdb_getchar();
> 
> nit: above 3 lines would be better with "do while", AKA:
> 
> do {
>   ch = kdb_getchar();
> } while (!strchr("\r\n q", ch));

Doh! Too much python...
> 
> 
> > @@ -50,14 +50,14 @@ static int kgdb_transition_check(char *buffer)
> >  }
> >
> >  /*
> > - * kdb_read_handle_escape
> > + * kdb_handle_escape
> 
> Optional nit: while you're touching this comment, you could make it
> kerneldoc complaint.
> 
> 
> > @@ -152,7 +158,7 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
> >                                 return '\e';
> >
> >                         *ped++ = key;
> > -                       key = kdb_read_handle_escape(escape_data,
> > +                       key = kdb_handle_escape(escape_data,
> >                                                      ped - escape_data);
> 
> nit: indentation no longer lines up for the "ped - escape_data" line.
> 
> Nothing here is terribly important, thus:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks. I'll pick the nits (although I might leave v4 out for review
for a relatively short time before applying it ;-) ).


Daniel.
