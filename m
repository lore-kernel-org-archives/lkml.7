Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEA8C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68972133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="S9Mqfl0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDIVbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:31:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46345 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfDIVbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:31:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so102527edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 14:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=olnzic9RVYGEeZJ7EJ5bldyRWdWNArtxoU9psEfyajE=;
        b=S9Mqfl0VRp7JcuoHd8gfFyiIUbkVrj853XW2kdXoGILErHUWNCke43CMZ2uWTSAoqa
         R34+P7SJ7Ty1xI22N+eDGz6N71tr209jbkAUDd57RLA5gy+CT+KF1Z20JvaJgdLgxED5
         Rz+8AR1sy9A/U9f+nwRjYaZdKiISbANn1VP5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=olnzic9RVYGEeZJ7EJ5bldyRWdWNArtxoU9psEfyajE=;
        b=L368Xi5uSdH4ULpH+qFwPbnR1Ytnh7Kh3mqWTzY8dUmAIkews2k3uo/A9bGR//iR88
         PC6ay2lAxDHMs1nDZCVjNEHRd5nlve15N0pLEJSjN/WcXc8HUkvedoZCj5ZBd2wmK8sH
         5D3NjnXvU98BrmC3gUioS+v+2iGxB3C0BIK2HF/zAx+sYGz/CRuwnjpEzAVPKZZ6Gsmt
         FyH55TVcTKHaUNDxGbPfL0t3depZ/8u576e6Ck2JoOQ3h4sG+sBO3BM0rWNPOL2OM+L0
         QFSIimSr3A+Ku3kjJuQGfcADp1ziqf+JfRtvFtK4uwlby7hcojxgNf6uQEGzvo5i8ead
         nQFw==
X-Gm-Message-State: APjAAAX/P2wPSHpQa3uS7LGuMec3yT/qGNjHV/navhsvZwCG1KkMSKyl
        OVfHyH4sgra8NXlwlX0c6wqV0yEZGAylTjEe
X-Google-Smtp-Source: APXvYqzVxoibykwumIElTbrjjzGQpTbSnvxOIaxDA90rkfhHiNHvYLIFjy4i/okktVw3A4Lgnh6fLw==
X-Received: by 2002:a50:e00b:: with SMTP id e11mr24026846edl.93.1554845511293;
        Tue, 09 Apr 2019 14:31:51 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id p35sm10241626edc.78.2019.04.09.14.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 14:31:50 -0700 (PDT)
Subject: Re: [PATCH] cpumask: fix double string traverse in cpumask_parse
To:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        "David S. Miller" <davem@davemloft.net>, Tejun Heo <tj@kernel.org>,
        Willem de Bruijn <willemb@google.com>
Cc:     Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org
References: <20190409204208.12190-1-ynorov@marvell.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <b3ce41ca-6a20-a53d-7db2-451e3e700040@rasmusvillemoes.dk>
Date:   Tue, 9 Apr 2019 23:31:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409204208.12190-1-ynorov@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2019 22.42, Yury Norov wrote:
> From: Yury Norov <ynorov@marvell.com>
> 
> cpumask_parse() finds first occurrence of either \n or \0 by calling
> strchr() and strlen(). We can do it better with a single call of
> strchrnul().
> 
> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  include/linux/cpumask.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 147bdec42215..2b87f35c586c 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -633,8 +633,7 @@ static inline int cpumask_parselist_user(const char __user *buf, int len,
>   */
>  static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
>  {
> -	char *nl = strchr(buf, '\n');
> -	unsigned int len = nl ? (unsigned int)(nl - buf) : strlen(buf);
> +	unsigned int len = (unsigned int)(strchrnul(buf, '\n') - buf);

ack, but please drop the cast. "len = strchrnul(buf, '\n') - buf;"

Rasmus


