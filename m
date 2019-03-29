Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E35CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1FE218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3k18amv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfC2SDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:03:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46553 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729929AbfC2SDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:03:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so2756041edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ToysUKbyIJdhK0Jy+JvqWwSmXFVVVtJFZtxHYxMj6E=;
        b=D3k18amvkc0nKB+dvuONeyAQJnjZ5iifJ84TZ8VkhoJZZPzQBQaPn3egX/6G1RgHUP
         tG0ZytnfCcstvew6HopB0iGXzpNHu9v1K0smGf53bMS/SDLibB9PmMmP4OOczdPTrkCR
         pn7/Na3OXR2/3XehRdeTEepJQcwZKcL14e8PmVwUPnrbgGe2gOHOEqf1rSeQlLufKAEX
         U9GRD+dA0c7wuX2vIl9JmQcZIyZWp/dpijG0WfiYLUuiTodVl8ZzBSy79sydVXwqikRb
         1lF2H7tn3eRwCVfNjuQ2QC9hegxglQ/yKMi8vqa4P1AcLUFrLS3gxVg3r7maJfsOY98l
         w95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ToysUKbyIJdhK0Jy+JvqWwSmXFVVVtJFZtxHYxMj6E=;
        b=YhMkBlzpuzn6RKEh71KAGpxXLpkMMsUi0aGOTA6Gt7N9QsZAG1UCHI/Z7v6CIubTvG
         eJ8XqLMspESJTJKcR27YvQqoDbM4s1Xttb6/CCvPrNiCw40eXpQ25Nng3AGbOVp4PdSf
         Q9z5cj/LlJWOrQvO3/XLkbsj6pDRAo+hV0XdY6DChXnUv1EXCp8T2mbD4Oh1inqf7yKy
         uLpJU2gl+ZB6jbhM0ET3A0ByEKwcNs7bhrLHhfmhL8+XD5/TteduWpTwoMLuAmpgp+Ue
         7Bvftzk2EaIlEUO4Fvrx1bdKUiJ0XtDVTQoWtUcVXhCco6iP+XEl6Ynh71CTBFh8zyrh
         ukwQ==
X-Gm-Message-State: APjAAAUWaEqKz7dRewG0Syus0k9q9uHiL2xFpxbVzsfuC8oMkE7CaIQw
        2Qw4oo+eqCcF+VMIKdM3bo4=
X-Google-Smtp-Source: APXvYqxZfxiLIYYzUQslceK1cJbwyMC88mGal7mclDYyGSFWdv2SBucqQ4hG/8ZlGHyK4rr64AwnKg==
X-Received: by 2002:a17:906:af6d:: with SMTP id os13mr27517451ejb.222.1553882613686;
        Fri, 29 Mar 2019 11:03:33 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4079:2f00:b0f8:92a3:86b7:4ccc])
        by smtp.gmail.com with ESMTPSA id p16sm813204eds.61.2019.03.29.11.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 11:03:32 -0700 (PDT)
Date:   Fri, 29 Mar 2019 19:03:31 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Qiaowei Ren <qiaowei.ren@intel.com>
Subject: Re: [PATCH v2 3/4] x86/fpu: Fix __user annotations
Message-ID: <20190329180329.hl3t7a43sg3sshsf@ltop.local>
References: <20190329163047.223508-1-jannh@google.com>
 <20190329163047.223508-3-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329163047.223508-3-jannh@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 05:30:46PM +0100, Jann Horn wrote:
> In save_xstate_epilog(), use __user when type-casting userspace pointers.
> 
> In setup_sigcontext() and x32_setup_rt_frame(), perform explicit __force
> casts for converting userspace pointers to unsigned long; put_user_ex()
> already performs a cast, but without __force, which is required by sparse
> for conversions from userspace pointers to numbers.

...
 
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 08dfd4c1a4f9..e13cd972f9af 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -206,7 +206,7 @@ int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
>  		put_user_ex(regs->ss, &sc->ss);
>  #endif /* CONFIG_X86_32 */
>  
> -		put_user_ex(fpstate, &sc->fpstate);
> +		put_user_ex((unsigned long __force)fpstate, &sc->fpstate);

The __force here is not needed and in fact meaningless as the address
space annotations and checks only concern pointers. By casting a
pointer to an unsigned long, all type info is lost anyway and thus
no address-space checks are performed. It's a bit like such casts
always have an implicit __force already included.

> @@ -569,7 +569,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
>  			restorer = NULL;
>  			err |= -EFAULT;
>  		}
> -		put_user_ex(restorer, &frame->pretcode);
> +		put_user_ex((unsigned long __force)restorer, &frame->pretcode);

Same here.

Best regards,
-- Luc Van Oostenryck
