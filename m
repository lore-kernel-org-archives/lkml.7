Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF4AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA042147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKfE4j31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfCLUS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:18:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39243 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfCLUS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:18:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id t124so3950751wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 13:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z6BubL2wRi82MlGh8uAIe15NDZT0o86JFANj0qZsAEU=;
        b=QKfE4j318o3heznw2sOZvrR+qlNzpG8i6yaG0NHvv3W25+PqlyY2nk1dEkuCT1Z9op
         4dApPTu9EFE3LHPW8SByq0rZNyvQC88ikg+6P9T853zseLMlTDgRarrkTdye+pHnFllL
         jrVk5ialYjgixOplhoTJeshydW/PezfPParoEipuX0ecYwXEQ42KsHsLehJxacsT7rQL
         4Uee3osj1ypeTJjC5v0Gi+tUsg7y1BCkNr8bOtQ1LVnI05JuMasJlkoqUqFrN0ez1++R
         F2BxMYhNFlVucNWvZq5oJv40E9CmI5+ECdONyPkJIY32s5Z+T+lMEfMBTXLOGaopmC9N
         2uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z6BubL2wRi82MlGh8uAIe15NDZT0o86JFANj0qZsAEU=;
        b=fSXjYfV5cnhjjTku2wsHCNnxAnNO0cQMGfgPKhmLNwUzFrpSoMkl9P+670nt8HlIgJ
         KpslAfjTX1LZrp6/cg65sdGXHW38Uxyvqj3Yd1/GvO+s2G0L31p4LuimT1qseKHlQZtg
         GMMWAi4wRZsO8mWrQQi68+U3Ae2RfjyaQHthV0aBCtISHpe+L20aMQWvxXHVbkutXM1o
         6jKGO1LI/q3gWmSNFmqjPXB0R0zwpXx6J37YkjVEz+l2VGRm/kpLbgnj+9hN2VG85Qay
         yKYPt0e9lhkUzU+aoIvc+Yqmsj/ojGzKENM/kajCZ3iBTKMukVliDzOdhFr8kR97RMKA
         piYg==
X-Gm-Message-State: APjAAAV4aHDlWyH27BiIS1J+1F4WRbvwKRJJU3eppRthJGeJsanQPSZj
        PgVaLaft3/f/poZf7o5VRpXXmqs=
X-Google-Smtp-Source: APXvYqwC0UOxVVvp9pZqpDoZPNM0jgdJ+wS1FWjxMf013vWEPItwscsyVyW/z4fGBK4kJ7FOTrLIVQ==
X-Received: by 2002:a1c:2d4:: with SMTP id 203mr3614479wmc.20.1552421936273;
        Tue, 12 Mar 2019 13:18:56 -0700 (PDT)
Received: from avx2 ([46.53.244.57])
        by smtp.gmail.com with ESMTPSA id p16sm21585629wro.25.2019.03.12.13.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 13:18:55 -0700 (PDT)
Date:   Tue, 12 Mar 2019 23:18:53 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop -Wdeclaration-after-statement
Message-ID: <20190312201853.GA9013@avx2>
References: <20190310133535.GA20473@avx2>
 <20190311173845.53c2e4e4d2257a3701fa2033@linux-foundation.org>
 <20190312172447.GA10166@avx2>
 <20190312125017.b1f5af3350434ca05b5fe35e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190312125017.b1f5af3350434ca05b5fe35e@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 12:50:17PM -0700, Andrew Morton wrote:
> On Tue, 12 Mar 2019 20:24:47 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > On Mon, Mar 11, 2019 at 05:38:45PM -0700, Andrew Morton wrote:
> > > On Sun, 10 Mar 2019 16:35:35 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > > 
> > > > Newly added static_assert() is formally a declaration, which will give
> > > > a warning if used in the middle of the function.
> > > > 
> > > > ...
> > > >
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -792,9 +792,6 @@ endif
> > > >  # arch Makefile may override CC so keep this after arch Makefile is included
> > > >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> > > >  
> > > > -# warn about C99 declaration after statement
> > > > -KBUILD_CFLAGS += -Wdeclaration-after-statement
> > > > -
> > > >  # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
> > > >  KBUILD_CFLAGS += $(call cc-option,-Wvla)
> > > 
> > > I do wish your changelogs were more elaborate :(
> > 
> > > So the proposal is to disable -Wdeclaration-after-statement in all
> > > cases for all time because static_assert() doesn't work correctly?
> > 
> > Yes. I converted 2 cases in /proc to static_assert() and you can't write
> > 
> > 	{
> > 		[code]
> > 		static_assert()
> > 	}
> > 
> > without a warning because static_assert() is declaration.
> > So people would move BUILD_BUG_ON() to where it doesn't belong.
> 
> Sure.
> 
> > > Surely there's something we can do to squish the static_assert() issue
> > > while retaining -Wdeclaration-after-statement?
> > 
> > It is not good in my opinion to stick to -Wdeclaration-after-statement.
> 
> Why?

It is useful to have declarations mixed with code.
It reduces effective scope of a variable:

	int a;
	[a misused]
		...
	[a used correctly]

vs

	[a misused -- compile error]
		...
	int a;
	[a used correctly]

It is possible to partially workaround that but at the cost of a
indentation level. I'll post the following patch soon:

-       NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
-       NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
-       NEW_AUX_ENT(AT_GID, from_kgid_munged(cred->user_ns, cred->gid));
-       NEW_AUX_ENT(AT_EGID, from_kgid_munged(cred->user_ns, cred->egid));
+       {
+               const struct cred *cred = current_cred();
+               struct user_namespace *user_ns = cred->user_ns;
+
+               NEW_AUX_ENT(AT_UID,  from_kuid_munged(user_ns, cred->uid));
+               NEW_AUX_ENT(AT_EUID, from_kuid_munged(user_ns, cred->euid));
+               NEW_AUX_ENT(AT_GID,  from_kgid_munged(user_ns, cred->gid));
+               NEW_AUX_ENT(AT_EGID, from_kgid_munged(user_ns, cred->egid));
+       }

Often it is simply not possible to shift big function one level
deeper.

Another related thing, C99 has this very cool feature of per-for-loop
declarations:

	for (int i = 0; ...)

Once kernel will switch to C99 or C11 it _will_ be used to the point of
requiring it on the coding style level. The superstition of declaring
everything in the beginning of a function will fall, so might as well
start earlier.
