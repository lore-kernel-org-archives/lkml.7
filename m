Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8543C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7256822CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVbfl0Yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfIDR0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:26:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41880 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfIDR0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:26:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so7032589pfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 10:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ROgB4h58QMEVyYv0sNprUzebRhyru9CLqVqNVq1yZxo=;
        b=GVbfl0Ypf5oyMkUBtwA6f+bRTs1kL+UgAFTzM8TNbffT+eW4C7XxGztnZpQuzSZ9cF
         tSgByzkhGVnJYEjs3dhDdwwAK6T8wgt2BVMfyNIClO0w4EwBXj/xAwkh2ZBIqGFfXQsg
         jonWQSR8hcqkc+bCFBpKNWS22hcAwjULt5OKTQZMwRdsHmAeUm6HW3FvFpYbFB1bJBoR
         Ape+np+dqRzxemvZm+tcvjhY3Wq8mXmLsJBr2CcGo3AdzP22TPA7n7LPR+Ach9ODMERE
         Gm1W0bBOOFILh5SqZ2eEshX/u6yc40X3KKj3G/4USe5FgZjBPmR79ES+l3oYWZFd5s5m
         7vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ROgB4h58QMEVyYv0sNprUzebRhyru9CLqVqNVq1yZxo=;
        b=Z0kmyWFFqFx4ptpZIIyYqEQyde6WIhSr0mnZrfagnV4E0YPwd0FEnca7DuUwlU8FJ+
         8mvkvuQt8e8Gk3BNdm3FQNGwL4QFJHD2AA5vkemEhG877YwmVP32MQgBK3FHrnRs1n2l
         snRvqcO1RYjSpqvyrwWvIuti9yeJxFb01XsJD8jzFpHAuTS4A49awTx21vFzYDN+wBi4
         200WguCrbu3JWS5/3jfjnCL49cRQpjBLL0XJIHEwrBHXFfJGvxKfgUJGCgaQUOiJxeJO
         SwFBYidn7SAUZ7QtDSG5rw9gAJ5tu9Z2/SPCP92N59NxCFt604ZiXBovawIKsoua26ok
         TWKg==
X-Gm-Message-State: APjAAAWaFPM0nga6d9jpiH31WrQkBtzpHRgYBlieXG8/dYNuLFnRdigS
        8sU9LjsmE3xmFuOajEOS+q0=
X-Google-Smtp-Source: APXvYqz4aFKZtWfspR0msaH56qTIBaI3tvW7Q1gaoI+dIgRntfIWFXQSxGUj8p2wgswda5OsObnG9w==
X-Received: by 2002:a62:cb:: with SMTP id 194mr22598138pfa.130.1567617960584;
        Wed, 04 Sep 2019 10:26:00 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a128sm29549698pfb.185.2019.09.04.10.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 10:25:59 -0700 (PDT)
Date:   Wed, 4 Sep 2019 10:25:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Matt Linton <amuse@google.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/process: Add Google contact for embargoed
 hardware issues
Message-ID: <20190904172558.GA24934@roeck-us.net>
References: <201909040922.56496BF70@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909040922.56496BF70@keescook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 09:24:49AM -0700, Kees Cook wrote:
> This adds myself as the Google contact for embargoed hardware security
> issues and fixes some small typos.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Matt Linton <amuse@google.com>
> Cc: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Guenter Roeck <groeck@chromium.org>

> ---
>  Documentation/process/embargoed-hardware-issues.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index d37cbc502936..1c1ad684d753 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -5,7 +5,7 @@ Scope
>  -----
>  
>  Hardware issues which result in security problems are a different category
> -of security bugs than pure software bugs which  only affect the Linux
> +of security bugs than pure software bugs which only affect the Linux
>  kernel.
>  
>  Hardware issues like Meltdown, Spectre, L1TF etc. must be treated
> @@ -159,7 +159,7 @@ Mitigation development
>  
>  The initial response team sets up an encrypted mailing-list or repurposes
>  an existing one if appropriate. The disclosing party should provide a list
> -of contacts for all other parties who have already been, or should be
> +of contacts for all other parties who have already been, or should be,
>  informed about the issue. The response team contacts these parties so they
>  can name experts who should be subscribed to the mailing-list.
>  
> @@ -230,8 +230,8 @@ an involved disclosed party. The current ambassadors list:
>    SUSE		Jiri Kosina <jkosina@suse.cz>
>  
>    Amazon
> -  Google
> -  ============== ========================================================
> +  Google	Kees Cook <keescook@chromium.org>
> +  ============= ========================================================
>  
>  If you want your organization to be added to the ambassadors list, please
>  contact the hardware security team. The nominated ambassador has to
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook
