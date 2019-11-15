Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14309C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98FC20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plD1YOaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKOEeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 23:34:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39637 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKOEd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 23:33:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id 29so5188056pgm.6;
        Thu, 14 Nov 2019 20:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uG8EYto2G5KUs/xrRVV9nqvd+H7D1BzazmBvDXAUch4=;
        b=plD1YOaNtJ71eOne2Z0YRcvw2L0eBFV+IsZdz01pd3dF/+Cp7NEW+SaLgddIzKXvIb
         kv2oQTPWaU9yuuvo9mhmpZlgPLnVwIx8sBAiz4A9FDvwlESV8kTbUli5Crq9aI9MOXCf
         HlaVk45La7pdje3K/dt9Opmq3P6teL6SnnSkLRgp/XTIYRSFR8vsW8ODOj8mfKR67wEi
         aegHhKAy6bAszf8Vu1eZbUUhXXi2v7ltLq3ixDO9dqlx890OGZSwfLpFXG1d9CWLFZ59
         I+9pZZSCHI7Zu947gxt/ktg3F+hdamMooXOsoFzv96ozqUF5hPZmBt+g39YCyaghndFu
         rtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uG8EYto2G5KUs/xrRVV9nqvd+H7D1BzazmBvDXAUch4=;
        b=J1d01wNZs5YzqpAmdbFPqwW76Hg2UvD2nv0rn8A+fM78m7sfQuv1RI8kZ3hzuT9/8k
         GRR8fznDTBkwGz057QMPwnjN1EALBtltN68XeLB73tCpJGHC+cdi8NWpT62r+KXpWu2a
         eYzdiRgUcH+nmNQGj5gzf/vQLo3FlV6TAsWHiNrcV5+OGEr1lfCmzYleiZey4cqApq2Z
         M1FqTs/irNalYLyLBrhl1Ecgp1TgdztZ0FI+1L/RxkERoIUnIoZK6fuxeBZakWoCekrT
         kG6wY8nF6pUrKp7aOYM7/hludotlfNIeEQ8pXkj/jvv4lUotTUVzH5lMXMg+SvXf4MR6
         Vcpw==
X-Gm-Message-State: APjAAAWGQ3LEzioigAfJOaYga0jUl1fUoMWGpAjdUYMzDX2dVJYjdm1p
        CX0PAHFSMq9Y8BUfOnbObPUyIXVhqGA=
X-Google-Smtp-Source: APXvYqzdYiwsPqZoNlVml6tlzRZzQKB4JQJ2ZAJztAW0vdJWLBdWIj5wPzwiGCeMgkTS6VEnWQ+S3A==
X-Received: by 2002:a62:aa0a:: with SMTP id e10mr5708723pff.46.1573792439044;
        Thu, 14 Nov 2019 20:33:59 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id m11sm1769772pgd.62.2019.11.14.20.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 20:33:57 -0800 (PST)
Date:   Fri, 15 Nov 2019 13:33:56 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jonathan Richardson <jonathan.richardson@broadcom.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        sergey.senozhatsky@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: console output duplicated when registering additional consoles
Message-ID: <20191115043356.GA220831@google.com>
References: <CAHrpVsUHgJA3wjh4fDg43y5OFCCvQb-HSRpyGyhFEKXcWw8WnQ@mail.gmail.com>
 <CAHrpVsW6jRUYK_mu+dLaBvucAAtUPQ0zcH6_NxsUsTrPewiY_w@mail.gmail.com>
 <20191114095737.wl5nvxu3w6p5thfc@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114095737.wl5nvxu3w6p5thfc@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gosh, that part of printk is really complex.

On (19/11/14 10:57), Petr Mladek wrote:
> For a proper solution we would need to match boot and real
> consoles that write messages into the physical device.
> But I am afraid that there is no support for this.

Wouldn't those have same tty driver?

---

 kernel/printk/printk.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f1b08015d3fa..a84cb20acf42 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2690,6 +2690,19 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static bool known_console_driver(struct console *newcon)
+{
+	struct console *con;
+
+	for_each_console(con) {
+		if (!(con->flags & CON_ENABLED))
+			continue;
+		if (con->device && con->device == newcon->device)
+			return true;
+	}
+	return false;
+}
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -2828,6 +2841,9 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_EXTENDED)
 		nr_ext_console_drivers++;
 
+	if (known_console_driver(newcon))
+		newcon->flags &= ~CON_PRINTBUFFER;
+
 	if (newcon->flags & CON_PRINTBUFFER) {
 		/*
 		 * console_unlock(); will print out the buffered messages
