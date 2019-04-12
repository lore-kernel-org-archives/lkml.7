Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5840C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8432171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfDLTr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:47:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36734 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfDLTr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:47:58 -0400
Received: by mail-io1-f65.google.com with SMTP id f6so9547914iop.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 12:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eytJCn/M3BPr+VLE9KRBg1wy49E1CvxwwjDmWVTBmUc=;
        b=gr0DuelXX8koG22k28U2kQAG6lCieC/eho7MbOLRgxwYKHvDkJUosxG2Zmbka7hKtu
         nccVymd51IYh/JqD9ug2QEgDRltxcMrBEY/4JYnm+0ft1mqR2vH0bu6xZjmuF3HYCPFE
         mKQMKR5h1Xwm7CUV3ZjFtxa/lIW/pDIAWzuaKCE9QK6tDNLswOS/OcR33Z4O8yakp9pn
         ts94Cq+48dL8cWhgMFdTD/hr7l8d1seD2vB8+FyKHD0n6lQ0BgE6x2BS86Cjnr69+5lB
         we8bA/v1TJQHHg2i6uPvt2x5+W73V8ryzII1j2U5r29t7ZiPM3KcPKv5v7m32Re4kJOE
         d6wg==
X-Gm-Message-State: APjAAAUr0Dq2CQQ8s9CdxieDEojbY0EZ0kz3V9jOhwa51kKtCIUOBcH6
        dLwx7lXnRL+IfS4AKffBPJ2DnQ==
X-Google-Smtp-Source: APXvYqycmA3Fwn4qflLxtQbMn7VL2CKTf2bzrk6uD+LoRj5JQol55d9h1F9lAgr68K+DoOFzO9xIMQ==
X-Received: by 2002:a5d:91d2:: with SMTP id k18mr29630462ior.24.1555098477717;
        Fri, 12 Apr 2019 12:47:57 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id c25sm15366576ioa.75.2019.04.12.12.47.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Apr 2019 12:47:56 -0700 (PDT)
Date:   Fri, 12 Apr 2019 13:47:52 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, eballetbo@gmail.com,
        zwisler@chromium.org, djkurtz@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v2] chrome/platform: cros_ec_proto:: Add trace event to
 trace EC commands
Message-ID: <20190412194752.GA238393@google.com>
References: <20190412184944.125338-1-rrangel@chromium.org>
 <20190412150438.56ba4429@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412150438.56ba4429@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 03:04:38PM -0400, Steven Rostedt wrote:
> On Fri, 12 Apr 2019 12:49:44 -0600
> Raul E Rangel <rrangel@chromium.org> wrote:
> 
> > +#define ec_cmds \
> > +	{EC_CMD_PROTO_VERSION, "PROTO_VERSION"}, \
> > +	{EC_CMD_HELLO, "HELLO"}, \
> > +	{EC_CMD_GET_VERSION, "GET_VERSION"}, \
> > +	{EC_CMD_READ_TEST, "READ_TEST"}, \
> > +	{EC_CMD_GET_BUILD_INFO, "GET_BUILD_INFO"}, \
> > +	{EC_CMD_GET_CHIP_INFO, "GET_CHIP_INFO"}, \
> > +	{EC_CMD_GET_BOARD_VERSION, "GET_BOARD_VERSION"}, \
> > +	{EC_CMD_READ_MEMMAP, "READ_MEMMAP"}, \
> > +	{EC_CMD_GET_CMD_VERSIONS, "GET_CMD_VERSIONS"}, \
> > +	{EC_CMD_GET_COMMS_STATUS, "GET_COMMS_STATUS"}, \
> > +	{EC_CMD_TEST_PROTOCOL, "TEST_PROTOCOL"}, \
> > +	{EC_CMD_GET_PROTOCOL_INFO, "GET_PROTOCOL_INFO"}, \
> > +	{EC_CMD_GSV_PAUSE_IN_S5, "GSV_PAUSE_IN_S5"}, \
> > +	{EC_CMD_GET_FEATURES, "GET_FEATURES"}, \
> 
> Usually, if I have something like this, I would do:
> 
> 
> #define ec_cmds \
> 	EC(PROTO_VERSION), \
> 	EC(HELLO), \
> 	EC(GET_VERSION), \
> 	EC(READ_TEST), \
> 	[...]
> 
> Then:
> 
> #define EC(a) {EC_CMD_##a, #a}
> 
> and then ec_cmds ends up with the same result with much less typing and
> little risk for copy past errors.
I generally don't like doing that because it breaks my editors Goto
Definition, but I can send out a patch that uses the macro.

Thanks,
Raul
> 
> -- Steve
