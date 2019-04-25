Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB851C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 03:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76DA217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 03:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOIrPSjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389066AbfDYDwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 23:52:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34332 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfDYDwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 23:52:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so10425005pfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 20:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JyMRC4bQxmeTecRIhQz8MaDeN6OKQdFakSOWHZxzJ1I=;
        b=cOIrPSjEugBZ2GkQWM5NvKDRb6VzYjjJXiTvqE7Lsj7qzmJrDUYKKOEMkhsTll5D3n
         OWIoZViz4EmUMQ5aUsOAc8nsW82yqxpAikMsYq4ieYF9LDDH25eNAKcsn4GXQk5j5gLa
         ettWTERzZdcK+TimJQX+kzQwwt4KB0A8ijQKrzfzNkwpA6AhHp5X5PxGqpoyvEfENE+v
         8slyTFyyrmHlV+NzId7T4kgFWoOSqg4EFtIZyFIu68jEMOnwCQ3icyK17oL83oOAfSSt
         1HMPOlHY5euAbs/Cde6b+ndkQM4i+qw+H0xKP8pNQWIQ7ldmT/vepFRKm9OuXTdslfyn
         4lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JyMRC4bQxmeTecRIhQz8MaDeN6OKQdFakSOWHZxzJ1I=;
        b=Cen5JC+Gc9oh4H8og2nV5Yj/qQg1L4Vub7AXd144qb5XLHy1Ob3BY+xH0UXVcpC+M4
         WEmPm9NONMvdllxjTuIZQcIHgzZRhKgqH9bfxv2lOyc41J5rr/v4oOVgcbXBAP81/S7I
         sSlLxwnb1nYdWwitUr8F/MHSpukaro0xrQUrQtrGdXpXGixu5X369402GnjVMpc8iAjV
         QusOwEQtLUWAAi53O9ECdtqL0SaOSuug+dzb5eXZ5uiBdLj9N8y5EuIXtmwvEeAKlVeH
         hSztBtrQP7hiVjW3dM+qtXH5WHg0VVjsDzMJEWLpJVeW8tGuqWJjbkJ1v+CgHLSKlsv0
         EQWQ==
X-Gm-Message-State: APjAAAXjwpeXzXzlLWvERh6TXFNUt8Richvkn5VdQ0YCshghvFYN5riJ
        NK4Yk688LyreIUg5VvtrDak=
X-Google-Smtp-Source: APXvYqyVhlqsD0Ke74YRA1J4/JYML+7yMMUUio3ArmBN6WffuxeCbjQ8TTRe9vBIiFtFTrVX8a/szg==
X-Received: by 2002:a63:4c45:: with SMTP id m5mr26240163pgl.78.1556164357455;
        Wed, 24 Apr 2019 20:52:37 -0700 (PDT)
Received: from localhost ([175.223.37.83])
        by smtp.gmail.com with ESMTPSA id p17sm27687094pfn.157.2019.04.24.20.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 20:52:36 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:52:33 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 1/2] printk: lock console_sem before we unregister
 boot consoles
Message-ID: <20190425035233.GA8532@jagdpanzerIV>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
 <20190423062511.1118-2-sergey.senozhatsky@gmail.com>
 <20190424144924.lw5sgl7qa2yrpxsj@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424144924.lw5sgl7qa2yrpxsj@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/24/19 16:49), Petr Mladek wrote:
> > +	if (bcon && (newcon->flags & (CON_CONSDEV|CON_BOOT)) == CON_CONSDEV) {
> > +		console_lock();
> > +		/*
> > +		 * We need to iterate through all boot consoles, to make
> >  		 * sure we print everything out, before we unregister them.
> >  		 */
> 
> I wondered if moving the console locking could break the above
> statement.
> 
> It seems that the comment has been invalid since the commit
> 8259cf4342029aad37660e ("printk: Ensure that "console
> enabled" messages are printed on the console").

That's very interesting. Yes, you are right, the comment is a
leftover. printk used to iterate consoles twice before
8259cf4342029aad37660e

               /* we need to iterate through twice, to make sure we print
                * everything out, before we unregister the console(s)
                */
               printk(KERN_INFO "console handover:");
               for_each_console(bcon)
                       printk("boot [%s%d] ", bcon->name, bcon->index);

               printk(" -> real [%s%d]\n", newcon->name, newcon->index);
               for_each_console(bcon)
                       unregister_console(bcon);

But 8259cf4342029aad37660e has changed that and has made comment
invalid.

> Could we remove it in this patch? It touches it indirectly anyway.

Sure we can.

We also can take extra care of pr_info("%sconsole [%s%d] enabled\n".
Right now we do

	...
	console_unlock();
	console_sysfs_notify();

	pr_info("%sconsole [%s%d] enabled\n",....


But we can simply move that pr_info() a bit up:

	pr_info("%sconsole [%s%d] enabled\n",
	console_unlock();
	console_sysfs_notify();


So the message will be printed on all consoles.

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c2bccf58d03e..981eb6c27cdb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2813,8 +2813,6 @@ void register_console(struct console *newcon)
 		exclusive_console_stop_seq = console_seq;
 		logbuf_unlock_irqrestore(flags);
 	}
-	console_unlock();
-	console_sysfs_notify();
 
 	/*
 	 * By unregistering the bootconsoles after we enable the real console
@@ -2827,6 +2825,9 @@ void register_console(struct console *newcon)
 		(newcon->flags & CON_BOOT) ? "boot" : "" ,
 		newcon->name, newcon->index);
 
+	console_unlock();
+	console_sysfs_notify();
+
 	if (keep_bootcon)
 		return;
 
---

> Otherwise, the patch looks fine to me:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks!

	-ss
