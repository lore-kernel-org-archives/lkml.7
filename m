Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BF0C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B0220717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjyEuMBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfDYUIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:08:10 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40645 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfDYUIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:08:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id o16so708098lfl.7;
        Thu, 25 Apr 2019 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U/BqXYTulsnDpCVbo7zpckUGHQVmVWk+Wu4kkxDKcuA=;
        b=gjyEuMBXw3BG5r0pql3WFgHwwep3ybT8+lvjimm3cz6bZOvnh9I5iW8djEfD6CM8/m
         skrpWpWAY+onh3KA0JZSh09QTSR8N1ncGHZGnUZF7VnSNEl7bdN5fUJ6K+Ta2FqSMQw9
         yOtbQICQbu/MN2yeEYvdDc712UF8VDG4Ym+0RLKF8i0ARQvjo4UERjrV3qr8s5fxxeXv
         vsFs0iVFwqaJaQqvH9WadiAl6hRdr1zUUMXXP1Z/+kX+eQJaaukbyJlqHu0j20WgqzJJ
         CveXWJ+tLzgTglUcDdau58Mf1c1WuHznbTPsfFEjtxQvGlN9vzpoB5bauNV8bnQ4yz26
         QPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U/BqXYTulsnDpCVbo7zpckUGHQVmVWk+Wu4kkxDKcuA=;
        b=p/J0TTJaholEcAXIuxTta7IjWF89Oz1vuEyPVFlvJgv7ntnBLoe7HM2D9lfXnw3BpW
         G2qjHRDKe8kkfCdxgoLLJu6VdLea8YmjRBhX79QvmQRPEREpBqcAvI08LW8Ofur4Ue07
         i06B8CpMIu/Mp+SxjC5Osv/qtzhdL+YgVVmjrE6akQCJwh3lcgBM/kNlkc5qMyyBYsQI
         5OlAfoBHGF45VkXV7w3/b8gdzsWucmkpp/n7ygF1YmzdI7LFiqMmFAvVzvBeLJbXUWiK
         sqUDxQfuN5XVmijqQz+RZT4qEFo/Dm32gGRQBVlKx2LWuqKQ+9hU8xmyvH489AA+SxuC
         17Xw==
X-Gm-Message-State: APjAAAWeVt/caYF2X0RvI5X49vrlarJHIRjqVuWzMHMpmBh9w2ekn77h
        30zbWgj7UxFoWZXhFkw/Vig=
X-Google-Smtp-Source: APXvYqyqs+t7DtHLY0N397hSmp7RzVzMJag/+aCW/naP9ZzNE43G1Zsnd08jz/NedD1zUr9sCbd2Hw==
X-Received: by 2002:a19:3f54:: with SMTP id m81mr21559379lfa.98.1556222887297;
        Thu, 25 Apr 2019 13:08:07 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id t7sm4700855ljj.87.2019.04.25.13.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 13:08:06 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 3A4C6460298; Thu, 25 Apr 2019 23:08:06 +0300 (MSK)
Date:   Thu, 25 Apr 2019 23:08:06 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCHv3 04/27] timens: Introduce CLOCK_BOOTTIME offset
Message-ID: <20190425200806.GQ6662@uranus.lan>
References: <20190425161416.26600-1-dima@arista.com>
 <20190425161416.26600-5-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425161416.26600-5-dima@arista.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 05:13:53PM +0100, Dmitry Safonov wrote:
> 
> diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
> index 8f75d34cf34a..5f0da6858b10 100644
> --- a/include/linux/time_namespace.h
> +++ b/include/linux/time_namespace.h
> @@ -48,6 +48,14 @@ static inline void timens_add_monotonic(struct timespec64 *ts)
>                  *ts = timespec64_add(*ts, ns_offsets->monotonic_time_offset);
>  }
>  
> +static inline void timens_add_boottime(struct timespec64 *ts)
> +{
> +        struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
> +
> +        if (ns_offsets)
> +                *ts = timespec64_add(*ts, ns_offsets->monotonic_boottime_offset);
> +}
>
...

>  struct timens_offsets {
>  	struct timespec64  monotonic_time_offset;
> +	struct timespec64  monotonic_boottime_offset;
>  };

Guys, is not the _offset postfix here redundant? timens_offsets
already has it and ns_offsets->monotonic_boottime_offset looks
too much.

static always_inline current_time_ns_offsets(void)
{
	return current->nsproxy->time_ns->offsets;
}

static inline void timens_add_boottime(struct timespec64 *ts)
{
	struct timens_offsets *tns_off = current_time_ns_offsets();

	if (tns_off)
		*ts = timespec64_add(*ts, tns_off->monotonic_boottime);
}

Hmm? Up to you though.
