Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D4AC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0D1265F2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfEaIoo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:44:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36552 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfEaIoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:44:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so2873745wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 01:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=6M6dXVXKFghnFsr3QMCnxQXaLInVC+XDKbFfMFVfErM=;
        b=YvoIAImPBz0rQRMAM5LcQdoRFP+1rkFksOvebiH1IMX6SOJARWBT5J5aCVKj/sGqBn
         o0yViOkmfKa4zJVkXxphAtkycN7wbIodIF1IeDCFd5MX/FzXYirqspc11ZKS0w8JpUSL
         IB9MHYx6zAdNeTH9ZqHjGTpCCSMjzJgdnarTINGBO79vZbIUYkfyO57BuQPxa/wuoPv4
         27FNRQNDCvbxf5Q39wrGmbIVMBckHWt9gSDgYZFUg6t1T01sYQtUcFqTCCUZLxE8jBv+
         DVEmqWFkYLvX8JdJrW6ZWfqesFDlPB+arp82garAqAdlEpO2iIc3HMzZXFezD8Ujg8H7
         +9Kg==
X-Gm-Message-State: APjAAAVRwokME4VLCoavfe97ViPqYNt2Oeue/Zr6xYeknIJynIemtngm
        aJsTwcm0mKp8ArxJMESvl4Ko4A==
X-Google-Smtp-Source: APXvYqyBDlZc0ihTdyXXtXUzobJit8CcEnV5IuLzcBn/aPtJl6Wu0TXjzTbNGwDi0Lqxqg/0bCezIg==
X-Received: by 2002:adf:f483:: with SMTP id l3mr159106wro.256.1559292282362;
        Fri, 31 May 2019 01:44:42 -0700 (PDT)
Received: from [10.82.105.87] (mob-5-90-59-71.net.vodafone.it. [5.90.59.71])
        by smtp.gmail.com with ESMTPSA id f197sm5459428wme.39.2019.05.31.01.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 01:44:41 -0700 (PDT)
Date:   Fri, 31 May 2019 10:44:38 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <e41c7ff9ae38363fe8c32346fea0f7efe551d162.camel@perches.com>
References: <20190531011227.21181-1-mcroce@redhat.com> <e41c7ff9ae38363fe8c32346fea0f7efe551d162.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2] checkpatch.pl: Warn on duplicate sysctl local variable
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>
CC:     Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Matteo Croce <mcroce@redhat.com>
Message-ID: <B6174D2A-C9E8-438D-A042-C39CAAA35728@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 31, 2019 5:06:58 AM GMT+02:00, Joe Perches <joe@perches.com> wrote:
> On Fri, 2019-05-31 at 03:12 +0200, Matteo Croce wrote:
> > Commit 6a33853c5773 ("proc/sysctl: add shared variables for range
> check")
> > adds some shared const variables to be used instead of a local copy
> in
> > each source file.
> > Warn when a chunk duplicates one of these values in a ctl_table
> struct:
> > 
> >     $ scripts/checkpatch.pl 0001-test-commit.patch
> >     WARNING: duplicated sysctl range checking value 'zero', consider
> using the shared one in include/linux/sysctl.h
> >     #27: FILE: arch/arm/kernel/isa.c:48:
> >     +               .extra1         = &zero,
> > 
> >     WARNING: duplicated sysctl range checking value 'int_max',
> consider using the shared one in include/linux/sysctl.h
> >     #28: FILE: arch/arm/kernel/isa.c:49:
> >     +               .extra2         = &int_max,
> > 
> >     total: 0 errors, 2 warnings, 14 lines checked
> > 
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > ---
> >  scripts/checkpatch.pl | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 342c7c781ba5..629c31435487 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -6639,6 +6639,12 @@ sub process {
> >  				     "unknown module license " . $extracted_string . "\n" .
> $herecurr);
> >  			}
> >  		}
> > +
> > +# check for sysctl duplicate constants
> > +		if ($line =~ /\.extra[12]\s*=\s*&(zero|one|int_max|max_int)\b/) {
> 
> why max_int, there isn't a single use of it in the kernel ?

Because you can never know how a local variabile will be called.
I wanted to add intmax and maxint too, bit it seemed too much.

Bye,
-- 
Matteo Croce
per aspera ad upstream
