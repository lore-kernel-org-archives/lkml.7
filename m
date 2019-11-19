Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB73DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903BC22318
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1ZKM5Eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfKSE7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 23:59:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40627 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfKSE7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 23:59:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id e17so3375788pgd.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 20:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RO+sv9d7iZyyhUGXwHPkKGIMvbZKwho2rispTgVxvMM=;
        b=H1ZKM5EuWeTvOTqP+ZdY7HRM5cF9dS2S83/KwTEO2X77s0X8A12AnFkGr5M5b2KZj2
         TjkxDIsinxYL9JCVw719Re4Bl8mp0dkV16SiRBLzeD934ewF6vcZeGqBq53vrPIY799K
         A0UFr7YWsOlRInWjoy5WSLAEHI24iZRgmC0amNNBmZTRq4lFIA0eL+sFJ4AzSdIJ9y5s
         y9ShwwJAr4/K4STi/kCC2JuEePIvFRLPP/jdOzkX0hW+vtslHP/M40v8wB6j2zx1Gy/t
         hofcO4BPRp1BEpbL3mrF57wKVCzhxhes/zx69oWex+vJoIBxBLVx6Rg306/Tk8joxWYr
         OYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RO+sv9d7iZyyhUGXwHPkKGIMvbZKwho2rispTgVxvMM=;
        b=fCKJWFXiw0o7i7zjjP3c2fztxHF3vMN8ZQ6VCVJVwbbKrEFiPpWChiaIjVNnKamgNK
         2aL2RbZrkJv/n071XFfs5QkZ1VblUtH69o0EkDG0GlD+Bkm66by145L07tkWLOm50M4E
         3rlz+0aPJaOJaURuQXbXqXvl2OIQX00kKzWEJK0ieGiUxzRBdOHdomppem6lTp9+LraP
         SRDaUYq6z9OhrI8uQqpDmemHacw6Oa163UPl0GRAcMqD2K9MQPlNcIyfUH+zeoEh10hc
         yUfqkPTjJhvJrm6Ed1gPPkGjB3ItrUVNcYabUdW4RwbEfavDP2yBeQO45KQZ5o1R3sdZ
         z0kA==
X-Gm-Message-State: APjAAAWahpsI9HHr1H+5HsKQEArgJP5klxqJNq3RpNL+KQJ++Kfhnnmt
        s6NekHDChMAKxnmcGeKllIIdlDf84nOpSSxWvkr/CPL/
X-Google-Smtp-Source: APXvYqyUVdA1ujm4LxjZVY6pqlYuvAOboZQe83wQh0PVsE/aYeOgD25SfDa2Bc1sslufp8emVmICT39qQEV2F3SOf98=
X-Received: by 2002:aa7:85d7:: with SMTP id z23mr3525958pfn.24.1574139586159;
 Mon, 18 Nov 2019 20:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20190904211456.31204-1-xiyou.wangcong@gmail.com> <20191112113102.0ffc883c@gandalf.local.home>
In-Reply-To: <20191112113102.0ffc883c@gandalf.local.home>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 18 Nov 2019 20:59:34 -0800
Message-ID: <CAM_iQpUJ5b89HZ6EcYx3n4xSy-uqrvVu4n7G=8ddEd102fHpoQ@mail.gmail.com>
Subject: Re: [PATCH v3] tracing: Introduce trace event injection
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 8:31 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> Again, sorry for the late review. Things have just been crazy :-/


