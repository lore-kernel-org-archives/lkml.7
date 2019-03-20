Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A21CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC1C2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISmOBG7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCTTFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:05:52 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:39831 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfCTTFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:05:52 -0400
Received: by mail-io1-f46.google.com with SMTP id e13so3055698ioq.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s3kY8srxmJS+TKqHmx8FizW3734l63ZrjDTzj1ruNlk=;
        b=ISmOBG7uFOVcfh9u8W2AI2JnBGYurV2aRXgOSDzM3Vq9lQE1jeDiW0zYjr0NcfLINy
         UaLaMo82kgowNfDGm3PrI4UjdbzY8AlXYrtu0y4PyivlaxBVlYiGVV6PvaP5Y9qMbCrB
         9Uws7OPBtFgf9Q7DxRZnasO+me0CI1eAEQcQFouXL1cdoPxR0WBlQnsUu5xeJJ9h/xRf
         2Xvt33m0K3rcdC3sArn8M8Ek3B7MYQCvo45ziilM19YOoma4WyUne/UjidDR22jh2kyW
         DYr5q5SVbnr9UBMEUD64Er0zS2ngb7qMhyTbZF8sKiaKViOsxvqvosqE4L2hzI528+I3
         AZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s3kY8srxmJS+TKqHmx8FizW3734l63ZrjDTzj1ruNlk=;
        b=WEXselOpCmuJJ4VIt/y8FfpryNgMk6jRnEfGm/8IAxYMZ/97K48OwfQPGLtSD9RCdA
         g6Rw7vqxdXu80QZmct1+wI2zG92zGN2voUChsz7XLfdlUqh6BxOdw/nGEPybOSc6n1rn
         NIRxQBpS9TZLhJH8CgcFSCEVCY33LOUL8EXTkXWTnbGxMaD7KeDxotb9E2gka1+fbHG2
         r1MDZfmx4p9fXwCiYPF2qq+aHV2QWD5Sz1Uku1V6+F1VhZbnxoPNu1uP4iF77hBA942V
         h7AP4nkA+T+Lsigtb86Zm/+tbnLayjxqQ7a5+9NhD7Y6rdLm1bdE09AobNfdZ+As/pyK
         nUhA==
X-Gm-Message-State: APjAAAU+KQeyYfK9XTEWc4LZWudwNkBwFcxR93uLiNyqatcV1Us6Sk3P
        sY6LsGd1Plj3MomynLQKwLo=
X-Google-Smtp-Source: APXvYqzMc0ydoqbmt8kYbglYZwbdhQ/XJakAgd5VuveM4RtE0VYlKERWoHUCsJmuKe7ktbBU45SNbQ==
X-Received: by 2002:a5d:9a08:: with SMTP id s8mr5713591iol.99.1553108751550;
        Wed, 20 Mar 2019 12:05:51 -0700 (PDT)
Received: from tzanussi-mobl ([2601:246:0:7004:8ddb:2c2a:9b01:337d])
        by smtp.googlemail.com with ESMTPSA id z25sm1079312ioh.43.2019.03.20.12.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 12:05:50 -0700 (PDT)
Message-ID: <1553108749.2079.1.camel@gmail.com>
Subject: Re: dell_smbios KASAN bug
From:   Tom Zanussi <tzanussi@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Mar 2019 14:05:49 -0500
In-Reply-To: <20190320144146.08ecd5e4@gandalf.local.home>
References: <1553106560.2080.5.camel@gmail.com>
         <20190320144146.08ecd5e4@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 14:41 -0400, Steven Rostedt wrote:
> On Wed, 20 Mar 2019 13:29:20 -0500
> Tom Zanussi <tzanussi@gmail.com> wrote:
> 
> > Hi,
> > 
> > While looking into an unrelated problem, I hit this KASAN use-
> > after-
> > free warning, so thought I'd let you know.
> > 
> > I have no idea how to fix it, but let me know if you need more
> > info.
> > 
> 
> Could you run with debug in the kernel command line, and see if you
> hit
> any failed messages from the dell_smbios_init() call?
> 

Not much, but this looks relevant:

[   26.783749] dell_smbios: No SMBIOS backends available (wmi: -19,
smm: -19)
[   26.963648] dell_smbios: No dell-smbios drivers are loaded

Tom

> 
> -- Steve
