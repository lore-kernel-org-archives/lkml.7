Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2115C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9916B205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Frznn9LJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfDDKMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:12:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44795 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDDKMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:12:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so1115779pfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 03:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Sh1iuY3EYkCwi70YrYiIV4FQVluhuBi89y90QhrWs78=;
        b=Frznn9LJ1QtmG2CHriFjDNn2lHSqyrZQqzsOlB2Ta9bw+9GMwD/WuNYU7iyYU776w0
         EE9Sx9D2uu9vJo7urG81scbuxria5NgVAygY11Kkq7yLtRr3/PK9pZPUsy6RIPl3PnPA
         IHwodid9his3Maic11nLOvpXiw2WdDR7Iw1NWCDK9kVb/JRjMOCiZZC5yb6XWkaIdx/m
         tdV0+ZkJ9fF7MwLXIE/qGdeqUzzkSYYp6iR04Y7YsXdsdkieRThYpFONKCSccdd7uNxG
         zGix8XpivQwiXbBt+mV0QTrWDhKGVjbJWwlwLsvpzuf/u5euPehRAf1HrnbmcY2YaaBd
         Gu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Sh1iuY3EYkCwi70YrYiIV4FQVluhuBi89y90QhrWs78=;
        b=gWz2f+7KW0XmqPyNJkeEZzr2XbqDmOC4Xtbm1FLhQxkhtZxdoDu094ngibrEDAGC25
         L7DhKTXBDKMdmpHdmrZDUNSSoxTP7YAOA9MSwAw5FUStZ5zaUdpVzyyKTKJTiGhKJGGs
         ImIfHx1OR5rFYqy8JysXAqkN2leniVuPZiMWPatID9EtNWblsBAuSTEF7XiZdClaRRkb
         EHIUKv1YEUhUKkQu45AtMftVGmO0Kzl3qULQdkW6VeauIS3xvMWYOx2+F9gAmEbDETFJ
         0FN9iNIPXx6rFHiPoXR7mupRlnOU5lzbMw0IeSU1U+XUuaAvHvXyldq4y9Veuc8S45hC
         pubg==
X-Gm-Message-State: APjAAAUMayLFS3euONwSEhp4ksQlsgY/dLQLUSHL6wb/Ze2CJYuoReVC
        9+Ft3tmAzY9CbMkJnR2sVO/0Rg==
X-Google-Smtp-Source: APXvYqxlih1O5Fyeyu9UCurgUB5U4oAiMLnWzLFZtvjs3btZRiHcSzCFasrATMJxQ9+KjiWFlMcFnw==
X-Received: by 2002:a63:7444:: with SMTP id e4mr5004312pgn.261.1554372762083;
        Thu, 04 Apr 2019 03:12:42 -0700 (PDT)
Received: from holly.lan ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u13sm41046518pfa.169.2019.04.04.03.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 03:12:41 -0700 (PDT)
Date:   Thu, 4 Apr 2019 17:12:36 +0700
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] gdbstub: mark expected switch fall-throughs
Message-ID: <20190404101236.7bq5xg7evzi7zpns@holly.lan>
References: <20190226191614.GA21908@embeddedor>
 <d0ae1626-1a41-55c5-cfe9-0dea3edc98f9@windriver.com>
 <533203bb-2f2a-6bee-659b-4385bce90575@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <533203bb-2f2a-6bee-659b-4385bce90575@embeddedor.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 02:57:36PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 2/26/19 2:47 PM, Jason Wessel wrote:
> > We'll have to fix them at some point.
> > 
> > Acked-by: Jason Wessel <jason.wessel@windriver.com>
> > 
> 
> Thank you, Jason.
> 
> Friendly ping:
> 
> Who can take this?

I happy to put it in my tree (probably next week).


Daniel.

> 
> Thanks
> --
> Gustavo
> 
> > 
> > Cheers,
> > Jason.
> > 
> > On 2/26/19 1:16 PM, Gustavo A. R. Silva wrote:
> >> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >> cases where we are expecting to fall through.
> >>
> >> This patch fixes the following warnings:
> >>
> >> kernel/debug/gdbstub.c: In function ‘gdb_serial_stub’:
> >> kernel/debug/gdbstub.c:1031:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>      if (remcom_in_buffer[1] == '\0') {
> >>         ^
> >> kernel/debug/gdbstub.c:1036:3: note: here
> >>     case 'C': /* Exception passing */
> >>     ^~~~
> >> kernel/debug/gdbstub.c:1040:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>      if (tmp == 0)
> >>         ^
> >> kernel/debug/gdbstub.c:1043:3: note: here
> >>     case 'c': /* Continue packet */
> >>     ^~~~
> >> kernel/debug/gdbstub.c:1050:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>      dbg_activate_sw_breakpoints();
> >>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/debug/gdbstub.c:1052:3: note: here
> >>     default:
> >>     ^~~~~~~
> >>
> >> Warning level 3 was used: -Wimplicit-fallthrough=3
> >>
> >> Notice that, in this particular case, the code comment is modified
> >> in accordance with what GCC is expecting to find.
> >>
> >> This patch is part of the ongoing efforts to enable
> >> -Wimplicit-fallthrough.
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >> ---
> >>   kernel/debug/gdbstub.c | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> >> index 7510dc687c0d..9f267b8905b4 100644
> >> --- a/kernel/debug/gdbstub.c
> >> +++ b/kernel/debug/gdbstub.c
> >> @@ -1033,13 +1033,14 @@ int gdb_serial_stub(struct kgdb_state *ks)
> >>                   return DBG_PASS_EVENT;
> >>               }
> >>   #endif
> >> +            /* Fall through */
> >>           case 'C': /* Exception passing */
> >>               tmp = gdb_cmd_exception_pass(ks);
> >>               if (tmp > 0)
> >>                   goto default_handle;
> >>               if (tmp == 0)
> >>                   break;
> >> -            /* Fall through on tmp < 0 */
> >> +            /* Fall through - on tmp < 0 */
> >>           case 'c': /* Continue packet */
> >>           case 's': /* Single step packet */
> >>               if (kgdb_contthread && kgdb_contthread != current) {
> >> @@ -1048,7 +1049,7 @@ int gdb_serial_stub(struct kgdb_state *ks)
> >>                   break;
> >>               }
> >>               dbg_activate_sw_breakpoints();
> >> -            /* Fall through to default processing */
> >> +            /* Fall through - to default processing */
> >>           default:
> >>   default_handle:
> >>               error = kgdb_arch_handle_exception(ks->ex_vector,
> >>
> > 
