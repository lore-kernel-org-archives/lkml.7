Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1C8C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 14:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C8B20684
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 14:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSIdKxQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfDNOtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 10:49:36 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:42365 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNOtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 10:49:36 -0400
Received: by mail-wr1-f47.google.com with SMTP id g3so18335150wrx.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pW196jQxTXRqAk/6Y2maXNg6Qsez96WYIIzxrDgF1h8=;
        b=rSIdKxQvbRANyYHwppj5VNhtpVi7LytWz5sTHTpgR/+hMVW3/hlMSl68gk0nfgJAkw
         NCUIsBheOy5Pb5Mv6X9owZaekMyFXi+tItyPpGW3svsBEgE+jTcztJ+lspwNbGM073Ie
         vtZ12y2jhgnk31JUE40zFomB3XGNGHRAGePNZrdysprZ3hSxhX3cJEX6VwvPe2MHnaNJ
         3kMlRa8OPYHUgfaL1le2si9tktKtfXnUI0Nbw5laBDlkb1nHIUQtQK8/7CalbA7qdW4L
         Kee3JGNr9ISKUMdmXcPltHCnx896YBAM5RCxlyKKzYoSIGhmv6H+HxkA39QJOE0btMj6
         1IEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pW196jQxTXRqAk/6Y2maXNg6Qsez96WYIIzxrDgF1h8=;
        b=XpTDzpPx8M4aNBqVNcuyeB/wkzp+ljFBTLTzN/RU9CAJEYlpsTO+DZgJJRbKAKT1By
         p1WA72UbpWTagR7X5aFFpHyTPiXTb9dbChjIKuMGvFZvaUqHe3j4PZbKal0YEV51Myjw
         I4PMupyz3RvCWJ5Pew054yls/03e+X6jAh7/F/3wMKE+jzzaNyC/FSgRNlbf2CBCK5Iy
         zBd4VfXzWqNgFJOxt+mjnxageQywsa092CQA/s2WrhL5sHDvzikE+KkSJc0hE83gwYeU
         VmS0aYWskZjqYprBlVLB/pfEmnJKTdDEKS4ZIArmG2FIx3KMFGKbj3Z56tsqt67xISvp
         c6xQ==
X-Gm-Message-State: APjAAAX9mURBD0PgdiWwG28i/tiqLP9pkd9Ul7eIfvr8atClBy24BozT
        PqV+cjF9wZEgsyw9fscTFw==
X-Google-Smtp-Source: APXvYqx1cbEWxr7mZ3pPsvTYAtYSS5VgvuyFDPPe4Nan5xLbD+OFk58brkwp67LZXuivDZEOuqs01g==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr21118897wrm.14.1555253374830;
        Sun, 14 Apr 2019 07:49:34 -0700 (PDT)
Received: from avx2 ([46.53.240.140])
        by smtp.gmail.com with ESMTPSA id 84sm25918729wme.43.2019.04.14.07.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 07:49:33 -0700 (PDT)
Date:   Sun, 14 Apr 2019 17:49:31 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC patch 21/41] proc: Simplify task stack retrieval
Message-ID: <20190414144931.GA14344@avx2>
References: <20190410102754.387743324@linutronix.de>
 <20190410103645.492122341@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190410103645.492122341@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:28:15PM +0200, Thomas Gleixner wrote:
> @@ -430,20 +429,16 @@ static int proc_pid_stack(struct seq_fil
>  	if (!entries)
>  		return -ENOMEM;
>  
> -	trace.nr_entries	= 0;
> -	trace.max_entries	= MAX_STACK_TRACE_DEPTH;
> -	trace.entries		= entries;
> -	trace.skip		= 0;
> -
>  	err = lock_trace(task);
>  	if (!err) {
> -		unsigned int i;
> +		unsigned int i, nent;
>  
> -		save_stack_trace_tsk(task, &trace);
> +		nent = stack_trace_save_tsk(task, entries,
> +					    MAX_STACK_TRACE_DEPTH, 0);
>  
> -		for (i = 0; i < trace.nr_entries; i++) {
> +		for (i = 0; i < nent; i++)
>  			seq_printf(m, "[<0>] %pB\n", (void *)entries[i]);
> -		}
> +

I only object to {} removal. The rule of mandatory {} that new languages
have adopted is pretty cool. Otherwise

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
