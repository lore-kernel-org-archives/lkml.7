Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8876FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7C42070B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3BEohni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfH1MCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:02:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44340 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfH1MCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:02:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so1341391pgl.11;
        Wed, 28 Aug 2019 05:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7x9QbvCyV5/uMb/ZbOZTelfBuJtIOSZaHEFOwZS1U/k=;
        b=Y3BEohniDvROSCc8HVpk5lxDFNRFq3WG0SOtiNwmkHU5GinDquwPZBDb4aU0eLfbuM
         aK678pnnDLR81ayJ3iuVvCL98TcTcxKDmGj74hdliwh0PJipIhsXmFvVzig2T3dJTShN
         2qaHRsfYmbf3x/O+aJNIDVUaqAHMp0nj7TF0GLPrgNEfRwJ5NEijtiVgOZCuQnU2FgJ7
         YD8nvS3s2Zx6Y7ipsyIXufshNneXGNzEIGPqdZPHKvMvXEPlLTUq9qY+t6wTB0je+zEy
         EHHtNQ3wFVZBr7wSwmd22ANQpmnURLZDPGe0mwEirZLNFUsT78P+xvvqJy0+I4JTabzn
         NlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7x9QbvCyV5/uMb/ZbOZTelfBuJtIOSZaHEFOwZS1U/k=;
        b=OivtLQ8TZnU16dnYYzpixrHUvbkz3MIm2+XoYmYRHobG5JFWIiNpnlYvkI2P9JmnpV
         QjS+a/eaa6Ro4e3W4mS914LmECH1OBYnSDuyuiWV77CSTxl4oXeSU84imlHSXpaXLqdb
         gxSNKtGgia+zMES9gYRuUq/AdzhxipzpIq4SH+XEpVSWdJNBudx5VjUPQG6OQcIIDtPA
         /gsYKTAWJFNhhvaSQea8SaA0w3BRYqB4S3UQL5kjk8TPojwgoVgxU2NX0gZOHq6Ma28B
         T/HYhWjwO9HsX/zW/GI0i9+ABwmfccRLe27R0qlHC3EoQ74ec/rR5W1WHv4+HWLMLWKx
         Zdvw==
X-Gm-Message-State: APjAAAXc9LR8q0Rp6AYOvUdGUJvSykppsYanrSkAHmdo+gDedQfgXZ98
        LBAKTwQ+5mzfScKjaC2Gzhp8I6J1
X-Google-Smtp-Source: APXvYqxqn73YmKtwiQE/Z78oW/kPclfZYPbgL6GOeW6wDfM8YR3mgFQYHFlhxHMRR6wnLD94mNR0Rg==
X-Received: by 2002:a62:1715:: with SMTP id 21mr4286575pfx.134.1566993770513;
        Wed, 28 Aug 2019 05:02:50 -0700 (PDT)
Received: from localhost ([39.7.47.251])
        by smtp.gmail.com with ESMTPSA id y23sm5509638pfr.86.2019.08.28.05.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 05:02:49 -0700 (PDT)
Date:   Wed, 28 Aug 2019 21:02:46 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, Enrico@kleine-koenig.org,
        Weigelt@kleine-koenig.org,
        Andrew Morton <akpm@linux-foundation.org>,
        metux IT consult <lkml@metux.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
Message-ID: <20190828120246.GA31416@jagdpanzerIV>
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
 <20190828113216.p2yiha4xyupkbcbs@pathway.suse.cz>
 <87o9097bff.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9097bff.fsf@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/28/19 14:54), Jani Nikula wrote:
[..]
> > I personally think that this feature is not worth the code, data,
> > and bikeshedding.
> 
> The obvious alternative, I think already mentioned, is to just add
> strerror() or similar as a function. I doubt there'd be much opposition
> to that. Folks could use %s and strerr(ret). And a follow-up could add
> the special format specifier if needed.

Yeah, I'd say that strerror() would be a better alternative
to vsprintf() specifier. (if we decide to add such functionality).

	-ss
