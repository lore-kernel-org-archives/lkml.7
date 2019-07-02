Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A7EC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BF921479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETbJAtbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfGBNqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:46:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35500 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfGBNqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:46:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so18482317qto.2;
        Tue, 02 Jul 2019 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=A5dZq2nQ324KEj+MevmqkAz8NKDu5TbeDuq4xGo1kzQ=;
        b=ETbJAtbxQfuTWHUHiZAW8r49xrIwSouErNyrxn+V6c8abTJiG6tdgpIxySIG0vw2/S
         orI1rKvRA8znkISvr+M90Ezwmbe/g/TXUKXpaCt8DXPai7xJzTMPnkSH4DXXoK9TSb5z
         fbhOi7CGXaavTNL3M7yElwbhIm84aiZ+43AWBZ5FM1jqhP6KhhvpNz17pNxibBF23E5D
         HXiliAm81IYg28pLOXTX6XEG/Rh+nt2hnNlGh6oxrwb4sfCmP2tluTRIrXsMquHF432j
         eqDaJUxj0b3UoBXbO/sAReUCva8hqqbVMMgaQqwDx0ETvVZEZy14hmIRqpA27JbCqx6F
         44oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A5dZq2nQ324KEj+MevmqkAz8NKDu5TbeDuq4xGo1kzQ=;
        b=qRTe1GpK+F4dRhCS2zO/GKI/9w9RuRJpyV5mK6w9WxpNPKMx0kZNWebleGvNS7Vsge
         rZA0izPgpWCJMkp9QbK5wWUG6fnRJEJVai7q+mxDDglPhtm+uvr0mQKhZHNAaXey4L++
         OqTIvkJtn44178tDPz41lBQFfHGxR49MKwnCFDYpuRcZ0b0ifzlwpXvzHVdua8JONy7Z
         d2jYv5bJrTSjnX15sHy7vdFRIjPQh6VAuCIdTtAJ7OAfGy2qMK5sYYcgJ0ekQMthK0DO
         fgsQmcUNoakpvGIXAhbZG5uuHYrybdECBMsCFMoQfU4ewB43evRXl4Q71shpTEdXs437
         sOGA==
X-Gm-Message-State: APjAAAVq7HruaMxbMn67Xd2AcM5v2BT+ywhy0EyOBinSPd0FGUciMtmb
        eA5gCEXObNjStutyP9JamEU=
X-Google-Smtp-Source: APXvYqzl8f47zaSGAVkoM+LmyB4UZETobt2thkWQOgwpuV5TE3sJECsdUB1olmuGCb0MZFDwzNRmJA==
X-Received: by 2002:a0c:8722:: with SMTP id 31mr26644808qvh.164.1562075167657;
        Tue, 02 Jul 2019 06:46:07 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id e52sm6697360qtk.20.2019.07.02.06.46.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 06:46:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D23F241153; Tue,  2 Jul 2019 10:46:03 -0300 (-03)
Date:   Tue, 2 Jul 2019 10:46:03 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
Subject: Re: [PATCH 23/43] tools lib: Adopt skip_spaces() from the kernel
 sources
Message-ID: <20190702134603.GA15462@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
 <20190702022616.1259-24-acme@kernel.org>
 <20190702121240.GB12694@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190702121240.GB12694@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 02, 2019 at 02:12:40PM +0200, Jiri Olsa escreveu:
> On Mon, Jul 01, 2019 at 11:25:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Same implementation, will be used to replace ad-hoc equivalent code in
> > tools/.
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: André Goddard Rosa <andre.goddard@gmail.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lkml.kernel.org/n/tip-dig691cg9ripvoiprpidthw7@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/include/linux/string.h |  4 +++-
> >  tools/lib/string.c           | 14 ++++++++++++++
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
> > index 6c3e2cc274c5..cee239350a6b 100644
> > --- a/tools/include/linux/string.h
> > +++ b/tools/include/linux/string.h
> > @@ -29,4 +29,6 @@ static inline bool strstarts(const char *str, const char *prefix)
> >  	return strncmp(str, prefix, strlen(prefix)) == 0;
> >  }
> >  
> > -#endif /* _LINUX_STRING_H_ */
> > +extern char * __must_check skip_spaces(const char *);
> > +
> > +#endif /* _TOOLS_LINUX_STRING_H_ */
> > diff --git a/tools/lib/string.c b/tools/lib/string.c
> > index 93b3d4b6feac..50d400822bb3 100644
> > --- a/tools/lib/string.c
> > +++ b/tools/lib/string.c
> > @@ -17,6 +17,7 @@
> >  #include <string.h>
> >  #include <errno.h>
> >  #include <linux/string.h>
> > +#include <linux/ctype.h>
> >  #include <linux/compiler.h>
> >  
> >  /**
> > @@ -106,3 +107,16 @@ size_t __weak strlcpy(char *dest, const char *src, size_t size)
> >  	}
> >  	return ret;
> >  }
> > +
> > +/**
> > + * skip_spaces - Removes leading whitespace from @str.
> > + * @str: The string to be stripped.
> > + *
> > + * Returns a pointer to the first non-whitespace character in @str.
> > + */
> > +char *skip_spaces(const char *str)
> > +{
> > +	while (isspace(*str))
> > +		++str;
> > +	return (char *)str;
> > +}
> > -- 
> > 2.20.1
> > 
> 
> this breaks objtool build, because it adds _ctype dependency via isspace call
> patch below fixes it for me

Thanks for  spotting this, I'll have it in my next pull request.

- Arnaldo
 
> jirka
> 
> 
> ---
> diff --git a/tools/objtool/Build b/tools/objtool/Build
> index 749becdf5b90..8dc4f0848362 100644
> --- a/tools/objtool/Build
> +++ b/tools/objtool/Build
> @@ -9,6 +9,7 @@ objtool-y += special.o
>  objtool-y += objtool.o
>  
>  objtool-y += libstring.o
> +objtool-y += libctype.o
>  objtool-y += str_error_r.o
>  
>  CFLAGS += -I$(srctree)/tools/lib
> @@ -17,6 +18,10 @@ $(OUTPUT)libstring.o: ../lib/string.c FORCE
>  	$(call rule_mkdir)
>  	$(call if_changed_dep,cc_o_c)
>  
> +$(OUTPUT)libctype.o: ../lib/ctype.c FORCE
> +	$(call rule_mkdir)
> +	$(call if_changed_dep,cc_o_c)
> +
>  $(OUTPUT)str_error_r.o: ../lib/str_error_r.c FORCE
>  	$(call rule_mkdir)
>  	$(call if_changed_dep,cc_o_c)

-- 

- Arnaldo
