Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319B7C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F075020873
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lTaIMlol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfJHWVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:21:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34650 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:21:23 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so593067ion.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEPHwIm7df4PkY9cDyDlenGTWq9+YLMznzJXQKYUKZ4=;
        b=lTaIMlolf/hxPt/kb7S/rw6zIuIcsCPjTvfaTUUWe+7Yy0objFkVfZpVz7gcrVh9IL
         85QkDgWcunWwUU/OaLhOIKrzM3xF8NQ/eIG9jU1V+XRqDZZD3W3IvPYwTUxXrn6ct54T
         VcheOHly0sJh2wZJPTgWFzGpBR+9EUheQLnCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEPHwIm7df4PkY9cDyDlenGTWq9+YLMznzJXQKYUKZ4=;
        b=NIReo3LsRDT67REte/wwxa+ZnD+HNj/mfjGD+f+rsOSHmQ7pnkCdrcR/5Z+PXaHpJ6
         nQ1CFvmSREb16fJTRINyJ/s5koENXsuqAoGqGebC6gwsbiahWLLgy6VBJdSo78wC+ouc
         WvZ0hdyhkGqnW3VrHeh6SDBZdXsFOt2aFOcDJlUHYJnjTY3Zk1UHKaukXpzqFsww5KOj
         VrPyt27sxXZ51tXx/T2COqTD8nIq6KDoOid1cM3aWGWdjC7BkAPGtw4x4vXRMWDKICt4
         dABkEOAVPcStx0aFGyOGdgVUJD0rGP6XdpHQ8PVydSwnvxVu9KwPPgqqdql5f4XgqVhD
         dQUQ==
X-Gm-Message-State: APjAAAU9/8LTRCvcdJ00deWHC/ZsMkTYB442gYid7RPuNCwTvLAFlpWu
        FWe//weSt6zcMOeJNzCoCp2AaSI3iRc=
X-Google-Smtp-Source: APXvYqwsaYllv7vyY4RTRqMAHOsfR+BWs1Ez8xAtgesSjo4QV2czDPx/pxl+rFdWwy4VJnxvKdycbQ==
X-Received: by 2002:a92:9a94:: with SMTP id c20mr644264ill.65.1570573282177;
        Tue, 08 Oct 2019 15:21:22 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id e71sm237170ilg.72.2019.10.08.15.21.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 15:21:21 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id z19so606352ior.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:21:21 -0700 (PDT)
X-Received: by 2002:a05:6e02:683:: with SMTP id o3mr35457412ils.58.1570573273677;
 Tue, 08 Oct 2019 15:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191008132043.7966-1-daniel.thompson@linaro.org> <20191008132043.7966-4-daniel.thompson@linaro.org>
In-Reply-To: <20191008132043.7966-4-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Oct 2019 15:21:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W9Tdh2hPekzgSYnCqoTX_ms1GY-FXgnxd-uEW0SWbyuw@mail.gmail.com>
Message-ID: <CAD=FV=W9Tdh2hPekzgSYnCqoTX_ms1GY-FXgnxd-uEW0SWbyuw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] kdb: Remove special case logic from kdb_read()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 8, 2019 at 6:21 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> kdb_read() contains special case logic to force it exit after reading
> a single character. We can remove all the special case logic by directly
> calling the function to read a single character instead. This also
> allows us to tidy up the function prototype which, because it now matches
> getchar(), we can also rename in order to make its role clearer.

nit: since you're doing the rename, should you rename
kdb_read_handle_escape() to match?


> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 56 ++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 33 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 78cb6e339408..a9e73bc9d1c3 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -106,7 +106,19 @@ static int kdb_read_handle_escape(char *buf, size_t sz)
>         return -1;
>  }
>
> -static int kdb_read_get_key(char *buffer, size_t bufsize)
> +/*
> + * kdb_getchar
> + *
> + * Read a single character from kdb console (or consoles).

nit: should we start moving to the standard kernel convention of
kernel-doc style comments?  See
"Documentation/doc-guide/kernel-doc.rst"


> + *
> + * An escape key could be the start of a vt100 control sequence such as \e[D
> + * (left arrow) or it could be a character in its own right.  The standard
> + * method for detecting the difference is to wait for 2 seconds to see if there
> + * are any other characters.  kdb is complicated by the lack of a timer service
> + * (interrupts are off), by multiple input sources. Escape sequence processing
> + * has to be done as states in the polling loop.

Before your paragraph, maybe add: "Most of the work of this function
is dealing with escape sequences." to give it a little bit of context.


> + */
> +static int kdb_getchar(void)

Is "int" the right return type here, or "unsigned char"?  You never
return EOF, right?  Always a valid character?  NOTE: if you do change
this to "unsigned char" I think you still need to keep the local "key"
variable as an "int" since -1 shouldn't be confused with the character
255.


