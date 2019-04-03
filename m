Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6966DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281512133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0TfpSys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDCTOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:14:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41078 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCTOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:14:35 -0400
Received: by mail-io1-f65.google.com with SMTP id v10so15032145iom.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 12:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IFeHXW/Oo0elV7Q22ZVvX1irrJRFIBvXcClMCke1fyc=;
        b=X0TfpSysJ8g4JAK4xhRY3BCFtUKcC3Ss9zajsvPBWyHFgW414Kj4eLQcjOWHwjrOMk
         FDbFAH5LnZWWMwv5BHzF5nmb1L109IgI1eyncWpt2rQSOpv5Jpq7wG8YI2usAtrREwM5
         3dAArPrvqb2kpPITLDdOUMDij6lODL1LDo+adSduIbtbdFJeokHU8VctKBHilpCvYXaM
         ANqKPYoR1NTtaBabsrOtvY94iBMBE0kB0WomzEE+o7NpOv/STePU8u0ZFug531EO0et6
         Ra/RdJd79NqDOS5E8iZLHSoSYIWslifLF872cznjT+YS8L+H8uBk55ifwFANsV6/ajDN
         mEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFeHXW/Oo0elV7Q22ZVvX1irrJRFIBvXcClMCke1fyc=;
        b=FCnLlJhPpqL3IvS3qHx9ZFaDJV0AjeOiMNsROgZzIyFASJCkJiDf6YtRdNZDlmqaPm
         /aCVqJ5Gj6WD3ZqQ+/oTBxmHb2Ejl8iF3DDkUeEvrpyDYBelV8YmydhyGTqIcaQcKNI9
         J80la/QOqVHc/fKrRtnLdepfAV6iNe4fB/CZfuPM+weJFPnmaXCi+fQJ8/NNnM7/+gRY
         emYeLEyhixAPD4QdAEtkMv6kFa0cAynCBiRYfw4iBh26mthUCkxKj1bxInyP0XCx4qMe
         7FS97j7e/wGmJnbnlQg0BVQeHmE1qPfla/s9QtE4LEFDQTd5sUf0R3SLJYAi4UxXvtFP
         72vw==
X-Gm-Message-State: APjAAAVbcEVjQnKfP/q/HJiMwoYgnv1BYFzPqlsbzQ4kgfA3ty3CuNW0
        /KIiFbs3pyIpfoxl6C445U8=
X-Google-Smtp-Source: APXvYqynhOEPFenYvO1yeK6NfgihrZRcIIG3PudAEIAJvV+s83Xgkd9p0rMjwaqO8Ycd1hYuGURzCA==
X-Received: by 2002:a6b:e415:: with SMTP id u21mr1362797iog.143.1554318874717;
        Wed, 03 Apr 2019 12:14:34 -0700 (PDT)
Received: from tzanussi-mobl ([2601:246:0:7004:b4dc:2200:482b:d526])
        by smtp.googlemail.com with ESMTPSA id b15sm7241443ios.25.2019.04.03.12.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 12:14:33 -0700 (PDT)
Message-ID: <1554318872.2069.2.camel@gmail.com>
Subject: Re: dell_smbios KASAN bug
From:   Tom Zanussi <tzanussi@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mario.Limonciello@dell.com, pali.rohar@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 03 Apr 2019 14:14:32 -0500
In-Reply-To: <20190403131654.7379a991@gandalf.local.home>
References: <1553106560.2080.5.camel@gmail.com>
         <20190320144146.08ecd5e4@gandalf.local.home>
         <1553108749.2079.1.camel@gmail.com>
         <20190320151353.1a223c0e@gandalf.local.home>
         <9541737623f942e49e9310aef963ffbf@ausx13mpc120.AMER.DELL.COM>
         <20190325101731.3558ecda@gandalf.local.home>
         <1553530847.6114.0.camel@gmail.com>
         <20190403131654.7379a991@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2019-04-03 at 13:16 -0400, Steven Rostedt wrote:
> On Mon, 25 Mar 2019 11:20:47 -0500
> Tom Zanussi <tzanussi@gmail.com> wrote:
> 
> > > Is it OK if I add the following tags to that patch?
> > > 
> > > Reported-by: Tom Zanussi <tzanussi@gmail.com>
> > > Tested-by: Tom Zanussi <tzanussi@gmail.com>
> > >   
> > 
> > Yep, fine with me.
> 
> I modified the patch slightly. Can you test this too. There should be
> no reason that it wont work as this is "safer" but I don't want to
> put
> your tested-by if you haven't tested it ;-)
> 

This one works fine too, so my Tested-by still applies.  ;-)

Tom

> -- Steve
> 
> diff --git a/drivers/platform/x86/dell-smbios-base.c
> b/drivers/platform/x86/dell-smbios-base.c
> index 0537d44d45a6..a74c0df25b15 100644
> --- a/drivers/platform/x86/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell-smbios-base.c
> @@ -625,6 +625,8 @@ static int __init dell_smbios_init(void)
>  
>  fail_platform_driver:
>  	kfree(da_tokens);
> +	da_tokens = NULL;
> +	da_num_tokens = 0;
>  	return ret;
>  }
>  