I know, the only problem is even I myself almost forget how the
code works, I have to spend some time to warm up. :-(


> > +config TRACE_EVENT_INJECT
> > +     bool "Trace event injection"
> > +     depends on TRACING
> > +     default n
>
> No need for the above "default n", that's the default.

Yeah, I know you want to save one line, let's do it!


> > +static int
> > +parse_field(char *str, struct trace_event_call *call,
> > +         struct ftrace_event_field **pf, u64 *pv)
> > +{
> > +     struct ftrace_event_field *field;
> > +     char *field_name;
> > +     int s, i = 0;
> > +     char *p;
> > +     int len;
> > +     u64 val;
> > +
> > +     if (!str[i])
> > +             return 0;
> > +     /* First find the field to associate to */
> > +     while (isspace(str[i]))
> > +             i++;
> > +     s = i;
> > +     while (isalnum(str[i]) || str[i] == '_')
> > +             i++;
> > +     len = i - s;
> > +     if (!len)
> > +             return -EINVAL;
> > +
> > +     field_name = kmemdup_nul(str + s, len, GFP_KERNEL);
> > +     if (!field_name)
> > +             return -ENOMEM;
> > +     field = trace_find_event_field(call, field_name);
> > +     kfree(field_name);
> > +     if (!field)
> > +             return -ENOENT;
> > +
> > +     *pf = field;
> > +     p = strchr(str + i, '=');
>
> Hmm, the above here will parse out:
>
>         "field some garbarge = one"
>
> It will skip the some garbage, and jump straight to 1.


Good catch! Let's write a test case for it and fix it accordingly.

>
> > +     if (!p)
> > +             return -EINVAL;
> > +     i = p + 1 - str;
> > +     while (isspace(str[i]))
> > +             i++;
> > +     s = i;
> > +     if (isdigit(str[i]) || str[i] == '-') {
> > +             char *num, c;
> > +             int ret;
> > +
> > +             /* Make sure the field is not a string */
> > +             if (is_string_field(field))
> > +                     return -EINVAL;
> > +
> > +             if (str[i] == '-')
> > +                     i++;
> > +
> > +             /* We allow 0xDEADBEEF */
> > +             while (isalnum(str[i]))
> > +                     i++;
> > +             num = str + s;
> > +             c = str[i];
>
> Probably should verify that c is whitespace or '\0'.

Hmm, I think we should be more strict on errors. Let's me
write a test case for this too.


>
> > +             str[i] = '\0';
> > +             /* Make sure it is a value */
> > +             if (field->is_signed)
> > +                     ret = kstrtoll(num, 0, &val);
> > +             else
> > +                     ret = kstrtoull(num, 0, &val);
> > +             str[i] = c;
> > +             if (ret)
> > +                     return ret;
> > +
> > +             *pv = val;
> > +             return i;
> > +     } else if (str[i] == '\'' || str[i] == '"') {
> > +             char q = str[i];
> > +
> > +             /* Make sure the field is OK for strings */
> > +             if (!is_string_field(field))
> > +                     return -EINVAL;
> > +
> > +             for (i++; str[i]; i++) {
> > +                     if (str[i] == '\\' && str[i + 1]) {
> > +                             i++;
> > +                             continue;
> > +                     }
> > +                     if (str[i] == q)
> > +                             break;
> > +             }
> > +             if (!str[i])
> > +                     return -EINVAL;
> > +
> > +             /* Skip quotes */
> > +             s++;
> > +             len = i - s;
> > +             if (len >= MAX_FILTER_STR_VAL)
> > +                     return -EINVAL;
> > +
> > +             *pv = (unsigned long)(str + s);
> > +             str[i] = 0;
> > +             /* go past the last quote */
> > +             i++;
> > +             return i;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int trace_get_entry_size(struct trace_event_call *call)
> > +{
> > +     struct ftrace_event_field *field;
> > +     struct list_head *head;
> > +     int size = 0;
> > +
> > +     head = trace_get_fields(call);
> > +     list_for_each_entry(field, head, link) {
> > +             if (field->size + field->offset > size)
> > +                     size = field->size + field->offset;
> > +     }
> > +
> > +     return size;
> > +}
> > +
> > +static void *trace_alloc_entry(struct trace_event_call *call, int *size)
> > +{
> > +     int entry_size = trace_get_entry_size(call);
> > +     struct ftrace_event_field *field;
> > +     struct list_head *head;
> > +     void *entry = NULL;
> > +
> > +     /* We need an extra '\0' at the end. */
> > +     entry = kzalloc(entry_size + 1, GFP_KERNEL);
> > +     if (!entry)
> > +             return NULL;
> > +
> > +     head = trace_get_fields(call);
> > +     list_for_each_entry(field, head, link) {
> > +             if (!is_string_field(field))
> > +                     continue;
> > +             if (field->filter_type == FILTER_STATIC_STRING)
> > +                     continue;
> > +             if (field->filter_type == FILTER_DYN_STRING) {
> > +                     u32 *str_item;
> > +                     int str_len = 0;
> > +                     int str_loc = entry_size & 0xffff;
> > +
> > +                     str_item = (u32 *)(entry + field->offset);
> > +                     *str_item = (str_len << 16) | str_loc;
>
> str_len is always zero here, right? Might as well just make this
>
>  *str_item = str_loc;
>

Hmm, I don't even remember whether I forgot to set str_len to some value
or simply we can just remove it...

Sorry for it, you know this code was written more than 6 months ago...


>
> > +             } else {
> > +                     char **paddr;
> > +
> > +                     paddr = (char **)(entry + field->offset);
> > +                     *paddr = "";
>
> Hmm, I know this is a default pointer to a sting, but perhaps we should
> make it point to NULL, and not a string defined by this function?


Again, I don't remember why but I guess it might be intentionally
reserved to empty string.


>
> > +             }
> > +     }
> > +
> > +     *size = entry_size + 1;
> > +     return entry;
> > +}
> > +
> > +#define INJECT_STRING "STATIC STRING CAN NOT BE INJECTED"
> > +
> > +/* Caller is responsible to free the *pentry. */
> > +static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
> > +{
> > +     struct ftrace_event_field *field;
> > +     unsigned long irq_flags;
> > +     void *entry = NULL;
> > +     int entry_size;
> > +     u64 val;
> > +     int len;
> > +
> > +     entry = trace_alloc_entry(call, &entry_size);
> > +     *pentry = entry;
> > +     if (!entry)
> > +             return -ENOMEM;
> > +
> > +     local_save_flags(irq_flags);
> > +     tracing_generic_entry_update(entry, call->event.type, irq_flags,
> > +                                  preempt_count());
> > +
> > +     while ((len = parse_field(str, call, &field, &val)) > 0) {
> > +             if (is_function_field(field))
>
> Why not allow injecting function fields?


I don't quite remember, but I think it is probably due to I don't have
such a use case for testing rasdaemon. Do you have any use case
on your mind?

>
> > +                     return -EINVAL;
> > +
> > +             if (is_string_field(field)) {
> > +                     char *addr = (char *)(unsigned long) val;
> > +
> > +                     if (field->filter_type == FILTER_STATIC_STRING) {
> > +                             strlcpy(entry + field->offset, addr, field->size);
> > +                     } else if (field->filter_type == FILTER_DYN_STRING) {
> > +                             int str_len = strlen(addr) + 1;
> > +                             int str_loc = entry_size & 0xffff;
> > +                             u32 *str_item;
> > +
> > +                             entry_size += str_len;
> > +                             *pentry = krealloc(entry, entry_size, GFP_KERNEL);
> > +                             entry = *pentry;
> > +                             if (!entry)
> > +                                     return -ENOMEM;
>
> The above leaks memory, as if *pentry is NULL then the old entry is not
> freed. The above needs to be:
>
>                                 *pentry = krealloc(entry, entry_size, GFP_KERNEL);
>                                 if (!*pentry) {
>                                         kfree(entry);
>                                         return -ENOMEM;
>                                 }
>                                 entry = *pentry;


Good catch!


>
> > +
> > +                             strlcpy(entry + (entry_size - str_len), addr, str_len);
> > +                             str_item = (u32 *)(entry + field->offset);
> > +                             *str_item = (str_len << 16) | str_loc;
> > +                     } else {
> > +                             char **paddr;
> > +
> > +                             /* TODO: can we find the constant string? */
>
>                                 probably not ;-)

Ok, I thought you want to keep it, then let's remove it.


Thanks!
