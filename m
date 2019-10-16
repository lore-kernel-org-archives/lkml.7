Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC787FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A089A207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qh7WLKvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393820AbfJPOJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:09:01 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46347 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393799AbfJPOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:09:00 -0400
Received: by mail-qk1-f195.google.com with SMTP id e66so2288038qkf.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jN7Dveffqa87qcgYwBlcVqa13+mGccK4fLl9wVw4FPc=;
        b=qh7WLKvMAOxf6aSAkLv9y3u3GnZy1KBJyQu9ajT5VYiT9VKe8KjPVW4ZUU6CrPrOCA
         x+QOoWuBn3ELp3AbKuVCyoSXfbWgovYjyPXv2TjvvM4fQy4lloJ4nI5yIIkRnnJ60vO2
         NL6e24sFZJc4oycdYMq5gT22urPN3kd7QfkGNJVfmNTBTy58NbUfhR4YQN7GgebpjZNx
         P0bNv0j8gAt3Xeuciy3RyMIwqbKWe3Fv9axfjpsmKh0eP7/JpfmH+DLlXrwAHcRX/s3r
         DCuLeBF5hm13J1CkDc+hlqiIryGZtxoetqGX7mS0QP7b5sISdj/W+DN5Balhme4u+fNs
         IBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jN7Dveffqa87qcgYwBlcVqa13+mGccK4fLl9wVw4FPc=;
        b=g8y5UnOmRgn4LhHpaBe/7Apxc2IE4cChLpfAmdC5L2Rp49orn0fuxrKGCIe3IgBSH9
         YRLU+91l3896pglysFzi7aW1CGIva8OSTKGcdSESVtitSvNRPE50lMkrtbeKvm9pQJ08
         05AVkMNtD5+m1C3k/E69t3k87pWBjldi/RlH3hmQA3XFTkE5/IOMQpa4Y3D8OmfZkiVb
         Tr/NDvl8dlG6uO4kmXLBLUGgIQRjqtMcEunIX07OS8+n8rlmVz+NqDD4BiF4efi79EOp
         qvp2WUmgLRtMGed7LN1ro/TTZKGLOQavYvnfPVZm9Q30CTAyRcJFpRw5T5eAwZ6ze5GF
         ToxA==
X-Gm-Message-State: APjAAAUNrNZzSAlWxrtfEAV7Ht2ZLuJYMnyGl0RTBtqXkSrf9R7NNu9i
        Y3DUVXKa8ibku7aQYwU1QbY=
X-Google-Smtp-Source: APXvYqwELWVXa9DU6HmIsqQ8vpefu9yJkQfzhO5IZOttbfwd6MNebJCBisRfQ+lfyv7FOGIguCvO+A==
X-Received: by 2002:a05:620a:215b:: with SMTP id m27mr3755302qkm.328.1571234939220;
        Wed, 16 Oct 2019 07:08:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id c12sm10494913qkc.81.2019.10.16.07.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:08:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DBC924DD66; Wed, 16 Oct 2019 11:08:56 -0300 (-03)
Date:   Wed, 16 Oct 2019 11:08:56 -0300
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] perf kmem: Fix memory leak in compact_gfp_flags()
Message-ID: <20191016140856.GG22835@kernel.org>
References: <f9e9f458-96f3-4a97-a1d5-9feec2420e07@huawei.com>
 <20191016130403.GA22835@kernel.org>
 <20191016130921.GC22835@kernel.org>
 <f1dc9f3f-ce4a-9a62-1940-8ea8b7fea750@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1dc9f3f-ce4a-9a62-1940-8ea8b7fea750@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 16, 2019 at 09:19:54PM +0800, Yunfeng Ye escreveu:
> 
> 
> On 2019/10/16 21:09, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Oct 16, 2019 at 10:04:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Wed, Oct 16, 2019 at 04:38:45PM +0800, Yunfeng Ye escreveu:
> >>> The memory @orig_flags is allocated by strdup(), it is freed on the
> >>> normal path, but leak to free on the error path.
> >>
> >> Are you using some tool to find out these problems? Or is it just visual
> >> inspection?
> > 
> By a static code anaylsis tool which not an open source tool. thanks.

Ok, so please state that next time, just for the fullest possible
disclosure and for people to realize to what extent problems in the
kernel and in tooling hosted in the kernel is being fixed by such tools.

I.e. you don't need to release the tool, not even give out its name,
just something like:

"Found by internal static analysis tool."

Thanks,

- Arnaldo
 
> > Anyway, applied after adding this to the commit log message:
> > 
> > Fixes: 0e11115644b3 ("perf kmem: Print gfp flags in human readable string")
> > 
> ok, thanks.
> 
> > - Arnaldo
> >  
> >> - Arnaldo
> >>  
> >>> Fix this by adding free(orig_flags) on the error path.
> >>>
> >>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> >>> ---
> >>>  tools/perf/builtin-kmem.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> >>> index 1e61e353f579..9661671cc26e 100644
> >>> --- a/tools/perf/builtin-kmem.c
> >>> +++ b/tools/perf/builtin-kmem.c
> >>> @@ -691,6 +691,7 @@ static char *compact_gfp_flags(char *gfp_flags)
> >>>  			new = realloc(new_flags, len + strlen(cpt) + 2);
> >>>  			if (new == NULL) {
> >>>  				free(new_flags);
> >>> +				free(orig_flags);
> >>>  				return NULL;
> >>>  			}
> >>>
> >>> -- 
> >>> 2.7.4.3
> >>
> >> -- 
> >>
> >> - Arnaldo
> > 

-- 

- Arnaldo
