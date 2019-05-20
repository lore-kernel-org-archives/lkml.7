Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518FCC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6BD2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dqiuZ4nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfETUZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:25:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33515 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfETUZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:25:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id y3so7258920plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=drPX8EULwG1mC1riPh+vpuW7Qes0D9bSwO5kUgMo2cw=;
        b=dqiuZ4numEMpl+z6MBJIiX1c3FLIffGFgceOk+Fjb7rqlWv01l2aQaEwfPT7oXDnnc
         +yevRlvQ53ocNWlt+IRoLrqoNNRKX+Bmlh1X12IBqRWlUjWkUb1c553haJXws76A7wCO
         OBJ07juf1YNRm0baldGCOSzBojgl+zociNX4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=drPX8EULwG1mC1riPh+vpuW7Qes0D9bSwO5kUgMo2cw=;
        b=YwgO7+t3jvaYx4u/YreZ42yIWB4956tLlZYo2qUZKw6wmSw5QaVAweaXGPpsZ5lbWG
         EgF1oUZsBETN8/rL38UVBQTlw/kfXGLd8faVJPV4Joj9eDDEf4o89QgCWM52JIfJrKWt
         GZp51ZH6RzZXmvT2tIBnRurQDtQUa4P6jqkQ5Ve68QfpsGeWjCZ4rIsWnjLLD1g3ylM+
         buQVI3MAKR3IeWbOZWoiyYOC8oNvuVdS8BFhm2fSobFFijKsMG0ff2D1F9+xoV0p052Z
         VONrnZ89CSKIAf62aeBP1AWSrcTXUTArvb1GuvUVdtX9Oy/gmQHBhbhIQLKG3ROjUrE5
         S1aQ==
X-Gm-Message-State: APjAAAUbk16ncxv0lOcel5c4bRPERTPisQ6Q4MyrAAufGR/2nK+zfoBN
        2kGBOqz3AnkiIdTek0Dw4AECco/afmw=
X-Google-Smtp-Source: APXvYqwhjvBDMa4czsMRDhwLbCTtGY6JO0/RTPgI21TjoOXjUJyLjqz96vGPcvAnYpXSljtRjqFS4Q==
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr78633420plt.81.1558383908410;
        Mon, 20 May 2019 13:25:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18sm36740436pfp.32.2019.05.20.13.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 13:25:07 -0700 (PDT)
Date:   Mon, 20 May 2019 13:25:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG v5.2-rc1] ARM build broken
Message-ID: <201905201324.1259BAB119@keescook>
References: <4DB08A04-D03A-4441-85DE-64A13E6D709C@goldelico.com>
 <201905200855.391A921AB@keescook>
 <D8F987B2-8F41-46DE-B298-89541D7A9774@goldelico.com>
 <201905201142.CF71598A@keescook>
 <9A29E642-3A9D-4BBF-A203-9179D8FADA31@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9A29E642-3A9D-4BBF-A203-9179D8FADA31@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 09:35:45PM +0200, H. Nikolaus Schaller wrote:
> 
> > Am 20.05.2019 um 20:53 schrieb Kees Cook <keescook@chromium.org>:
> > 
> > 
> >> Build error:
> >> 
> >> HOSTCXX -fPIC scripts/gcc-plugins/arm_ssp_per_task_plugin.o - due to: scripts/gcc-plugins/gcc-common.h
> >> In file included from scripts/gcc-plugins/arm_ssp_per_task_plugin.c:3:0:
> >> scripts/gcc-plugins/gcc-common.h:153:0: warning: "__unused" redefined
> >> #define __unused __attribute__((__unused__))
> >> ^
> > 
> > Does the following patch fix your build? (I assume that line is just a
> > warning, but if not...)
> > 
> > diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
> > index 552d5efd7cb7..17f06079a712 100644
> > --- a/scripts/gcc-plugins/gcc-common.h
> > +++ b/scripts/gcc-plugins/gcc-common.h
> > @@ -150,8 +150,12 @@ void print_gimple_expr(FILE *, gimple, int, int);
> > void dump_gimple_stmt(pretty_printer *, gimple, int, int);
> > #endif
> > 
> > +#ifndef __unused
> > #define __unused __attribute__((__unused__))
> > +#endif
> > +#ifndef __visible
> > #define __visible __attribute__((visibility("default")))
> > +#endif
> > 
> > #define DECL_NAME_POINTER(node) IDENTIFIER_POINTER(DECL_NAME(node))
> > #define DECL_NAME_LENGTH(node) IDENTIFIER_LENGTH(DECL_NAME(node))
> 
> Yes, fixes this issue.

Ah, good! Okay, then the rest of the build errors were from not
finishing to build the plugin correctly. Thanks for debugging this; I'll
get the fix sent to Linus. :)

-- 
Kees Cook
