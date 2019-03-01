Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66554C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBE920857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rUF1eq+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389376AbfCASaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:30:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37979 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388934AbfCASaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:30:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id g37so9060889plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 10:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9uyvylYFSkA0QW0XxHbiwXU0SqdDY56aMSbjTkF8uKk=;
        b=rUF1eq+vf6Go/I4HNZxkae1KrzgzcmMoU6TWLeVKgh71HGKHJmgZr8WXTJ2+J+mnXX
         S4Xn6L9KRrZwyFnoWcCTZ4AGNe/eX6RN9w2Na/O9YX2SMrAm5G2DZJN0/+Cw+pJZbhEC
         CYExFa0RNJtIxp1mOJMWLu4JHwOutmIXchpoHa/HrWdeyV6o7JFnDmk2g3MWZeNHy8NI
         JbM8SoeSVzcqrn3ipKt47Qqvwv7ilui/TI3MBMT4cP7l/KyCqNhLcDEYfNCqpQvcucoF
         UXWecM1On6CBBQwxpkZUWPzNmz7CaUWqmZLRVGXuPcRYeD4YCDdi73gpH5251Zjpt2ox
         2YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9uyvylYFSkA0QW0XxHbiwXU0SqdDY56aMSbjTkF8uKk=;
        b=fPx4NAdh59mcB0FrtsfdYJxPKS2yEtlK85kcRxjMz9UuYB+iD10KqmNZB9oVhK3vLv
         d53aZf0gWJbjJZ1QG1K/pTy2WO0lYbXoJQ7racgspu6FTp5lju7O40SYSMlI6aibZ3G3
         olX7MspUO1gNYF9KddFwved+PNYEE+ogoOj54NvD8+xjrfFQEUbpThJx1FiClYVsQre/
         VK5O7VygPsrLOsOiWkNkhv1JrFUSBMvIzzwLcAspBYACDUFgBlhlB+CScyzOCUxZHjXI
         LT/gmfh01dGO25FECAXOvamGCBCOL9woS5yDDOvHEEsFZmkugW9nOt7hwkGgJVxUR6aT
         mpSA==
X-Gm-Message-State: APjAAAV/rMd7xzLbYTHBGNtYVODkIFOFHDlLbGSUJfMnzyzA83oU+Wwr
        D7is0qUtJTvoAJgovrlJWBSD2Q==
X-Google-Smtp-Source: APXvYqzZ00rUYXAb+Fz/hsLulVhYQDWQqjpUMQWBq/t8utUjkAr+amDTsXeNyV/bO+vYYoVlWheu8A==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr6812521plp.118.1551465018990;
        Fri, 01 Mar 2019 10:30:18 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id s6sm28455672pfe.37.2019.03.01.10.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 10:30:17 -0800 (PST)
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
To:     Eial Czerwacki <eial@scalemp.com>, dennis@kernel.org,
        tj@kernel.org, cl@linux.com
Cc:     linux-kernel@vger.kernel.org, Shai Fultheim <shai@scalemp.com>,
        Oren Twaig <oren@scalemp.com>
References: <1548071251-1849-1-git-send-email-eial@scalemp.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
Date:   Fri, 1 Mar 2019 13:30:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1548071251-1849-1-git-send-email-eial@scalemp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On 01/21/2019 06:47 AM, Eial Czerwacki wrote:
 >

Your main issue was that you only sent this patch to LKML, but not the 
maintainers of the file.  If you don't, your patch might get lost.  To 
get the appropriate people and lists, run:

	scripts/get_maintainer.pl YOUR_PATCH.patch.

For this patch, you'll get this:

Dennis Zhou <dennis@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
Tejun Heo <tj@kernel.org> (maintainer:PER-CPU MEMORY ALLOCATOR)
Christoph Lameter <cl@linux.com> (maintainer:PER-CPU MEMORY ALLOCATOR)
linux-kernel@vger.kernel.org (open list)

I added the three maintainers to this email.

I have a few minor comments below.

 > [PATCH] percpu/module resevation: change resevation size iff X86_VSMP 
is set

You misspelled 'reservation'.  Also, I'd just say: "percpu: increase 
module reservation size if X86_VSMP is set".  ('change' -> 'increase'), 
only says 'reservation' once.)

> as reported in bug #201339 (https://bugzilla.kernel.org/show_bug.cgi?id=201339)

I think you can add a tag for this right above your Signed-off-by tags. 
e.g.:

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201339

> by enabling X86_VSMP, INTERNODE_CACHE_BYTES's definition differs from the default one
> causing the struct size to exceed the size ok 8KB.
                                             ^of

Which struct are you talking about?  I have one in mind, but others 
might not know from reading the commit message.

I ran into this on https://bugzilla.kernel.org/show_bug.cgi?id=202511. 
In that case, it was because modules (drm and amdkfd) were using 
DEFINE_SRCU, which does a DEFINE_PER_CPU on struct srcu_data, and that 
used ____cacheline_internodealigned_in_smp.

> 
> in order to avoid such issue, increse PERCPU_MODULE_RESERVE to 64KB if CONFIG_X86_VSMP is set.
                                ^increase

> 
> the value was caculated on linux 4.20.3, make allmodconfig all and the following oneliner:
                ^calculated

> for f in `find -name *.ko`; do echo $f; readelf -S $f  |grep perc; done |grep data..percpu -B 1 |grep ko |while read r; do echo -n "$r: "; objdump --syms --section=.data..percpu $r|grep data |sort -n  |awk '{c++; d=strtonum("0x" $1) + strtonum("0x" $5); if (m < d) m = d;} END {printf("%d vars-> last addr 0x%x ( %d )\n", c, m, m)}' ; done |column -t |sort -k 8 -n | awk '{print $8}'| paste -sd+ | bc

Not sure how useful the one-liner is, versus a description of what 
you're doing.  i.e. "the size of all module percpu data sections, or 
something."

Also, how close was that calculated value to 64K?  If more modules start 
using DEFINE_SRCU, each of which uses 8K, then that 64K might run out.

Thanks,
Barret

> Signed-off-by: Eial Czerwacki <eial@scalemp.com>
> Signed-off-by: Shai Fultheim <shai@scalemp.com>
> Signed-off-by: Oren Twaig <oren@scalemp.com>
> ---
>   include/linux/percpu.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index 70b7123..6b79693 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -14,7 +14,11 @@
>   
>   /* enough to cover all DEFINE_PER_CPUs in modules */
>   #ifdef CONFIG_MODULES
> +#ifdef X86_VSMP
> +#define PERCPU_MODULE_RESERVE		(1 << 16)
> +#else
>   #define PERCPU_MODULE_RESERVE		(8 << 10)
> +#endif
>   #else
>   #define PERCPU_MODULE_RESERVE		0
>   #endif
> 

