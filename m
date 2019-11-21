Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FFDC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB612088F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="C+eT+CCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKUHlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:41:09 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33973 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUHlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:41:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id l28so1801480lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 23:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+ivP0t11qSgLHR500CRfbVMbU6+LuXa4U6V5HH6I6vo=;
        b=C+eT+CCBu8ohnBcx0TCg3g5E1+IZFpyG7hHpwW0/Wl2NU0XUc9mNlHVgij+cGnD9iu
         TVqYggV3M+UpxBgycfJh4T/Cg8RFqJhkTsrm/cBMRlXSaMg5Rlhsoy3cDkoOKa9oHfwk
         RYEZMUEfnXkYhPWKzckzp9YjqMikHwTpTi1ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ivP0t11qSgLHR500CRfbVMbU6+LuXa4U6V5HH6I6vo=;
        b=bCOWlsfxlxSagzgGg98+t0GmnHL3dT9T6/kDat3xzGZyhH89HrdwgOX0/dLWDK6fdS
         TbUGoP90hflBeeaiPE0vu9odneNRZwuOJ4zPC5lWR38E/rx1UG57WhkNujsUgmloLrZE
         sPStLwxFvKERQDQWtkXp1ig96D2ERqBDiL/9LgoCo4hyeRGytmLabib0Gv3SCHVTd1Wk
         jYbLy7qfQllPKzZlUwIDd+3YxsILcHyI9qQ/ODoGGkT2ViV/d+AM3ON0uTQ+SG++CWZq
         s2tvMSyfcFgpLNec2lMHpUwBcKMW4LLVJa94lWJ/Wdfv4OL/yCtzPWfFT7+9Hz5OYdcL
         PJvg==
X-Gm-Message-State: APjAAAXHvZz/CPncZPFlHl24ozujEkQanHzKmRi9szO3aXa6S52hDOE9
        LP+qc6ByddW/IX6jokuAkuJpP4LIfax0UIC7
X-Google-Smtp-Source: APXvYqx2M1l64FZyT7SmsjUGPO15HMnwZrUi74dFhH1FQy7LkZXKtDDawPki60RTdYy3BGgQ8yWm4Q==
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr6259977lfp.5.1574322063173;
        Wed, 20 Nov 2019 23:41:03 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id c12sm743854ljk.77.2019.11.20.23.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 23:41:02 -0800 (PST)
Subject: Re: [PATCH 2/3] docs, parallelism: Do not leak blocking mode to
 writer
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191121000304.48829-1-keescook@chromium.org>
 <20191121000304.48829-3-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <041953ef-0b6c-4ea8-8734-aa1e6703f9f8@rasmusvillemoes.dk>
Date:   Thu, 21 Nov 2019 08:41:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121000304.48829-3-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2019 01.03, Kees Cook wrote:
> Setting non-blocking via a local copy of the jobserver file descriptor
> is safer than just assuming the writer on the original fd is prepared
> for it to be non-blocking.

This is a bit inaccurate. The fd referring to the write side of the pipe
is always blocking - it has to be, due to the protocol requiring you to
write back the tokens you've read, so you can't just drop a token on the
floor. But it's also rather moot, since the pipe will never hold
anywhere near 4096 bytes, let alone a (linux) pipe's default capacity of
64K.

But what we cannot do is change the mode of the open file description to
non-blocking for the read side, in case the parent make (or some sibling
process that has also inherited the same "struct file") expects it to be
blocking.

> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Link: https://lore.kernel.org/lkml/44c01043-ab24-b4de-6544-e8efd153e27a@rasmusvillemoes.dk
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/jobserver-count | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/jobserver-count b/scripts/jobserver-count
> index 6e15b38df3d0..a68a04ad304f 100755
> --- a/scripts/jobserver-count
> +++ b/scripts/jobserver-count
> @@ -12,12 +12,6 @@ default="1"
>  if len(sys.argv) > 1:
>  	default=sys.argv[1]
>  
> -# Set non-blocking for a given file descriptor.
> -def nonblock(fd):
> -	flags = fcntl.fcntl(fd, fcntl.F_GETFL)
> -	fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)
> -	return fd
> -
>  # Extract and prepare jobserver file descriptors from envirnoment.
>  try:
>  	# Fetch the make environment options.
> @@ -31,8 +25,13 @@ try:
>  	# Parse out R,W file descriptor numbers and set them nonblocking.
>  	fds = opts[0].split("=", 1)[1]
>  	reader, writer = [int(x) for x in fds.split(",", 1)]
> -	reader = nonblock(reader)
> -except (KeyError, IndexError, ValueError, IOError):
> +	# Open a private copy of reader to avoid setting nonblocking
> +	# on an unexpecting writer.

s/writer/reader/

> +	reader = os.open("/proc/self/fd/%d" % (reader), os.O_RDONLY)
> +	flags = fcntl.fcntl(reader, fcntl.F_GETFL)
> +	fcntl.fcntl(reader, fcntl.F_SETFL, flags | os.O_NONBLOCK)

I think you can just specify O_NONBLOCK in the open() call so you avoid
those two fcntls.

Rasmus