>  {
>  #define ESCAPE_UDELAY 1000
>  #define ESCAPE_DELAY (2*1000000/ESCAPE_UDELAY) /* 2 seconds worth of udelays */
> @@ -124,7 +136,6 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
>                 }
>
>                 key = (*f)();
> -
>                 if (key == -1) {
>                         if (escape_delay) {
>                                 udelay(ESCAPE_UDELAY);
> @@ -134,14 +145,6 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
>                         continue;
>                 }
>
> -               if (bufsize <= 2) {
> -                       if (key == '\r')
> -                               key = '\n';
> -                       *buffer++ = key;
> -                       *buffer = '\0';
> -                       return -1;
> -               }
> -
>                 if (escape_delay == 0 && key == '\e') {
>                         escape_delay = ESCAPE_DELAY;
>                         ped = escape_data;
> @@ -183,17 +186,7 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
>   *     function.  It is not reentrant - it relies on the fact
>   *     that while kdb is running on only one "master debug" cpu.
>   * Remarks:
> - *
> - * The buffer size must be >= 2.  A buffer size of 2 means that the caller only
> - * wants a single key.

By removing this you broke "BTAPROMPT".  So doing:

set BTAPROMPT=1
bta

It's now impossible to quit out.  Not that I've ever used BTAPROMPT,
but seems like we should either get rid of it or keep it working.


> - *
> - * An escape key could be the start of a vt100 control sequence such as \e[D
> - * (left arrow) or it could be a character in its own right.  The standard
> - * method for detecting the difference is to wait for 2 seconds to see if there
> - * are any other characters.  kdb is complicated by the lack of a timer service
> - * (interrupts are off), by multiple input sources and by the need to sometimes
> - * return after just one key.  Escape sequence processing has to be done as
> - * states in the polling loop.
> + *     The buffer size must be >= 2.
>   */
>
>  static char *kdb_read(char *buffer, size_t bufsize)
> @@ -228,9 +221,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
>         *cp = '\0';
>         kdb_printf("%s", buffer);
>  poll_again:
> -       key = kdb_read_get_key(buffer, bufsize);
> -       if (key == -1)
> -               return buffer;
> +       key = kdb_getchar();
>         if (key != 9)
>                 tab = 0;
>         switch (key) {
> @@ -741,7 +732,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
>
>         /* check for having reached the LINES number of printed lines */
>         if (kdb_nextline >= linecount) {
> -               char buf1[16] = "";
> +               char ch;

The type of "ch" should be the same as returned by kdb_getchar()?
Either "int" if you're keeping it "int" or "unsigned char"?


>                 /* Watch out for recursion here.  Any routine that calls
>                  * kdb_printf will come back through here.  And kdb_read
> @@ -776,39 +767,38 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
>                 if (logging)
>                         printk("%s", moreprompt);
>
> -               kdb_read(buf1, 2); /* '2' indicates to return
> -                                   * immediately after getting one key. */
> +               ch = kdb_getchar();
>                 kdb_nextline = 1;       /* Really set output line 1 */
>
>                 /* empty and reset the buffer: */
>                 kdb_buffer[0] = '\0';
>                 next_avail = kdb_buffer;
>                 size_avail = sizeof(kdb_buffer);
> -               if ((buf1[0] == 'q') || (buf1[0] == 'Q')) {
> +               if ((ch == 'q') || (ch == 'Q')) {
>                         /* user hit q or Q */
>                         KDB_FLAG_SET(CMD_INTERRUPT); /* command interrupted */
>                         KDB_STATE_CLEAR(PAGER);
>                         /* end of command output; back to normal mode */
>                         kdb_grepping_flag = 0;
>                         kdb_printf("\n");
> -               } else if (buf1[0] == ' ') {
> +               } else if (ch == ' ') {
>                         kdb_printf("\r");
>                         suspend_grep = 1; /* for this recursion */
> -               } else if (buf1[0] == '\n') {
> +               } else if (ch == '\n' || ch == '\r') {
>                         kdb_nextline = linecount - 1;
>                         kdb_printf("\r");
>                         suspend_grep = 1; /* for this recursion */
> -               } else if (buf1[0] == '/' && !kdb_grepping_flag) {
> +               } else if (ch == '/' && !kdb_grepping_flag) {
>                         kdb_printf("\r");
>                         kdb_getstr(kdb_grep_string, KDB_GREP_STRLEN,
>                                    kdbgetenv("SEARCHPROMPT") ?: "search> ");
>                         *strchrnul(kdb_grep_string, '\n') = '\0';
>                         kdb_grepping_flag += KDB_GREPPING_FLAG_SEARCH;
>                         suspend_grep = 1; /* for this recursion */
> -               } else if (buf1[0] && buf1[0] != '\n') {
> +               } else if (ch && ch != '\n') {

Remove "&& ch != '\n'".  We would have hit an earlier case in the
if/else anyway.  If you really want to keep it here for some reason, I
guess you should also handle '\r' ?


-Doug
