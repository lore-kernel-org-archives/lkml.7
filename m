Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04278C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3780206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXg9mUPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfCKMtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:49:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34163 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfCKMtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:49:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so970327pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 05:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C+GwhHTtBwie6EI5/ao7Xzpr/O+vEe11buV/rCGi6ks=;
        b=LXg9mUPLL4dio3CBC+lcPpOL+rihuJ5JGEf/aV2u8avo39C0gz1DLlSYAfX6J/xCQi
         uCeecwFhd/PXDX7L51UDdk7MfzjFTofKVX/qywwo1qTRkEAnO9JxHU8hxqIu8VfMjZsg
         16gPEyFqsMnFShEepJjfCCH+F1l2ClZa5iFkM3dEkS4cV7PRW/ZA3ZZemm/rqQpLvaiM
         3yXYGv0NrJZu8fwxZTFNxbdzbNQtZtR5JCe+kEocxq56Bo+tWBftckpZrDjBtoKLxnoC
         AmQv36FtAkWsAfl3FhOGzPEsR8He/QQVI0m4KWL9Tsvek7ZdRPy5baBUqomfmO2DQnyV
         tKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C+GwhHTtBwie6EI5/ao7Xzpr/O+vEe11buV/rCGi6ks=;
        b=TLQtUEGKblo/W8d6SgyQRkR88EgPF213pE5+WyCOPm3urXSC31xlFD7iqfLwmVrrS9
         docm6Q2Z651Tcz6xtl++d+usuXUoRboWqb4h/8W9z7qLKAiKUxVcJs94i/QAtsqRbDZb
         NB38ygfSq4BCCpuWhsOFZfX0h37VTHJ+I0Vuq4GkqK7FWeezUGhvH8pupp2ZDaqQWF8e
         Uef0qBDqq9ymaQHR9IjXYhM28M9ohT+MTgeN1ec4GUHSfI6Hn7uvPlAxpE8QdmkQO5fS
         LzbUPZhrEn89//UGx5lsEPtBg1SSHvBgvHzFeJtHTclGRjIEN2u1glwltqVyCn5dqB4m
         /O4g==
X-Gm-Message-State: APjAAAVxBR0ZX8NIqUDdGmmzC7ZZqMZ5auoJRBJcXYgqVO44I7oHz115
        i5P0hUh1rMKolKaGLk8Z9ya5weWq
X-Google-Smtp-Source: APXvYqx61Vj44atwLvWG8HV7S042Lz1T6e3dbGwFr65dnaXZyx0idYsbXjm/vKBHdSYXGTd84kF8CQ==
X-Received: by 2002:a62:8c:: with SMTP id 134mr32564793pfa.27.1552308549653;
        Mon, 11 Mar 2019 05:49:09 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id b6sm9188025pfo.27.2019.03.11.05.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 05:49:08 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 11 Mar 2019 21:49:05 +0900
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: kmsg_dump: Mark registered flag as private
Message-ID: <20190311124905.GA416@tigerII.localdomain>
References: <20190310200302.GA11096@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310200302.GA11096@darwi-home-pc>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/10/19 21:03), Ahmed S. Darwish wrote:
> The 'registered' flag is internally used by kmsg_dump_register()
> and kmsg_dump_unregister() to track multiple registrations of the
> same dumper.
> 
> It's protected by printk's internal dump_list_lock, and must thus
> be accessed only from there. Mark it as private.
> 
> Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> ---
>  include/linux/kmsg_dump.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> index 2e7a1e032c71..7c08cb58259a 100644
> --- a/include/linux/kmsg_dump.h
> +++ b/include/linux/kmsg_dump.h
> @@ -36,7 +36,7 @@ enum kmsg_dump_reason {
>   * @dump:	Call into dumping code which will retrieve the data with
>   * 		through the record iterator
>   * @max_reason:	filter for highest reason number that should be dumped
> - * @registered:	Flag that specifies if this is already registered
> + * @registered:	Flag that specifies if this is already registered (private)
>   */
>  struct kmsg_dumper {
>  	struct list_head list;


Do we really do this thing?


$ git grep "(private)" include/linux/
include/linux/kmsg_dump.h: * @list:     Entry in the dumper list (private)
include/linux/uwb.h: * specific (private) DevAddr (UWB_RSV_TARGET_DEVADDR).

	-ss
