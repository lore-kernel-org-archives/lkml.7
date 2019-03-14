Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BE7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DE021852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqaNQrOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfCNPbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:31:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38489 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfCNPbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:31:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id x13so5208266ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X29qD572XDhwQDUYvvfauJvranUfr9DXAotN0Ygi2yc=;
        b=dqaNQrOQUPxFhCD/KKrTghKxyFjnBT2TnlKsLgqN2NJwu/bGJko5Bn8cRTDVTLE0ec
         kexX/vmwZU/YOc103gcdyHOyw+DmM7oyKvITJro5pUBFLe4qQS9y05U8C1qlM16BEihN
         yUptR5O2sYXlSSH4zvKQwNY+p9VVRXf6EDZQAUggRqtW/LEViV2uxfVbILt7NzTZ+qbP
         GZVvgpqB+s3ZzhIiJ/PpGx4XVn5m8jIFWlnEluztr033u36C492CNt3DD2CNzkE874Df
         gqmAiauOWmFE9H0W3HKnAlGev+Puw42QtBzVXd+ubL9j43PQKAsheAkrEaQE6i9TvURh
         Y+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=X29qD572XDhwQDUYvvfauJvranUfr9DXAotN0Ygi2yc=;
        b=N0EV3bhdZBSqzhJamRN9ZyEYormbO0dPdJ7uIERyWtUOpBYMIqlX5K34CkGjN3RnjN
         le+wj6QqB0kIR5MbU56FUfZFw0bLAH8oArWTxgJKyT/GXjZ+BQG404kW41XqfHtlIkUR
         NfAwsG2lIMb2Cfn1xFk3R2pubICJIYWGTnBPoU0IUyqaS4FZqv051de1gydE2FAUryaH
         0ifjD7pKdK508186LYfcN6QJE8P0fvj3xsUIB7uAXmAvRn5fsN1YHbjACEdFiRsndUqO
         EFgXhgD2clUPjsx92JdXGPi2uPn24SYrz0HOZv0y3EJFIYWRT5B/sf/H9b31KLc7YzR+
         CQDg==
X-Gm-Message-State: APjAAAXyLoTefnELOPU4OHAg9QL7aXWxGiCnm4bBihFUxJ8yQBVIVyLt
        cpuvaGKMpnqAQeK4KIl8nnQ=
X-Google-Smtp-Source: APXvYqwoqa59LLqCtLkWDksgqoJmFXNvIVopFbiDO+KIaQRmGbc+e8ApD8bcbDbcI+KGGpVkzjw3Xg==
X-Received: by 2002:a2e:8510:: with SMTP id j16mr19670247lji.2.1552577499410;
        Thu, 14 Mar 2019 08:31:39 -0700 (PDT)
Received: from linmac2 ([46.138.63.5])
        by smtp.gmail.com with ESMTPSA id b26sm54629lfa.47.2019.03.14.08.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 08:31:38 -0700 (PDT)
From:   moosotc@gmail.com
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] objtool: Move objtool_file struct off the stack
References: <183fac0cca806ab54b0709ed0eb94aa2e86fdc24.1552577139.git.jpoimboe@redhat.com>
Date:   Thu, 14 Mar 2019 18:31:37 +0300
In-Reply-To: <183fac0cca806ab54b0709ed0eb94aa2e86fdc24.1552577139.git.jpoimboe@redhat.com>
        (Josh Poimboeuf's message of "Thu, 14 Mar 2019 10:25:58 -0500")
Message-ID: <87mulxxyjq.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf <jpoimboe@redhat.com> writes:

> Objtool uses over 512k of stack, thanks to the hash table embedded in
> the objtool_file struct.  This causes an unnecessarily large stack
> allocation and breaks users with low stack limits.
>
> Move the struct off the stack.
>
> Fixes: 042ba73fe7eb ("objtool: Add several performance improvements")
> Reported-by: Vassili Karpov <moosotc@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  tools/objtool/check.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 0414a0d52262..91c4799192e1 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2184,9 +2184,10 @@ static void cleanup(struct objtool_file *file)
>  	elf_close(file->elf);
>  }
>  
> +struct objtool_file file;
> +

Maybe it also deserves a "static" storage duration (if nothing else this
would prevent possible name clashes)?

>  int check(const char *_objname, bool orc)
>  {
> -	struct objtool_file file;
>  	int ret, warnings = 0;
>  
>  	objname = _objname;

-- 
mailto:moosotc@gmail.com
