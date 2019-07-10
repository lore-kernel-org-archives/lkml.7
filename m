Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E4FC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A206520844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5pcFIr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfGJIT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:19:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41300 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfGJIT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:19:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id q4so858131pgj.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 01:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N6SercxtoSKSRCScJgllC9YsDuWHEtkF2Gy5vLajuYI=;
        b=f5pcFIr4KEnuKujSw0PCI8+ne2ZPT/eTiNxYlV/Fjw+Q+q0Vu48E8I1wCOX1vQXJej
         xust2dEsnBU/pTvXSaBLTG21oarZ2Xepwu3XxlB1zEXsusT4uDJeiTo4r/JZG9KPch2Y
         qx84ao943+2eOxQcCjY+J34bWcbEyPxGT9yvre2IP8ZwcndXohe+JD6DrT+vScM6ndC0
         dh2+0sJf0NLvFZq5iroWefzcT/bIm00EpY1cBiEsBQ0jiE0FP9Mkj0V831eO3Bqsa99r
         9PicD7cGit2+UXfs/qVeNN7PYuDeIlfXWYSQP9nx1NMvYQ8nNGWusHe+seyTprY7EOlN
         IWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N6SercxtoSKSRCScJgllC9YsDuWHEtkF2Gy5vLajuYI=;
        b=IGsPNDLN0czgkiqsuQAJUw3Pzz7OJ2e45ms1We4ydN85mZfyCnx0fgXvlXrruYtbRR
         27pWK/WeUX8JrVNreD15kz8ZEkVAnYJ+ScMaaDIO+47shAGJ8qgDtBJ+WxXvK29CsVcV
         hLp0iIlkL5tVccwNaMj9YLz48ia59CiCX6ca6/olD0sFzJB9Ro5Oje0TW0rSjLztg481
         ZY3TwW7ha5uelGOiohhFgce75FK0iOw/gz0f8zr/P/0TPfsEbHUZpA4mKwghHNjG6ISC
         FQSxxLw4nMkLLBh+s0OujqKfyS3IlMBzQgsrZ94rTADops+uY85gWEN9p36//FtH7+J/
         gRBA==
X-Gm-Message-State: APjAAAXLC13jP2P1ylo0NY+k9QTWyPP6K5En0WXgCZHXQuN6XFb/6oF0
        5Oq9wuTb7qCAq+tdgM7TSjc=
X-Google-Smtp-Source: APXvYqwbWG/EgQGeyQs7s7Fp/DdmsOs7K4ad8V6aBkUpsRLK8b9OdhhMxuEWNxE1nlhfrWj4c0gUcg==
X-Received: by 2002:a17:90a:9505:: with SMTP id t5mr5443039pjo.96.1562746767357;
        Wed, 10 Jul 2019 01:19:27 -0700 (PDT)
Received: from localhost ([175.223.19.33])
        by smtp.gmail.com with ESMTPSA id j15sm2809810pfn.150.2019.07.10.01.19.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 01:19:26 -0700 (PDT)
Date:   Wed, 10 Jul 2019 17:19:22 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: Do not lose last line in kmsg dump
Message-ID: <20190710081922.GA7020@jagdpanzerIV>
References: <20190709081042.31551-1-vincent.whitchurch@axis.com>
 <20190709101230.GA16909@jagdpanzerIV>
 <20190709142939.luqhbd6x6bzdkydr@pathway.suse.cz>
 <20190710080402.ab3f4qfnvez6dhtc@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710080402.ab3f4qfnvez6dhtc@axis.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/10/19 10:04), Vincent Whitchurch wrote:
> > > [..]
> > > 
> > > > @@ -1318,7 +1318,7 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog,
> > > >  		}
> > > >  
> > > >  		if (buf) {
> > > > -			if (prefix_len + text_len + 1 >= size - len)
> > > > +			if (prefix_len + text_len + 1 > size - len)
> > > >  				break;
> > > 
> > > So with this patch the last byte of the buffer is 0xA. It's a bit
> > > uncomfortable that `len', which we return from msg_print_text(),
> > > now points one byte beyond the buffer:
> > > 
> > > 	buf[len++] = '\n';
> > > 	return len;
> > > 
> > > This is not very common. Not sure what usually happens to kmsg_dump
> > > buffers, but anyone who'd do a rather innocent
> > > 
> > > 	kmsg_dump(buf, &len);
> > > 	buf[len] = 0x00;
> > > 
> > > will write to something which is not a kmsg buffer (in some cases).

[..]

> arch/powerpc/xmon/xmon.c
> 2836:	while (kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len)) {
> 2837-		buf[len] = '\0';
> 
> arch/um/kernel/kmsg_dump.c
> 29:	while (kmsg_dump_get_line(dumper, true, line, sizeof(line), &len)) {
> 30-		line[len] = '\0';
> 
> I guess we should fix these first and leave this patch as is?

We certainly need to fix something here, and I'd say that we
better handle it on the msg_print_text() side. There might be
more kmsg_dump_get_line() users doing `buf[len] = '\0'' in the
future.

	-ss
