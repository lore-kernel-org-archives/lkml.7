Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08E2C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800CD2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUisLtI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfH0Sqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:46:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45657 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbfH0Sqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:46:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id w26so14642798pfq.12;
        Tue, 27 Aug 2019 11:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y/FpJfIQDFFYFWCv8d3VQXA3ejRf4dcDUC9VQhShWIk=;
        b=PUisLtI1N8WCRaQO16uILlJJfdxkC1gSxGhTwLgCpeRbDvg+pIPeq3HngTxt+0WdCm
         ZnUuS9myTf58efM2uqSEvZ3OT0yH61LQLgnLEydkvgGi6OSmR73pJZOSpEKmH0SEbUew
         E/ap2SW/XY6EgjMGBG1aJMEB0INkVpLQGRJFNfnYiutaB+J1V2MNjYblS/dgxAzZxoQ6
         jrWQ4ZcMJFcGLpQGpxk2eLb/6hMa/Bqg91YUKuxYs3TLXH7+3Twix0OcSToEsqC1O6iC
         Igv81Ho8J/fwUTQ7zIhQGZFAPIX9BVIO0blL5FNczXwPS5W/OSy0er9XnjSGlwWQXkGh
         kFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y/FpJfIQDFFYFWCv8d3VQXA3ejRf4dcDUC9VQhShWIk=;
        b=VCcR0iz5Vy67yJXMUEo/4OgEGU8H58C5I1ODayYI1Tzx+wMpUBZVjq9QumoGbFxBIY
         nNQLSLdp3IycuoMZ3fXXQEz/2l5lebRfLpwxkyJfKScPgyTTjHsIRlNbR1Ds/9Exh/w3
         vA5xqivuKSJnV0RAb0E1LKOae3+PtzrkqBqBQwTzgOHUMSo0wU/87MZN7Il3w03ranCf
         G9aPbnRCxFDLRryVuKbIBh7JHXPmhtFUUpO+VqyCSerGl5yBvrKgWxrfamPyd5rN3BjR
         43dB4iNo1VFO6ZvFEI822lVx2oBJk7IUesD1h4P3uhCzmmfweRGc+1IpUen4XI/bMIQx
         2Sgw==
X-Gm-Message-State: APjAAAVoPZyqseryrxJ3/tKgN3RqVSbfp3uom1jhQYtVOGRP1AUgZKvp
        OGQnjvgXGAnHuNCtx8v6D54=
X-Google-Smtp-Source: APXvYqz09YuVdeR/3PMOpPSn74q3fvy5vLGD3UkUsFXl/F/WadfQsTqxhHLZ5pJgNxtIwAbJBwn9oQ==
X-Received: by 2002:a65:49cc:: with SMTP id t12mr21051640pgs.83.1566931593494;
        Tue, 27 Aug 2019 11:46:33 -0700 (PDT)
Received: from [192.168.1.70] (c-73-231-235-122.hsd1.ca.comcast.net. [73.231.235.122])
        by smtp.gmail.com with ESMTPSA id b13sm110101pjz.10.2019.08.27.11.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 11:46:33 -0700 (PDT)
Subject: Re: [PATCH] scripts/dtc: Simplify condition in get_node_by_path
To:     Denis Efremov <efremov@linux.com>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190827145727.16791-1-efremov@linux.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <1b896532-006b-b729-35cc-03f5c58748ef@gmail.com>
Date:   Tue, 27 Aug 2019 11:46:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827145727.16791-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

On 8/27/19 7:57 AM, Denis Efremov wrote:
> The strlen && strprefixeq check in get_node_by_path is
> excessive, since strlen is checked in strprefixeq macro
> internally. Thus, 'strlen(child->name) == p-path'
> conjunct duplicates after macro expansion and could
> be removed.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/dtc/livetree.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/scripts/dtc/livetree.c b/scripts/dtc/livetree.c
> index 0c039993953a..032df5878ccc 100644
> --- a/scripts/dtc/livetree.c
> +++ b/scripts/dtc/livetree.c
> @@ -526,8 +526,7 @@ struct node *get_node_by_path(struct node *tree, const char *path)
>  	p = strchr(path, '/');
>  
>  	for_each_child(tree, child) {
> -		if (p && (strlen(child->name) == p-path) &&
> -		    strprefixeq(path, p - path, child->name))
> +		if (p && strprefixeq(path, p - path, child->name))
>  			return get_node_by_path(child, p+1);
>  		else if (!p && streq(path, child->name))
>  			return child;
> 

livetree.c is maintained in the upstream dtc project.  We pull changes
from that project into the Linux kernel source tree.

Info on submitting patches is in the upstream file "Documentation/manual.txt":

   1) Sources

   Source code for the Device Tree Compiler can be found at git.kernel.org.

   The upstream repository is here:

       git://git.kernel.org/pub/scm/utils/dtc/dtc.git
       https://git.kernel.org/pub/scm/utils/dtc/dtc.git

   The gitweb interface for the upstream respository is:

       https://git.kernel.org/cgit/utils/dtc/dtc.git/

   1.1) Submitting Patches

   Patches should be sent to the maintainers:
           David Gibson <david@gibson.dropbear.id.au>
           Jon Loeliger <jdl@jdl.com>
   and CCed to <devicetree-compiler@vger.kernel.org>.
