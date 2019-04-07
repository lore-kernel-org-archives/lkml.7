Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5421C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9426C213F2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0TWfzwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDGLWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:22:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35161 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfDGLWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 07:22:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id s39so9172443edb.2;
        Sun, 07 Apr 2019 04:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p38y1Z8OAIHDpBI4bmmPeGfl/LANifrJcDre2IIMaIo=;
        b=K0TWfzwAWnp5stOsw5iuSYR/OmivN800u+j2/7ddjRikl7q71SUEpwCdTjpSK/+1XJ
         sm2GgcClZ2EBwHMrPMSDwpW3iTsy6w3E21VD/sM0+EOPK/RgcvuJprDif3nsBjcm7DfV
         Y0WT11K+W0/qinsk4TrcWUGT5ow3VEWgPYD4PO+He0oHdWePT+VLbIggOu/mmG+Ad22W
         K75znBZOfjiFxBkMJYvw8lvKUbjbpehCOtuuS5R/cXnIUriCn112I0rnyQeSlLpHr7yp
         yc/7wAMOSqOj9x0E43V7hFCuFFTyANC21gxPorK8Pj2rT56khNJtCvWm3rYwtrB724m3
         6cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p38y1Z8OAIHDpBI4bmmPeGfl/LANifrJcDre2IIMaIo=;
        b=od6fSwKO9FqpnDfZCBtPPFOyjF3v7DaKCI4sqoxEVAAknGW8hhOFtUVxOk0KXOBE6v
         lv91Hq8I3FLTIuzeUjGKMMqV2LDKQGxTsGjun2BRIc8i6IIyZj6f/XSdDRjQ1RM0f/ER
         j7mo0D9rmAmSyZNuI+fAW496ahCDWyR0bB24udZCpipLExLJvVq/d8SltfBI9V9nKMiI
         EsjqDW/wBkGE37JkhyvS3miebQBw3VhzhSIj/ohgES/lEE26wLVP7l8YRldJt26YHvnp
         AvrF4Z2ufXOCtOad127HXkxQlmNiq/BS7+OyNZUrais98vwM4V+1pzErb78k565GUEHJ
         Q9eA==
X-Gm-Message-State: APjAAAWOTA/biQE5ra+6JZYMX+bXqGYdZXtZ1zKLuCTD6AIZZFq4O7JM
        2CynnN/FGFjgGI467TcyKaA=
X-Google-Smtp-Source: APXvYqyG8RQ8O2Q2QYqWTONy4XeRtMrSAislCJr56xv/h9FCc6D8VVmecrYKkt5LGJ7emtvkyhvxtw==
X-Received: by 2002:a17:906:8381:: with SMTP id p1mr13192459ejx.169.1554636161976;
        Sun, 07 Apr 2019 04:22:41 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id j14sm4965167ejc.69.2019.04.07.04.22.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Apr 2019 04:22:40 -0700 (PDT)
Date:   Sun, 7 Apr 2019 04:22:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net, lenb@kernel.org,
        keith.busch@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] acpi/hmat: fix an uninitialized memory_target
Message-ID: <20190407112238.GA30750@archlinux-ryzen>
References: <20190407011222.38963-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407011222.38963-1-cai@lca.pw>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2019 at 09:12:22PM -0400, Qian Cai wrote:
> The commit 665ac7e92757 ("acpi/hmat: Register processor domain to its
> memory") introduced an uninitialized "struct memory_target" that could
> cause an incorrect branching.
> 
> drivers/acpi/hmat/hmat.c:385:6: warning: variable 'target' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>         if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/hmat/hmat.c:392:6: note: uninitialized use occurs here
>         if (target && p->flags & ACPI_HMAT_PROCESSOR_PD_VALID) {
>             ^~~~~~
> drivers/acpi/hmat/hmat.c:385:2: note: remove the 'if' if its condition
> is always true
>         if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/hmat/hmat.c:369:30: note: initialize the variable 'target'
> to silence this warning
>         struct memory_target *target;
>                                     ^
>                                      = NULL
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/acpi/hmat/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index c9b8abcf012c..6653dba3b377 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>  					      const unsigned long end)
>  {
>  	struct acpi_hmat_proximity_domain *p = (void *)header;
> -	struct memory_target *target;
> +	struct memory_target *target = NULL;
>  
>  	if (p->header.length != sizeof(*p)) {
>  		pr_notice("HMAT: Unexpected address range header length: %d\n",
> -- 
> 2.17.2 (Apple Git-113)
> 
