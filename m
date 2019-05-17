Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC16DC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDF520848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 06:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4fYzjKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfEQG74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 02:59:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42502 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfEQG74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 02:59:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id 13so3200520pfw.9;
        Thu, 16 May 2019 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=acOBVSJe/b9a1J3px6iLY0/PUzqcYk644yoY0pO+fWc=;
        b=r4fYzjKyyva15V5BJgQyBUWunPQ6iE3RrmKaRS0nJqt4r0z5+xRT221roa7vGpJJJK
         4yu10nSaIOGCBD4V9jAhebSoCUQOn9hI4PsqoBN3WlN7wj2gizty6A1ZuAl22108dMFt
         IXLnRBZ6TyXjNF4IiaYMdg4EwuzBKX9lCfV4+8+YzimfO2ZCtBfBfJGnQERypAuhU6yL
         BsLpBjoX3+entTCYxXFFd30pWOt0sQqlrldKxvGstP8vpmyambOIqORidM1JfXx29cpu
         YsmX0YDhCP5jmTLeCOIM1ixTstQJPkXKqo9SRwU7c7EwCcb8wwxpBSbgoufbVt9JBoic
         tlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=acOBVSJe/b9a1J3px6iLY0/PUzqcYk644yoY0pO+fWc=;
        b=QBX/WspPLNEBpwHzKhq1zT4amfIERgcfr8kRS2hENH45cmJ1yWIVbfz+SFZw5NN2sT
         OPipdpttGR8QguM+VtADIt6+7vQwZryMinbMk//Zpxa5zA+mySDE0nP22v8DdYPyVb/Y
         56INEdfvtMU4iDiw7EyJ/zbcOz7A2T6cgFWw8J9AD2hVSPaTZPfvwY/j2Bepej3NsMTj
         sDDYQ94znJjtLBiDprRwuNexy/q578DF/z5aSaJw1vMDDDuHcBS9zZ0yd72NOvutZQPY
         YTGgXuZceLjDVtZubztSXQ3iNr4MsN/AExg2fchpcowaXWuW8SUAQNb1rocqj/PTz442
         qhmg==
X-Gm-Message-State: APjAAAWFC4KqDuQzXTkaF4K/QA4L9p6kRIHLpyw/a8oHGxoAU/AvHg05
        yUP0YAwNBWdr1c7pw1wH2/E=
X-Google-Smtp-Source: APXvYqwVsYMDzmbtlH7JvkVY3DQu3VRAiUxen2R5hvO3et1uXbQGqPujCoICePAFj3Sc5WcxJCveJA==
X-Received: by 2002:aa7:8e0d:: with SMTP id c13mr60354955pfr.193.1558076395817;
        Thu, 16 May 2019 23:59:55 -0700 (PDT)
Received: from localhost ([175.223.38.122])
        by smtp.gmail.com with ESMTPSA id u6sm9339104pfm.10.2019.05.16.23.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 23:59:55 -0700 (PDT)
Date:   Fri, 17 May 2019 15:59:51 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH] s390: add unreachable() to dump_fault_info() to fix
 -Wmaybe-uninitialized
Message-ID: <20190517065951.GA11550@jagdpanzerIV>
References: <20190517064922.22743-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517064922.22743-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/17/19 15:49), Masahiro Yamada wrote:
[..]
> @@ -211,6 +211,8 @@ static void dump_fault_info(struct pt_regs *regs)
>  		asce = S390_lowcore.kernel_asce;
>  		pr_cont("kernel ");
>  		break;
> +	default:
> +		unreachable();
>  	}
>  	pr_cont("ASCE.\n");
>  	dump_pagetable(asce, regs->int_parm_long & __FAIL_ADDR_MASK);

Or have default fault type and asce?

Just an idea.

---

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index c220399ae196..876d71c31894 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -174,7 +174,8 @@ static void dump_pagetable(unsigned long asce, unsigned long address)
 
 static void dump_fault_info(struct pt_regs *regs)
 {
-	unsigned long asce;
+	unsigned long asce = S390_lowcore.kernel_asce;
+	char *type = "kernel ";
 
 	pr_alert("Failing address: %016lx TEID: %016lx\n",
 		 regs->int_parm_long & __FAIL_ADDR_MASK, regs->int_parm_long);
@@ -197,22 +198,18 @@ static void dump_fault_info(struct pt_regs *regs)
 	switch (get_fault_type(regs)) {
 	case USER_FAULT:
 		asce = S390_lowcore.user_asce;
-		pr_cont("user ");
+		type = "user ";
 		break;
 	case VDSO_FAULT:
 		asce = S390_lowcore.vdso_asce;
-		pr_cont("vdso ");
+		type = "vdso ";
 		break;
 	case GMAP_FAULT:
 		asce = ((struct gmap *) S390_lowcore.gmap)->asce;
-		pr_cont("gmap ");
-		break;
-	case KERNEL_FAULT:
-		asce = S390_lowcore.kernel_asce;
-		pr_cont("kernel ");
+		type = "gmap ";
 		break;
 	}
-	pr_cont("ASCE.\n");
+	pr_cont("%s ASCE.\n", type);
 	dump_pagetable(asce, regs->int_parm_long & __FAIL_ADDR_MASK);
 }
 
