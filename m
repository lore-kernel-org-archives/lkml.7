Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBD2ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E1F20663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IRP9Gp/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390260AbfJPAfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 20:35:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37163 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfJPAfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 20:35:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so13556614pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 17:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rf4qoYyym4OwL8++6P6U9mCaO/3P2myy/Ny/GVBd60Q=;
        b=IRP9Gp/cJhpFJaURX7/ZJIIpkjlkzVHyKeR3E6m4jvjUm9XRNardXfNdATdaX4UJf9
         5vhyJYmrai6Gy+w9n12CYH1PbhelsdACD9X+14BQhtRJ20IxkwAKlsjZrn5hYV2J+DNy
         zs9JK3H+/n4EgWykXOS1pB1s2AOMDv6Mq7YoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rf4qoYyym4OwL8++6P6U9mCaO/3P2myy/Ny/GVBd60Q=;
        b=XhSUSLggo1nZIVcPv4s/iykounAn2dHW16362BqWxeJ+x91qMqMMFcfNBaI0pBoYDB
         ZdYPfWMKVNZ7YQmSeeSuWAH5UfU5XUAHq6UK6M0LP7yzniFe9Deyb8G9WfH7zgITmK4+
         HzS7xF+ZEn0xT7O86GONb96bGouJWWnFciDHRvU317d9A6fxzfBI6sfIMjWySiFm/eaG
         M5fUxk7HcOGLhwQV5bf1Tj3RCFu2dROh48nfDu7RB4EJDnd/e8N/bFfsIwDqS3INsES4
         nfrHPWjUaFHjl8ci5aYLL7uDOGEYj+xbqaEjZ6vDwMiY1mHb+7XCT2h49/Uw5nwQ/aOt
         w8Jw==
X-Gm-Message-State: APjAAAUrh+I+m+4VGj91QRQe1jvDDsOvSQOCWKMey5cLVli928IVQJUK
        RjohL6SSaRiAQXK/bnIOA508ew==
X-Google-Smtp-Source: APXvYqyPPkyjiknKmvJtBVlA6uQdX3TqmCgOcloVhb3YghiCNtEgFx94uDlnXbKNkyFOOguf0p6now==
X-Received: by 2002:a63:1e5f:: with SMTP id p31mr22515386pgm.291.1571186101558;
        Tue, 15 Oct 2019 17:35:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j10sm21326993pfn.128.2019.10.15.17.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 17:35:01 -0700 (PDT)
Date:   Tue, 15 Oct 2019 20:35:00 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, James Morris <jmorris@namei.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v2] perf_event: Add support for LSM and SELinux checks
Message-ID: <20191016003500.GC89937@google.com>
References: <20191014170308.70668-1-joel@joelfernandes.org>
 <c5bd06a4-54a4-b56e-457c-df36f05d2e3f@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5bd06a4-54a4-b56e-457c-df36f05d2e3f@tycho.nsa.gov>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index bb7b271397a6..2af95f937a5b 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -427,6 +427,15 @@ struct perf_event_attr {
> >   	__u16	__reserved_2;	/* align to __u64 */
> >   };
> > +
> > +/* Access to perf_event_open(2) syscall. */
> > +#define PERF_SECURITY_OPEN		0
> > +
> > +/* Finer grained perf_event_open(2) access control. */
> > +#define PERF_SECURITY_CPU		1
> > +#define PERF_SECURITY_KERNEL		2
> > +#define PERF_SECURITY_TRACEPOINT	3
> > +
> 
> Why are these definitions part of the uapi header and not private to the
> kernel?

No reason but I agree it is better to put them in the private header.

Peter, if you are Ok with it, could you squash the below diff into my
original patch? But let me know if you want me to resend the whole patch
again. Thanks.

---8<-----------------------

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 664bb7f99c46..587ae4d002f5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1245,6 +1245,14 @@ extern int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
 int perf_event_max_stack_handler(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp, loff_t *ppos);
 
+/* Access to perf_event_open(2) syscall. */
+#define PERF_SECURITY_OPEN		0
+
+/* Finer grained perf_event_open(2) access control. */
+#define PERF_SECURITY_CPU		1
+#define PERF_SECURITY_KERNEL		2
+#define PERF_SECURITY_TRACEPOINT	3
+
 static inline int perf_is_paranoid(void)
 {
 	return sysctl_perf_event_paranoid > -1;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 2af95f937a5b..bb7b271397a6 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -427,15 +427,6 @@ struct perf_event_attr {
 	__u16	__reserved_2;	/* align to __u64 */
 };
 
-
-/* Access to perf_event_open(2) syscall. */
-#define PERF_SECURITY_OPEN		0
-
-/* Finer grained perf_event_open(2) access control. */
-#define PERF_SECURITY_CPU		1
-#define PERF_SECURITY_KERNEL		2
-#define PERF_SECURITY_TRACEPOINT	3
-
 /*
  * Structure used by below PERF_EVENT_IOC_QUERY_BPF command
  * to query bpf programs attached to the same perf tracepoint
-- 
2.23.0.700.g56cf767bdb-goog

