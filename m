Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2947BC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 00:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF0520640
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 00:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJiE+j6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbfIQAxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 20:53:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37180 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbfIQAxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 20:53:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id b10so725582plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 17:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bb3WgUuPlwJWlYbzoUQVlukqZNU/xGNNtLsMKZAKSWI=;
        b=JJiE+j6yomdxr6HSuUweYXgimT2ZE+elZD7yXoRYTuhZwLroQjRbf33BiGhl+/ecw1
         Z9r/FP6bqd9jN8I9Hoz4Vl5u/19RTPOqvefNOGfqtSSxMUQu/8SS4r3RmlsaQDPfeJr3
         eeNzl1kYYq0UrvUDshYHOC5YpIERwW8isPEgNbuDlaM7sIIAiZa7ca16WICZguqkcGl/
         aCGcwWn2N++7fdU99NbfKxrTFr5E1tfFIjWIHLe3nrmgh3fIDbxEoE0AREy0Z1g3Z9l2
         IPsMwpB95rnV9lJn6rjxAsdKIj9/lS3sW474ujoVQWbwvmWs2VnYpceyk3kFvGYKReCm
         2gKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bb3WgUuPlwJWlYbzoUQVlukqZNU/xGNNtLsMKZAKSWI=;
        b=L45EBhvDlG1m8JjL1ixyS0XWH00J8GzOQD9VFcXCswlUsjKjpyoqsCF3vdTGs0bnBh
         iNIhWIPmpFZ0rFcDkMkjnhK9cMWOaHol+L/DokRLD+epmHZPI/ZDCg44k94DKHepX1ps
         zy746jWNZ1IW8IUOcUCWSXB/x9bpGLRALS6Eotu9EwlO/NbOxqBTinYmv3CsOUc+fq9S
         73piQrltQy/8PCBgAmfi7jWXIBiO5ENHzhEWNjFKiU3iNoe4SY2yfUEyLLk+w9j363jO
         rVK8yCKFk+CV3ZytXaNtxIgEkigiH5p3I6UWmYKxRDduEW7SMWQJz2wK5nQUqo9NxLB7
         EfwA==
X-Gm-Message-State: APjAAAXMrXiZZv3U3xnit4CVrsXehPU3S73EHWaG0Uu4Qbxcu45+vSCK
        IUj5UJp3mgz0kwzAebwXBRY=
X-Google-Smtp-Source: APXvYqxWmGkNGIvP0iApQpIgZ+XbGCgnNGJDgqVmTf07dDFscLXble+QsYvpdfkGJt5n1L26rkvQWg==
X-Received: by 2002:a17:902:166:: with SMTP id 93mr944351plb.195.1568681624214;
        Mon, 16 Sep 2019 17:53:44 -0700 (PDT)
Received: from localhost ([110.70.27.73])
        by smtp.gmail.com with ESMTPSA id bx18sm336950pjb.26.2019.09.16.17.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 17:53:43 -0700 (PDT)
Date:   Tue, 17 Sep 2019 09:53:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Qian Cai <cai@lca.pw>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: page_alloc.shuffle=1 + CONFIG_PROVE_LOCKING=y = arm64 hang
Message-ID: <20190917005340.GA9679@jagdpanzerIV>
References: <1566509603.5576.10.camel@lca.pw>
 <1567717680.5576.104.camel@lca.pw>
 <1568128954.5576.129.camel@lca.pw>
 <20190911011008.GA4420@jagdpanzerIV>
 <1568289941.5576.140.camel@lca.pw>
 <20190916104239.124fc2e5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916104239.124fc2e5@gandalf.local.home>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/16/19 10:42), Steven Rostedt wrote:
[..]
> > 
> > This will also fix the hang.
> > 
> > Sergey, do you plan to submit this Ted?
> 
> Perhaps for a quick fix (and a comment that says this needs to be fixed
> properly).

I guess it would make sense, since LTS and -stable kernels won't get new
printk().

	-ss
